/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.hd.rcugrc.project.oa.portal.appusedrecord.service.impl;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hd.rcugrc.product.oa.common.util.MyEscapeUtil;
import com.hd.rcugrc.product.oa.common.util.StringUtils;
import com.hd.rcugrc.project.oa.portal.appusedrecord.dao.AppUsedRecordDao;
import com.hd.rcugrc.project.oa.portal.appusedrecord.service.AppUsedRecordService;


/**
* <p>
* 
* @author <a href="mailto:songjw@smartdot.com.cn">songjw</a>
* @version 1.0, 2019年10月12日
*/
public class AppUsedRecordServiceImpl implements AppUsedRecordService {

    final static Logger logger = LoggerFactory.getLogger(AppUsedRecordServiceImpl.class);
    private String loginfoIp;
    private String sendWeAppUsedDatasPath;
    private AppUsedRecordDao appUsedRecordDao;
    
    public String getLoginfoIp() {
        return loginfoIp;
    }
    public void setLoginfoIp(String loginfoIp) {
        this.loginfoIp = loginfoIp;
    }
    public String getSendWeAppUsedDatasPath() {
        return sendWeAppUsedDatasPath;
    }
    @Resource
    public void setSendWeAppUsedDatasPath(String sendWeAppUsedDatasPath) {
        this.sendWeAppUsedDatasPath = sendWeAppUsedDatasPath;
    }
    public AppUsedRecordDao getAppUsedRecordDao() {
        return appUsedRecordDao;
    }
    @Resource
    public void setAppUsedRecordDao(AppUsedRecordDao appUsedRecordDao) {
        this.appUsedRecordDao = appUsedRecordDao;
    }
    
    public JSONArray getAppUsedRecordInfo(String startTime,String endTime){
        System.out.println("AppUsedRecordServiceImpl.getAppUsedRecordInfo()");
        List<Map<String, Object>> recordInfo = appUsedRecordDao.getAppUsedRecordInfo("2019-10-11 13:36:16","2019-10-12 14:36:58");
        JSONArray jsonArray = new JSONArray();
        for(Map<String, Object> map:recordInfo){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("appid",map.get("APPID"));
            jsonObject.put("appname",map.get("APPNAME"));
            jsonObject.put("organid",map.get("ORGANID"));
            jsonObject.put("cnt",map.get("CNT"));
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }
    
    @Override
    public String postAppUserRecordInfo(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar calendar = Calendar.getInstance();
        String endTime_s = sdf.format(calendar.getTime());
        String endTime = sdf2.format(calendar.getTime());
        calendar.add(Calendar.HOUR_OF_DAY, -1);
        String startTime_s = sdf.format(calendar.getTime());
        String startTime = sdf2.format(calendar.getTime());
        JSONArray dataJson = this.getAppUsedRecordInfo(startTime_s,endTime_s);
        
        String url = loginfoIp+sendWeAppUsedDatasPath+"?startTime="+startTime+"&endTime="+endTime+"&dataJson="+MyEscapeUtil.escape(MyEscapeUtil.escape(dataJson.toString()));
        String result = "";
        HttpPost post = new HttpPost(url);
        try {
            CloseableHttpClient httpClient = HttpClients.createDefault();
            post.setHeader("Content-Type","application/json;charset=utf-8");
            post.addHeader("Authorization","Basic YWRtaW46");
            /*StringEntity postingString = new StringEntity(itemProcessListInfo.toString(),"utf-8");
            post.setEntity(postingString);*/
            HttpResponse response = httpClient.execute(post);
            InputStream in = response.getEntity().getContent();
            BufferedReader br = new BufferedReader(new InputStreamReader(in,"utf-8"));
            StringBuilder strber = new StringBuilder();
            String line = null;
            while((line = br.readLine())!=null){
                strber.append(line + "\n");
            }
            br.close();
            in.close();
            result = strber.toString();
            if(response.getStatusLine().getStatusCode()!=HttpStatus.SC_OK){
                logger.error("服务器异常。");
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new RuntimeException(e);
        }finally{
            post.abort();
        }
        JSONObject jsonObject = JSONObject.parseObject(result);
        if(jsonObject!=null){
            if(jsonObject.getString("resultCode").equals(1)){
                logger.info("首页链接访问量数据推送成功。");
                this.removeRecord("");
            }else{
                logger.error(jsonObject.getString("resultMsg"));
            }
        }else{
            logger.error("首页链接访问量数据推送接口返回数据格式错误。");
        }        
        
        return result;
    }
    
    @Override
    public void removeRecord(String endTime){
        if(StringUtils.isBlank(endTime)){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.HOUR_OF_DAY, -30);
            endTime = sdf.format(calendar.getTime());
        }
        appUsedRecordDao.removeRecord(endTime);
    }
}
