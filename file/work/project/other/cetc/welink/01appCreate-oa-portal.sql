
-- 创建OA门户配置表

create table OA_PORTAL_CONFIG(
	ID INT8 NOT NULL,
    CREATOR_ID NUMERIC(19,2),
    CREATOR_ACCOUNT VARCHAR2(32 CHAR),
    CREATOR_NAME VARCHAR2(50 CHAR),
    MODIFY_EMP_ID NUMERIC(19,2),
    MODIFY_EMP_NAME VARCHAR2(50 CHAR),
    MODIFY_EMP_ACCOUNT VARCHAR2(32 CHAR),
    CREATE_DEPT_ID NUMERIC(19,2),
    CREATE_DEPT_CODE VARCHAR2(255 CHAR),
    CREATE_DEPT_NAME VARCHAR2(255 CHAR),
    MODIFY_DEPT_ID NUMERIC(19,2),
    MODIFY_DEPT_CODE VARCHAR2(255 CHAR),
    MODIFY_DEPT_NAME VARCHAR2(255 CHAR),
    CREATION_TIME timestamp ,
    LAST_MODIFIED_TIME timestamp,
    DELETED NUMERIC(19,2),
    BELONGED_ORG_ID NUMERIC(19,2),
    END_TYPE NUMERIC(19,2),
    FLOW_STATE VARCHAR2(50 CHAR),
    UUID VARCHAR2(19 CHAR),
    NUMBER_WORD VARCHAR2(50 CHAR),
    OANUMBER VARCHAR2(50 CHAR),
    DOC_TYPE VARCHAR2(50 CHAR),
    DOC_TITLE VARCHAR2(255 CHAR),
    ATTACHMENT VARCHAR2(100 CHAR),
	RESERVE_STRING_1 VARCHAR2(500 CHAR),
	RESERVE_STRING_2 VARCHAR2(500 CHAR),
	RESERVE_STRING_3 VARCHAR2(500 CHAR),	
	RESERVE_STRING_4 VARCHAR2(500 CHAR),
	RESERVE_STRING_5 VARCHAR2(500 CHAR),
	RESERVE_LONG_1 NUMERIC(19,2),
	RESERVE_LONG_2 NUMERIC(19,2),
	RESERVE_LONG_3 NUMERIC(19,2),	
	RESERVE_LONG_4 NUMERIC(19,2),
	RESERVE_LONG_5 NUMERIC(19,2),
	
	INDEX_PAGE_URL VARCHAR2(500 CHAR),
	TWO_PAGE_URL VARCHAR2(500 CHAR),
	THREE_PAGE_URL VARCHAR2(500 CHAR),
	
	USE_DEPT_NAME VARCHAR2(2000 CHAR),
	USE_DEPT_ID VARCHAR2(2000 CHAR),
	USE_ROLE_NAME VARCHAR2(2000 CHAR),
	USE_ROLE_ID VARCHAR2(2000 CHAR),
	USE_USER_NAME VARCHAR2(2000 CHAR),
	USE_USER_ACCOUNT VARCHAR2(2000 CHAR),
	STATUS VARCHAR(100),
	REMARK VARCHAR(2000),	
	MANAGER_ROLE_NAME VARCHAR2(100 CHAR),
	MANAGER_ROLE_ID VARCHAR2(2000 CHAR),	
	
	COMP_INDEX_URL VARCHAR2(2000 CHAR),
	DEPT_INDEX_URL VARCHAR2(2000 CHAR),
	USER_INDEX_URL VARCHAR2(2000 CHAR),
	USE_COMP_INDEX_ROLE_NAME VARCHAR2(2000 CHAR),
	USE_DEPT_INDEX_ROLE_NAME VARCHAR2(2000 CHAR),
	USE_COMP_INDEX_ROLE_ID VARCHAR2(2000 CHAR),
	USE_DEPT_INDEX_ROLE_ID VARCHAR2(2000 CHAR),
	
	constraint PK_OA_PORTAL_CONFIG primary key (ID)
	);
		
	
    comment on table OA_PORTAL_CONFIG is 'OA门户配置表';
	comment on column OA_PORTAL_CONFIG.ID is '业务单ID';
    comment on column OA_PORTAL_CONFIG.CREATOR_ID is '创建用户ID';
    comment on column OA_PORTAL_CONFIG.CREATOR_ACCOUNT is '创建用户帐号';
    comment on column OA_PORTAL_CONFIG.CREATOR_NAME is '创建用户名称';
    comment on column OA_PORTAL_CONFIG.MODIFY_EMP_ID is '修改用户ID';
    comment on column OA_PORTAL_CONFIG.MODIFY_EMP_NAME is '修改用户名称';
    comment on column OA_PORTAL_CONFIG.MODIFY_EMP_ACCOUNT is '修改用户帐号';
    comment on column OA_PORTAL_CONFIG.CREATE_DEPT_ID is '创建部门ID';
    comment on column OA_PORTAL_CONFIG.CREATE_DEPT_CODE is '创建部门编码';
    comment on column OA_PORTAL_CONFIG.CREATE_DEPT_NAME is '创建部门名称';
    comment on column OA_PORTAL_CONFIG.MODIFY_DEPT_ID is '修改部门ID';
    comment on column OA_PORTAL_CONFIG.MODIFY_DEPT_CODE is '修改部门编码';
    comment on column OA_PORTAL_CONFIG.MODIFY_DEPT_NAME is '修改部门名称';
    comment on column OA_PORTAL_CONFIG.CREATION_TIME is '创建时间';
    comment on column OA_PORTAL_CONFIG.LAST_MODIFIED_TIME is '最后修改时间';
    comment on column OA_PORTAL_CONFIG.DELETED is '删除标记';
    comment on column OA_PORTAL_CONFIG.BELONGED_ORG_ID is '所属机构分级ID';
    comment on column OA_PORTAL_CONFIG.END_TYPE is '结束或发布标记';
    comment on column OA_PORTAL_CONFIG.FLOW_STATE is '流程状态';
    comment on column OA_PORTAL_CONFIG.UUID is '唯一标识';
    comment on column OA_PORTAL_CONFIG.NUMBER_WORD is '编号代字';
    comment on column OA_PORTAL_CONFIG.OANUMBER is '编号';
    comment on column OA_PORTAL_CONFIG.DOC_TYPE is '业务类型ID';
    comment on column OA_PORTAL_CONFIG.DOC_TITLE is '标题';
    comment on column OA_PORTAL_CONFIG.ATTACHMENT is '附件';		
	comment on column OA_PORTAL_CONFIG.RESERVE_STRING_1 is '扩展字符字段1';
	comment on column OA_PORTAL_CONFIG.RESERVE_STRING_2 is '扩展字符字段2';
	comment on column OA_PORTAL_CONFIG.RESERVE_STRING_3 is '扩展字符字段3';
	comment on column OA_PORTAL_CONFIG.RESERVE_STRING_4 is '扩展字符字段4';
	comment on column OA_PORTAL_CONFIG.RESERVE_STRING_5 is '扩展字符字段5';
	comment on column OA_PORTAL_CONFIG.RESERVE_LONG_1 is '扩展数值字段1';
	comment on column OA_PORTAL_CONFIG.RESERVE_LONG_2 is '扩展数值字段2';
	comment on column OA_PORTAL_CONFIG.RESERVE_LONG_3 is '扩展数值字段3';
	comment on column OA_PORTAL_CONFIG.RESERVE_LONG_4 is '扩展数值字段4';
	comment on column OA_PORTAL_CONFIG.RESERVE_LONG_5 is '扩展数值字段5';
	
	comment on column OA_PORTAL_CONFIG.INDEX_PAGE_URL is '首页页面URL';	
	comment on column OA_PORTAL_CONFIG.TWO_PAGE_URL is '二级页面URL';	
	comment on column OA_PORTAL_CONFIG.THREE_PAGE_URL is '三级页面URL';	
	comment on column OA_PORTAL_CONFIG.USE_DEPT_NAME is '使用部门名称';	
	comment on column OA_PORTAL_CONFIG.USE_DEPT_ID is '使用部门ID';	
	comment on column OA_PORTAL_CONFIG.USE_ROLE_NAME is '使用角色名称';	
	comment on column OA_PORTAL_CONFIG.USE_ROLE_ID is '使用角色ID';	
	comment on column OA_PORTAL_CONFIG.USE_USER_NAME is '使用人员名称';	
	comment on column OA_PORTAL_CONFIG.USE_USER_ACCOUNT is '使用人员账号';	
	comment on column OA_PORTAL_CONFIG.STATUS is '门户状态';	
	comment on column OA_PORTAL_CONFIG.REMARK is '备注';	
	
	comment on column OA_PORTAL_CONFIG.COMP_INDEX_URL is '公司领导首页';	
	comment on column OA_PORTAL_CONFIG.DEPT_INDEX_URL is '部门领导首页';	
	comment on column OA_PORTAL_CONFIG.USER_INDEX_URL is '普通用户首页';	
	comment on column OA_PORTAL_CONFIG.USE_COMP_INDEX_ROLE_NAME is '使用公司领导首页角色名称';	
	comment on column OA_PORTAL_CONFIG.USE_DEPT_INDEX_ROLE_NAME is '使用部门领导首页角色名称';	
	comment on column OA_PORTAL_CONFIG.USE_COMP_INDEX_ROLE_ID is '使用公司领导首页角色ID';	
	comment on column OA_PORTAL_CONFIG.USE_DEPT_INDEX_ROLE_ID is '使用部门领导首页角色ID';	
		-- 创建OA用户快捷链接表
