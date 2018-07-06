package com.ssmp.util;

import org.apache.commons.io.IOUtils;
import org.csource.common.NameValuePair;
import org.csource.fastdfs.*;
import org.springframework.stereotype.Component;

import java.io.FileOutputStream;
import java.util.UUID;

@Component
public class FastDFS  {
	private static StorageClient storageClient;
	static {
		String fdfsConfPath="";
		if(FastDFS.class.getClassLoader().getResource("fdfs_client.conf")!=null){
			fdfsConfPath = FastDFS.class.getClassLoader().getResource("fdfs_client.conf").getFile();
		}
		try {
			//使用全局方法加载配置文件
			ClientGlobal.init(fdfsConfPath);
			//创建一个TrackerClient对象
			TrackerClient tracker = new TrackerClient();
			//通过TrackerClient对象获得TrackerServer对象
			TrackerServer trackerServer = tracker.getConnection();
			//创建StorageServer的引用，null就可以了
			StorageServer storageServer = null;
			//创建一个StorageClient对象，其需要两个参数（TrackerServer 和 StorageServer），通过storageClient来进行操作
			storageClient = new StorageClient(trackerServer, storageServer);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 根据URL 或 byte[]上传图片
	 * @param url 本地图片地址"D:\\stsworkspace\\sprites.png";
	 * @param ext 本地图片后缀名"png"
	 * @param nvp 自定义元数据
	 * @return 可访问路径 
	 */
	public static <T> String[] updateByUrl(T url,String ext,NameValuePair nvp []) {
		StringBuffer sb = new StringBuffer("http://192.168.42.128:84/");
		String[] strings = null;
		try {
			if(url instanceof String) {
				strings = storageClient.upload_file((String)url, ext, nvp);
			}else if(url instanceof byte[]) {
				strings = storageClient.upload_file((byte[])url, ext, nvp);
			}
			/*for(String str : strings) {
				sb.append(str);
				sb.append("/");
			}
			sb.deleteCharAt(sb.length()-1);*/
		} catch (Exception e) {
			e.printStackTrace();
		}
		return strings;
	}
	/**
	 * 下载图片 http://192.168.42.128:84/group1/M00/BC/B7/wKgqgls3YFCAW77-AAFY1Aipxfo426.jpg
	 * @param group 组名 group1
	 * @param url 路径 M00/BC/B7/wKgqgls3YFCAW77-AAFY1Aipxfo426
	 * @param ext 类型 jpg
	 */
	public static void downByUrl(String group,String url,String ext) {
		try {
			byte[] b = storageClient.download_file(group, url+"."+ext);
			System.out.println(b);
			IOUtils.write(b, new FileOutputStream("C:/Users/Luke/Desktop/"+UUID.randomUUID().toString()+".jpg"));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 获取文件信息 http://192.168.42.128:84/group1/M00/BC/B7/wKgqgls3YFCAW77-AAFY1Aipxfo426.jpg
	 * @param group 组名 group1
	 * @param url 路径 M00/BC/B7/wKgqgls3YFCAW77-AAFY1Aipxfo426
	 * @param ext 类型 jpg
	 */
	public static void getFileInfo(String group,String url,String ext) {
		try {
			FileInfo fi = storageClient.get_file_info(group, url+"."+ext);
			System.out.println(fi.getSourceIpAddr());
			System.out.println(fi.getFileSize());
			System.out.println(fi.getCreateTimestamp());
			System.out.println(fi.getCrc32());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 获取文件元数据
	 * @param group 组名 group1
	 * @param url 路径 M00/BC/B7/wKgqgls3YFCAW77-AAFY1Aipxfo426
	 * @param ext 类型 jpg
	 */
	public static void getFileMate(String group,String url,String ext) {
		try {
			NameValuePair nvps[] = storageClient.get_metadata(group, url+"."+ext);
			for(NameValuePair nvp : nvps) {
				System.out.println(nvp.getName() + ":" + nvp.getValue());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 删除文件
	 * @param group 组名 group1
	 * @param url 路径 M00/BC/B7/wKgqgls3YFCAW77-AAFY1Aipxfo426
	 * @param ext 类型 jpg
	 */
	public static void deleteFile(String group,String url,String ext) {
		try {
			int i = storageClient.delete_file(group, url+"."+ext);
			System.out.println(i==0?"删除成功":"删除失败:"+i);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
