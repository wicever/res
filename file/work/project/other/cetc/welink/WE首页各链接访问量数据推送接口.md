
[TOC]

# 各应用点击量统计数据【事件绑定并传参】【string转JSONObject】【ajax-Controller】
## 需求背景
需要对WE首页各个应用访问量进行统计，所以需要记录各应用点击量数据，并通过接口推送到第三方

## 接口约定
|接口约定|值|说明|其他|
|-|-|-|-|
|应用注册接口||||
|接口路径|http://192.168.65.69:8080/werank/mng/registryWeApp|||
|参数||||
|appPrefix|20191010080000|String,应用标识大小写不敏感||
|appName|20191010090000|String,应用名，必须escape转码两次，转码前如：一网通办||
|dataJson|String,||
|返回结果|{"resultCode":0,"resultMsg":"开始时间不可大于结束时间"}|resultCode,int,结果编码1成功0失败，resultMsg,String,结果信息||
|访问量数据推送接口||||
|接口路径|http://192.168.65.69:8080/werank/stat/sendWeAppUsedDatas|post请求，参数直接放url里||
|参数||||
|startTime|20191010080000|String,开始时间||
|endTime|20191010090000|String,结束时间||
|dataJson|String,转码前：[{"appprefix":"ywtb","organid":"j4","cnt":20},{"appprefix":"ywtb","organid":"j4","cnt":20}]|各应用点击量信息，JSON需要通过第三方给的工具类MyEscapeUtil.escape进行两次转码，其中organid是机构ORGID，appprefix应用id，cnt是点击量【此接口使用前需要先注册】||
|返回结果|{"resultCode":0,"resultMsg":"开始时间不可大于结束时间"}|resultCode,int,结果编码1成功0失败，resultMsg,String,结果信息||

## 设计思路
1. 增加点击量记录表：点击时间、点击人account、点击人名称、点击人部门id、点击人在部门ORGID、点击人在部门名称、应用id、应用名、
2. 首页增加链接统一跳转函数，绑定需要监控的元素（我的邮件、我的网盘、全景图、电科头条、共享资源、视频会议、公文、资源下载、一网通办、通知公告、个人日程）
3. 点击时调用统一跳转函数跳转并记录点击相关信息
4. 增加定时任务（每小时cronExpression："0 0 0/1 * * ?"同步），定时推送之前1小时的点击量数据
5. 推送完成后删除创建时间在此之前30天的数据

## 设计实现
### 增加参数：core.properties
hd.integrate.loginfo.ip=http://192.168.65.69:8080
hd.integrate.sendWeAppUsedDatas.path=/werank/stat/sendWeAppUsedDatas
hd.integrate.registryWeApp.path=/werank/mng/registryWeApp

### 创建点击量记录表sql
```
-- 创建WE首页各链接访问量数据
-- DROP TABLE OA_APPUSED_DATAS;
create table OA_APPUSED_DATAS(
	ID INT8 NOT NULL,
    CREATION_TIME timestamp ,
    CREATOR_ACCOUNT VARCHAR2(32 CHAR),
    CREATOR_NAME VARCHAR2(50 CHAR),
    CREATE_DEPT_ID INT8,
    CREATE_DEPT_ORGID VARCHAR2(255 CHAR),
    CREATE_DEPT_NAME VARCHAR2(255 CHAR),
    APPID VARCHAR2(255 CHAR),
    APPNAME VARCHAR2(255 CHAR),
	
	constraint PK_OA_APPUSED_DATAS primary key (ID)
);
comment on table OA_APPUSED_DATAS is 'WE首页各链接访问量数据';
comment on column OA_APPUSED_DATAS.ID is 'ID';
comment on column OA_APPUSED_DATAS.CREATION_TIME is '创建时间';
comment on column OA_APPUSED_DATAS.CREATOR_ACCOUNT is '创建用户帐号';
comment on column OA_APPUSED_DATAS.CREATOR_NAME is '创建用户名称';
comment on column OA_APPUSED_DATAS.CREATE_DEPT_ID is '创建部门ID';
comment on column OA_APPUSED_DATAS.CREATE_DEPT_ORGID is '创建部门编码';
comment on column OA_APPUSED_DATAS.CREATE_DEPT_NAME is '创建部门名称';
comment on column OA_APPUSED_DATAS.APPID is '访问应用id';
comment on column OA_APPUSED_DATAS.APPNAME is '访问的应用名';
```

