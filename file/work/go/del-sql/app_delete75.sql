--  ------------------------ƽ̨��----------------------------
-- ת���¼��
DELETE FROM  HD_WF_TURNT_TO_LOG;
-- ���ؼ�¼��
DELETE FROM  HD_WF_ROLLBACK_LOG;
-- ���������
DELETE FROM  HD_COMP_REMIND;
-- ���������
DELETE FROM  HD_FORM_EXT_OPINION;
-- JQUERY ����
DELETE FROM  HD_COMP_ATAH_PROP;

-- ��������
-- DELETE FROM  HD_COMP_ATAH_TYPE;
-- ����������
-- DELETE FROM  HD_COMP_ATAH_ORG;
-- �������ϵ��
-- DELETE FROM  HD_COMP_ATAH_GROUP_REL;

-- OA_INFO_DELIVERY_NOTICE
DELETE FROM HD_COMP_ATAH A WHERE EXISTS (SELECT * FROM HD_COMP_ATAH_GROUP_REL R WHERE A.ID =  R.ATAH_CODE  AND R.GROUP_CODE IN(SELECT ATTACHMENT FROM OA_INFO_DELIVERY_NOTICE N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));

-- OA_INFO_DELIVERY_NEWS
DELETE FROM HD_COMP_ATAH A WHERE EXISTS (SELECT * FROM HD_COMP_ATAH_GROUP_REL R WHERE A.ID =  R.ATAH_CODE  AND R.GROUP_CODE IN(SELECT THUMBNAIL FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE  CREATOR_ID !=1 OR ART_STATUS = 0)));

-- OA_INFO_DELIVERY_NEWS
DELETE FROM HD_COMP_ATAH A WHERE EXISTS (SELECT * FROM HD_COMP_ATAH_GROUP_REL R WHERE A.ID =  R.ATAH_CODE  AND R.GROUP_CODE IN(SELECT MOBILE_THUM FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE  CREATOR_ID !=1 OR ART_STATUS = 0)));



-- �����洢
DELETE FROM  HD_COMP_ATAH_DOWNLOAD;
-- ��ͨ
DELETE FROM  HD_COMMUNICATION_LOG;
DELETE FROM  HD_COMMUNICATION_OPINION;
DELETE FROM  HD_COMMUNICATION;
-- ������Ա��
DELETE FROM  HD_FORM_SENDTOREAD;
-- ���ı�
DELETE FROM  HD_COMP_READ;
-- �ҵĹ�ע
DELETE FROM  HD_COMP_ATTENTION;

-- OA 

-- ��Ϣ����
DELETE FROM  HD_CMS_ART_ATT_DAT A WHERE A.ID IN( SELECT ID FROM HD_CMS_ART_ATT_INFO WHERE ART_ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0));
DELETE FROM HD_CMS_ART_ATT_INFO WHERE ART_ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE FROM HD_CMS_ART_TEXT_CONTENT WHERE ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE FROM HD_CMS_ART_HTML_CONTENT  WHERE ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE FROM  HD_CMS_ARTICLE_EXT WHERE ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0) ;
DELETE FROM  HD_CMS_ART_COLUMN WHERE ART_ID IN( SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 );



-- �������
DELETE FROM  HD_FORM_FREQ_OPINION;
-- ���
DELETE FROM  HD_FORM_SERIAL_NUMBER;
-- ��Ź���
DELETE FROM  HD_FORM_DOCTYPE_TEMPLATE_REL;
DELETE FROM  HD_FORM_DOCTYPE_NUMBERING_REL;
DELETE FROM  HD_FORM_DOCUMENT_TYPE;
DELETE FROM  HD_FORM_NUMBERING_RULE;
-- �������
DELETE FROM  HD_FORM_SEQUENCE;
-- ģ��
DELETE FROM  HD_FORM_TEMPLATE_DATA;
DELETE FROM  HD_FORM_TEMPLATE_INFO;
-- ����


