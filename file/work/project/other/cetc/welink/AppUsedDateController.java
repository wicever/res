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
            String CREATION_TIME = sdf.format(calendar.getTime());
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
                appUsedRecordEntity.setCreationTime(DateTime.now());
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
            throw new RuntimeException(e);
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
}