create table OA_QUICK_LINK(
	ID INT8 NOT NULL,
    CREATOR_ID NUMERIC(19,0),
    CREATOR_ACCOUNT varchar2(32 char),
    CREATOR_NAME varchar2(50 char),
    MODIFY_EMP_ID NUMERIC(19,0),
    MODIFY_EMP_NAME varchar2(50 char),
    MODIFY_EMP_ACCOUNT varchar2(32 char),
    CREATE_DEPT_ID NUMERIC(19,0),
    CREATE_DEPT_CODE varchar2(255 char),
    CREATE_DEPT_NAME varchar2(255 char),
    MODIFY_DEPT_ID NUMERIC(19,0),
    MODIFY_DEPT_CODE varchar2(255 char),
    MODIFY_DEPT_NAME varchar2(255 char),
    CREATION_TIME timestamp ,
    LAST_MODIFIED_TIME timestamp,
    DELETED NUMERIC(1,0),
    BELONGED_ORG_ID NUMERIC(19,0),
    END_TYPE NUMERIC(1,0),
    FLOW_STATE VARCHAR2(50 CHAR),
    UUID VARCHAR2(19 CHAR),
    NUMBER_WORD VARCHAR2(50 CHAR),
    OANUMBER VARCHAR2(50 CHAR),
    DOC_TYPE VARCHAR2(50 CHAR),
    DOC_TITLE VARCHAR2(255 char),
    ATTACHMENT varchar2(100 char),   	
	SORT_NUMBER  NUMERIC(19,0) not null,	
	USE_COUNT  NUMERIC(19,0) not null,		
	LINK_ADDRESS		VARCHAR2(500 char),
	BACKGROUND_COLOR	VARCHAR2(500 char),		
	BACKGROUND_IMG 		VARCHAR2(500 char),
	REMARK 		VARCHAR2(2000 char),			
		RESERVE_STRING_1 VARCHAR2(500 char),
		RESERVE_STRING_2 VARCHAR2(500 char),
		RESERVE_STRING_3 VARCHAR2(500 char),	
		RESERVE_STRING_4 VARCHAR2(500 char),
		RESERVE_STRING_5 VARCHAR2(500 char),
		RESERVE_LONG_1 NUMERIC(19,0),
		RESERVE_LONG_2 NUMERIC(19,0),
		RESERVE_LONG_3 NUMERIC(19,0),	
		RESERVE_LONG_4 NUMERIC(19,0),
		RESERVE_LONG_5 NUMERIC(19,0),
		constraint PK_OA_QUICK_LINK primary key (ID)
	);
	
	
    comment on table OA_QUICK_LINK is 'OA用户快捷链接表';
	comment on column OA_QUICK_LINK.ID is '业务单ID';
    comment on column OA_QUICK_LINK.CREATOR_ID is '创建用户ID';
    comment on column OA_QUICK_LINK.CREATOR_ACCOUNT is '创建用户帐号';
    comment on column OA_QUICK_LINK.CREATOR_NAME is '创建用户名称';
    comment on column OA_QUICK_LINK.MODIFY_EMP_ID is '修改用户ID';
    comment on column OA_QUICK_LINK.MODIFY_EMP_NAME is '修改用户名称';
    comment on column OA_QUICK_LINK.MODIFY_EMP_ACCOUNT is '修改用户帐号';
    comment on column OA_QUICK_LINK.CREATE_DEPT_ID is '创建部门ID';
    comment on column OA_QUICK_LINK.CREATE_DEPT_CODE is '创建部门编码';
    comment on column OA_QUICK_LINK.CREATE_DEPT_NAME is '创建部门名称';
    comment on column OA_QUICK_LINK.MODIFY_DEPT_ID is '修改部门ID';
    comment on column OA_QUICK_LINK.MODIFY_DEPT_CODE is '修改部门编码';
    comment on column OA_QUICK_LINK.MODIFY_DEPT_NAME is '修改部门名称';
    comment on column OA_QUICK_LINK.CREATION_TIME is '创建时间';
    comment on column OA_QUICK_LINK.LAST_MODIFIED_TIME is '最后修改时间';
    comment on column OA_QUICK_LINK.DELETED is '删除标记';
    comment on column OA_QUICK_LINK.BELONGED_ORG_ID is '所属机构分级ID';
    comment on column OA_QUICK_LINK.END_TYPE is '结束或发布标记';
    comment on column OA_QUICK_LINK.FLOW_STATE is '流程状态';
    comment on column OA_QUICK_LINK.UUID is '唯一标识';
    comment on column OA_QUICK_LINK.NUMBER_WORD is '编号代字';
    comment on column OA_QUICK_LINK.OANUMBER is '编号';
    comment on column OA_QUICK_LINK.DOC_TYPE is '业务类型ID';
    comment on column OA_QUICK_LINK.DOC_TITLE is '标题';
    comment on column OA_QUICK_LINK.ATTACHMENT is '附件';		
	comment on column OA_QUICK_LINK.SORT_NUMBER is '排序号';
	comment on column OA_QUICK_LINK.USE_COUNT is '使用数';
	comment on column OA_QUICK_LINK.LINK_ADDRESS is '链接地址';
	comment on column OA_QUICK_LINK.BACKGROUND_COLOR is '背景颜色';
	comment on column OA_QUICK_LINK.BACKGROUND_IMG is '显示图标';
	comment on column OA_QUICK_LINK.REMARK is '备注';	
	comment on column OA_QUICK_LINK.RESERVE_STRING_1 is '扩展字符字段1';
	comment on column OA_QUICK_LINK.RESERVE_STRING_2 is '扩展字符字段2';
	comment on column OA_QUICK_LINK.RESERVE_STRING_3 is '扩展字符字段3';
	comment on column OA_QUICK_LINK.RESERVE_STRING_4 is '扩展字符字段4';
	comment on column OA_QUICK_LINK.RESERVE_STRING_5 is '扩展字符字段5';
	comment on column OA_QUICK_LINK.RESERVE_LONG_1 is '扩展数值字段1';
	comment on column OA_QUICK_LINK.RESERVE_LONG_2 is '扩展数值字段2';
	comment on column OA_QUICK_LINK.RESERVE_LONG_3 is '扩展数值字段3';
	comment on column OA_QUICK_LINK.RESERVE_LONG_4 is '扩展数值字段4';
	comment on column OA_QUICK_LINK.RESERVE_LONG_5 is '扩展数值字段5';
	
	