### 前端跳转函数【事件绑定并传参】
在普通用户和领导首页需要监控的元素增加class，并将class增加到js的apps对象中
在`/grc_office/src/project/src/main/webapp/resources/portal/user/js/userpage.js`和`/grc_office/src/project/src/main/webapp/resources/portal/leader/js/leaderpage.js`增加如下代码
```

//首页页面元素，页面加载后即可绑定事件
var apps = {
    "mail":"我的邮件",
    "disk":"我的网盘",
    "zszx":"共享资源",
    "gongwen":"公文",
    "down":"资源下载",
    "ywtb":"一网通办",
    "tzgg":"通知公告",//通知公告更多
    "grrc":"个人日程",//个人日程更多
}
/* 特殊模块如列表异步加载需要分别单独增加
 * addAppUsedRecord("","","");
 * 领导"我的邮件"在函数：openMailList中增加，(leaderpage.js：addAppUsedRecord("","mail","我的邮件");)
 * 邮件列表点击监控在函数：openMail，(leaderpage.js、userpage.js：addAppUsedRecord("","mail","我的邮件");)
 * 全景图加载即增加记录在:CetcBiInfo.initCetcBiInfo，(leaderpage.js：addAppUsedRecord("","qjt","全景图");)
 * 电科头条在函数：openNewsDetails，(leaderpage.js、userpage.js：addAppUsedRecord("","dktt","电科头条");)
 * 视频会议在函数：hikMessageHint.js中增加addAppUsedRecord("","sphy","视频会议");
 * 通知公告列表点击监控在：Notice.initNoticeList中增加addAppUsedRecord("","tzgg","通知公告");(userpage.js)
 * 个人日程加载即增加记录在：(schedule.js、scheduleByUser.js：addAppUsedRecord("","grrc","个人日程");)
 * 
 */


function bindSuperLink(){
  $.each(apps,function(appId,appName){
     $("."+appId).on("click",{"appId":appId,"appName":appName},addAppUsedRecord);
  })
}

//增加链接访问记录
function addAppUsedRecord(event,appId,appName){
  if(appId=="" || appId==undefined || appName=="" || appName==undefined){
    appId = event.data.appId;
    appName = event.data.appName;
  }
  if(appId=="" || appId==undefined || appName=="" || appName==undefined){
    console.log("appId、appName 不能为空。");
  }else{
    $.ajax({
      type: "post",
      url: contextPath + "/user/rest/appUsedDate/add",
      async:true,
      dataType: "json",
      data: {account:pageConfig.currentUserInfo.currentUserAccount,name:pageConfig.currentUserInfo.currentUserName,deptId:pageConfig.currentUserInfo.currentUserDeptId,deptName:pageConfig.currentUserInfo.currentUserDeptName,appId:appId,appName:appName},
      success: function(result){
        if(result && result.status=="1"){
          console.log(appName+" 已增加访问记录。");
        }else{
          console.log(result.msg);
        }
      },
      error:function(jqXHR, textStatus, errorThrown){
        console.log("增加访问记录"+jqXHR.status+"："+textStatus);
      }
    });
  }
}

//绑定链接点击事件
$(document).ready(function() {
  //首页元素事件绑定
  bindSuperLink();
  //右上角小三角资源下载
  $("#portal_srcDownload").on("click",{"appId":"down","appName":"资源下载"},addAppUsedRecord);
});
```

