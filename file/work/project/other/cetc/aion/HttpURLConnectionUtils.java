package com.hd.rcugrc.product.servlet.mvc;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import java.util.Locale;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

@Component 
public class HttpURLConnectionUtils {
	private static Logger logger = LoggerFactory.getLogger(HttpURLConnectionUtils.class);
	
	/**
	 * 读取系统配置的Properties全部信息
	 * 
	 * @param filePath	文件路径
	 * @return
	 * @author 刘帅
	 * @throws 
	 */
	private static Map appPropertiesMap; 
	public static Map getAppProperties(String filePath){

		try{
			if(null != appPropertiesMap && appPropertiesMap.size() > 0){
				return appPropertiesMap;
			}else{
				appPropertiesMap = new HashMap<String, String>();
				if (null == filePath) {
					filePath = HttpURLConnectionUtils.class.getResource(
							"/properties/app.properties").getFile();
				}

				Properties pps = new Properties();
				InputStream in = new BufferedInputStream(new FileInputStream(
						filePath));
				pps.load(in);
				Enumeration en = pps.propertyNames(); // 得到配置文件的名字

				while (en.hasMoreElements()) {
					String strKey = (String) en.nextElement();
					String strValue = pps.getProperty(strKey);
					// System.out.println(strKey + "=" + strValue);
					appPropertiesMap.put(strKey, strValue);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return appPropertiesMap;
		
	}
	
	/**
	 * get方式调用业务系统接口，获取业务系统数据
	 * 	
	 * @param targetURL		请求地址
	 * @param timeOut		请求超时时间
	 * @param postData		返回数据编码：GBK、UTF-8
	 * @return 请求的返回信息
	 * @author 刘帅
	 * @throws 
	 */
	public static String getBusinessAppData(String targetURL,int timeOut,String respEncoding) {
		return requestBusinessAppData(targetURL,timeOut,"GET",null,respEncoding);
	}
	
	/**
	 * post方式调用业务系统接口，获取业务系统数据
	 * 	
	 * @param targetURL		请求地址
	 * @param timeOut		请求超时时间
	 * @param postData		post的字节流
	 * @param postData		返回数据编码：GBK、UTF-8
	 * @return 请求的返回信息
	 * @author 刘帅
	 * @throws 
	 */
	public static String postBusinessAppData(String targetURL,int timeOut,String postData,String respEncoding) {
		return requestBusinessAppData(targetURL,timeOut,"POST",postData,respEncoding);
	}
	
	/**
	 * delete方式调用业务系统接口，获取业务系统数据
	 * 	
	 * @param targetURL		请求地址
	 * @param timeOut		请求超时时间
	 * @param postData		post的字节流
	 * @param postData		返回数据编码：GBK、UTF-8
	 * @return 请求的返回信息
	 * @author 陈琦
	 * @throws 
	 */
	public static String deleteBusinessAppData(String targetURL,int timeOut,String respEncoding) {
		return requestBusinessAppData(targetURL,timeOut,"DELETE",null,respEncoding);
	}
	
	/**
	 * 调用业务系统接口，获取业务系统数据
	 * 	
	 * @param targetURL		请求地址
	 * @param timeOut		请求超时时间
	 * @param requestType	请求类型，GET,POST
	 * @param postData		POST请求时，post的字节流
	 * @param postData		返回数据编码：GBK、UTF-8，默认UTF-8
	 * @return 请求的返回信息
	 * @author 刘帅
	 * @throws 
	 */
	public static String requestBusinessAppData(String targetURL,int timeOut,String requestType,String postData,String respEncoding) {
		
		String responseHTML = null;
		HttpURLConnection httpUrlConnection = null;
		
		InputStream urlStream = null;
		PrintWriter pw = null;
		
		String encoding = (StringUtils.isBlank(respEncoding)?"UTF-8":respEncoding);
		
		if(logger.isDebugEnabled()){
			logger.debug("调用业务系统接口，getBusinessAppData");
			logger.debug("targetURL="+targetURL);
			logger.debug("timeOut="+timeOut);
			logger.debug("requestType="+requestType);
			logger.debug("postData="+postData);		
			logger.debug("encoding="+encoding);	
		}
		
		try {
			
			URL url = new java.net.URL(targetURL);
			URLConnection urlConnection = url.openConnection();

			httpUrlConnection = (HttpURLConnection) urlConnection;
			httpUrlConnection.setUseCaches(false);  
			httpUrlConnection.setConnectTimeout(timeOut);
			httpUrlConnection.setReadTimeout(timeOut);
			httpUrlConnection.setDoInput(true);
			
			// 设定传送的内容类型是可序列化的java对象    
			// (如果不设此项,在传送序列化对象时,当WEB服务默认的不是这种类型时可能抛java.io.EOFException) 
			//httpUrlConnection.setRequestProperty("Content-type","application/x-java-serialized-object");
			
			//web表单方式提交
			httpUrlConnection.setRequestProperty("Content-type","application/x-www-form-urlencoded;charset=UTF-8");			
			//httpUrlConnection.setRequestProperty("Content-type","text/plain; charset=utf-8");
			
			//处理不同的请求类型
			if("GET".equals(requestType) || "DELETE".equals(requestType)){
				httpUrlConnection.setRequestMethod(requestType);	
			}else{
				httpUrlConnection.setRequestMethod(requestType);	
				httpUrlConnection.setDoOutput(true);
				
				//建立输入流，向指向的URL post字节流
				//httpUrlConnection.getOutputStream().write(postData);
				
				
				//建立输入流，向指向的URL post字符串
				/*DataOutputStream dos = null;
				dos=new DataOutputStream(httpUrlConnection.getOutputStream());
				dos.writeBytes(postData);
				dos.flush();
				dos.close();*/
				
				pw = new PrintWriter(httpUrlConnection.getOutputStream());
				pw.print(postData);
	            pw.flush();
	            pw.close();
	            	            
			}
			
			httpUrlConnection.connect();
			
			//获取请求的返回值
			urlStream = httpUrlConnection.getInputStream();			
			BufferedReader reader = new BufferedReader(new InputStreamReader(urlStream, encoding));

			// 依次循环，至到读的值为空
			String s; 
			StringBuilder sb = new StringBuilder();
			while ((s = reader.readLine()) != null) {
				sb.append(s);
			}
			reader.close();
			responseHTML = sb.toString();			
						
			if(logger.isDebugEnabled()){	
				logger.debug("调用业务系统接口："+targetURL+"，的返回值");	
				logger.debug(responseHTML);
			}			
			
		} catch (Exception e) {
			logger.error(e.getMessage());
			if(logger.isDebugEnabled()){
				logger.debug("访问URL失败："+targetURL);
			}
			e.printStackTrace();
		} finally {
			if (null != null) {
				IOUtils.closeQuietly(urlStream);
				urlStream = null;
			}

			if (null != httpUrlConnection) {
				httpUrlConnection.disconnect();
			}
		}

		return responseHTML;
	}

	/**
	 * 获取请求的返回信息
	 * 
	 * @param httpUrlConnection
	 * @return 请求的返回信息
	 * @author 刘帅
	 * @throws 
	 */
	public static String getResponseHTML(HttpURLConnection httpUrlConnection) {
		String str = "";
		try {
			// 实例化输入流，并获取网页代码
			BufferedReader reader = new BufferedReader(new InputStreamReader(
					httpUrlConnection.getInputStream(), "UTF-8"));

			String s; // 依次循环，至到读的值为空
			StringBuilder sb = new StringBuilder();
			while ((s = reader.readLine()) != null) {
				sb.append(s);
			}
			reader.close();

			str = sb.toString();

		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}

		return str;
	}

    /** 
     * 对象转数组 
     * @param obj 
     * @return 
     */  
    public static byte[] toByteArray (Object obj) {     
        byte[] bytes = null;     
        ByteArrayOutputStream bos = new ByteArrayOutputStream();     
        try {       
            ObjectOutputStream oos = new ObjectOutputStream(bos);        
            oos.writeObject(obj);       
            oos.flush();        
            bytes = bos.toByteArray ();     
            oos.close();        
            bos.close();       
        } catch (Exception e) {       
            e.printStackTrace();  
            logger.error(e.getMessage());
        }     
        return bytes;   
    }  
      
    /** 
     * 数组转对象 
     * @param bytes 
     * @return 
     */  
    public static Object toObject (byte[] bytes) {     
        Object obj = null;     
        try {       
            ByteArrayInputStream bis = new ByteArrayInputStream (bytes);       
            ObjectInputStream ois = new ObjectInputStream (bis);       
            obj = ois.readObject();     
            ois.close();  
            bis.close();  
        } catch (Exception e) {       
            e.printStackTrace();   
            logger.error(e.getMessage());
        }
        return obj;   
    } 
	
	
	//获取post的body中指定name的参数
	public static String getRequestBodyParams(String requestBody,String paramName){
		String paramValue = "";
		try{
			if(null == requestBody || "".equals(requestBody) || requestBody.indexOf(paramName) == -1){
				return paramValue;
			}
			requestBody = "&"+requestBody+"&";
			paramValue = requestBody.substring(requestBody.indexOf("&"+paramName+"=") + ("&"+paramName+"=").length());
			paramValue = paramValue.substring(0,paramValue.indexOf("&"));
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return paramValue;
	}
	
	//将map中的参数拼接成post参数，并且可以指定参数的编码方式
	public static String getUrlParamByMap(Map<String,String> param,String encodeType){
		String urlParam = "";
		StringBuffer sb = new StringBuffer();
		try{
			for(String key:param.keySet()){				
				sb.append("&" + key + "=" + ((null != encodeType)?URLEncoder.encode(param.get(key),encodeType):param.get(key)));
			}
			urlParam = sb.toString();
			if(urlParam.length() > 0){
				urlParam = urlParam.substring(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return urlParam;
	}
	
	public static void printBrowserContent(HttpServletResponse response,String text){
		response.setHeader("Content-type","text/html;charset=UFT-8");
		response.setCharacterEncoding("UTF-8");
		PrintWriter pw;
		try {
			pw = response.getWriter();
			pw.write(text);
		} catch (IOException e) {
			e.printStackTrace();
		}	
	}
	
	/**
	 * 获取UUID
	 * 
	 * @return 返回唯一标识符UUID
	 * @author 
	 * @throws 
	 */
	public static String getUUID(){
		UUID uuid = UUID.randomUUID();     
        String str = uuid.toString(); 
        //cf66bb44-31b5-4b1f-afac-45ea345480f4
        return str;
	}
	
	public static String getRequestPostData(HttpServletRequest request,String characterEncoding){
		StringBuilder sb = new StringBuilder(); 
        try{ 
        	
        	if(null == characterEncoding || "".equals(characterEncoding)){
        		characterEncoding = request.getCharacterEncoding();
        	}
        	
        	BufferedReader reader = request.getReader();
        	char[]buff = new char[1024]; 
            int len; 
            while((len = reader.read(buff)) != -1) { 
            	sb.append(buff,0, len); 
            } 
        }catch (IOException e) { 
        	e.printStackTrace(); 
        } 
		return sb.toString();
	}
	
    /**
     * 解析出url参数中的键值对
     * 如 "index.jsp?Action=del&id=123"，解析出Action:del,id:123存入map中
     *
     *@param strUrlParam	URL中的参数
     * @param URL 			url地址
     * 	
     * @return url请求参数部分
     */
    public static Map<String, String> getUrlParams(String strUrlParam,String URL) {
        Map<String, String> mapRequest = new HashMap<String, String>();
 
        String[] arrSplit = null;
 
        if(null == strUrlParam || "".equals(strUrlParam)){
        	strUrlParam = TruncateUrlPage(URL);
        }
        
        if (strUrlParam == null) {
            return mapRequest;
        }
        //每个键值为一组 
        arrSplit = strUrlParam.split("[&]");
        for (String strSplit : arrSplit) {
            String[] arrSplitEqual = null;
            arrSplitEqual = strSplit.split("[=]");
 
            //解析出键值
            if (arrSplitEqual.length > 1) {
                //正确解析
                mapRequest.put(arrSplitEqual[0], arrSplitEqual[1]);
 
            } else {
                if (arrSplitEqual[0] != "") {
                    //只有参数没有值，不加入
                    mapRequest.put(arrSplitEqual[0], "");
                }
            }
        }
        return mapRequest;
    }

    /**
     * 去掉url中的路径，留下请求参数部分
     *
     * @param strURL url地址
     * @return url请求参数部分
     */
    public static String TruncateUrlPage(String strURL) {
        String strAllParam = null;
        String[] arrSplit = null;
 
        strURL = strURL.trim();
 
        arrSplit = strURL.split("[?]");
        if (strURL.length() > 1) {
            if (arrSplit.length > 1) {
                if (arrSplit[1] != null) {
                    strAllParam = arrSplit[1];
                }
            }
        }
 
        return strAllParam;
    }

	
	public static void main(String[] args) {

	}

	
    /**
     * 根据传入的key进行AES加密
     * @param sSrc 原文
     * @param sKey 加密key
     * @return 加密结果
     * @throws Exception
     */
    public static String encrypt(final String sSrc, final String sKey) throws Exception {
        if (sKey == null) {
            logger.warn("AES.encrypt: key is null");
            return null;
        }

        final byte[] raw = sKey.getBytes("ASCII");
        final SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
        final Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, skeySpec);
        final byte[] encrypted = cipher.doFinal(sSrc.getBytes("UTF-8"));
        return byte2hex(encrypted).toLowerCase(Locale.CHINA);
    }

    /**
     * byte转hex
     * @param bArr byte数组
     * @return hex字符串
     */
    public static String byte2hex(final byte[] bArr) {
        String hexString = "";
        String tmpString = "";
        final StringBuilder stringBuffer = new StringBuilder();
        for (final byte aBArr : bArr) {
            tmpString = Integer.toHexString(aBArr & 0XFF);
            if (tmpString.length() == 1) {
                stringBuffer.append("0").append(tmpString);
            } else {
                stringBuffer.append(tmpString);
            }
        }
        hexString = stringBuffer.toString();
        return hexString.toUpperCase(Locale.CHINA);
    }

    /**
     * 根据传入的key进行AES解密
     * @param sSrc 加密字符串
     * @param sKey 加密key
     * @return 解密结果
     */
    public static String decrypt(final String sSrc, final String sKey) {
        try {

            if (sKey == null) {
                logger.warn("AES.decrypt: key is null");
                return null;
            }

            final byte[] raw = sKey.getBytes("ASCII");
            final SecretKeySpec skeySpec = new SecretKeySpec(raw, "AES");
            final Cipher cipher = Cipher.getInstance("AES");
            cipher.init(Cipher.DECRYPT_MODE, skeySpec);
            final byte[] encrypted1 = hex2byte(sSrc);
            try {
                final byte[] original = cipher.doFinal(encrypted1);
                return new String(original,"UTF-8");
            } catch (final Exception e) {
                logger.warn(e.getMessage(), e);
                return null;
            }
        } catch (final Exception ex) {
            logger.warn(ex.getMessage(), ex);
            return null;
        }
    }

    /**
     *  hex转byte
     * @param hexString hex字符串
     * @return byte数组
     */
    public static byte[] hex2byte(final String hexString) {
        if (hexString == null) {
            return new byte[]{};
        }
        final int len = hexString.length();
        // l % 2 == 1
        if (len % 2 != 0) {
            return new byte[]{};
        }
        final byte[] bytes = new byte[len / 2];
        for (int i = 0; i != len / 2; i++) {
            bytes[i] = (byte) Integer.parseInt(hexString.substring(i * 2, i * 2 + 2),
                    16);
        }
        return bytes;
    }
}
