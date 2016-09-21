package com.yyauto.common;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.impl.crypto.MacProvider;

import java.security.Key;
import java.security.Signature;
import java.util.Date;

/**
 * description: json web token management
 * author: dongooo
 * create: 2016-09-13 下午12:20
 * php: https://github.com/dongooo
 **/

public final class JWTManager {


    private static Key getSignatureKey() {
        //临时使用
        return MacProvider.generateKey();
    }

    /***
     * 用签名算法HS256和私钥key生成token
     * @param userName
     * @param expires
     * @return
     */
    public static String generateToken(String userName, Date expires,Key key){
        if(userName == null){
            throw new NullPointerException("null userName illegal !");
        }
        if(expires == null){
            throw new NullPointerException("null expires is illegal !");
        }

        //Key key = getSignatureKey();

        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS512;
        String jwtString = Jwts.builder()
                .setIssuer("YYAuto")//设置发行人
                .setSubject(userName)//设置抽象主题
                .setAudience("user")//设置角色
                .setExpiration(expires)//过期时间
                .setIssuedAt(new Date())//设置现在时间
                .setId("v1")//版本v1
                .signWith(signatureAlgorithm,key)
                .compact();
        return jwtString;
    }

    /***
     * 验证token是否有效
     * @param token
     * @param key
     * @return
     */
    public static boolean verifyToken(String token,Key key){
        try {
            Jwts.parser().setSigningKey(key).parseClaimsJws(token.trim());
            return true;
        }catch (Exception ex){
            ex.printStackTrace();
            return false;
        }
    }

    /***
     * 获取token中存储的用户名
     * @param jwsToken
     * @param key
     * @return
     */
    public static String getUserName(String jwsToken,Key key){
        if(verifyToken(jwsToken,key)){
            Jws<Claims> claimsJws = Jwts.parser().setSigningKey(key).parseClaimsJws(jwsToken);
            return claimsJws.getBody().getSubject();
        }
        return null;
    }

    /***
     * 获取token中存储的用户角色
     * @param jwsToken
     * @param key
     * @return
     */
    public static String[] getRoles(String jwsToken,Key key){
        if(verifyToken(jwsToken,key)){
            Jws<Claims> claimsJws = Jwts.parser().setSigningKey(key).parseClaimsJws(jwsToken);
            return claimsJws.getBody().getAudience().split(",");
        }
        return new String[]{};
    }

    /***
     * 获取版本信息
     * @param jwsToken
     * @param key
     * @return
     */
    public static String getVersion(String jwsToken,Key key){
        if(verifyToken(jwsToken,key)){
            Jws<Claims> claimsJws = Jwts.parser().setSigningKey(key).parseClaimsJws(jwsToken);
            return claimsJws.getBody().getId();
        }
        return "";
    }



}