--  统一待办所有表结构

--	已办表
-- DROP TABLE UNITD_DONE_ACT;

CREATE TABLE UNITD_DONE_ACT (
	ID INT8 NOT NULL,
	SYSID VARCHAR(50) NOT NULL,
	UNI_SRCID VARCHAR(50) NOT NULL,
	TITLE VARCHAR(1000) NOT NULL,
	URL VARCHAR(1000) NOT NULL,
	RECEIVER_ACCOUNT VARCHAR(100) NOT NULL,
	RECEIVER_NAME VARCHAR(100) NOT NULL,
	DOC_TYPE VARCHAR(100),
	DOC_NUMBER VARCHAR(100),
	ISWORKFLOW INT4,
	WORKFLOW_NAME VARCHAR(300),
	ACTIVE_STEP_NAME VARCHAR(300),
	LAST_STEP_NAME VARCHAR(300),
	PRIORITY INT4,
	JINJI VARCHAR(50),
	MIJI VARCHAR(50),
	SENDER_NAME VARCHAR(20),
	SENDER_ACCOUNT VARCHAR(50),
	SEND_TIME TIMESTAMP,
	CREATOR_NAME VARCHAR(50),
	CREATOR_ACCOUNT VARCHAR(50),
	CREATION_TIME TIMESTAMP,
	DUE_TIME TIMESTAMP,
	DONE_TIME TIMESTAMP,
	LOCAL_CREATE_TIME TIMESTAMP,
	CONSTRAINT UNITD_DONE_ACT_PKEY PRIMARY KEY (ID)
);
CREATE INDEX UNITD_DONE_ACT_RECEIVER_IDX ON UNITD_DONE_ACT (RECEIVER_ACCOUNT);

