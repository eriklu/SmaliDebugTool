##SmaliDebugTool
==============

### 功能描述
Smali输出信息工具集。包含一组函数用来在smali文件中增加输出语句，可以输出到logcat和文件。另外还包含了设置未处理异常处理器和执行线程的功能。DebugTool 是Apk逆向日志输出工具。方便在修改smali文件时增加输出信息。当然也可以在APK开发中使用。
  
为了减少修改smali文件时的平衡参数工作，所有函数最多使用两个参数。
  
### 输出目标
可以输出到文件和logcat。
  
### 输出内容
可以输出字符串和byte数组。
  
### 增强类：
- 支持输出函数调用栈(debug.DebugTool$ThreadStack)
- File对象的文件名(debug.DebugTool$FileObject)
- 整数数值(debug.DebugTool$Number)、
- HttpGet(debug.DebugTool$HttpClient)
- HttpPost(debug.DebugTool$HttpClient)
- Object(debug.DebugTool$Object)对象
  
### 存在的问题
没有判断对象是否为空值。
  
### 其他功能：
1. 执行一个线程（Thread)／Runnable对象
2. 执行一个Task桩。Task桩用来执行一些命令，主要用在smali文件时。测试一些代码的功能。需要用户自动拷贝指令到Task.smali文件中。
3. 设置默认的未处理异常处理器，输出出错线程的堆栈信息。
  
### smali 代码示例
  
1. 输出字符串
``` smali
const-string v0, "file xxx.smali line xxx"
invoke-static {v0}, Ldebug/DebugTool;->logcat(Ljava/lang/String;)V
invoke-static {v0}, Ldebug/DebugTool;->log2File(Ljava/lang/String;)V
```
2. 输出byte数组
``` smali
#这里v0是指向数组对象的指针	
invoke-static {v0}, Ldebug/DebugTool;->logcat([B)V
invoke-static {v0}, Ldebug/DebugTool;->log2File([B)V
```
3. 输出函数执行栈
``` smali
#//输出到logcat
invoke-static {}, Ldebug/DebugTool$ThreadStack;->logcat()V
#//输出到文件
invoke-static {}, Ldebug/DebugTool$ThreadStack;->log2File()V
```
4. 执行函数
``` smali
const－class v0, Lxx/yy  #xx／yy为线程类
invoke-static {v0}, Ldebug/DebugTool$ThreadTask;->runThread(Ljava/lang/Class;)V
```
5. 设置未处理异常处理器
``` smali
invoke-static {}, Ldebug/DebugTool;->setUnhandleExceptionHandler()V
```
