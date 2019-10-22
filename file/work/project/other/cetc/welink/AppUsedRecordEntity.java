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