comment on table UNITD_DONE_ACT is '已办在线表';
comment on column UNITD_DONE_ACT.ID is '主键ID';
comment on column UNITD_DONE_ACT.LOCAL_CREATE_TIME is '本地创建时间';
comment on column UNITD_DONE_ACT.SYSID is '来源业务系统标识';
comment on column UNITD_DONE_ACT.UNI_SRCID is '源系统中待阅，唯一标识';
comment on column UNITD_DONE_ACT.TITLE is '文件标题';
comment on column UNITD_DONE_ACT.URL is '文件相对URL/绝对URL地址';
comment on column UNITD_DONE_ACT.RECEIVER_ACCOUNT is '接收人账户';
comment on column UNITD_DONE_ACT.RECEIVER_NAME is '接收人显示名';
comment on column UNITD_DONE_ACT.DOC_TYPE is '业务类型/文件类型';
comment on column UNITD_DONE_ACT.DOC_NUMBER is '文件编号';
comment on column UNITD_DONE_ACT.ISWORKFLOW is '是否流程';
comment on column UNITD_DONE_ACT.WORKFLOW_NAME is '流程名称';
comment on column UNITD_DONE_ACT.ACTIVE_STEP_NAME is '当前步骤名称';
comment on column UNITD_DONE_ACT.LAST_STEP_NAME is '上一步骤名称';
comment on column UNITD_DONE_ACT.PRIORITY is '优先级';
comment on column UNITD_DONE_ACT.JINJI is '紧急程度';
comment on column UNITD_DONE_ACT.MIJI is '密级';
comment on column UNITD_DONE_ACT.SENDER_NAME is '发送人显示名';
comment on column UNITD_DONE_ACT.SENDER_ACCOUNT is '发送人账户';
comment on column UNITD_DONE_ACT.SEND_TIME is '发送时间';
comment on column UNITD_DONE_ACT.CREATOR_NAME is '源系统中文件创建人显示名';
comment on column UNITD_DONE_ACT.CREATOR_ACCOUNT is '源系统中文件创建人账户';
comment on column UNITD_DONE_ACT.CREATION_TIME is '源系统中文件创建时间';
comment on column UNITD_DONE_ACT.DUE_TIME is '源系统中待办超时时间';
comment on column UNITD_DONE_ACT.DONE_TIME is '源系统中已办处理时间';