### 后台记录点击信息
#### Entity
/grc_office/src/project/src/main/java/com/hd/rcugrc/project/oa/portal/appusedrecord/entity/AppUsedRecordEntity.java
```
/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.hd.rcugrc.project.oa.portal.appusedrecord.entity;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;
import org.joda.time.DateTime;

import com.hd.rcugrc.product.oa.EntityType;
import com.hd.rcugrc.product.oa.annotation.BusinessEntity;

/**
* <p>
* 
* @author <a href="mailto:songjw@smartdot.com.cn">songjw</a>
* @version 1.0, 2019年10月11日
*/

@BusinessEntity(module = "首页各链接访问记录", entityName = "首页各链接访问记录", entityType = EntityType.CONFIG)
@Entity(name = "AppUsedRecordEntity")
@Table(name = "OA_APPUSED_DATAS")
public class AppUsedRecordEntity {

    private Long id;
    private DateTime creationTime;
    private String creatorAccount;
    private String creatorName;
    private Long createDeptId;
    private String createDeptOrgId;
    private String createDeptName;
    private String appId;
    private String appName;
    
    @Id
    @GeneratedValue(generator = "AppUsedRecordEntityIdGenerator")
    @GenericGenerator(name = "AppUsedRecordEntityIdGenerator", strategy = "com.hd.rcugrc.data.ids.TableBasedLongIdGenerator", parameters = {
            @org.hibernate.annotations.Parameter(name = "table_name", value = "HD_ID_GEN"),
            @org.hibernate.annotations.Parameter(name = "segment_column_name", value = "ID_NAME"),
            @org.hibernate.annotations.Parameter(name = "value_column_name", value = "ID_VAL"),
            @org.hibernate.annotations.Parameter(name = "segment_value", value = "OA_APPUSED_DATAS"),
            @org.hibernate.annotations.Parameter(name = "increment_size", value = "1") })
    @Column(name = "ID")
    public Long getId() {
        return id;
    }
    public void setId(Long id) {
        this.id = id;
    }
    
    @Column(name = "CREATION_TIME")
    @Type(type = "com.hd.rcugrc.data.hibernate.type.DateTimeType")
    public DateTime getCreationTime() {
        return creationTime;
    }
    public void setCreationTime(DateTime creationTime) {
        this.creationTime = creationTime;
    }
    @Column(name = "CREATOR_ACCOUNT")
    public String getCreatorAccount() {
        return creatorAccount;
    }
    public void setCreatorAccount(String creatorAccount) {
        this.creatorAccount = creatorAccount;
    }
    @Column(name = "CREATOR_NAME")
    public String getCreatorName() {
        return creatorName;
    }
    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }
    @Column(name = "CREATE_DEPT_ID")
    public Long getCreateDeptId() {
        return createDeptId;
    }
    public void setCreateDeptId(Long createDeptId) {
        this.createDeptId = createDeptId;
    }
    @Column(name = "CREATE_DEPT_ORGID")
    public String getCreateDeptOrgId() {
        return createDeptOrgId;
    }
    public void setCreateDeptOrgId(String createDeptOrgId) {
        this.createDeptOrgId = createDeptOrgId;
    }
    @Column(name = "CREATE_DEPT_NAME")
    public String getCreateDeptName() {
        return createDeptName;
    }
    public void setCreateDeptName(String createDeptName) {
        this.createDeptName = createDeptName;
    }
    @Column(name = "APPID")
    public String getAppId() {
        return appId;
    }
    public void setAppId(String appId) {
        this.appId = appId;
    }
    @Column(name = "APPNAME")
    public String getAppName() {
        return appName;
    }
    public void setAppName(String appName) {
        this.appName = appName;
    }
    
}

```
#### Dao
/grc_office/src/project/src/main/java/com/hd/rcugrc/project/oa/portal/appusedrecord/dao/AppUsedRecordDao.java
```
/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.hd.rcugrc.project.oa.portal.appusedrecord.dao;

import java.util.List;
import java.util.Map;

import org.joda.time.DateTime;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.hd.rcugrc.data.jpa.GenericRepository;
import com.hd.rcugrc.project.oa.portal.appusedrecord.entity.AppUsedRecordEntity;

/**
* <p>
* 
* @author <a href="mailto:songjw@smartdot.com.cn">songjw</a>
* @version 1.0, 2019年10月11日
*/
public interface AppUsedRecordDao extends GenericRepository<AppUsedRecordEntity,Long>{

    @Transactional(readOnly=true)
    @Query(value="SELECT T.appId AS APPID,T.appName AS APPNAME,T.createDeptOrgId AS ORGANID,COUNT(*) AS CNT FROM AppUsedRecordEntity T WHERE T.creationTime BETWEEN :startTime AND :endTime GROUP BY T.createDeptOrgId,T.appId,T.appName ORDER BY T.createDeptOrgId")
    public List<Map<String,Object>> getAppUsedRecordInfo(@Param(value="startTime") DateTime startTime,@Param(value="endTime") DateTime endTime);
    
/*    @Transactional(readOnly=true)
    @Query(value="SELECT T.APPID,T.APPNAME,T.CREATE_DEPT_ORGID AS ORGANID,COUNT(*) AS CNT FROM OA_APPUSED_DATAS T WHERE T.CREATION_TIME BETWEEN :startTime AND :endTime GROUP BY T.CREATE_DEPT_ORGID,T.APPID,T.APPNAME ORDER BY T.CREATE_DEPT_ORGID",nativeQuery=true)
    public List<Map<String,Object>> getAppUsedRecordInfo(@Param(value="startTime") String startTime,@Param(value="endTime") String endTime);
   */
    
    @Transactional
    @Modifying
    @Query(value="DELETE FROM OA_APPUSED_DATAS T WHERE T.CREATION_TIME < :endTime",nativeQuery=true)
    public void removeRecord(@Param(value="endTime") String endTime);
}


```
修改/grc_office/src/product/src/main/java/com/hd/rcugrc/product/oa/cloudSyn/dao/GroupSynchroDao.java
增加
```
@Query(value = "SELECT t.orgId FROM com.hd.rcugrc.product.oa.cloudSyn.entity.GroupSynchroEntity t WHERE t.groupId = :groupId")
    public String getOrgidByGroupId(@Param(value = "groupId") Long groupId);
```

