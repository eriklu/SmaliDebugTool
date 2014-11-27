package debug;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.Thread.UncaughtExceptionHandler;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;

import android.annotation.SuppressLint;
import android.os.Environment;
import android.util.Log;

/***
 * 
 * @author Erik Lu
 *
 * DebugTool 是Apk逆向日志输出工具。
 * 
 * 方便在修改smali文件时增加输出信息。当然也可以在APK开发中使用。
 * 
 * 为了减少修改smali文件时的平衡参数工作，所有函数最多使用两个参数。
 * 
 * 输出目标：可以输出到文件和logcat。
 * 
 * 输出内容：可以输出字符串，和byte数组。
 * 
 * 增强类：支持输出函数调用栈(debug.DebugTool$ThreadStack)、File对象的文件名(debug.DebugTool$FileObject)、整数数值(debug.DebugTool$Number)、
 * HttpGet(debug.DebugTool$HttpClient)、HttpPost(debug.DebugTool$HttpClient), Object(debug.DebugTool$Object)对象
 * 
 * 存在的问题：没有判断对象是否为空值。
 * 
 * 其他功能：
 * 1、执行一个线程（Thread)／Runnable对象
 * 2、执行一个Task桩。Task桩用来执行一些命令，主要用在smali文件时。测试一些代码的功能。需要用户自动拷贝指令到Task.smali文件中。
 * 3、设置默认的未处理异常处理器，输出出错线程的堆栈信息。
 * 
 * smali 代码示例
 * 
 * 1. 输出字符串
 *    const-string v0, "file xxx.smali line xxx"
 *    invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V
 *    invoke-static {v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;)V
 * 2. 输出byte数组
 * 	  #这里v0是指向数组对象的指针	
 * 	  invoke-static {v0}, Ldebug/DebugTool;->logcat([B)V
 *    invoke-static {v0}, Ldebug/DebugTool;->log2File([B)V
 * 3. 输出函数执行栈
 * 	  #//输出到logcat
 *    invoke-static {}, Ldebug/DebugTool$ThreadStack;->logcat()V
 *    #//输出到文件
 *    invoke-static {}, Ldebug/DebugTool$ThreadStack;->log2File()V
 * 4. 执行函数
 *    const－class v0, Lxx/yy  #xx／yy为线程类
 *    invoke-static {v0}, Ldebug/DebugTool$ThreadTask;->runThread(Ljava/lang/Class;)V
 * 5. 设置未处理异常处理器
 * 	  invoke-static {}, Ldebug/DebugTool;->setUnhandleExceptionHandler()V
 */

@SuppressLint("SimpleDateFormat")
public class DebugTool {
	
	public final static String _filename;
	public final static String _tag;
	
	public final static String version = "0.2";
	
	static {
		_filename = Environment.getExternalStorageDirectory().getAbsolutePath() + File.separator + "smaliDebugLog.txt";
		_tag = "smaliDebugLog";
	}

	public static String format(String msg){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd HHMMss", Locale.CHINA);
		return String.format("%s:%s\n", sdf.format(new Date()), msg);
	}
	
	public static void log2File(String msg){
		log2File(_filename, msg);
	}
	