--	消息日志表
-- DROP TABLE UNITD_MSG_LOG;

CREATE TABLE UNITD_MSG_LOG (
	UUID VARCHAR(50) NOT NULL,
	VER VARCHAR(10) NOT NULL,
	"ACTION" VARCHAR(50) NOT NULL,
	SYSID VARCHAR(50) NOT NULL,
	MSG_SEND_TIME TIMESTAMP,
	IP_PORT VARCHAR(50),
	MSG_BODY VARCHAR(4000),
	RECEIVERS VARCHAR(1500),
	TITLE VARCHAR(1500),
	UNI_SRCID VARCHAR(50),
	ISDEAL INT4,
	ERROR VARCHAR(500),
	LOCAL_CREATE_TIME TIMESTAMP,
	CONSTRAINT UNITD_MSG_LOG_PKEY PRIMARY KEY (UUID)
);
CREATE INDEX UNITD_MSG_LOG_ISDEAL_IDX ON UNITD_MSG_LOG (ISDEAL);

comment on table UNITD_MSG_LOG is '消息日志表';
comment on column UNITD_MSG_LOG.UUID is '消息UUID主键';
comment on column UNITD_MSG_LOG.VER is '消息版本号';
comment on column UNITD_MSG_LOG."ACTION" is '消息操作类型';
comment on column UNITD_MSG_LOG.SYSID is '来源系统标识';
comment on column UNITD_MSG_LOG.MSG_SEND_TIME is '消息在来源系统的发送时间';
comment on column UNITD_MSG_LOG.IP_PORT is '来源系统IP+port';
comment on column UNITD_MSG_LOG.MSG_BODY is '消息体';
comment on column UNITD_MSG_LOG.RECEIVERS is '所有接收人账户列表';
comment on column UNITD_MSG_LOG.TITLE is '标题';
comment on column UNITD_MSG_LOG.UNI_SRCID is '消息来源系统唯一ID';
comment on column UNITD_MSG_LOG.ISDEAL is '是否已处理';
comment on column UNITD_MSG_LOG.ERROR is '处理的错误信息';
comment on column UNITD_MSG_LOG.LOCAL_CREATE_TIME is '本地创建时间';
--	已阅表
-- DROP TABLE UNITD_READED_ACT;

CREATE TABLE UNITD_READED_ACT (
	ID INT8 NOT NULL,
	READED_TIME TIMESTAMP NOT NULL,
	SYSID VARCHAR(50) NOT NULL,
	UNI_SRCID VARCHAR(50) NOT NULL,
	TITLE VARCHAR(1000) NOT NULL,
	URL VARCHAR(1000) NOT NULL,
	RECEIVER_ACCOUNT VARCHAR(50) NOT NULL,
	RECEIVER_NAME VARCHAR(50) NOT NULL,
	DOC_TYPE VARCHAR(100),
	DOC_NUMBER VARCHAR(100),
	SENDER_NAME VARCHAR(50),
	SENDER_ACCOUNT VARCHAR(50),
	SEND_TIME TIMESTAMP,
	CREATOR_NAME VARCHAR(50),
	CREATOR_ACCOUNT VARCHAR(50),
	CREATION_TIME TIMESTAMP,
	CONSTRAINT UNITD_READED_ACT_PKEY PRIMARY KEY (ID)
);
CREATE INDEX UNITD_READED_ACT_RECEIVER_IDX ON UNITD_READED_ACT (RECEIVER_ACCOUNT);

