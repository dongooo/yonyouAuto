package com.yyauto.common;

import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.impl.crypto.MacProvider;
import org.junit.Test;

import javax.servlet.ServletContext;
import java.io.*;
import java.security.Key;

/**
 * description: 生成签名证书工具类
 * author: dongooo
 * create: 2016-09-13 下午1:52
 * php: https://github.com/dongooo
 **/

public class KeyUtil {

    public static Key getKey(ServletContext servletContext){
        String path = servletContext.getRealPath("/");
        File file = new File(path,"keyStore.txt");
        try {
            //证书文件不存在
            if(!file.exists()){
                Key key = MacProvider.generateKey(SignatureAlgorithm.HS512);
                ObjectOutputStream oStream = new ObjectOutputStream(new FileOutputStream(file));
                oStream.writeObject(key);
                oStream.close();
                return key;
            }
            ObjectInputStream oIStream = null;
            oIStream = new ObjectInputStream(new FileInputStream(file));
            Key key = (Key) oIStream.readObject();
            return key;
        }catch (Exception ex){
            ex.printStackTrace();
            return null;
        }
    }

}
