/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.hd.rcugrc.project.oa.portal.appusedrecord.service;
/**
* <p> WE首页访问量统计数据Service
* 
* @author <a href="mailto:songjw@smartdot.com.cn">songjw</a>
* @version 1.0, 2019年10月12日
*/
public interface AppUsedRecordService {

    String postAppUserRecordInfo();

    void removeRecord(String endTime);
    
}
