/*
* Copyright 2013-2019 Smartdot Technologies Co., Ltd. All rights reserved.
* SMARTDOT PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
*
*/
package com.hd.rcugrc.platform.rest.allinonenet.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hd.rcugrc.product.oa.allinonenet.itemprocesslist.service.ItemProcessService;

/**
* <p>
* 
* @author <a href="mailto:songjw@smartdot.com.cn">songjw</a>
* @version 1.0, 2019年10月9日
*/

@Controller
@RequestMapping("/rest/PostYwtbDatasController")
public class PostYwtbDatasController {

    private ItemProcessService itemProcessService;

    public ItemProcessService getItemProcessService() {
        return itemProcessService;
    }

    @Resource
    public void setItemProcessService(ItemProcessService itemProcessService) {
        this.itemProcessService = itemProcessService;
    }
    
    /**
     * 按时间段推送一网通办数据
     * @return
     */
    @RequestMapping(value="/postYwtbDatasByTime",method=RequestMethod.GET)
    @ResponseBody
    public String postYwtbDatasByTime(){
        return itemProcessService.postYwtbDatas("ByTime");
    }
    
    /**
     * 推送所有一网通办数据
     * @return
     */
    @RequestMapping(value="/postAllYwtbDatasByTime",method=RequestMethod.GET)
    @ResponseBody
    public String postAllYwtbDatasByTime(){
        return itemProcessService.postYwtbDatas("All");
    }
    
}