	public static void log2File(String logname, String msg){
		try {
			FileOutputStream fout = new FileOutputStream(logname, true);
			fout.write(format(msg).getBytes());
			fout.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void log2File(String logname, byte[] msg){
		try {

			FileOutputStream fout = new FileOutputStream(logname, true);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd HHMMss");
			fout.write(sdf.format(new Date()).getBytes());
			fout.write(":".getBytes());
			fout.write(msg);
			fout.write("\n".getBytes());
			fout.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static void log2File(byte[] msg){
		log2File(_filename, msg);
	}
	
	public static void logcat(String msg){

		Log.d(_tag, msg);
	}
	
	public static void logcat(byte[] msg){
		StringBuilder sb = new StringBuilder();
		for(byte b : msg){
			sb.append(String.format("%02x", b));
		}
		logcat(sb.toString());
		
	}
	
	/**
	 * 给应用设置默认的未处理异常处理器
	 * 
	 */
	public static void setUnhandleExceptionHandler(){
		Thread.setDefaultUncaughtExceptionHandler(new DefalutUncaughtExceptionHandler());
	}
	
	public static class ThreadStack{
		
		public static void logcat(){
			DebugTool.logcat(getThreadStack());
		}
		
		public static void log2File(){
			DebugTool.log2File(getThreadStack());
		}
		
		public static void log2FileThreadStack(String filename){
			DebugTool.log2File(filename, getThreadStack());
		}
		
		private static String getThreadStack(){
			Thread t = Thread.currentThread();
			StackTraceElement[] stacks = t.getStackTrace();
			StringBuilder sb = new StringBuilder();
			for(StackTraceElement stack : stacks){
				sb.append(stack.toString()).append("\n");
			}
			return sb.toString();
		}
	}
	
	public static class Object {
		public static void logcatObjectIsNull(Object o){
			DebugTool.logcat(o == null ? "true" : "false");
		}
		
		public static void logcat(Object o){
			if(o == null){
				DebugTool.logcat("object is null");
			}else {
				DebugTool.logcat(o.getClass().getCanonicalName() + "|" + o.toString());
			}
		}
		
		public static void log2File(Object o){
			log2File(DebugTool._filename, o);
		}
		
		public static void log2File(String filename, Object o){
			if(o == null){
				DebugTool.log2File(filename, "object is null");
			}else {
				DebugTool.log2File(filename, o.getClass().getCanonicalName() + "|" + o.toString());
			}
		}
	}

	public static class  FileObject{
		public static void logcat(File f){
			DebugTool.logcat(f.getAbsolutePath());
		}
		
		public static void log2File(File f){
			DebugTool.log2File(f.getAbsolutePath());
		}
		
		public static void log2File(String logfilename, File f){
			DebugTool.log2File(logfilename, f.getAbsolutePath());
		}
	}
	
	public static class Number{
		public static void logcat(int value){
			DebugTool.logcat(value + "");
		}
		
		public static void log2File(int value){
			DebugTool.log2File(value + "");
		}
		
		public static void log2File(String logfilename,int value){
			DebugTool.log2File(logfilename, value + "");
		}
	}
	
	public static class HttpClientObject{
		public static void logcat(HttpGet get){
			DebugTool.logcat(get.getURI().getPath());
			DebugTool.logcat(get.toString());
		}
		
		public static void log2File(HttpGet get){
			log2File(DebugTool._filename, get);
		}
		
		public static void log2File(String logfilename, HttpGet get){
			DebugTool.log2File(logfilename, get.getURI().getPath());
			DebugTool.log2File(logfilename, get.toString());
		}
		
		public static void logcat(HttpPost post){
			DebugTool.logcat(post.getURI().getPath());
			DebugTool.logcat(post.toString());
		}
		
		public static void log2File(HttpPost post){
			log2File(DebugTool._filename, post);
		}
		
		public static void log2File(String logfilename, HttpPost post){
			DebugTool.log2File(logfilename, post.getURI().getPath());
			DebugTool.log2File(logfilename, post.toString());
		}
		
	}
	

	public static class ThreadTask {
		public static void runTask(){
			Task t = new Task();
			t.start();
		}
		
//		public static void runThread(Thread thread){
//			thread.start();
//		}
		
		public static void runThread(Class<Thread> threadClass){
			try {
				threadClass.newInstance().start();
			} catch (Exception e) {
				DebugTool.logcat(e.getLocalizedMessage());
				DebugTool.log2File(e.getLocalizedMessage());
			}
		}
		
		public static void runRunnable(Class<Runnable> runnableClass){
			try {
				new Thread(runnableClass.newInstance()).start();
			} catch (Exception e) {
				DebugTool.logcat(e.getLocalizedMessage());
				DebugTool.log2File(e.getLocalizedMessage());
			}
		}

	}
	

	
	
	
	/**
	 *  @author Erik Lu
	 * 线程任务桩
	 * 用来启动一个线程来执行一个函数。
	 */
	static class Task extends Thread{
		public void run(){
			try{
				//do somthing.
				throw new IOException();
			}catch(Exception e){
				
			}
		}
	}

	/**
	 * 
	 * @author Erik Lu
	 * 给应用设置默认的异常处理器
	 * 打印异常退出线程的堆栈信息到SD卡的smaliDebugLog.txt文件
	 * 
	 * 使用方法
	 * 
	 */

	static class DefalutUncaughtExceptionHandler implements UncaughtExceptionHandler
	{

		@Override
		public void uncaughtException(Thread thread, Throwable ex) {
			DebugTool.ThreadStack.logcat();
			DebugTool.ThreadStack.log2File();
			DebugTool.log2File(ex.getLocalizedMessage());
		}
		
	}

}

