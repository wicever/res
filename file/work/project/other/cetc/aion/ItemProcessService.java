/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license
terms.
*
*/
package com.hd.rcugrc.product.oa.allinonenet.itemprocesslist.service;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hd.rcugrc.product.oa.allinonenet.ItemToBackReason.entity.ItemToBackReasonEntity;
import com.hd.rcugrc.product.oa.allinonenet.itemprocesslist.entity.ItemProcessListEntity;

import net.sf.json.JSON;

/**
* <p>
*
* @author <a href="mailto:duyehui@smartdot.com.cn">duyehui</a>
* @version 1.0, 2019年6月6日
*/
public interface ItemProcessService {

    
    /**
     * 创建里程碑过程实例
     * @param itemId
     * @param startFormId
     * @param startBeanId
     * @param docTitle
     * @param oanumber
     * @param instId
     * @return
     */
    public ItemProcessListEntity createItemProcess(Long itemId,String startFormId,Long startBeanId,String docTitle,String oanumber,Long instId);
    
    /**
     * 变更里程碑过程状态
     * @param processId
     * @param processState
     * @return
     */
    public ItemProcessListEntity updateItemProcess(Long processId,String processState);
    
    /**
     * 变更里程碑过程状态
     * @param processId
     * @return 
     */
    public void createItemToBackAndupdateState(Long processId, String formId,String userAccount,String content,String processState);
    
    /**
     * 获取退回原因
     * @param processId
     * @return 
     */
    public List<Map<String, Object>> getItemToBackByItemId(Long id);
    
    /**
     * 修改办件状态
     * @param processId
     * @return 
     */
 	public void updateItemProcessStateByBeanIdAndFormId(Long processId, String formId, String processState);

 	/**
     * 办件进度查询
     * @param oanumber
     * @return 
     */
	public Map<String, Object> findItemProcessUrlByOanumber(String oanumber);
	
	/**
	 * 用于创建OA接口时创建里程碑过程文档
	 * @param itemId
	 * @param startFormId
	 * @param uuid
	 * @param docTitle
	 * @return
	 */
    public ItemProcessListEntity createItemProcessByOa(Long itemId, String startFormId, String uuid, String docTitle);
    
    
    /**
     * 变更里程碑过程状态(用于OA的流程接口)
     * @param uuid
     * @param processState (办理状态 handle 处理中，end 处理完毕，cancel 撤销)
     * @return 
     */
    public ItemProcessListEntity updateItemProcessByOa(String uuid,String processState);

    /**
     * 排行榜接口一网通办事项列表信息获取
     * @return
     */
    public JSONArray findItemProcessListInfo(String startTime,String endTime);
    /**
     * 推送前一小时的数据
     * @return Type:All ,ByTime
     */
    public String postYwtbDatas(String Type);


}