comment on table UNITD_READED_ACT is '已阅在线表';
comment on column UNITD_READED_ACT.ID is '主键ID';
comment on column UNITD_READED_ACT.READED_TIME is '已阅时间';
comment on column UNITD_READED_ACT.SYSID is '来源业务系统标识';
comment on column UNITD_READED_ACT.UNI_SRCID is '源系统中待阅，唯一标识';
comment on column UNITD_READED_ACT.TITLE is '文件标题';
comment on column UNITD_READED_ACT.URL is '文件相对URL/绝对URL地址';
comment on column UNITD_READED_ACT.RECEIVER_ACCOUNT is '接收人账户';
comment on column UNITD_READED_ACT.RECEIVER_NAME is '接收人显示名';
comment on column UNITD_READED_ACT.DOC_TYPE is '业务类型/文件类型';
comment on column UNITD_READED_ACT.DOC_NUMBER is '文件编号';
comment on column UNITD_READED_ACT.SENDER_NAME is '发送人显示名';
comment on column UNITD_READED_ACT.SENDER_ACCOUNT is '发送人账户';
comment on column UNITD_READED_ACT.SEND_TIME is '发送时间';
comment on column UNITD_READED_ACT.CREATOR_NAME is '源系统中文件创建人显示名';
comment on column UNITD_READED_ACT.CREATOR_ACCOUNT is '源系统中文件创建人账户';
comment on column UNITD_READED_ACT.CREATION_TIME is '源系统中文件创建时间';

--	系统来源配置表
-- DROP TABLE UNITD_SYS_MAPPING;

CREATE TABLE UNITD_SYS_MAPPING (
	SYSID VARCHAR(50) NOT NULL,
	ADDRESS VARCHAR(200),
	CONSTRAINT UNITD_SYS_MAPPING_PKEY PRIMARY KEY (SYSID)
);
comment on table UNITD_SYS_MAPPING is '来源系统地址映射表';
comment on column UNITD_SYS_MAPPING.SYSID is '来源系统标识';
comment on column UNITD_SYS_MAPPING.ADDRESS is '业务系统待办URL前半部分，包含协议、主机、端口、应用路径';

--	待办表
-- DROP TABLE UNITD_TODO_ACT;

CREATE TABLE UNITD_TODO_ACT (
	ID INT8 NOT NULL,
	SYSID VARCHAR(50) NOT NULL,
	UNI_SRCID VARCHAR(50) NOT NULL,
	TITLE VARCHAR(1000) NOT NULL,
	URL VARCHAR(1000) NOT NULL,
	RECEIVER_ACCOUNT VARCHAR(50) NOT NULL,
	RECEIVER_NAME VARCHAR(50) NOT NULL,
	DOC_TYPE VARCHAR(50),
	DOC_NUMBER VARCHAR(50),
	ISWORKFLOW INT4,
	WORKFLOW_NAME VARCHAR(300),
	ACTIVE_STEP_NAME VARCHAR(300),
	LAST_STEP_NAME VARCHAR(300),
	PRIORITY INT4,
	JINJI VARCHAR(50),
	MIJI VARCHAR(50),
	SENDER_NAME VARCHAR(50),
	SENDER_ACCOUNT VARCHAR(50),
	SEND_TIME TIMESTAMP,
	CREATOR_NAME VARCHAR(50),
	CREATOR_ACCOUNT VARCHAR(50),
	CREATION_TIME TIMESTAMP,
	"AlARM_TIME" TIMESTAMP,
	DUE_TIME TIMESTAMP,
	LOCAL_CREATE_TIME TIMESTAMP,
	CONSTRAINT PK_UNITD_TODO_ACT PRIMARY KEY (ID)
);
CREATE INDEX UNITD_TODO_ACT_RECEIVER_IDX ON UNITD_TODO_ACT (RECEIVER_ACCOUNT);
CREATE INDEX UNITD_TODO_ACT_S_U_R_IDX ON UNITD_TODO_ACT (SYSID,UNI_SRCID,RECEIVER_ACCOUNT);

