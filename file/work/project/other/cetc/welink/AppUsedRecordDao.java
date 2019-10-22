/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.hd.rcugrc.project.oa.portal.appusedrecord.dao;

import java.util.List;
import java.util.Map;
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
    @Query(value="SELECT T.APPID,T.APPNAME,T.CREATE_DEPT_ORGID AS ORGANID,COUNT(*) AS CNT FROM PORTALAPP.OA_APPUSED_DATAS T WHERE T.CREATION_TIME BETWEEN :startTime AND :endTime GROUP BY T.CREATE_DEPT_ORGID,T.APPID,T.APPNAME ORDER BY T.CREATE_DEPT_ORGID",nativeQuery=true)
    public List<Map<String,Object>> getAppUsedRecordInfo(@Param(value="startTime") String startTime,@Param(value="endTime") String endTime);
    
    @Transactional
    @Query(value="DELETE FROM PORTALAPP.OA_APPUSED_DATAS T WHERE T.CREATION_TIME < :endTime",nativeQuery=true)
    public void removeRecord(@Param(value="endTime") String endTime);
}
