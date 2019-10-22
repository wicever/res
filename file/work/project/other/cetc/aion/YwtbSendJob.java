/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.hd.rcugrc.product.oa.allinonenet.itemprocesslist.quartz;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;

import com.hd.rcugrc.core.cron.AbstractCronJob;
import com.hd.rcugrc.product.oa.allinonenet.itemprocesslist.service.ItemProcessService;

/**
* <p> 定时向第三方推送一网通办排行数据
* 
* @author <a href="mailto:songjw@smartdot.com.cn">JiWen</a>
* @version 1.0, 2019年10月9日
*/
public class YwtbSendJob extends AbstractCronJob{

    final static Logger logger = LoggerFactory.getLogger(YwtbSendJob.class);
    private ItemProcessService itemProcessService;

    public ItemProcessService getItemProcessService() {
        return itemProcessService;
    }

    public void setItemProcessService(ItemProcessService itemProcessService) {
        this.itemProcessService = itemProcessService;
    }

    protected void initJob() throws Exception {
        Assert.notNull(this.itemProcessService, "ItemProcessService is required!");
    }
    
    @Override
    protected void execute() {
        logger.info("排行榜一网通办事项数据开始推送 ... ");
        String postYwtbDatas = itemProcessService.postYwtbDatas("ByTime");
        logger.info("排行榜一网通办事项数据推送结束："+postYwtbDatas);
    }

}
