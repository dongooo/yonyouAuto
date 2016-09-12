package com.yyauto.controller;

import com.scienjus.authorization.annotation.Authorization;
import com.scienjus.authorization.annotation.CurrentUser;
import com.scienjus.authorization.manager.TokenManager;
import com.yyauto.dao.UserMapper;
import com.yyauto.model.BaseResult;
import com.yyauto.model.BaseToken;
import com.yyauto.model.User;
import com.yyauto.model.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
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

    @Autowired
    private TokenManager tokenManager;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserMapper userMapper;

    /***
     * 系统登录
     * @param user
     * @return
     */
    @RequestMapping(method = RequestMethod.POST,value = "/login")
    public @ResponseBody ResponseEntity login(@RequestBody User user){
        String userName = user.getUserName();
        String password = user.getPassword();
        Assert.notNull(userName,"userNmae can not be empty");
        Assert.notNull(password,"password can not be empty");

        User userMap = userMapper.findByUserName(userName);
        if(userMap == null){
            return new ResponseEntity<BaseResult>(BaseResult.ok("用户不存在"),HttpStatus.OK);
        }else if(!userMap.getPassword().equals(password)){
            return new ResponseEntity<BaseResult>(BaseResult.ok("密码错误"),HttpStatus.OK);
        }
        String token = UUID.randomUUID().toString();
        tokenManager.createRelationship(userMap.getUid(),token);
        return new ResponseEntity<BaseResult>(BaseResult.ok(token),HttpStatus.OK);
    }

    /***
     * 检查token有效性
     * @return
     */
    @RequestMapping(method =RequestMethod.GET,value = "tokenValidate")
    public @ResponseBody ResponseEntity tokenValidate(){
        return null;
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
