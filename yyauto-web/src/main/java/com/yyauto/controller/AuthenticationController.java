package com.yyauto.controller;

import com.scienjus.authorization.annotation.Authorization;
import com.scienjus.authorization.annotation.CurrentUser;
import com.scienjus.authorization.manager.TokenManager;
import com.yyauto.common.JWTManager;
import com.yyauto.common.KeyUtil;
import com.yyauto.common.Util;
import com.yyauto.dao.UserMapper;
import com.yyauto.model.BaseResult;
import com.yyauto.model.BaseToken;
import com.yyauto.model.User;
import com.yyauto.model.UserRepository;
import com.yyauto.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * description: 权限认证控制器
 * author: dongooo
 * create: 2016-09-05 上午11:26
 * php: https://github.com/dongooo
 **/
@RestController
@RequestMapping("/auth")
public class AuthenticationController {

    @Context
    ServletContext servletContext;

    @Autowired
    private TokenManager tokenManager;

    @Autowired
    private UserRepository userRepository;

    @Resource
    private IUserService iUserService;

    /***
     * 系统登录
     * @param user
     * @return
     */
    @RequestMapping(method = RequestMethod.POST,value = "/login")
    public @ResponseBody Map<String,Object> login(@RequestBody User user, HttpServletRequest req){
        try{
            String userName = user.getUserName();
            String password = user.getPassword();
            Assert.notNull(userName,"userNmae can not be empty");
            Assert.notNull(password,"password can not be empty");

            Map<String,Object> resultMap = new HashMap<String, Object>();
            Map<String,Object> map = new HashMap<String, Object>();
            User userMap = iUserService.findByUserName(userName);
            if(userMap == null){
                //return new ResponseEntity<BaseResult>(BaseResult.ok("用户不存在"),HttpStatus.OK);
            }else if(!userMap.getPassword().equals(password)){
                //return new ResponseEntity<BaseResult>(BaseResult.ok("密码错误"),HttpStatus.OK);
            }
            //String token = UUID.randomUUID().toString();

            Date expiry = Util.getExpiryDate(7*24*60);
            String jwtString = JWTManager.generateToken(userName,expiry, KeyUtil.getKey(req.getServletContext()));
            tokenManager.createRelationship(userMap.getUid(),jwtString);
            resultMap.put("expiry",expiry);
            resultMap.put("access_token",jwtString);
            resultMap.put("uid",userMap.getUid());
            resultMap.put("client_id",UUID.randomUUID().toString());
            map.put("data",resultMap);
            return map;
            //return new ResponseEntity<BaseResult>(BaseResult.ok(jwtString),HttpStatus.OK);
        }catch (Exception ex){
            ex.printStackTrace();
            return null;
            //return new ResponseEntity<BaseResult>(BaseResult.ok(ex.getMessage()),HttpStatus.OK);
        }

    }

    /***
     * 检查token有效性
     * @return
     */
    @RequestMapping(method =RequestMethod.GET,value = "tokenValidate")
    public @ResponseBody ResponseEntity tokenValidate(HttpServletRequest req){
        String token = req.getHeader("Authorization");
        boolean isValidation = JWTManager.verifyToken(token,KeyUtil.getKey(req.getServletContext()));
        return new ResponseEntity<BaseResult>(BaseResult.ok(isValidation),HttpStatus.OK);
    }

    /***
     * 获取用户信息
     * @param currentUser
     * @return
     */
    @RequestMapping(method = RequestMethod.GET,value = "/getUserName")
    @Authorization
    public @ResponseBody ResponseEntity<BaseResult> getUsername(@CurrentUser User currentUser) {
        //生成一个token
        return new ResponseEntity<BaseResult>(BaseResult.ok(currentUser.getNickName()+currentUser.getUid()), HttpStatus.OK);
    }

    /***
     * 退出登录
     * @param currentUser
     * @return
     */
    @RequestMapping(method = RequestMethod.DELETE,value = "/logout")
    @Authorization
    public ResponseEntity<BaseResult> logout(@CurrentUser User currentUser) {
        tokenManager.delRelationshipByKey(currentUser.getUid());
        return new ResponseEntity<BaseResult>(BaseResult.ok(), HttpStatus.OK);
    }

}