comment on table UNITD_TODO_ACT is '待办在线表';
comment on column UNITD_TODO_ACT.ID is '主键ID';
comment on column UNITD_TODO_ACT.LOCAL_CREATE_TIME is '本地创建时间';
comment on column UNITD_TODO_ACT.SYSID is '来源业务系统标识';
comment on column UNITD_TODO_ACT.UNI_SRCID is '源系统中待阅，唯一标识';
comment on column UNITD_TODO_ACT.TITLE is '文件标题';
comment on column UNITD_TODO_ACT.URL is '文件相对URL/绝对URL地址';
comment on column UNITD_TODO_ACT.RECEIVER_ACCOUNT is '接收人账户';
comment on column UNITD_TODO_ACT.RECEIVER_NAME is '接收人显示名';
comment on column UNITD_TODO_ACT.DOC_TYPE is '业务类型/文件类型';
comment on column UNITD_TODO_ACT.DOC_NUMBER is '文件编号';
comment on column UNITD_TODO_ACT.ISWORKFLOW is '是否流程';
comment on column UNITD_TODO_ACT.WORKFLOW_NAME is '流程名称';
comment on column UNITD_TODO_ACT.ACTIVE_STEP_NAME is '当前步骤名称';
comment on column UNITD_TODO_ACT.LAST_STEP_NAME is '上一步骤名称';
comment on column UNITD_TODO_ACT.PRIORITY is '优先级';
comment on column UNITD_TODO_ACT.JINJI is '紧急程度';
comment on column UNITD_TODO_ACT.MIJI is '密级';
comment on column UNITD_TODO_ACT.SENDER_NAME is '发送人显示名';
comment on column UNITD_TODO_ACT.SENDER_ACCOUNT is '发送人账户';
comment on column UNITD_TODO_ACT.SEND_TIME is '发送时间';
comment on column UNITD_TODO_ACT.CREATOR_NAME is '源系统中文件创建人显示名';
comment on column UNITD_TODO_ACT.CREATOR_ACCOUNT is '源系统中文件创建人账户';
comment on column UNITD_TODO_ACT.CREATION_TIME is '源系统中文件创建时间';
comment on column UNITD_TODO_ACT."AlARM_TIME" is '源系统中待办警告时间';
comment on column UNITD_TODO_ACT.DUE_TIME is '源系统中待办超时时间';
--	待阅表

-- DROP TABLE UNITD_TOREAD_ACT;

CREATE TABLE UNITD_TOREAD_ACT (
	ID INT8 NOT NULL,
	LOCAL_CREATE_TIME TIMESTAMP NOT NULL,
	SYSID VARCHAR(50) NOT NULL,
	UNI_SRCID VARCHAR(50) NOT NULL,
	TITLE VARCHAR(1000) NOT NULL,
	URL VARCHAR(1000) NOT NULL,
	RECEIVER_ACCOUNT VARCHAR(50) NOT NULL,
	RECEIVER_NAME VARCHAR(50) NOT NULL,
	DOC_TYPE VARCHAR(100),
	DOC_NUMBER VARCHAR(100),
	SENDER_NAME VARCHAR(50),
	SENDER_ACCOUNT VARCHAR(50),
	SEND_TIME TIMESTAMP,
	CREATOR_NAME VARCHAR(50),
	CREATOR_ACCOUNT VARCHAR(50),
	CREATION_TIME TIMESTAMP,
	CONSTRAINT UNITD_TOREAD_ACT_PKEY PRIMARY KEY (ID)
);
CREATE INDEX UNITD_TOREAD_ACT_RECEIVER_IDX ON UNITD_TOREAD_ACT (RECEIVER_ACCOUNT);
CREATE INDEX UNITD_TOREAD_ACT_S_U_R_IDX ON UNITD_TOREAD_ACT (SYSID,UNI_SRCID,RECEIVER_ACCOUNT);

comment on table UNITD_TOREAD_ACT is '待阅在线表';
comment on column UNITD_TOREAD_ACT.ID is '主键ID';
comment on column UNITD_TOREAD_ACT.LOCAL_CREATE_TIME is '本地创建时间';
comment on column UNITD_TOREAD_ACT.SYSID is '来源业务系统标识';
comment on column UNITD_TOREAD_ACT.UNI_SRCID is '源系统中待阅，唯一标识';
comment on column UNITD_TOREAD_ACT.TITLE is '文件标题';
comment on column UNITD_TOREAD_ACT.URL is '文件相对URL/绝对URL地址';
comment on column UNITD_TOREAD_ACT.RECEIVER_ACCOUNT is '接收人账户';
comment on column UNITD_TOREAD_ACT.RECEIVER_NAME is '接收人显示名';
comment on column UNITD_TOREAD_ACT.DOC_TYPE is '业务类型/文件类型';
comment on column UNITD_TOREAD_ACT.DOC_NUMBER is '文件编号';
comment on column UNITD_TOREAD_ACT.SENDER_NAME is '发送人显示名';
comment on column UNITD_TOREAD_ACT.SENDER_ACCOUNT is '发送人账户';
comment on column UNITD_TOREAD_ACT.SEND_TIME is '发送时间';
comment on column UNITD_TOREAD_ACT.CREATOR_NAME is '源系统中文件创建人显示名';
comment on column UNITD_TOREAD_ACT.CREATOR_ACCOUNT is '源系统中文件创建人账户';
comment on column UNITD_TOREAD_ACT.CREATION_TIME is '源系统中文件创建时间';

