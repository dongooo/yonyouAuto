package com.yyauto.filter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * description: CORS跨域请求解决
 * author: dongooo
 * create: 2016-07-22 上午11:05
 * php: https://github.com/dongooo
 **/

public class httpCORSFilter extends OncePerRequestFilter {

    private static final Log LOG = LogFactory.getLog(httpCORSFilter.class);

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException,IOException{
        response.addHeader("Access-Control-Allow-Origin","*");

        //if(request.getHeader("Access-Control-Request-Method") != null && "OPTIONS".equals(request.getMethod())){
            LOG.trace("Sending Header....");
            response.addHeader("Access-Control-Allow-Methods","GET,POST,PUT,DELETE,OPTIONS");
            response.addHeader("Access-Control-Allow-Headers","If-Modified-Since,Content-Type,Authorization");
            response.addHeader("Access-Control-Max-Age","3600");
        //}
        filterChain.doFilter(request,response);
    }

}
