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
