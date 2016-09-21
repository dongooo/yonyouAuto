package com.yyauto.common;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.MessageDigest;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * 加密安全类。。。
 * @author Administrator
 *
 */
public class Encryption {
	private static KeyGenerator keygen;
	private static SecretKey secretKey;
	private static Cipher cipher;
	private static Encryption security = null;

	private Encryption() {
	}

	public static Encryption getInstance() throws Exception {
		if (security == null) {
			security = new Encryption();
			keygen = KeyGenerator.getInstance("AES");
			secretKey = keygen.generateKey();
			cipher = Cipher.getInstance("AES");
		}
		return security;
	}
	
	/**
	 * MD5加码 生成32位md5码 
	 * @param inStr
	 * @return
	 */
	public static String string2MD5(String inStr){  
        MessageDigest md5 = null;  
        try{  
            md5 = MessageDigest.getInstance("MD5");  
        }catch (Exception e){  
            System.out.println(e.toString());  
            e.printStackTrace();  
            return "";  
        }  
        char[] charArray = inStr.toCharArray();  
        byte[] byteArray = new byte[charArray.length];  
  
        for (int i = 0; i < charArray.length; i++)  
            byteArray[i] = (byte) charArray[i];  
        byte[] md5Bytes = md5.digest(byteArray);  
        StringBuffer hexValue = new StringBuffer();  
        for (int i = 0; i < md5Bytes.length; i++){  
            int val = ((int) md5Bytes[i]) & 0xff;  
            if (val < 16)  
                hexValue.append("0");  
            hexValue.append(Integer.toHexString(val));  
        }  
        return hexValue.toString();  
  
    }  
  
    /** 
     * 加密解密算法 执行一次加密，两次解密 
     */   
    public static String convertMD5(String inStr){  
  
        char[] a = inStr.toCharArray();  
        for (int i = 0; i < a.length; i++){  
            a[i] = (char) (a[i] ^ 't');  
        }  
        String s = new String(a);  
        return s;  
  
    }  

	// 加密
	public String encrypt(String str) throws Exception {
		cipher.init(Cipher.ENCRYPT_MODE, secretKey);
		byte[] src = str.getBytes();
		byte[] enc = cipher.doFinal(src);
		return parseByte2HexStr(enc);
	}

	// 解密
	public String decrypt(String str) throws Exception {
		cipher.init(Cipher.DECRYPT_MODE, secretKey);

		byte[] enc = parseHexStr2Byte(str);
		byte[] dec = cipher.doFinal(enc);
		return new String(dec);
	}

	/** 
     * BASE64解密 
     *  
     * @param key 
     * @return 
     * @throws Exception 
     */  
    public String decryptBASE64(String key) throws Exception {
    	byte[] decodeBuffer = (new BASE64Decoder()).decodeBuffer(URLDecoder.decode(key));
    	
    	return new String(decodeBuffer, "UTF8");
    }  
  
    /** 
     * BASE64加密 
     *  
     * @param key 
     * @return 
     * @throws Exception 
     */  
    public String encryptBASE64(String str) throws Exception {
         return URLEncoder.encode((new BASE64Encoder()).encodeBuffer(str.getBytes("UTF8")));
    }  
    
	/**
	 * 将16进制转换为二进制
	 * 
	 * @param hexStr
	 * @return
	 */
	public static byte[] parseHexStr2Byte(String hexStr) {
		if (hexStr.length() < 1)
			return null;
		byte[] result = hexStr.getBytes();
//		byte[] result = new byte[hexStr.length() / 2];
		for (int i = 0; i < hexStr.length() / 2; i++) {
			int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
			int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2),
					16);
			result[i] = (byte) (high * 16 + low);
		}
		return result;
	}

	/**
	 * 将二进制转换成16进制
	 * 
	 * @param buf
	 * @return
	 */
	public static String parseByte2HexStr(byte buf[]) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < buf.length; i++) {
			String hex = Integer.toHexString(buf[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			sb.append(hex.toUpperCase());
		}
		return sb.toString();
	}

	public static void main(String[] args) throws Exception {
		String str = "abc haha 我";
//		String ss = Encryption.getInstance().encrypt(str);
//		System.out.println(ss);
//		System.out.println(Encryption.getInstance().decrypt(ss));
		//String username = "13975050198";
		//String password = "8be4e7aa4d5198ebb021b9f493babfc8";
		
		String s = new String("8be4e7aa4d5198ebb021b9f493babfc8");
        System.out.println("原始：" + s);  
        System.out.println("MD5后：" + string2MD5(s));
        str = convertMD5(s);
        System.out.println("解密的：" + convertMD5(str));  
        System.out.println("加密的：" + convertMD5((s)));  
        System.out.println("解密的：" + convertMD5(convertMD5((s))));
	}
}