#### Controller【string转JSONObject】
/grc_office/src/project/src/main/java/com/hd/rcugrc/project/servlet/mvc/AppUsedDateController.java
```
/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.hd.rcugrc.project.servlet.mvc;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.hd.rcugrc.product.oa.cloudSyn.dao.GroupSynchroDao;
import com.hd.rcugrc.product.oa.common.util.StringUtils;
import com.hd.rcugrc.project.oa.portal.appusedrecord.dao.AppUsedRecordDao;
import com.hd.rcugrc.project.oa.portal.appusedrecord.entity.AppUsedRecordEntity;
import com.hd.rcugrc.project.oa.portal.appusedrecord.service.AppUsedRecordService;

import oracle.net.aso.a;

/**
* <p> WE首页各链接访问量记录
* 
* @author <a href="mailto:songjw@smartdot.com.cn">songjw</a>
* @version 1.0, 2019年10月10日
*/

@Controller
@RequestMapping(value="/user/rest/appUsedDate")
public class AppUsedDateController {
    
    final static Logger logger = LoggerFactory.getLogger(AppUsedDateController.class);
    @Resource
    private GroupSynchroDao groupSynchroDao;
    @Resource(name="appUsedRecordService")
    private AppUsedRecordService appUsedRecordService;
    @Resource
    private AppUsedRecordDao appUsedRecordDao;
    private EntityManager entityManager;
    
    @PersistenceContext(unitName = "appEntityManager")
    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }
    
    @Transactional
    @RequestMapping(value="/add",method=RequestMethod.POST)
    @ResponseBody
    public JSONObject add(HttpServletRequest request,HttpServletResponse response){
        String result = "{\"msg\": \"error\",\"status\": \"0\"}";
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Calendar calendar = Calendar.getInstance();
            String CREATOR_ACCOUNT = request.getParameter("account");
            String CREATOR_NAME = request.getParameter("name");
            String CREATE_DEPT_ID = request.getParameter("deptId");
            String CREATE_DEPT_NAME = request.getParameter("deptName");
            String APPID = request.getParameter("appId");
            String APPNAME = request.getParameter("appName");
            String CREATE_DEPT_ORGID = groupSynchroDao.getOrgidByGroupId(Long.valueOf(CREATE_DEPT_ID));
            if(CREATE_DEPT_ORGID!=null){
/*                StringBuilder query = new StringBuilder("INSERT INTO OA_AION_APPUSED_DATAS (");
                query.append(" CREATOR_ACCOUNT,CREATOR_NAME,CREATE_DEPT_ID,CREATE_DEPT_ORGID,CREATE_DEPT_NAME,APPID,APPNAME ");
                query.append(" ) VALUES (");
                query.append(" '"+CREATOR_ACCOUNT+"','"+CREATOR_NAME+"',"+CREATE_DEPT_ID+",'"+CREATE_DEPT_ORGID+"','"+CREATE_DEPT_NAME+"','"+APPID+"','"+APPNAME +"'");*/
//                query.append(":CREATION_TIME,:CREATOR_ACCOUNT,:CREATOR_NAME,:CREATE_DEPT_ID,:CREATE_DEPT_ORGID,:CREATE_DEPT_NAME,:APPID,:APPNAME ");
//                query.append(" ':CREATION_TIME',':CREATOR_ACCOUNT',':CREATOR_NAME',:CREATE_DEPT_ID,':CREATE_DEPT_ORGID',':CREATE_DEPT_NAME',':APPID',':APPNAME' ");
               /* query.append(" )");
                Query emQuery = entityManager.createNativeQuery(query.toString());*/
                /*emQuery.setParameter("CREATION_TIME", CREATION_TIME);
                emQuery.setParameter("CREATOR_ACCOUNT", CREATOR_ACCOUNT);
                emQuery.setParameter("CREATOR_NAME", CREATOR_NAME);
                emQuery.setParameter("CREATE_DEPT_ID", CREATE_DEPT_ID);
                emQuery.setParameter("CREATE_DEPT_ORGID", CREATE_DEPT_ORGID);
                emQuery.setParameter("CREATE_DEPT_NAME", CREATE_DEPT_NAME);
                emQuery.setParameter("APPID", APPID);
                emQuery.setParameter("APPNAME", APPNAME);*/
                /*List list = emQuery.getResultList();
                if(list.size()>0){
                    result = "{\"msg\": \"ok\",\"status\": \"1\"}}";
                }*/
                
                AppUsedRecordEntity appUsedRecordEntity = new AppUsedRecordEntity();
//                calendar.add(Calendar.HOUR_OF_DAY, 8);
                DateTime CreationTime = new DateTime(calendar.get(Calendar.YEAR),calendar.get(Calendar.MONTH),calendar.get(Calendar.DAY_OF_MONTH),calendar.get(Calendar.HOUR_OF_DAY),calendar.get(Calendar.MINUTE),calendar.get(Calendar.SECOND));
                
                appUsedRecordEntity.setCreationTime(CreationTime);
                appUsedRecordEntity.setCreatorAccount(CREATOR_ACCOUNT);
                appUsedRecordEntity.setCreatorName(CREATOR_NAME);
                appUsedRecordEntity.setCreateDeptId(Long.valueOf(CREATE_DEPT_ID));
                appUsedRecordEntity.setCreateDeptName(CREATE_DEPT_NAME);
                appUsedRecordEntity.setCreateDeptOrgId(CREATE_DEPT_ORGID);
                appUsedRecordEntity.setAppId(APPID);
                appUsedRecordEntity.setAppName(APPNAME);
                AppUsedRecordEntity saveAndFlush = appUsedRecordDao.saveAndFlush(appUsedRecordEntity);
                if (saveAndFlush!=null) {
                    result = "{\"msg\": \"ok\",\"status\": \"1\"}";
                }
                
            }else{
                result = "{\"msg\": \"未查询到ORGID\",\"status\": \"0\"}";
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
//            throw new RuntimeException(e);
        }
        return JSONObject.parseObject(result);
    }
    
    @ResponseBody
    @RequestMapping(value = "/post")
    public String post(HttpServletRequest request,HttpServletResponse response){
        String result = appUsedRecordService.postAppUserRecordInfo();
        return result;
    }
    
    @RequestMapping(value = "/remove",method=RequestMethod.GET)
    public void remove(HttpServletRequest request,HttpServletResponse response){
        String endTime = request.getParameter("endTime");
        appUsedRecordService.removeRecord(endTime);
    }
    
    @RequestMapping(value="/register",method=RequestMethod.GET)
    @ResponseBody
    public JSONObject regist(HttpServletRequest request,HttpServletResponse response){
        String result = "{\"resultMsg\": \"error\",\"resultCode\": \"0\"}";
        try {
            String appPrefix = request.getParameter("appPrefix");
            String appName = request.getParameter("appName");
            if(!StringUtils.isBlank(appPrefix) && !StringUtils.isBlank(appName) ){

                result = appUsedRecordService.regist(appPrefix, appName);
                
            }else{
                result = "{\"resultMsg\": \"参数不能为空\",\"resultCode\": \"0\"}";
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
//            throw new RuntimeException(e);
        }
        return JSONObject.parseObject(result);
    }
    
}


```
### 后台获取访问量数据、推送数据
/grc_office/src/product/src/main/webapp/WEB-INF/classes/META-INF/spring/hd-product-service.xml
```
    <!-- WE首页访问量数据service -->
    <bean id="appUsedRecordService"
          class="com.hd.rcugrc.project.oa.portal.appusedrecord.service.impl.AppUsedRecordServiceImpl">
          <property name="loginfoIp" value="${hd.integrate.loginfo.ip}" />
          <property name="sendWeAppUsedDatasPath" value="${hd.integrate.sendWeAppUsedDatas.path}" />
          <property name="registryWeAppPath" value="${hd.integrate.registryWeApp.path}" />
    </bean>
```
#### 获取访问量数据\推送数据
/grc_office/src/project/src/main/java/com/hd/rcugrc/project/oa/portal/appusedrecord/service/impl/AppUsedRecordServiceImpl.java
```
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
import org.joda.time.DateTime;
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
    private String registryWeAppPath;
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
    
    public String getRegistryWeAppPath() {
        return registryWeAppPath;
    }
    public void setRegistryWeAppPath(String registryWeAppPath) {
        this.registryWeAppPath = registryWeAppPath;
    }
    public AppUsedRecordDao getAppUsedRecordDao() {
        return appUsedRecordDao;
    }
    @Resource
    public void setAppUsedRecordDao(AppUsedRecordDao appUsedRecordDao) {
        this.appUsedRecordDao = appUsedRecordDao;
    }
    
    public JSONArray getAppUsedRecordInfo(DateTime startTime,DateTime endTime){
        System.out.println("AppUsedRecordServiceImpl.getAppUsedRecordInfo()");
        System.out.println(startTime);
        System.out.println(endTime);
        List<Map<String, Object>> recordInfo = appUsedRecordDao.getAppUsedRecordInfo(startTime,endTime);
        JSONArray jsonArray = new JSONArray();
        for(Map<String, Object> map:recordInfo){
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("appprefix",map.get("APPID"));
            /*jsonObject.put("appname",map.get("APPNAME"));*/
            jsonObject.put("organid",map.get("ORGANID"));
            jsonObject.put("cnt",map.get("CNT"));
            jsonArray.add(jsonObject);
        }
        return jsonArray;
    }
    
    @Override
    public String postAppUserRecordInfo(){
        System.out.println("postAppUserRecordInfo()");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar calendar = Calendar.getInstance();
        String endTime_s = sdf.format(calendar.getTime());
        String endTime = sdf2.format(calendar.getTime());
        DateTime dEndTime = new DateTime(calendar.get(Calendar.YEAR),calendar.get(Calendar.MONTH),calendar.get(Calendar.DAY_OF_MONTH),calendar.get(Calendar.HOUR_OF_DAY),calendar.get(Calendar.MINUTE),calendar.get(Calendar.SECOND));
        calendar.add(Calendar.HOUR_OF_DAY, -1);
        String startTime_s = sdf.format(calendar.getTime());
        String startTime = sdf2.format(calendar.getTime());
        
        DateTime dStartTime = new DateTime(calendar.get(Calendar.YEAR),calendar.get(Calendar.MONTH),calendar.get(Calendar.DAY_OF_MONTH),calendar.get(Calendar.HOUR_OF_DAY),calendar.get(Calendar.MINUTE),calendar.get(Calendar.SECOND));
        
        JSONArray dataJson = this.getAppUsedRecordInfo(dStartTime,dEndTime);
        System.out.print("待推送访问量数据："+dataJson.toJSONString());
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
        System.out.println("访问量数据推送结果："+result);
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
        System.out.println("removeRecord(String endTime)");
        if(StringUtils.isBlank(endTime)){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Calendar calendar = Calendar.getInstance();
            calendar.add(Calendar.HOUR_OF_DAY, -30);
            endTime = sdf.format(calendar.getTime());
        }
        appUsedRecordDao.removeRecord(endTime);
    }
    
    @Override
    public String regist(String appPrefix,String appName){
        System.out.println("注册参数"+appPrefix+","+appName);
        String url = loginfoIp+registryWeAppPath+"?appPrefix="+appPrefix+"&appName="+MyEscapeUtil.escape(MyEscapeUtil.escape(appName));
        System.out.println("注册url"+url);
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
//            throw new RuntimeException(e);
        }finally{
            post.abort();
        }
        System.out.println("注册返回结果"+result);
        JSONObject jsonObject = JSONObject.parseObject(result);
        if(jsonObject!=null){
            if(jsonObject.getString("resultCode").equals(1)){
                logger.info("应用注册成功。");
                this.removeRecord("");
            }else{
                logger.error(jsonObject.getString("resultMsg"));
            }
        }else{
            logger.error("应用注册接口返回数据格式错误。");
        }        
        
        return result;
    }
}



```

