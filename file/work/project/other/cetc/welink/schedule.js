/**
 * 个人日程接口
 */
$(document).ready(function() {
	//getWeScheduleDate(pageConfig.currentUserInfo.currentUserAccount);
	
	getUserScheduleData();
});


/******************************获取移动平台日程start******************************/
function getUserScheduleData(){
	var urlParams = contextPath + "/user/rest/protalPage/getScheduleList";
	
	$.ajax({
		type: "post",
		url: urlParams,
		async:true,
		dataType: "json",
		data: {},
		success: function(result){
			if(result){
				if(result.user_schelist==""){
					var data;
					switch(pageConfig.currentUserInfo.currentUserAccount){
					case "wumq":
						data = data1;
						break;
					case "huam":
						data = data2;
						break;
					case "xiongql":
						data = data3;
						break;
					}
					var formatData = formatScheduleData(data);
					var html = getSchedueleHtml(formatData);
					$(".schedule").html(html);
				}else{
					if(result.user_schelist){
						var formatData = formatScheduleData(result.user_schelist);
						var html = getSchedueleHtml(formatData);
						$(".schedule").html(html);
					}
				}
			}
		},
		error:function(){
			//调用异常，展示默认数据			
			var data = getDefaultScheduleData();
			var formatData = formatWeScheduleData(data);
			var html = getSchedueleHtml(formatData);
			$(".schedule").html(html);
		}
	});
}