--  表结构 结束

-- 创建新手指引提示信息状态表
CREATE TABLE OA_PORTAL_VIEW_MSG (
	ID INT8 NOT NULL,
	USER_ACCOUNT VARCHAR(100),
	STATUS INT8 NOT NULL,
	CONFIG_EXT1 VARCHAR(50),
	CONFIG_EXT2 VARCHAR(200),
	CONSTRAINT PK_OA_PORTAL_VIEW_MSG PRIMARY KEY (ID)
);

-- 机构人员同步日志
CREATE TABLE OA_GROUP_SYN_LOG (
	ID INT8 NOT NULL,
	GROUP_NUM INT4 NULL,
	USER_NUM INT4 NULL,
	SYN_TIME TIMESTAMP NULL,
	CONSTRAINT PK_OA_GROUP_SYN_LOG PRIMARY KEY (ID)
)
WITH (
	OIDS=FALSE
);

-- 同步数据的
CREATE TABLE OA_GROUP_SYNCHRO (
	ID NUMERIC(19) NOT NULL,
	ORGID VARCHAR(255) NULL,
	ORG_SHORT_NAME VARCHAR(255) NULL,
	ORG_FULL_NAME VARCHAR(255) NULL,
	ORG_PARENT_ID VARCHAR(255) NULL,
	PARENT_ID VARCHAR(255) NULL,
	ORG_LEVEL NUMERIC(10) NULL,
	LEVEL_CODE VARCHAR(255) NULL,
	SYS_ID VARCHAR(255) NULL,
	JD VARCHAR(255) NULL,
	WD VARCHAR(255) NULL,
	JIERUI VARCHAR(255) NULL,
	NDDI_NAME VARCHAR(255) NULL,
	STATUS NUMERIC(10) NULL,
	SYN_TIME VARCHAR(100) NULL,
	GROUPID VARCHAR(255) NULL,
	SORTNUMBER NUMERIC(10) NULL,
	ORGAN_TYPE VARCHAR(50) NULL,
	YDCODE VARCHAR(50) NULL,
	CONSTRAINT PK_OA_GROUP_SYNCHRO PRIMARY KEY (ID)
)
WITH (
	OIDS=FALSE
);

--增量同步组织用户记录 yuecy
create  table  OA_GROUP_SYN_LOG(
       ID BIGINT NOT NULL, --流水号
       GROUP_NUM INTEGER, --组织数量
       USER_NUM INTEGER, --用户数量
       SYN_TIME timestamp, --同步时间
       constraint PK_OA_GROUP_SYN_LOG primary key (ID)
 );
 ALTER TABLE OA_GROUP_SYNCHRO ADD YDCODE VARCHAR(255);
 
 
 -- 创建WE首页各链接访问量数据

create table OA_AION_APPUSED_DATAS(
    ID INT8 ,
    CREATION_TIME timestamp ,
    CREATOR_ACCOUNT VARCHAR2(32 CHAR),
    CREATOR_NAME VARCHAR2(50 CHAR),
    CREATE_DEPT_ID INT8,
    CREATE_DEPT_ORGID VARCHAR2(255 CHAR),
    CREATE_DEPT_NAME VARCHAR2(255 CHAR),
    APPID VARCHAR2(255 CHAR),
    APPNAME VARCHAR2(255 CHAR)
);
    

comment on table OA_AION_APPUSED_DATAS is 'WE首页各链接访问量数据';
comment on column OA_AION_APPUSED_DATAS.ID is 'ID';
comment on column OA_AION_APPUSED_DATAS.CREATION_TIME is '创建时间';
comment on column OA_AION_APPUSED_DATAS.CREATOR_ACCOUNT is '创建用户帐号';
comment on column OA_AION_APPUSED_DATAS.CREATOR_NAME is '创建用户名称';
comment on column OA_AION_APPUSED_DATAS.CREATE_DEPT_ID is '创建部门ID';
comment on column OA_AION_APPUSED_DATAS.CREATE_DEPT_ORGID is '创建部门编码';
comment on column OA_AION_APPUSED_DATAS.CREATE_DEPT_NAME is '创建部门名称';
comment on column OA_AION_APPUSED_DATAS.APPID is '访问应用id';
comment on column OA_AION_APPUSED_DATAS.APPNAME is '访问的应用名';