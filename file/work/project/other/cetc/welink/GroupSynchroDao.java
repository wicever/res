/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved. 
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license 
*
*/
package com.hd.rcugrc.product.oa.cloudSyn.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.hd.rcugrc.data.jpa.GenericRepository;
import com.hd.rcugrc.product.oa.cloudSyn.entity.GroupSynchroEntity;

/**
* <p>
* @author <a href="mailto:yufl@smartdot.com.cn">yufl</a> 
* @version 1.0, 2019年5月23日 
*/
public abstract interface GroupSynchroDao extends GenericRepository<GroupSynchroEntity, Long> {
    
    @Transactional
    @Modifying
    @Query(value = "delete from OA_GROUP_SYNCHRO where GROUPID = :groupId",nativeQuery = true)
    void delectedGroupSynchroByGroupId(@Param(value = "groupId") Long groupId);
    
    @Query(value = "SELECT t.orgId FROM com.hd.rcugrc.product.oa.cloudSyn.entity.GroupSynchroEntity t WHERE t.groupId = :groupId")
    public String getOrgidByGroupId(@Param(value = "groupId") Long groupId);
}
 