/*demo data*/
var data1 = [
	{
		"datetext":"2019-08-12",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-13",
		"schelist":[
			{
				"id":"1",
				"begintime":"2019-08-13 09:00:00",
				"endtime":"2019-08-13 10:00:00",
				"schename":"会议",
				"scheaddr":"2217会议室"
			}
		]
	},
	{
		"datetext":"2019-08-14",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-15",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-16",
		"schelist":[
			{
				"id":"2",
				"begintime":"2019-08-16 09:00:00",
				"endtime":"2019-08-16 10:00:00",
				"schename":"申威合作研讨会",
				"scheaddr":"2217会议室"
			}
		]
	},
	{
		"datetext":"2019-08-17",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-18",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	}
];
var data2 = [
	{
		"datetext":"2019-08-12",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-13",
		"schelist":[
			{
				"id":"1",
				"begintime":"2019-08-13 08:30:00",
				"endtime":"2019-08-13 10:00:00",
				"schename":"每周例会",
				"scheaddr":"集团内"
			}
		]
	},
	{
		"datetext":"2019-08-14",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-15",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-16",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-17",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-18",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	}
];
var data3 = [
	{
		"datetext":"2019-08-12",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-13",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-14",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-15",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-16",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-17",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	},
	{
		"datetext":"2019-08-18",
		"schelist":[
			{
				"schename":"暂无日程"
			}
		]
	}
];
/*demo data*/

function formatScheduleData(schelist){
	try{
		//今天的日期
		var toDay = dateFormat(new Date(),"yyyy-MM-dd");
		var scheduleList = [];
		
		var index = 1;
		//for(var date in schelist){
		for(var i = 0;i < schelist.length;i ++){
			var date = schelist[i].datetext;
			var day = {			
					"date":"",
					"weekday":"",
					"isActive":false,
					"schedules":[],
          "passed":""	
			}
			
			var dateList = date.split("-");
			//显示月日
			day.date = dateList[1]+"-"+dateList[2];
			//显示周
			day.weekday=getWeekdayTextByNumber(index);
			//date是否是今天
			day.isActive = (date == toDay)?true:false;
      //是否是已经过去的时间
      day.passed = isPassed(date)?"passed":"";
			
			var schedules = [];
			var items = schelist[i].schelist;
			$(items).each(function(){
				var item = {
					"id":"",
					"startDate":"",
					"startTime":"",
					"endDate":"",
					"endTime":"",
					"comment": "",
					"address": "",
					"editable": false,
					"color": ""
				}
				if(this.id){
					item.id = this.id;
				}
				if(this.begintime){
					var startList = this.begintime.split(" ");
					item.startDate = startList[0];
					item.startTime = startList[1].substr(0,5);
				}
				if(this.endtime){
					var endList = this.endtime.split(" ");
					item.endDate = endList[0];
					item.endTime = endList[1].substr(0,5);
				}
				item.comment = this.schename;
				if(this.scheaddr){
					item.address = this.scheaddr;
				}
				
				schedules.push(item);
			});
			
			day.schedules = schedules;			
			scheduleList.push(day);
			index++;
		}
		
		if(scheduleList.length > 0){
			return scheduleList;
		}else{
			return formatWeScheduleData(getDefaultScheduleData());
		}
		
	}catch(error){
		return formatWeScheduleData(getDefaultScheduleData());
	}
}
/******************************获取移动平台日程start******************************/


//判断是否已经过去
function isPassed(day){
  var toDay = dateFormat(new Date(),"yyyyMMdd");
  var day = dateFormat(new Date(day),"yyyyMMdd");
  if(toDay>day){
    return true;
  }else{
    return false;
  }
}

/******************************获取WE日程start******************************/
//获取WE的日程数据
function getWeScheduleDate(account){	
	var urlParams = contextPath + "/user/product/oa/externalInterfaceCall/getWeScheduleData?account="+account;
	
	$.ajax({
		type: "get",
		url: urlParams,
		async:true,
		dataType: "json",
		data: {},
		success: function(result){
			//更多日程
			$("#scheduleMore").click(function(event){
				window.open(result.more,"_blank");
			});
			
			//日程数据
			var data;
			if($.isEmptyObject(result.data)){
				data = getDefaultScheduleData();
			}else{
				data = result.data;
			}
			
			var formatData = formatWeScheduleData(data);
			var html = getSchedueleHtml(formatData);
			$(".schedule").html(html);
			addAppUsedRecord("","grrc","个人日程");
		},
		error:function(){
			//调用异常，展示默认数据			
			var data = getDefaultScheduleData();
			var formatData = formatWeScheduleData(data);
			var html = getSchedueleHtml(formatData);
			$(".schedule").html(html);
		}
	});
}

/*
//获取WE的日程数据
function getWeScheduleDate(account){	
	
	//WE的更多日程接口
	var moreUrl = "http://192.168.1.32:8888/oa-webapp/user/product/oa/oaagendamanage/jsp/agendaManagerIndex.jsp";
	$("#scheduleMore").click(function(event){
		window.open(moreUrl,"_blank");
	});
	
	
	//WE的日程接口
	var interfaceUrl = "http://192.168.1.32:8888/oa-webapp/user/rest/OaAgendaManagerController/getOaAgendaManagerForWeekByAccountAndDate?";
	interfaceUrl+= "account="+account;
	
	//调用rest接口超时时间
	var timeOut = 3000;
	//调用rest接口方式
	var type = "get";
	//调用rest接口后的response内容解析编码
	var respEncoding="UTF-8";
	
	var urlParams = contextPath + "/user/product/oa/externalInterfaceCall/callRest?type=get&timeOut="+timeOut+"&respEncoding="+respEncoding;
	
	//rest接口地址
	urlParams += "&targetURL=" + encodeURIComponent(interfaceUrl);
	
	console.log(urlParams);
	
	$.ajax({
		type: "get",
		url: urlParams,
		async:false,
		dataType: "json",
		data: {},
		success: function(data){
			var formatData = formatWeScheduleData(data);
			var html = getSchedueleHtml(formatData);
			$(".schedule").html(html);
		},
		error:function(){
			//调用异常，展示默认数据			
			var data = getDefaultScheduleData();
			var formatData = formatWeScheduleData(data);
			var html = getSchedueleHtml(formatData);
			$(".schedule").html(html);
		}
	});
}
*/

//格式化WE的日程数据
function formatWeScheduleData(interfaceData){
	try{
		//今天的日期
		var toDay = dateFormat(new Date(),"yyyy-MM-dd");
		var scheduleList = [];
		
		var index = 1;
		for(var date in interfaceData){
			var day = {			
					"date":"",
					"weekday":"",
					"isActive":false,
					"schedules":[],
          "passed":""	
			}
			
			var dateList = date.split("-");
			//显示月日
			day.date = dateList[1]+"-"+dateList[2];
			//显示周
			day.weekday=getWeekdayTextByNumber(index);
			//date是否是今天
			day.isActive = (date == toDay)?true:false;
      //是否是已经过去的时间
      day.passed = isPassed(date)?"passed":"";
			
			var schedules = [];
			var items = interfaceData[date];
			$(items).each(function(){
				var item = {
					"id":"",
					"startDate":"",
					"startTime":"",
					"endDate":"",
					"endTime":"",
					"comment": "",
					"address": "",
					"editable": false,
					"color": ""
				}
				
				item.id = this.id;
				var startList = this.start.split(" ");
				item.startDate = startList[0];
				item.startTime = startList[1];
				var endList = this.end.split(" ");
				item.endDate = endList[0];
				item.endTime = endList[1];
				item.comment = this.comment;
				item.address = this.address;
				item.editable = this.editable;
				item.color = this.color;
				
				schedules.push(item);
			});
			
			day.schedules = schedules;			
			scheduleList.push(day);
			index++;
		}
		
		if(scheduleList.length > 0){
			return scheduleList;
		}else{
			return formatWeScheduleData(getDefaultScheduleData());
		}
		
	}catch(error){
		return formatWeScheduleData(getDefaultScheduleData());
	}
}

//获取星期天按序号
function getWeekdayTextByNumber(number){
	var weekdayText = "周一";
	switch(number){
	case 1:
		weekdayText = "周一";
		break;
	case 2:
		weekdayText = "周二";
		break;
	case 3:
		weekdayText = "周三";
		break;
	case 4:
		weekdayText = "周四";
		break;
	case 5:
		weekdayText = "周五";
		break;
	case 6:
		weekdayText = "周六";
		break;
	case 7:
		weekdayText = "周日";
		break;
	}
	
	return weekdayText;
}

/**
*对Date的扩展，将 Date 转化为指定格式的String
*月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符，
*年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)
*例子：
*(new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423
*(new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18
*/
function dateFormat(date,fmt) {
	  var o = {
	    "M+": date.getMonth() + 1, //月份
	    "d+": date.getDate(), //日
	    "h+": date.getHours(), //小时
	    "m+": date.getMinutes(), //分
	    "s+": date.getSeconds(), //秒
	    "q+": Math.floor((date.getMonth() + 3) / 3), //季度
	    "S": date.getMilliseconds() //毫秒
	  };
	  if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
	  for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	  return fmt;
}

//获取默认的周日程数据
function getDefaultScheduleData(){	
  var weekDay = {};
  
	var currentDate = new Date()
    var timesStamp = currentDate.getTime();
    var currenDay = currentDate.getDay();
    var dates = [];
    for (var i = 0; i < 7; i++) {
    	var dateValue = new Date(timesStamp + 24 * 60 * 60 * 1000 * (i - (currenDay + 6) % 7));
    	var dateText = dateFormat(dateValue,"yyyy-MM-dd");
    	
    	weekDay[dateText]=[];
    }
  
  return weekDay;
}

//将日程数据生成日程的html
function getSchedueleHtml(templateData){

	var thHtmlTemplate = $.templates(getScheduleThHtmlTemplate());
	var tdHtmlTemplate = $.templates(getScheduleTdHtmlTemplate());
	
	var thHtml = thHtmlTemplate.render(templateData);
	var tdHtml = tdHtmlTemplate.render(templateData);
	
	var scheduleHtml = 
		'<tbody>'+
			'<tr>'+thHtml+'</tr>'+
			'<tr>'+tdHtml+'</tr>'+
		'</tbody>';
	
	return scheduleHtml;
}

//获取日程列表头信息
function getScheduleThHtmlTemplate(){
	var template= '{{for}}<th class="{{if isActive == true }}active{{/if}}">{{:weekday}} <br> {{:date}}</th>{{/for}}';
	return template;
}

//获取日程列表信息
function getScheduleTdHtmlTemplate(){
	var template= 		
		'{{for}}<td class="{{:passed}}">'+
			'{{if schedules.length == 0 }}'+
				'<span class="noSchedule">暂无安排</span>'+
			'{{else}}'+
				'{{for schedules}}'+
					'<span class="item" title="{{:startTime}} {{:address}} {{:comment}}">{{:startTime}} {{:comment}}</span>'+
				'{{/for}}'+
			'{{/if}}'+
		'</td>{{/for}}';			
	return template;
}
/******************************获取WE日程end******************************/