-- OA_INFO_DELIVERY_NEWS
DELETE FROM HD_FORM_FILE_DATA F WHERE EXISTS (SELECT * FROM HD_COMP_ATAH_GROUP_REL R WHERE F.ID =  R.ATAH_CODE  AND R.GROUP_CODE IN(SELECT MOBILE_THUM FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE FROM HD_FORM_FILE_INFO F WHERE EXISTS (SELECT * FROM HD_COMP_ATAH_GROUP_REL R WHERE F.ID =  R.ATAH_CODE  AND R.GROUP_CODE IN(SELECT MOBILE_THUM FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE  FROM HD_COMP_ATAH_GROUP_REL WHERE GROUP_CODE IN (SELECT MOBILE_THUM FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 ));
-- OA_INFO_DELIVERY_NEWS
DELETE  FROM HD_FORM_FILE_DATA F WHERE EXISTS (SELECT * FROM HD_COMP_ATAH_GROUP_REL R WHERE F.ID =  R.ATAH_CODE  AND R.GROUP_CODE IN(SELECT THUMBNAIL FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE FROM HD_FORM_FILE_INFO F WHERE EXISTS (SELECT * FROM HD_COMP_ATAH_GROUP_REL R WHERE F.ID =  R.ATAH_CODE  AND R.GROUP_CODE IN(SELECT THUMBNAIL FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE FROM HD_COMP_ATAH_GROUP_REL WHERE GROUP_CODE IN (SELECT THUMBNAIL FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 ));
-- HD_FORM_FILE_INFO
DELETE FROM HD_FORM_FILE_DATA F WHERE EXISTS (SELECT * FROM HD_COMP_ATAH_GROUP_REL R WHERE F.ID =  R.ATAH_CODE  AND R.GROUP_CODE IN(SELECT ATTACHMENT FROM OA_INFO_DELIVERY_NOTICE N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
 DELETE FROM HD_FORM_FILE_INFO F WHERE EXISTS (SELECT * FROM HD_COMP_ATAH_GROUP_REL R WHERE F.ID =  R.ATAH_CODE  AND R.GROUP_CODE IN(SELECT ATTACHMENT FROM OA_INFO_DELIVERY_NOTICE N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 )));
DELETE FROM HD_COMP_ATAH_GROUP_REL WHERE GROUP_CODE IN (SELECT ATTACHMENT FROM OA_INFO_DELIVERY_NOTICE N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0 ));

DELETE FROM OA_INFO_DELIVERY_NEWS N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE  FROM OA_INFO_DELIVERY_NOTICE N WHERE N.ARTICLE_ID IN(SELECT ID  FROM HD_CMS_ARTICLE  WHERE CREATOR_ID !=1 OR ART_STATUS = 0);
DELETE FROM  HD_CMS_ARTICLE WHERE CREATOR_ID !=1 OR ART_STATUS = 0;

DELETE FROM  HD_FORM_TMPFILE_DATA;
DELETE FROM  HD_FORM_TMPFILE_INFO;
-- ���
DELETE FROM  HD_FORM_OPINION;
-- ��Ա��
DELETE FROM  HD_FORM_GROUP_MEMBER;
-- ת��
DELETE FROM  HD_WF_FW_RECEIPT;
DELETE FROM  HD_WF_FW_INFO;
-- �б�
DELETE FROM  HD_WF_LIST;
DELETE FROM  HD_WF_COMPLETED;
DELETE FROM  HD_WF_PROCESSED;
DELETE FROM  HD_WF_INPROCESS;
-- ����
DELETE FROM  HD_TODOLIST_WF_INFO;
DELETE FROM  HD_TODOLIST_USER;
DELETE FROM  HD_TODOLIST;
-- �����������������ݹ�����ϵ
DELETE FROM  HD_WF_FORM_REL;
-- ��ת����
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
-- ʱ���
DELETE FROM  HD_TIMESTAMP;
-- Ȩ��
DELETE FROM  HD_ACL_ENTRY;
DELETE FROM  HD_ACL_OBJ_ID;
DELETE FROM  HD_ACL_SID;
DELETE FROM  HD_ACL_CLASS;
DELETE FROM  HD_ACL_OBJ_ID_MAP;
-- ���
delete from hd_id_gen where  id_name     
	 not IN(
		'HD_COMP_ATAH',
		'HD_CMS_ART_ATT_DAT',
		'HD_FORM_FILE_DATA',
		'HD_FORM_FILE_INFO',
		'HD_COMP_ATAH_GROUP_REL',
		'OA_INFO_DELIVERY_NEWS',
		'OA_INFO_DELIVERY_NOTICE'
	)
and  id_name not LIKE 'HD_CMS%'

and id_name not LIKE 'HD_PORTAL%'

 and id_name     
	 not in(
		'hd_comp_atah',
		'hd_cms_art_att_dat',
		'hd_form_file_data',
		'hd_form_file_info',
		'hd_comp_atah_group_rel',
		'oa_info_delivery_news',
		'oa_info_delivery_notice'
	)
and  id_name not like 'hd_cms%'

and id_name not like 'hd_portal%';
 
 
-- ������־
DELETE FROM  HD_LOG_DATA;
DELETE FROM  HD_LOG_INFO;

-- ��������
DELETE FROM  HD_TOKEN_INFO;

-- -----------------------------------HANDOVER START----------------------------------------------
DELETE FROM  HD_HANDOVER_LOG;
DELETE FROM  HD_HANDOVER_PROCESSED;
DELETE FROM  HD_HANDOVER_READ;
-- �������Ӷ�ʱ����
DELETE FROM  HD_HANDOVER_TIMER_TASK;
-- -----------------------------------HANDOVER END----------------------------------------------

-- �����Լ���ʼ���Ķ�ʱ����
DELETE FROM  HD_DEFAULT_QRTZ_JOB;

-- ����ͳ�Ʊ�
DELETE FROM  HD_CHARTS_LOG;
DELETE FROM  HD_CHARTS_PROCESSING_INST;
DELETE FROM  HD_CHARTS_COMPLETED_INST;
DELETE FROM  HD_CHARTS_PROCESSING_STEP;
DELETE FROM  HD_CHARTS_COMPLETED_STEP;
-- �洢�ؼ�����
DELETE FROM  HD_FORM_FILE_SPACE;



-- -------------------------------OA��-------------------------------------------
-- ----------���˹���̨--------------------
-- OA�û�������ӱ�
DELETE FROM  OA_QUICK_LINK;
-- ��Ϣ����
DELETE FROM  OA_MESSAGE_REMIND_LOG;
-- OA����
DELETE FROM  OA_TODOLIST ;
-- �ҵ��Ѱ�
DELETE FROM  OA_DONELIST_TENANTID ;
-- OA�ҵ�����
DELETE FROM  OA_MYAPPLIST ;
-- �������ı�
DELETE FROM  OA_SENDTOREAD_LOG;


-- -----------����̨����----------------
-- OA���˹���̨ҳ���ñ�
DELETE FROM  OA_WORKBENCH_PAGE_CONFIG;
-- OA�쵼����̨ҳ���ñ�
DELETE FROM  OA_LEADER_PAGE_CONFIG;

-- ------------����--------------------------
-- �����ճ̰���
DELETE FROM  OA_AGENDA_MANAGER;
-- �����������
DELETE FROM  OA_OPINION_FORM;
-- ��Ϣ��������
DELETE FROM  OA_MSG_PUSH_CONFIG ;
-- �ϼ���
DELETE FROM  OA_TRASH_FLOW_FORM ;
-- ��ż�¼��ɾ���ű�
DELETE FROM  OA_DOC_NUMBER;
-- �����ĵ���¼
DELETE FROM  OA_RELATED_DOC;
-- ȫȨ�ޱ༭������¼
DELETE FROM  OA_FULLAUTHEDIT_LOG ;
-- ��ͨ������־��
DELETE FROM  OA_COMMUNICATION_TODO_LOG;
-- �������̸�����־OA����
DELETE FROM  OA_WF_LOG ;
-- ���̵�ͼ�ҵ��ղ�
DELETE FROM  OA_MY_FLOW_MAP;


-- -------------------------ͨ��ģ��------------------
-- ��Ʒ���̱���ģ���
DELETE FROM  OA_COMMON_FLOW;
-- ��Ʒ�����̱���ģ���
DELETE FROM  OA_COMMON_NO_FLOW;



-- ---------------���Ĺ���----------------------
-- ----------�������ñ�-----------------
-- ҵ�����ͱ�
DELETE FROM  OA_DOC_BUSINESS_TYPE_MANAGE;
-- ��ͷ����
DELETE FROM  OA_REDHEAD_CONFIG;
-- ������ñ�ɾ���ű�
DELETE FROM  OA_DOC_NUM_CONFIG;
-- ҵ��������ñ�
-- DELETE FROM  OA_SERVICE_ATTR ;

-- ���ı�
DELETE FROM  OA_DOC_DISPATCH;
-- ���ı�
DELETE FROM  OA_DOC_RECIVE;
-- ǩ����
DELETE FROM  OA_SIGN_REPORT;
-- �������۲�������
DELETE FROM  OA_EVALUATION_CONFIG;
-- �������ۼ�¼
DELETE FROM  OA_EVALUATION_RECORD;
-- ��������
DELETE FROM  OA_EVALUATION_RECORD_DATA;
-- �ӳٹ鵵
DELETE FROM  OA_ARCHIVELATERLIST;
-- PDFת�����ñ�
DELETE FROM  OA_PDFTURNCONFIG;
-- ��Ա���
DELETE FROM  OA_PERSONAL_USER_GROUPS;
-- ���������
DELETE FROM  OA_DOC_UNIT;



-- -----------------------�ۺϰ칫---------------------------------
-- ---------��ٹ���---------------------
-- ��������
DELETE FROM  OA_LEAVE_MANAGE ;
-- �����Ϣά����
DELETE FROM  OA_HOLIDAY_MAINTAIN ;
-- ��ٹ������ñ�
DELETE FROM  OA_ANNUAL_LEAVE_CONFIG ;

-- ------------��������--------------
-- ����ά��
DELETE FROM  OA_CAR_DETAIL;
-- ����Ԥ��
DELETE FROM  OA_CAR_RESERVE;
-- ˾��ά��
DELETE FROM  OA_CAR_DRIVER;

-- ---------��ӡ����------------------
-- ɾ����ӡ��������
DELETE FROM  OA_SEAL_APPLY;
-- ɾ����ӡ�ӱ�
DELETE FROM  OA_SEAL_APPLY_SUB;

-- ------------��ֵ�׺�----------------
-- �쵼��������
DELETE FROM  OA_AGENDA_CONFIG;
-- ��ֵ�׺�Ʒ�����
DELETE FROM  OA_LOW_CONSUMABLES;
-- ��ֵ�׺�Ʒ��Ʒ��
DELETE FROM  OA_LOW_THRESHOLD;
-- ��ֵ�׺�Ʒ����
DELETE FROM  OA_CONSUMABLES_WAREHOUSING;
-- ��ֵ�׺�Ʒ��Ʒʹ�ü�¼��
DELETE FROM  OA_LOW_CONSUMABLESUSEINFO;
-- ��ֵ�׺�Ʒ��������
DELETE FROM  OA_CONSUMABLE_RECIPIENTS;
-- ��ֵ�׺�Ʒ�����ӱ�
DELETE FROM  OA_CONSUMABLES_RECIPIENTS_ITEM;

-- ----------------------�����ҹ���------------
-- ������Ԥ����
DELETE FROM  OA_DOC_MEETING ;
-- ������ά����
DELETE FROM  OA_MEETING_ROOM ;


-- ---------------------�������------------------------------
-- ��������ά��
DELETE FROM  OA_ISSUE_TYPE;
-- �����걨��
DELETE FROM  OA_ISSUE_APPLY;
-- ��������
DELETE FROM  OA_ISSUE_YTK;
-- �����ϻ�����
DELETE FROM  OA_SH_MAIN;
-- �����ϻ��ӱ�
DELETE FROM  OA_SH_CHILD;
-- ����֪ͨ��
DELETE FROM  OA_ISSUE_NOTICE;
-- ����֪ͨ�����
DELETE FROM  OA_NOTICE_CHANGE;
-- ����֪ͨ������
DELETE FROM  OA_NOTICE_FEEDBACK;
-- ����ǩ��
DELETE FROM  OA_ISSUE_SIGN;
-- �����������
DELETE FROM  OA_ISSUE_VOTE_MAIN;
-- ��������ӱ�
DELETE FROM  OA_ISSUE_VOTE_CHILD;
-- �������֪ͨ��¼��
DELETE FROM  OA_ISSUE_NOTICE_TODO;





-- --------------�������----------------------
-- ������������
DELETE FROM  OA_EM_TASK_HANDLE;
-- ��������߰쵥
DELETE FROM  OA_EM_TASK_URGENT;
-- ��������
DELETE FROM  OA_EM_TASK_EXAMINE;
-- ���������������
DELETE FROM  OA_EM_TASK_EVALUATE;
-- ������������
DELETE FROM  OA_EM_TASK_FEEDBACK;
-- �����������������õ�
DELETE FROM  OA_EM_TASK_REMIND_CONFIG;



-- --------------��Ϣ����----------------
-- �����ַ�
DELETE FROM  OA_INFO_SUBMIT_JOB_SEND;
-- �����ַ��ӱ�
DELETE FROM  OA_INFO_SUBMIT_SUB_MODEL;
-- ��Ϣ�
DELETE FROM  OA_INFO_SUBMIT_INFO_FILL;
-- ��Ϣ��ӱ�
DELETE FROM  OA_INFO_SUBMIT_SUB_DATA;




-- ------------�ĵ�����--------------------
-- �ĵ����ķ������
DELETE FROM  OA_DOC_CENTER_CATEGORY;
-- �ĵ�����-�������
DELETE FROM  OA_DOC_CATEGORY_REL;
-- �ĵ�����-��ע����
DELETE FROM  OA_DOC_CENTER_ATTENTION;
-- �ĵ�����-�ĵ���Ϣ
DELETE FROM  OA_DOC_CENTER_DOCINFO;
-- �ĵ�����-�汾��ʷ
DELETE FROM  OA_DOC_CENTER_VERSION_HIS;
-- �ĵ�����-��ǩ���
DELETE FROM  OA_DOC_CENTER_LABEL_CATEGORY;
-- �ĵ�����-��ǩ��Ϣ��
DELETE FROM  OA_DOC_CENTER_LABEL;
-- �ĵ�����-��ǩ���ñ�
DELETE FROM  OA_DOC_CENTER_LABLE_USED;
-- �ĵ�����-�ĵ����ʼ�¼
DELETE FROM  OA_DOC_CENTER_VISIT_INFO;
-- �ĵ�����-�ĵ�����
DELETE FROM  OA_DOC_CENTER_BORROW;
-- �ĵ�����-������ͬ��
DELETE FROM  OA_DOC_CENTER_COMM_LIKE;
-- �ĵ�����-�ĵ����ۻظ�
DELETE FROM  OA_DOC_CENTER_COMM_REPLY;
-- �ĵ�����-�ĵ�����
DELETE FROM  OA_DOC_CENTER_COMMENT;
-- �ĵ�����-�ղط���
DELETE FROM  OA_DOC_CENTER_COLLECT_FOLDER;
-- �ĵ�����-�ղ��ĵ�
DELETE FROM  OA_DOC_CENTER_COLLECT_FILE;
-- �ĵ�����-�ĵ��Ƽ�
DELETE FROM  OA_DOC_CENTER_RECOMMEND;




-- -----------OA ���ڴ�--------------------
-- DELETE FROM  OA_REGISTER;

-- �ƶ��칫�򿨣����õ�ַά��
-- DELETE FROM  OA_MOBILE_ATTENDANCE_CONFIG;



-- -----------------��Ϣ��������------------
-- OA��Ϣ�������������
-- DELETE FROM  OA_INFO_DELIVERY_NOTICE;
-- OA��Ϣ�������������
-- DELETE FROM  OA_INFO_DELIVERY_NEWS;



-- -----------------����Լ��----------------------
-- ��ϢԼ��
DELETE FROM   OA_NEWS_MANUSCRIPTS;
-- ����Լ���ϱ�
DELETE FROM   OA_NEWS_MANUSCRIPTS_REPORT;
-- ���Ÿ��״̬��
DELETE FROM   OA_NEWS_INFO_STATUS;
-- ������Ϣ����
DELETE FROM   OA_NEWS_INFO_EDITORIAL;