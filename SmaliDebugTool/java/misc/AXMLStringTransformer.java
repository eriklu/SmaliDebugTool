package misc;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;
import java.nio.charset.CharsetEncoder;
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * @author Erik Lu
 * 
 * Ä¿µÄÊÇÌæ»»android xmlÎÄ¼þÖÐÒýÓÃµ½µ½²»¹æÔòµÄÀàÃû¡£
 * ÅäºÏapktoolÐÞ¸Ä°æÊ¹ÓÃ
 *
 * ×ª»»android xmlÎÄ¼þÖÐµÄ×Ö·û´®¡£
 * 
 * ¿ÉÒÔ×ö·±¼òÌå×ª»»¡£
 *
 */

public class AXMLStringTransformer {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		if(args.length <= 1){
			System.out.println("Usage: java AXMLStringTransformer infile [outdir]\n\tjava AXMLStringTransformer indir [outdir]\n");
			try {
				System.in.read();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			System.exit(1);
		
		}
		
		String infile = null, outfile = null;
		if(args.length > 1){
			infile = args[1];
		}
		
		if(args.length > 2){
			outfile = args[2];
		}
		
		try {
			transform(infile, new StringHexEncoderTransformer(), new FilenameFilter() {
				
				@Override
				public boolean accept(File dir, String name) {
					if(new File(dir.getAbsolutePath() + File.separator + name).isDirectory()) return true;
					if(name.endsWith(".xml")) return true;
					return false;
				}
			}, outfile);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 
	 * @param file Òª´¦ÀíµÄandroid xml ÎÄ¼þ»òÄ¿Â¼.
	 * @param transformer ×Ö·û´®Ó³ÉäÆ÷
	 * @param filenameFilter ÎÄ¼þÃû¹ýÂËÆ÷£¬¿ÉÒÔÎª¿Õ
	 * @param outputDir Êä³öÄ¿Â¼£¬ÈôÎªnullÔò¸²¸ÇÔ­Ê¼ÎÄ¼þ
	 * @throws IOException outputDir²»ÊÇºÏ·¨Ä¿Â¼
	 */
	public static void transform(String file, StringTransformer transformer, FilenameFilter filenameFilter, String outputDir) throws IOException{
		if( (file == null) ||  (transformer==null)) return;
		
		File outFileDir = null;
		if (outputDir != null) {
			outFileDir = new File(outputDir);
			if (outFileDir.exists() && !outFileDir.isDirectory()) {
				outFileDir = null;
				throw new IOException(outputDir + "²»ÊÇÒ»¸ö¿ÉÐ´Ä¿Â¼!");
			} else {
				outFileDir.mkdirs();
				if (!outFileDir.exists()) {
					outFileDir = null;
					throw new IOException(outputDir + "Ä¿Â¼´´½¨Ê§°Ü!");
				}
			}
		}
		
		File f = new File(file);
		if(!f.exists()) return;
		
		if(f.isDirectory()){
			String[] files = filenameFilter != null ?  f.list(filenameFilter) : f.list();
			for(String filename : files){
				if(file.equals(".") || filename.equals("..")) continue;
				transform(f.getAbsolutePath() + File. separator + filename, transformer, filenameFilter, outputDir==null ? null :outputDir + File.separator + f.getName());
			}
		}else {
			if((filenameFilter == null) || (filenameFilter!= null && filenameFilter.accept(f.getParentFile(), f.getName()))){
				AXMLStringTransformer aXMLTransformer = new AXMLStringTransformer(f, outFileDir, transformer);
				aXMLTransformer.transformerAXML();
				return;
			}
		}
	}
	
	private AXMLStringTransformer(File file, File outFileDir, StringTransformer transformer) {
		this.inFile = file;
		this.ourputDir = outFileDir;
		this.transformer = transformer;
	}
	
	private synchronized void transformerAXML() throws IOException{
		System.out.println("handle file " + inFile.getAbsolutePath());
		extractStringsFromAXMLFile();
		byte[] newStringChunk = transformStrings();
		rebuildNewAXMLFile(newStringChunk);
	}
	
	private void extractStringsFromAXMLFile(){
		try {
			InputStream in = new FileInputStream(inFile);
			
			in.read(buf4);
			int fileMagicNumber = toInt(buf4);
			
			if(fileMagicNumber != 0x00080003) throw new IOException("not a android xml file.");
			
			in.skip(8);

			
			in.read(buf4);
			int chunkSize = toInt(buf4); 
			oldChunkSize = chunkSize;
			in.read(buf4);
			int stringCnt = toInt(buf4);
			in.read(buf4);
			int styleCnt = toInt(buf4);
			in.read(buf4);
			int flag = toInt(buf4);
			in.read(buf4);
			int strOff = toInt(buf4);
			in.read(buf4);
			int styleOff = toInt(buf4);
			
			isUTF8 = (flag & 0x00000100) != 0;
			
			stringOffsets = new int[stringCnt];
			//if(styleCnt != 0) throw new IllegalArgumentException("º¬ÓÐstyle×Ö·û´®!");
			for(int i=0; i<stringCnt; i++){
				in.read(buf4);
				stringOffsets[i] = toInt(buf4);
			}
			
			int stringChunkSize = ((styleOff == 0) ? chunkSize : styleOff) - strOff;
			oldStringChunkSize = stringChunkSize;
			byte[] chunk = new byte[stringChunkSize];
			in.read(chunk);
			in.close();
			stringLst = new ArrayList<String>();
			for(int i=0; i<stringCnt; i++){
				int offset = stringOffsets[i];
				int length = 0;
				if(isUTF8){
			         int[] val = getUtf8(chunk, offset);
			            offset = val[0];
			            length = val[1];
				}else {
			        int[] val = getUtf16(chunk, offset);
			        offset += val[0];
			        length = val[1];
				}
				String str =(isUTF8 ? UTF8_DECODER : UTF16LE_DECODER).decode(
			            ByteBuffer.wrap(chunk, offset, length)).toString();
				
				stringLst.add(str);
			}

			in.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (CharacterCodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
	}
	
	private byte[] transformStrings() throws IOException {
		for(int i=0; i<stringLst.size(); i++){
			stringLst.set(i, transformer.transform(stringLst.get(i)));
		}
		
		ByteArrayOutputStream bao = new ByteArrayOutputStream();
		int m=0;
		for(int i=0; i<stringLst.size(); i++){
			stringOffsets[i] = m;
			String str = stringLst.get(i);
			ByteBuffer bb =(isUTF8 ? UTF8_ECODER : UTF16LE_ECODER).encode(CharBuffer.wrap(str.toCharArray()));
			int len = bb.array().length / 2;
			bao.write(len);
			bao.write(len>>>8);
			bao.write(bb.array());
			bao.write(0);
			bao.write(0);
			m += 2 + len + len + 2;
		}
		
		int size1 = bao.size();
		int more = (4 - size1 % 4);
		if(more != 4){
			for(int i=0; i<more; i++){
				bao.write(0);
			}
		}
		
		return bao.toByteArray();
	}
	
	private void rebuildNewAXMLFile(byte[] newStringChunk) throws IOException {
		
		int sizechange =  newStringChunk.length - oldStringChunkSize;
		FileInputStream in = new FileInputStream(inFile);
		ByteArrayOutputStream bao1 = new ByteArrayOutputStream();
		in.read(buf4);
		bao1.write(buf4);
		
		in.read(buf4);
		int filezize = toInt(buf4);
		filezize += sizechange;
		writeInt(bao1, filezize);
		in.read(buf4);
		bao1.write(buf4);
		in.skip(4);
		writeInt(bao1, oldChunkSize + sizechange );
		//stringCnt,styleCnt,flag,strOff
		for(int i=0; i<4; i++){
			in.read(buf4);
			bao1.write(buf4);
		}
		in.read(buf4);
		int styleOffset = toInt(buf4);
		writeInt(bao1, styleOffset==0 ? 0 : (sizechange + styleOffset));
		
		in.skip(4 * stringOffsets.length);
		for(int i=0; i<stringOffsets.length; i++){
			writeInt(bao1, stringOffsets[i]);
		}
		
		in.skip(oldStringChunkSize);
		bao1.write(newStringChunk);
		
		byte[] buf1024 = new byte[1024];
		int read = -1;
		while((read = in.read(buf1024)) != -1){
			bao1.write(buf1024, 0, read);
		}
		
		String outputFilename = null;
		if(ourputDir == null){
			outputFilename = inFile.getPath() ;
		}else {
			outputFilename = ourputDir.getPath() + File.separator + inFile.getName();
		}
		System.out.println("save to :" + outputFilename);
		FileOutputStream fout = new FileOutputStream(outputFilename);
		fout.write(bao1.toByteArray());
		fout.close();
	}
	
	private static void writeInt(ByteArrayOutputStream bao, int i){
		bao.write(i);
		bao.write(i>>>8);
		bao.write(i >>> 16);
		bao.write(i >>> 24);
	}
	
	private static final int[] getUtf8(byte[] array, int offset) {
        int val = array[offset];
        int length;

        if ((val & 0x80) != 0) {
            offset += 2;
        } else {
            offset += 1;
        }
        val = array[offset];
        if ((val & 0x80) != 0) {
            offset += 2;
        } else {
            offset += 1;
        }
        length = 0;
        while (array[offset + length] != 0) {
            length++;
        }
        return new int[] { offset, length};
    }

    private static final int[] getUtf16(byte[] array, int offset) {
        int val = ((array[offset + 1] & 0xFF) << 8 | array[offset] & 0xFF);

        if (val == 0x8000) {
            int high = (array[offset + 3] & 0xFF) << 8;
            int low = (array[offset + 2] & 0xFF);
            return new int[] {4, (high + low) * 2};
        }
        return new int[] {2, val * 2};
    }
    
    private static int toInt(byte[] buf){
		return ((buf[3]& 0xFF)<<24) | ((buf[2]& 0xFF)<<16) | ((buf[1]& 0xFF)<<8) | (buf[0]& 0xFF);
	}
	
    private static int toShort(byte[] buf){
		return (buf[1]<<8) | buf[0];
	}

	public static interface StringTransformer{
		public String transform(String str);
	}
	
	
	private File inFile, ourputDir;
	private StringTransformer transformer;
	private int oldChunkSize, oldStringChunkSize;
	private int[] stringOffsets = null;
	private List<String> stringLst = null;
	private boolean isUTF8;
	
	private static final byte[] buf2 = new byte[2];
	private static final byte[] buf4 = new byte[4];
	
	private static final CharsetDecoder UTF16LE_DECODER = Charset.forName("UTF-16LE").newDecoder();
    private static final CharsetDecoder UTF8_DECODER = Charset.forName("UTF-8").newDecoder();
    private static final CharsetEncoder UTF16LE_ECODER = Charset.forName("UTF-16LE").newEncoder();
    private static final CharsetEncoder UTF8_ECODER = Charset.forName("UTF-8").newEncoder();
	
    
	public static class StringHexEncoderTransformer implements StringTransformer {

		@Override
		public String transform(String str) {

			try {
				byte[] bytes = str.getBytes("UTF-8");
				ByteArrayOutputStream bao = new ByteArrayOutputStream();
				boolean first = true;
				for(int i=0; i<bytes.length; i++){
					if((bytes[i]<32 || bytes[i] > 126) && bytes[i]!=0xa && bytes[i]!=13 && bytes[i]!=13){
						if(first){
							bao.write(95);
							first = false;
						}
						bao.write(String.format("%02x", bytes[i]).getBytes());
					}else {
						bao.write(bytes[i]);
						first = true;
					}
				}
				str = bao.toString();
			}  catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			return str;
		}
		
	}
}
