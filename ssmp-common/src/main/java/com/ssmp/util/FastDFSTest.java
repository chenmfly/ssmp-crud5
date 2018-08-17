package com.ssmp.util;

import org.csource.common.NameValuePair;

import javax.imageio.stream.FileImageInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;

public class FastDFSTest {
	/*
	 * 根据URL获取
	 */
	//@Test
	public void t1() {
		FastDFS fd = new FastDFS();
		//自定义元数据
		NameValuePair nvp [] = new NameValuePair[]{ 
                new NameValuePair("age", "18"), 
                new NameValuePair("sex", "male") 
        }; 
		String[] url = fd.updateByUrl("D:\\06.jpg","jpg",nvp);
		System.out.println(url);
	}
	/*
	 * 根据Byte获取
	 */
	//@Test
	public void t2() {
		FastDFS fd = new FastDFS();
		//自定义元数据
		NameValuePair nvp [] = new NameValuePair[]{ 
                new NameValuePair("age", "18"), 
                new NameValuePair("sex", "male") 
        }; 
		byte[] b = image2byte("D:\\05.jpg");
		String[] url = fd.updateByUrl(b,"jpg",nvp);
		System.out.println(url);
	}
	/*
	 * 下载文件
	 */
	//@Test
	public void t3() {
		FastDFS fd = new FastDFS();
		fd.downByUrl("group1", "M00/37/AF/wKgqgVs3tf-AKjYgAAFY1Aipxfo761","jpg");
	}
	/*
	 * 获取文件信息
	 */
	//@Test
	public void t4() {
		FastDFS fd = new FastDFS();
		fd.getFileInfo("group1", "M00/37/AF/wKgqgVs3tf-AKjYgAAFY1Aipxfo761","jpg");
	}
	/*
	 * 获取文件元数据
	 */
	//@Test
	public void t5() {
		FastDFS fd = new FastDFS();
		fd.getFileMate("group1", "M00/37/AF/wKgqgVs3tf-AKjYgAAFY1Aipxfo761","jpg");
	}
	/*
	 * 删除文件
	 */
	//@Test
	public void t6() {
		FastDFS fd = new FastDFS();
		fd.deleteFile("group1", "M00/37/AF/wKgqgVs3tf-AKjYgAAFY1Aipxfo761","jpg");
	}
	/*
	 * 图片到byte数组
	 */
	public static byte[] image2byte(String path){
		byte[] data = null;
		FileImageInputStream input = null;
		try {
			input = new FileImageInputStream(new File(path));
			ByteArrayOutputStream output = new ByteArrayOutputStream();
			byte[] buf = new byte[1024];
			int numBytesRead = 0;
			while ((numBytesRead = input.read(buf)) != -1) {
				output.write(buf, 0, numBytesRead);
			}
			data = output.toByteArray();
			output.close();
			input.close();
		}
		catch (Exception ex1) {
			ex1.printStackTrace();
		}
		return data;
	}
}
