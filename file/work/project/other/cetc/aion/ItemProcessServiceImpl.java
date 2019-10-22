/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license
terms.
*
*/
package com.hd.rcugrc.product.oa.allinonenet.itemprocesslist.service.impl;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.joda.time.DateTime;
import org.redisson.connection.pool.SlaveConnectionPool;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import com.hd.rcugrc.data.dao.annotation.AppWriteTx;
import com.hd.rcugrc.platform.common.util.StringUtils;
import com.hd.rcugrc.product.oa.allinonenet.ItemToBackReason.entity.ItemToBackReasonEntity;
import com.hd.rcugrc.product.oa.allinonenet.ItemToBackReason.service.ItemToBackReasonService;
import com.hd.rcugrc.product.oa.allinonenet.itemprocesslist.dao.ItemProcessListDao;
import com.hd.rcugrc.product.oa.allinonenet.itemprocesslist.entity.ItemProcessListEntity;
import com.hd.rcugrc.product.oa.allinonenet.itemprocesslist.service.ItemProcessService;
import com.hd.rcugrc.product.oa.allinonenet.itemsconfig.dao.ItemConfigDao;
import com.hd.rcugrc.product.oa.allinonenet.itemsconfig.dao.ItemMilestoneDao;
import com.hd.rcugrc.product.oa.allinonenet.itemsconfig.entity.ItemConfigEntity;
import com.hd.rcugrc.product.oa.allinonenet.itemsconfig.entity.ItemMilestoneEntity;
import com.hd.rcugrc.product.oa.common.util.HttpUtil;
import com.hd.rcugrc.product.oa.common.util.MyEscapeUtil;
import com.hd.rcugrc.security.context.AuthenticationHelper;
import com.hd.rcugrc.security.hierarchy.service.HierarchySwitchService;
import com.hd.rcugrc.security.user.Group;
import com.hd.rcugrc.security.user.UserInfoService;

//import net.sf.json.JSON;
//import net.sf.json.JSONArray;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.JSONArray;

import oracle.jdbc.dcn.QueryChangeDescription.QueryChangeEventType;

/**
* <p>
*
* @author <a href="mailto:duyehui@smartdot.com.cn">duyehui</a>
* @version 1.0, 2019年6月6日
*/
public class ItemProcessServiceImpl implements ItemProcessService {

    private ItemProcessListDao itemProcessListDao;
    private HierarchySwitchService hierarchySwitchService;
    private UserInfoService userInfoService;
    private ItemToBackReasonService itemToBackReasonService;
    private ItemMilestoneDao itemMilestoneDao;
    private ItemConfigDao itemConfigDao;
    private String loginfoIp;
    private String ywtbSendDatasPath;
    private EntityManager entityManager;
    final static Logger logger = LoggerFactory.getLogger(ItemProcessServiceImpl.class);
    
    public String getLoginfoIp() {
        return loginfoIp;
    }

    public void setLoginfoIp(String loginfoIp) {
        this.loginfoIp = loginfoIp;
    }

    public String getYwtbSendDatasPath() {
        return ywtbSendDatasPath;
    }

    public void setYwtbSendDatasPath(String ywtbSendDatasPath) {
        this.ywtbSendDatasPath = ywtbSendDatasPath;
    }

    public ItemToBackReasonService getItemToBackReasonService() {
        return itemToBackReasonService;
    }

    @Resource
    public void setItemToBackReasonService(ItemToBackReasonService itemToBackReasonService) {
        this.itemToBackReasonService = itemToBackReasonService;
    }
    
    public ItemProcessListDao getItemProcessListDao() {
        return itemProcessListDao;
    }

    @Resource
    public void setItemProcessListDao(ItemProcessListDao itemProcessListDao) {
        this.itemProcessListDao = itemProcessListDao;
    }
    

    public HierarchySwitchService getHierarchySwitchService() {
        return hierarchySwitchService;
    }

    @Resource
    public void setHierarchySwitchService(HierarchySwitchService hierarchySwitchService) {
        this.hierarchySwitchService = hierarchySwitchService;
    }
    
    public UserInfoService getUserInfoService() {
        return userInfoService;
    }

    @Resource
    public void setUserInfoService(UserInfoService userInfoService) {
        this.userInfoService = userInfoService;
    }
    
    public ItemMilestoneDao getItemMilestoneDao() {
        return itemMilestoneDao;
    }
    @Resource
    public void setItemMilestoneDao(ItemMilestoneDao itemMilestoneDao) {
        this.itemMilestoneDao = itemMilestoneDao;
    }

    
    public ItemConfigDao getItemConfigDao() {
        return itemConfigDao;
    }