### 定时推送点击量信息
/grc_office/src/product/src/main/webapp/WEB-INF/classes/META-INF/spring/hd-product-quartz.xml
```
  <util:list id="productSchedulerTriggers">
        <!-- WE首页链接访问量数据推送 -->
        <ref bean="appUsedDate" />

  </util:list>
  
  <!-- WE首页链接访问量数据推送 start-->
  <bean id="appUsedDate" class="org.springframework.scheduling.quartz.CronTriggerFactoryBean">
    <property name="description" value="WE首页链接访问量数据推送"></property>
    <property name="jobDetail" ref="appUsedDateJobDetail" />
    <property name="cronExpression" value="0 0 0/1 * * ?" /> <!-- 每小时同步一次 -->
  </bean>
  <bean id="appUsedDateJobDetail" class="com.hd.rcugrc.core.scheduling.quartz.BeanInvokingJobDetailFactoryBean">
    <property name="targetBean" value="appUsedDateJob" />
    <property name="targetMethod" value="run" />
    <property name="concurrent" value="false" />
    <property name="durable" value="true" />
    <property name="shouldRecover" value="true" />
  </bean>
 
  <bean id="appUsedDateJob" class="com.hd.rcugrc.project.oa.portal.appusedrecord.quartz.AppUsedDateJob">
    <property name="runAsAccount" value="hdadmin"/>
    <property name="appUsedRecordService" ref="appUsedRecordService" />
  </bean> 
```
/grc_office/src/project/src/main/java/com/hd/rcugrc/project/oa/portal/appusedrecord/quartz/AppUsedDateJob.java
```
/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.hd.rcugrc.project.oa.portal.appusedrecord.quartz;

import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import com.hd.rcugrc.core.cron.AbstractCronJob;
import com.hd.rcugrc.project.oa.portal.appusedrecord.service.AppUsedRecordService;

/**
* <p> WE首页信息访问量数据推送
* 
* @author <a href="mailto:songjw@smartdot.com.cn">songjw</a>
* @version 1.0, 2019年10月12日
*/
public class AppUsedDateJob extends AbstractCronJob{

    final static Logger logger = LoggerFactory.getLogger(AppUsedDateJob.class);
    @Resource
    private AppUsedRecordService appUsedRecordService;
    public AppUsedRecordService getAppUsedRecordService() {
        return appUsedRecordService;
    }
    public void setAppUsedRecordService(AppUsedRecordService appUsedRecordService) {
        this.appUsedRecordService = appUsedRecordService;
    }
    protected void initJob() throws Exception {
        Assert.notNull(this.appUsedRecordService, "appUsedRecordService is required!");
    }
    
    @Override
    protected void execute() {
        logger.info("WE首页信息访问量开始推送 ...");
        appUsedRecordService.postAppUserRecordInfo();
        logger.info("WE首页信息访问量推送结束 ...");
    }
}

```

