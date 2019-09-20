/*
 * Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
 * SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */
package com.hd.rcugrc.product.servlet.mvc;

import com.hd.rcugrc.security.user.User;
import com.hd.rcugrc.security.user.UserInfoService;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *
 * @author <a href="mailto:songjw@smartdot.com.cn">JiWen</a>
 * @version 1.0, 2019-09-18
 */
@RequestMapping("/user/product/oa/hikVideoConference")
public class HikVideoConferenceController {

    final static Logger logger = LoggerFactory.getLogger(ExternalInterfaceCallController.class);

    @Resource
    private UserInfoService userInfoService;

    @Value("${hd.integrate.oa.hikVideoConferenceLogin}")
    private String hikVideoConferenceAddress;

    @RequestMapping(value="login")
    @ResponseBody
    public String hikLogin(
            HttpServletRequest request,
            HttpServletResponse response){
        String result = "{\"code\":\"\"}";
        String account = request.getParameter("account");
        User user = userInfoService.getUserByAccount(account);
        String name = user.getName();
        String pwd = user.getPassword();
        String token = user.getAccount();
        CloseableHttpClient client = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost(hikVideoConferenceAddress);
        try {
            List<NameValuePair> params = new ArrayList<>();
            params.add(new BasicNameValuePair("name", name));
            params.add(new BasicNameValuePair("password", pwd));
            params.add(new BasicNameValuePair("token", token));
            post.setEntity(new UrlEncodedFormEntity(params, "UTF-8"));
            HttpResponse nresponse = client.execute(post);
            String res = EntityUtils.toString(nresponse.getEntity());
            result = res;
            System.out.println(res);
            ((CloseableHttpResponse) nresponse).close();
            client.close();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }


}