    @Resource
    public void setItemConfigDao(ItemConfigDao itemConfigDao) {
        this.itemConfigDao = itemConfigDao;
    }
    
    @PersistenceContext(unitName = "appEntityManager")
    public void setEntityManager(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    @Override
    public ItemProcessListEntity createItemProcess(Long itemId, String startFormId, Long startBeanId, String docTitle,
            String oanumber,Long instId) {
        
        // 获取登录账号
        String account = AuthenticationHelper.getCurrentUser();
        // 根据账户获取机构
        Group group = hierarchySwitchService.findHierarchyGroupIdByUser(account);
        com.hd.rcugrc.security.user.User user = userInfoService.getUserByAccount(account);
        Group g = userInfoService.getGroupById(user.getParentId());
        //我的办件的URL
        String url = "";
        
        //获取事项配置数据
        ItemConfigEntity itemConfigEntity = itemConfigDao.getItemConfigById(itemId);
        
        ItemProcessListEntity itemProcessListEntity = new ItemProcessListEntity();
        
        itemProcessListEntity.setItemId(itemId);
        itemProcessListEntity.setStartBeanId(startBeanId);
        itemProcessListEntity.setStartFormId(startFormId);
        itemProcessListEntity.setCreationTime(DateTime.now());
        itemProcessListEntity.setDocTitle(docTitle);
        itemProcessListEntity.setOanumber(oanumber);
        
        itemProcessListEntity.setBelongedOrgId(group.getId());
        itemProcessListEntity.setCreateDeptCode(g.getCode());
        itemProcessListEntity.setCreateDeptId(g.getId());
        itemProcessListEntity.setCreateDeptName(g.getName());
        itemProcessListEntity.setCreatorAccount(account);
        itemProcessListEntity.setCreatorId(user.getId());
        itemProcessListEntity.setCreatorName(user.getName());
        //运行状态
        itemProcessListEntity.setProcessState("handle");
        //打开的链接
        itemProcessListEntity.setProcessUrl(url);
        //负责部门
        itemProcessListEntity.setResponsibleDept(itemConfigEntity.getResponsibilityDeptName());
        
        //结束时间后期在改
        itemProcessListEntity.setFinishTime(DateTime.now());
        //预计结束时间后期在改
        itemProcessListEntity.setEstimateFinishTime(DateTime.now());
        
        ItemProcessListEntity process = itemProcessListDao.mergeAndFlush(itemProcessListEntity);
        
        //获取里程碑定义
        List<ItemMilestoneEntity> milestones = itemMilestoneDao.getItemMilestoneByItemId(itemId);
        if(milestones.size() > 0) {
            //获取第一个里程碑
            ItemMilestoneEntity itemMilestoneEntity = milestones.get(0);
            String type = itemMilestoneEntity.getStartType();
            //根据启动类型拼写URL
            if(type.equals("isFlow")) {
               // bpm/create.htm?flowId=G_1_AQKK_FAWEN
               url = "/bpm/view.htm?instId=" + instId + "&aionItemId=" + itemId + "&aionProcessId=" + process.getId();
            }else if(type.equals("noFlow")) {
                String startUrl = itemMilestoneEntity.getStartUrl();
               // wp/G_1_AllInOneNet/G_1_myAppointment/G_1_appointmentEdit.htm 
               url = startUrl + "&id=" +startBeanId+ "&aionItemId=" + itemId + "&aionProcessId=" + process.getId();
            }
            ItemProcessListEntity item = itemProcessListDao.getItemProcessById(process.getId());
            item.setProcessUrl(url);
            process = itemProcessListDao.mergeAndFlush(item);
        }
        
        return process;
    }
    
    /**
     * 变更里程碑过程状态
     * @param processId
     * @param processState
     * @return
     */
    public ItemProcessListEntity updateItemProcess(Long processId,String processState) {
        ItemProcessListEntity itemProcessListEntity = itemProcessListDao.getItemProcessById(processId);
        if(itemProcessListEntity != null) {
            itemProcessListEntity.setProcessState(processState);
            itemProcessListEntity.setFinishTime(DateTime.now());
            itemProcessListEntity.setIsevaluate("0");
            ItemProcessListEntity item = itemProcessListDao.mergeAndFlush(itemProcessListEntity);
            return item;
        }
        return itemProcessListEntity;
    }

	@Override
	@AppWriteTx
	public void createItemToBackAndupdateState(Long processId, String formId,String userAccount,String content, String processState){
		// TODO Auto-generated method stub
		//修改我的办件状态
		itemProcessListDao.updateItemProcessStateByBeanIdAndFormId(processId,formId,processState);
		ItemProcessListEntity itemProcessListEntity =itemProcessListDao.getitemProcessIdByBeanIdAndFormId(processId,formId);
		long itemId=itemProcessListEntity.getId();
		itemToBackReasonService.createItemReason(itemId, userAccount, content);
	}

	@Override
	public List<Map<String, Object>> getItemToBackByItemId(Long id) {
		// TODO Auto-generated method stub
		return itemToBackReasonService.getItemToBackByItemId(id);
	}

	@Override
	@AppWriteTx
	public void updateItemProcessStateByBeanIdAndFormId(Long processId, String formId, String processState) {
		// TODO Auto-generated method stub
		 itemProcessListDao.updateItemProcessStateByBeanIdAndFormId(processId, formId, processState);
	}

	/**
     * 办件进度查询
     * @param oanumber
     * @return 
     */
	@Override
	public Map<String, Object> findItemProcessUrlByOanumber(String oanumber) {
		// TODO Auto-generated method stub
		return itemProcessListDao.findItemProcessUrlByOanumber(oanumber);
	}
	
	
	@Override
    public ItemProcessListEntity createItemProcessByOa(Long itemId, String startFormId, String uuid, String docTitle) {
        
        // 获取登录账号
        String account = AuthenticationHelper.getCurrentUser();
        // 根据账户获取机构
        Group group = hierarchySwitchService.findHierarchyGroupIdByUser(account);
        com.hd.rcugrc.security.user.User user = userInfoService.getUserByAccount(account);
        Group g = userInfoService.getGroupById(user.getParentId());
        //我的办件的URL
        String url = "";
        //标题为当前部门+事项名称
        docTitle = "["+g.getName()+"]" + docTitle;
        //用时间戳作为单据编号
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String oanumber = formatter.format(new Date());
        //获取事项配置数据
        ItemConfigEntity itemConfigEntity = itemConfigDao.getItemConfigById(itemId);
        
        ItemProcessListEntity itemProcessListEntity = new ItemProcessListEntity();
        
        itemProcessListEntity.setItemId(itemId);
        //更新时填写
        itemProcessListEntity.setStartBeanId(0L);
        itemProcessListEntity.setStartFormId(startFormId);
        itemProcessListEntity.setCreationTime(DateTime.now());
        itemProcessListEntity.setDocTitle(docTitle);
        itemProcessListEntity.setOanumber(oanumber);
        
        itemProcessListEntity.setBelongedOrgId(group.getId());
        itemProcessListEntity.setCreateDeptCode(g.getCode());
        itemProcessListEntity.setCreateDeptId(g.getId());
        itemProcessListEntity.setCreateDeptName(g.getName());
        //加上'_oabackup'后辍，避免垃圾数据出现在用户列表中
        itemProcessListEntity.setCreatorAccount(account + "_oabackup");
        itemProcessListEntity.setCreatorId(user.getId());
        itemProcessListEntity.setCreatorName(user.getName());
        //运行状态
        itemProcessListEntity.setProcessState("handle");
        //打开的链接
        itemProcessListEntity.setProcessUrl(url);
        //负责部门
        itemProcessListEntity.setResponsibleDept(itemConfigEntity.getResponsibilityDeptName());
        //设置UUid
        itemProcessListEntity.setUuid(uuid);
        
        
        //结束时间后期在改
        itemProcessListEntity.setFinishTime(DateTime.now());
        //预计结束时间后期在改
        itemProcessListEntity.setEstimateFinishTime(DateTime.now());
        
        ItemProcessListEntity process = itemProcessListDao.mergeAndFlush(itemProcessListEntity);
        
        //根据启动类型拼写URL
        url = "/wp/G_1_AllInOneNet/G_1_UniversalClass/G_1_UniversalPage.htm?aionItemId="+itemId+"&aionProcessId=" + process.getId();

        ItemProcessListEntity item = itemProcessListDao.getItemProcessById(process.getId());
        item.setProcessUrl(url);
        process = itemProcessListDao.mergeAndFlush(item);
        
        return process;
    }
	
    public ItemProcessListEntity updateItemProcessByOa(String uuid,String processState) {
        ItemProcessListEntity itemProcessListEntity = itemProcessListDao.getItemProcessByUuid(uuid);
        if(itemProcessListEntity != null) {
            itemProcessListEntity.setProcessState(processState);
            itemProcessListEntity.setFinishTime(DateTime.now());
            itemProcessListEntity.setIsevaluate("0");
            String account = itemProcessListEntity.getCreatorAccount();
            //修改账户名，去掉备注
            account = account.split("_oa")[0];
            itemProcessListEntity.setCreatorAccount(account);
            ItemProcessListEntity item = itemProcessListDao.mergeAndFlush(itemProcessListEntity);
            return item;
        }
        return itemProcessListEntity;
    }

	@Transactional(readOnly = true)
    @Override
    public JSONArray findItemProcessListInfo(String startTime,String endTime) {
        
        //通过OA_AION_ITEM_PROCESS_LIST关联OA_GROUP_SYNCHRO，根据时间段查询ORGID、部门名称、文件数量信息
        /*StringBuilder query = new StringBuilder("SELECT g.ORGID,t.CREATE_DEPT_NAME,t.COUNT FROM");
        query.append(" (SELECT l.CREATE_DEPT_ID,l.CREATE_DEPT_NAME,COUNT(*) FROM AIONAPP.OA_AION_ITEM_PROCESS_LIST l ");
        if(!StringUtils.isBlank(startTime) && !StringUtils.isBlank(endTime)){
            query.append(" WHERE CREATION_TIME BETWEEN ? AND ? ");
        }
        query.append(" GROUP BY l.CREATE_DEPT_ID,l.CREATE_DEPT_NAME ORDER BY l.CREATE_DEPT_ID) t");
        query.append(" LEFT JOIN OA_GROUP_SYNCHRO g ON t.CREATE_DEPT_ID = g.GROUPID ");*/
        
        
        //仅查询OA_AION_ITEM_PROCESS_LIST中数据，根据时间段查询CREATE_DEPT_ID、部门名称、文件数量信息
        StringBuilder query = new StringBuilder("SELECT t.CREATE_DEPT_ID,t.CREATE_DEPT_NAME,COUNT(*) FROM AIONAPP.OA_AION_ITEM_PROCESS_LIST t");
        if(!StringUtils.isBlank(startTime) && !StringUtils.isBlank(endTime)){
            query.append(" WHERE T.CREATION_TIME BETWEEN ? AND ? ");
        }
        query.append(" GROUP BY t.CREATE_DEPT_ID,t.CREATE_DEPT_NAME ORDER BY t.CREATE_DEPT_ID");
        
        Query emQuery = entityManager.createNativeQuery(query.toString());
        if(!StringUtils.isBlank(startTime) && !StringUtils.isBlank(endTime)){
            emQuery.setParameter(1, startTime);
            emQuery.setParameter(2, endTime);
        }
        List<Object[]> resultList = emQuery.getResultList();
        
        JSONArray dataJson = new JSONArray();

        for(Object[] r:resultList){
            if(r[0]!=null){
                JSONObject item = new JSONObject();
                item.put("organid", r[0]);
                item.put("organname", r[1]);
                item.put("cnt", r[2]);
                dataJson.add(item);
            }
        }
        
        return dataJson;
    }
    
    @Override
    public String postYwtbDatas(String Type){
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar calendar = Calendar.getInstance();
        String endTime_s = sdf.format(calendar.getTime());
        String endTime = sdf2.format(calendar.getTime());
        calendar.add(Calendar.HOUR_OF_DAY, -1);
        String startTime_s = sdf.format(calendar.getTime());
        String startTime = sdf2.format(calendar.getTime());
        
        JSONArray dataJson = new JSONArray();
        if(Type.equals("All")){
            dataJson = this.findItemProcessListInfo("","");
        }else{
            dataJson = this.findItemProcessListInfo(startTime_s,endTime_s);
        }
        
        String url = loginfoIp+ywtbSendDatasPath+"?startTime="+startTime+"&endTime="+endTime+"&dataJson="+MyEscapeUtil.escape(MyEscapeUtil.escape(dataJson.toString()));
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
        JSONObject jsonObject = JSONObject.parseObject(result);
        if(jsonObject!=null){
            if(jsonObject.getString("resultCode").equals(1)){
                logger.info("排行榜一网通办事项数据推送成功。");
            }else{
                logger.error(jsonObject.getString("resultMsg"));
            }
        }else{
            logger.error("排行榜一网通办事项数据推送接口返回数据格式错误。");
        }        
        
        return result;
    }
    
}
