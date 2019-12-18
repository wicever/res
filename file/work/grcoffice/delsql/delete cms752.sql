--  ------------------------平台表----------------------------
-- 转办记录表
DELETE FROM  HD_WF_TURNT_TO_LOG;
-- 驳回记录表
DELETE FROM  HD_WF_ROLLBACK_LOG;
-- 提醒任务表
DELETE FROM  HD_COMP_REMIND;
-- 公共意见表
DELETE FROM  HD_FORM_EXT_OPINION;
-- JQUERY 附件
DELETE FROM  HD_COMP_ATAH_PROP;

-- 附件类型
-- DELETE FROM  HD_COMP_ATAH_TYPE;
-- 附件背靠背
-- DELETE FROM  HD_COMP_ATAH_ORG;
-- 附件组关系表
-- DELETE FROM  HD_COMP_ATAH_GROUP_REL;

-- -------------------------------------------------20191021 执行不过-------------------------
-- OA_INFO_DELIVERY_NOTICE
DELETE FROM HD_COMP_ATAH   WHERE  ID IN (SELECT R.ATAH_CODE FROM HD_COMP_ATAH_GROUP_REL R WHERE R.GROUP_CODE IN(SELECT ATTACHMENT FROM OA_INFO_DELIVERY_NOTICE N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));

-- OA_INFO_DELIVERY_NEWS
DELETE FROM HD_COMP_ATAH   WHERE  ID IN(SELECT R.ATAH_CODE  FROM HD_COMP_ATAH_GROUP_REL R WHERE  R.GROUP_CODE IN(SELECT THUMBNAIL FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE  CREATOR_ID !=1 OR ART_STATUS = 0)));

-- OA_INFO_DELIVERY_NEWS
DELETE FROM HD_COMP_ATAH WHERE EXISTS (SELECT R.ATAH_CODE  FROM HD_COMP_ATAH_GROUP_REL R WHERE R.GROUP_CODE IN(SELECT MOBILE_THUM FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE  CREATOR_ID !=1 OR ART_STATUS = 0)));



-- 附件存储
DELETE FROM  HD_COMP_ATAH_DOWNLOAD;
-- 沟通
DELETE FROM  HD_COMMUNICATION_LOG;
DELETE FROM  HD_COMMUNICATION_OPINION;
DELETE FROM  HD_COMMUNICATION;
-- 送阅人员表
DELETE FROM  HD_FORM_SENDTOREAD;
-- 待阅表
DELETE FROM  HD_COMP_READ;
-- 我的关注
DELETE FROM  HD_COMP_ATTENTION;

-- OA 

-- 信息发布
DELETE FROM  HD_CMS_ART_ATT_DAT WHERE ID IN( SELECT ID FROM HD_CMS_ART_ATT_INFO WHERE ART_ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0));
DELETE FROM HD_CMS_ART_ATT_INFO WHERE ART_ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE FROM HD_CMS_ART_TEXT_CONTENT WHERE ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE FROM HD_CMS_ART_HTML_CONTENT  WHERE ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE FROM  HD_CMS_ARTICLE_EXT WHERE ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0) ;
DELETE FROM  HD_CMS_ART_COLUMN WHERE ART_ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 );



-- 常用意见
DELETE FROM  HD_FORM_FREQ_OPINION;
-- 编号
DELETE FROM  HD_FORM_SERIAL_NUMBER;
-- 编号规则
DELETE FROM  HD_FORM_DOCTYPE_TEMPLATE_REL;
DELETE FROM  HD_FORM_DOCTYPE_NUMBERING_REL;
DELETE FROM  HD_FORM_DOCUMENT_TYPE;
DELETE FROM  HD_FORM_NUMBERING_RULE;
-- 编号序列
DELETE FROM  HD_FORM_SEQUENCE;
-- 模板
DELETE FROM  HD_FORM_TEMPLATE_DATA;
DELETE FROM  HD_FORM_TEMPLATE_INFO;
-- 附件