## 实现效果
调用测试
数据增加：http://127.0.0.1:8888/webapp/user/rest/appUsedDate/add
数据推送：http://127.0.0.1:8888/webapp/user/rest/appUsedDate/post
数据移除：http://127.0.0.1:8888/webapp/user/rest/appUsedDate/remove
应用注册：http://127.0.0.1:8888/webapp/user/rest/appUsedDate/register


## 其他相关

## 设计备份
```
01appCreate-oa-portal.sql	Staged Modified	docs/database-aqkk/kingbase
app-project-persistence.xml	Modified	src/project/src/main/webapp/WEB-INF/classes/META-INF
AppUsedDateController.java	Added Modified	src/project/src/main/java/com/hd/rcugrc/project/servlet/mvc
AppUsedDateJob.java	Untracked	src/project/src/main/java/com/hd/rcugrc/project/oa/portal/appusedrecord/quartz
AppUsedRecordDao.java	Untracked	src/project/src/main/java/com/hd/rcugrc/project/oa/portal/appusedrecord/dao
AppUsedRecordEntity.java	Untracked	src/project/src/main/java/com/hd/rcugrc/project/oa/portal/appusedrecord/entity
AppUsedRecordService.java	Untracked	src/project/src/main/java/com/hd/rcugrc/project/oa/portal/appusedrecord/service
AppUsedRecordServiceImpl.java	Untracked	src/project/src/main/java/com/hd/rcugrc/project/oa/portal/appusedrecord/service/impl
core.properties	Modified	src/base/webapp/WEB-INF/properties
GroupSynchroDao.java	Modified	src/product/src/main/java/com/hd/rcugrc/product/oa/cloudSyn/dao
hd-product-quartz.xml	Modified	src/product/src/main/webapp/WEB-INF/classes/META-INF/spring
hd-product-service.xml	Modified	src/product/src/main/webapp/WEB-INF/classes/META-INF/spring
userpage.js	Modified	src/project/src/main/webapp/resources/portal/user/js
leaderpage.js	Modified	src/project/src/main/webapp/resources/portal/leader/js
```