-- ----------------- 20191021 前面带 -- 执行不过-------------------------------
-- OA_INFO_DELIVERY_NEWS
DELETE FROM HD_FORM_FILE_DATA  WHERE ID IN (SELECT R.ATAH_CODE FROM HD_COMP_ATAH_GROUP_REL R WHERE  R.GROUP_CODE IN(SELECT MOBILE_THUM FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE FROM HD_FORM_FILE_INFO WHERE ID IN (SELECT  R.ATAH_CODE  FROM HD_COMP_ATAH_GROUP_REL R WHERE R.GROUP_CODE IN(SELECT MOBILE_THUM FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE  FROM HD_COMP_ATAH_GROUP_REL WHERE GROUP_CODE IN (SELECT MOBILE_THUM FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 ));
-- OA_INFO_DELIVERY_NEWS
 DELETE  FROM HD_FORM_FILE_DATA WHERE ID IN (SELECT R.ATAH_CODE FROM HD_COMP_ATAH_GROUP_REL R WHERE R.GROUP_CODE IN(SELECT THUMBNAIL FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE FROM HD_FORM_FILE_INFO WHERE ID IN (SELECT R.ATAH_CODE FROM HD_COMP_ATAH_GROUP_REL R WHERE R.GROUP_CODE IN(SELECT THUMBNAIL FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE FROM HD_COMP_ATAH_GROUP_REL WHERE GROUP_CODE IN (SELECT THUMBNAIL FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 ));
-- HD_FORM_FILE_INFO
 DELETE FROM HD_FORM_FILE_DATA WHERE ID IN  (SELECT R.ATAH_CODE FROM HD_COMP_ATAH_GROUP_REL R WHERE R.GROUP_CODE IN(SELECT ATTACHMENT FROM OA_INFO_DELIVERY_NOTICE N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE FROM HD_FORM_FILE_INFO WHERE ID IN  (SELECT R.ATAH_CODE FROM HD_COMP_ATAH_GROUP_REL R WHERE R.GROUP_CODE IN(SELECT ATTACHMENT FROM OA_INFO_DELIVERY_NOTICE N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE FROM HD_COMP_ATAH_GROUP_REL WHERE GROUP_CODE IN (SELECT ATTACHMENT FROM OA_INFO_DELIVERY_NOTICE N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 ));

DELETE FROM OA_INFO_DELIVERY_NEWS  WHERE ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE  FROM OA_INFO_DELIVERY_NOTICE WHERE ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE FROM  HD_CMS_ARTICLE WHERE CREATOR_ID !=1 OR ART_STATUS = 0;


DELETE FROM  HD_FORM_TMPFILE_DATA;
DELETE FROM  HD_FORM_TMPFILE_INFO;
-- 意见
DELETE FROM  HD_FORM_OPINION;
-- 人员组
DELETE FROM  HD_FORM_GROUP_MEMBER;
-- 转发
DELETE FROM  HD_WF_FW_RECEIPT;
DELETE FROM  HD_WF_FW_INFO;
-- 列表
DELETE FROM  HD_WF_LIST;
DELETE FROM  HD_WF_COMPLETED;
DELETE FROM  HD_WF_PROCESSED;
DELETE FROM  HD_WF_INPROCESS;
-- 待办
DELETE FROM  HD_TODOLIST_WF_INFO;
DELETE FROM  HD_TODOLIST_USER;
DELETE FROM  HD_TODOLIST;
-- 表单数据与流程数据关联关系
DELETE FROM  HD_WF_FORM_REL;
-- 流转数据
DELETE FROM  HD_WF_LOG;
DELETE FROM  HD_WF_INST_LOCK;
DELETE FROM  HD_WF_ACL_ENTRY;
DELETE FROM  HD_WF_TIMER_TASK;
DELETE FROM  HD_WF_SUB_OPER;
DELETE FROM  HD_WF_SUB_INFO;
DELETE FROM  HD_WF_ACT_USER;
DELETE FROM  HD_WF_ACT_OPER;
DELETE FROM  HD_WF_ACT_PRE;
DELETE FROM  HD_WF_ACT_STEP;
DELETE FROM  HD_WF_HIS_USER;
DELETE FROM  HD_WF_HIS_OPER;
DELETE FROM  HD_WF_HIS_PRE;
DELETE FROM  HD_WF_HIS_STEP;
DELETE FROM  HD_WF_INST;
DELETE FROM  HD_WF_TRUST;
-- 时间戳
DELETE FROM  HD_TIMESTAMP;
-- 权限
DELETE FROM  HD_ACL_ENTRY;
DELETE FROM  HD_ACL_OBJ_ID;
DELETE FROM  HD_ACL_SID;
DELETE FROM  HD_ACL_CLASS;
DELETE FROM  HD_ACL_OBJ_ID_MAP;

-- 序号
DELETE FROM HD_ID_GEN WHERE  ID_NAME     
	 NOT IN(
		'HD_COMP_ATAH',
		'HD_CMS_ART_ATT_DAT',
		'HD_FORM_FILE_DATA',
		'HD_FORM_FILE_INFO',
		'HD_COMP_ATAH_GROUP_REL',
		'OA_INFO_DELIVERY_NEWS',
		'OA_INFO_DELIVERY_NOTICE',
		'OA_SERVICE_ATTR'
	)
AND  ID_NAME NOT LIKE 'HD_CMS%'

AND ID_NAME not LIKE 'HD_PORTAL%'

AND ID_NAME     
	 NOT IN(
		'hd_comp_atah',
		'hd_cms_art_att_dat',
		'hd_form_file_data',
		'hd_form_file_info',
		'hd_comp_atah_group_rel',
		'oa_info_delivery_news',
		'oa_info_delivery_notice',
		'oa_service_attr'
	)
AND  ID_NAME NOT LIKE 'hd_cms%'

AND ID_NAME NOT LIKE 'hd_portal%';
 
 
-- 操作日志
DELETE FROM  HD_LOG_DATA;
DELETE FROM  HD_LOG_INFO;

-- 访问令牌
DELETE FROM  HD_TOKEN_INFO;

-- -----------------------------------HANDOVER START----------------------------------------------
DELETE FROM  HD_HANDOVER_LOG;
DELETE FROM  HD_HANDOVER_PROCESSED;
DELETE FROM  HD_HANDOVER_READ;
-- 工作交接定时任务
DELETE FROM  HD_HANDOVER_TIMER_TASK;
-- -----------------------------------HANDOVER END----------------------------------------------

-- 新增以及初始化的定时任务
DELETE FROM  HD_DEFAULT_QRTZ_JOB;

-- 流程统计表
DELETE FROM  HD_CHARTS_LOG;
DELETE FROM  HD_CHARTS_PROCESSING_INST;
DELETE FROM  HD_CHARTS_COMPLETED_INST;
DELETE FROM  HD_CHARTS_PROCESSING_STEP;
DELETE FROM  HD_CHARTS_COMPLETED_STEP;
-- 存储控件管理
DELETE FROM  HD_FORM_FILE_SPACE;



-- -------------------------------OA表-------------------------------------------
-- ----------个人工作台--------------------
-- OA用户快捷链接表
DELETE FROM  OA_QUICK_LINK;
-- 消息提醒
DELETE FROM  OA_MESSAGE_REMIND_LOG;
-- OA待办
DELETE FROM  OA_TODOLIST ;
-- 我的已办
DELETE FROM  OA_DONELIST_TENANTID ;
-- OA我的申请
DELETE FROM  OA_MYAPPLIST ;
-- 待阅已阅表
DELETE FROM  OA_SENDTOREAD_LOG;


-- -----------工作台配置----------------
-- OA个人工作台页配置表
DELETE FROM  OA_WORKBENCH_PAGE_CONFIG;
-- OA领导工作台页配置表
DELETE FROM  OA_LEADER_PAGE_CONFIG;

-- ------------其他--------------------------
-- 工作日程安排
DELETE FROM  OA_AGENDA_MANAGER;
-- 常用意见排序
DELETE FROM  OA_OPINION_FORM;
-- 消息推送配置
DELETE FROM  OA_MSG_PUSH_CONFIG ;
-- 废件箱
DELETE FROM  OA_TRASH_FLOW_FORM ;
-- 编号记录表删除脚本
DELETE FROM  OA_DOC_NUMBER;
-- 关联文档记录
DELETE FROM  OA_RELATED_DOC;
-- 全权限编辑操作记录
DELETE FROM  OA_FULLAUTHEDIT_LOG ;
-- 沟通待办日志表
DELETE FROM  OA_COMMUNICATION_TODO_LOG;
-- 工作流程跟踪日志OA定制
DELETE FROM  OA_WF_LOG ;
-- 流程地图我的收藏
DELETE FROM  OA_MY_FLOW_MAP;


-- -------------------------通用模板------------------
-- 产品流程表单模板表
DELETE FROM  OA_COMMON_FLOW;
-- 产品非流程表单模板表
DELETE FROM  OA_COMMON_NO_FLOW;



-- ---------------公文管理----------------------
-- ----------公文配置表-----------------
-- 业务类型表
DELETE FROM  OA_DOC_BUSINESS_TYPE_MANAGE;
-- 红头配置
DELETE FROM  OA_REDHEAD_CONFIG;
-- 编号配置表删除脚本
DELETE FROM  OA_DOC_NUM_CONFIG;
-- 业务服务配置表
-- DELETE FROM  OA_SERVICE_ATTR ;

-- 发文表
DELETE FROM  OA_DOC_DISPATCH;
-- 收文表
DELETE FROM  OA_DOC_RECEIVE;
-- 签报表
DELETE FROM  OA_SIGN_REPORT;
-- 公文评价参数配置
DELETE FROM  OA_EVALUATION_CONFIG;
-- 公文评价记录
DELETE FROM  OA_EVALUATION_RECORD;
-- 公文评价
DELETE FROM  OA_EVALUATION_RECORD_DATA;
-- 延迟归档
DELETE FROM  OA_ARCHIVELATERLIST;
-- PDF转换设置表
DELETE FROM  OA_PDFTURNCONFIG;
-- 人员组表
DELETE FROM  OA_PERSONAL_USER_GROUPS;
-- 机构组表单
DELETE FROM  OA_DOC_UNIT;



-- -----------------------综合办公---------------------------------
-- ---------请假管理---------------------
-- 请假申请表
DELETE FROM  OA_LEAVE_MANAGE ;
-- 年假信息维护表
DELETE FROM  OA_HOLIDAY_MAINTAIN ;
-- 年假规则配置表
DELETE FROM  OA_ANNUAL_LEAVE_CONFIG ;

-- ------------车辆管理--------------
-- 车辆维护
DELETE FROM  OA_CAR_DETAIL;
-- 车辆预定
DELETE FROM  OA_CAR_RESERVE;
-- 司机维护
DELETE FROM  OA_CAR_DRIVER;

-- ---------用印管理------------------
-- 删除用印申请主表
DELETE FROM  OA_SEAL_APPLY;
-- 删除用印子表
DELETE FROM  OA_SEAL_APPLY_SUB;

-- ------------低值易耗----------------
-- 领导秘书配置
DELETE FROM  OA_AGENDA_CONFIG;
-- 低值易耗品分类表
DELETE FROM  OA_LOW_CONSUMABLES;
-- 低值易耗品物品表
DELETE FROM  OA_LOW_THRESHOLD;
-- 低值易耗品入库表
DELETE FROM  OA_CONSUMABLES_WAREHOUSING;
-- 低值易耗品物品使用记录表
DELETE FROM  OA_LOW_CONSUMABLESUSEINFO;
-- 低值易耗品领用主表
DELETE FROM  OA_CONSUMABLE_RECIPIENTS;
-- 低值易耗品领用子表
DELETE FROM  OA_CONSUMABLES_RECIPIENTS_ITEM;

-- ----------------------会议室管理------------
-- 会议室预定表
DELETE FROM  OA_DOC_MEETING ;
-- 会议室维护表
DELETE FROM  OA_MEETING_ROOM ;


-- ---------------------会议管理------------------------------
-- 会议类型维护
DELETE FROM  OA_ISSUE_TYPE;
-- 议题申报单
DELETE FROM  OA_ISSUE_APPLY;
-- 议题库表单
DELETE FROM  OA_ISSUE_YTK;
-- 议题上会主表
DELETE FROM  OA_SH_MAIN;
-- 议题上会子表
DELETE FROM  OA_SH_CHILD;
-- 会议通知单
DELETE FROM  OA_ISSUE_NOTICE;
-- 会议通知变更单
DELETE FROM  OA_NOTICE_CHANGE;
-- 会议通知反馈单
DELETE FROM  OA_NOTICE_FEEDBACK;
-- 会议签到
DELETE FROM  OA_ISSUE_SIGN;
-- 会议决议主表
DELETE FROM  OA_ISSUE_VOTE_MAIN;
-- 议题决议子表
DELETE FROM  OA_ISSUE_VOTE_CHILD;
-- 代办会议通知记录表
DELETE FROM  OA_ISSUE_NOTICE_TODO;





-- --------------督办管理----------------------
-- 督办任务处理单
DELETE FROM  OA_EM_TASK_HANDLE;
-- 督办任务催办单
DELETE FROM  OA_EM_TASK_URGENT;
-- 督办任务单
DELETE FROM  OA_EM_TASK_EXAMINE;
-- 督办任务点评表单
DELETE FROM  OA_EM_TASK_EVALUATE;
-- 督办任务反馈单
DELETE FROM  OA_EM_TASK_FEEDBACK;
-- 督办任务反馈提醒配置单
DELETE FROM  OA_EM_TASK_REMIND_CONFIG;
-- 督办变更
DELETE FROM OA_EM_TASK_ALTERATION;



-- --------------信息报送----------------
-- 工作分发
DELETE FROM  OA_INFO_SUBMIT_JOB_SEND;
-- 工作分发子表
DELETE FROM  OA_INFO_SUBMIT_SUB_MODEL;
-- 信息填报
DELETE FROM  OA_INFO_SUBMIT_INFO_FILL;
-- 信息填报子表
DELETE FROM  OA_INFO_SUBMIT_SUB_DATA;




-- ------------文档中心--------------------
-- 文档中心分类管理
DELETE FROM  OA_DOC_CENTER_CATEGORY;
-- 文档中心-分类关联
DELETE FROM  OA_DOC_CATEGORY_REL;
-- 文档中心-关注分类
DELETE FROM  OA_DOC_CENTER_ATTENTION;
-- 文档中心-文档信息
DELETE FROM  OA_DOC_CENTER_DOCINFO;
-- 文档中心-版本历史
DELETE FROM  OA_DOC_CENTER_VERSION_HIS;
-- 文档中心-标签类别
DELETE FROM  OA_DOC_CENTER_LABEL_CATEGORY;
-- 文档中心-标签信息表
DELETE FROM  OA_DOC_CENTER_LABEL;
-- 文档中心-标签引用表
DELETE FROM  OA_DOC_CENTER_LABLE_USED;
-- 文档中心-文档访问记录
DELETE FROM  OA_DOC_CENTER_VISIT_INFO;
-- 文档中心-文档借阅
DELETE FROM  OA_DOC_CENTER_BORROW;
-- 文档中心-评论赞同表
DELETE FROM  OA_DOC_CENTER_COMM_LIKE;
-- 文档中心-文档评论回复
DELETE FROM  OA_DOC_CENTER_COMM_REPLY;
-- 文档中心-文档评论
DELETE FROM  OA_DOC_CENTER_COMMENT;
-- 文档中心-收藏分类
DELETE FROM  OA_DOC_CENTER_COLLECT_FOLDER;
-- 文档中心-收藏文档
DELETE FROM  OA_DOC_CENTER_COLLECT_FILE;
-- 文档中心-文档推荐
DELETE FROM  OA_DOC_CENTER_RECOMMEND;




-- -----------OA 考勤打卡--------------------
 DELETE FROM  OA_REGISTER;

-- 移动办公打卡，常用地址维护
-- DELETE FROM  OA_MOBILE_ATTENDANCE_CONFIG;



-- -----------------信息发布表单------------
-- OA信息发布公告类表单
-- DELETE FROM  OA_INFO_DELIVERY_NOTICE;
-- OA信息发布新闻类表单
-- DELETE FROM  OA_INFO_DELIVERY_NEWS;



-- -----------------新闻约稿----------------------
-- 信息约稿
DELETE FROM   OA_NEWS_MANUSCRIPTS;
-- 新闻约稿上报
DELETE FROM   OA_NEWS_MANUSCRIPTS_REPORT;
-- 新闻稿件状态表
DELETE FROM   OA_NEWS_INFO_STATUS;
-- 新闻信息编审
DELETE FROM   OA_NEWS_INFO_EDITORIAL;
-- 自动约稿模板
DELETE FROM OA_NEWS_MANUSCRIPTS_TEMP;
