/**
 * 普通用户页面前端js
 */

var TodoList = {};;
TodoList.curr = 0;
TodoList.total = 0;
TodoList.pageSize = 5;
TodoList.initTodoList = function(start,count){
	// zhaolk 20190718  更换统一待办数据来源
//	hdOaDwrTodoListServiceImpl.findOATodoList([], start, count, "sentDate DESC", "", {callback : function(ret) {
	dwrUnifiedAllActiveService.findUnifiedTodoList([], start, count, "SEND_TIME DESC",  {callback : function(ret) {
		TodoList.total = parseInt(ret.totalSize);
		$("#badge-todo").html(ret.totalSize);
		var liStr="";
		for(var i=0;i<ret.data.length;i++){
			var todo = ret.data[i];
			
			liStr+='<li class="col-md-3 col-xs-3">';
			
			if(todo.priority>0){
				liStr+='<a href="javascript:;" class="item redcorner" onclick="openMindWin(this)" link="'+todo.link+'&account='+todo.receiveUser+'" title="'+todo.title+'">';
			}else{
				liStr+='<a href="javascript:;" class="item" onclick="openMindWin(this)" link="'+todo.link+'&account='+todo.receiveUser+'" title="'+todo.title+'">';
			}
			
			liStr+='<p></p>';
			/*zhaolk 20190718
			liStr+='<p>'+custom_formatDate(todo.sentDate)+'</p>';
			liStr+=todo.title;
			var deptName = todo.creatorDeptName==null?"":todo.creatorDeptName;
			var name = todo.creatorName==null?"":todo.creatorName;
			liStr+='<span class="time">'+deptName+' '+name+'</span>';
			*/
			/*liStr+='<p>'+custom_formatDate(todo.stime)+'</p>';
			liStr+=todo.title;
			var deptName = todo.cdept==null?"":todo.cdept;
			var name = todo.creator==null?"":todo.creator;
			liStr+='<span class="time">'+deptName+' '+name+'</span>';*/
			liStr+=todo.title;
			var sender = "发送人："+todo.sender+"<br>";
			var receiver = "接收时间："+formatDate(todo.stime);
			liStr+='<span class="time">'+sender+receiver+'</span>';
			liStr+='</a>';
			liStr+='</li>';
		}
		$("#ul-todo").html(liStr);
		
		var id = "ul-todo";
		$('#'+id).width("100%");
		$("#ul-todo").css("display","");
	}});	
}

TodoList.nextTodo = function(){
	var pageCount = (TodoList.total-1)/TodoList.pageSize+1;
	pageCount = parseInt(pageCount)
	var next = TodoList.curr+1;
	if(next<pageCount){
		$("#ul-todo").html("");
		TodoList.initTodoList(next*TodoList.pageSize,TodoList.pageSize);
		TodoList.curr = next;
	}
}
TodoList.prevTodo = function(){
	var prev = TodoList.curr-1;
	if(prev>-1){
		$("#ul-todo").html("");
		TodoList.initTodoList(prev*TodoList.pageSize,TodoList.pageSize);
		TodoList.curr = prev;
	}
}

//我的已办
var DoneList = {};;
DoneList.curr = 0;
DoneList.total = 0;
DoneList.pageSize = 5;
DoneList.initDoneList = function(start,count){
	// zhaolk 20190718  更换统一待办数据来源
//	dwrOaDoneService.findDoneList([], start, count, "sentDate DESC",  {callback : function(ret) {
	dwrUnifiedAllActiveService.findUnifiedDoneList([], start, count, "DONE_TIME DESC",  {callback : function(ret) {
		DoneList.total = parseInt(ret.totalSize);
		//$("#badge-done").html(ret.totalSize);
		var liStr="";
		for(var i=0;i<ret.data.length;i++){
			var done = ret.data[i];
			
			liStr+='<li class="col-md-3 col-xs-3">';
			liStr+='<a href="javascript:;" class="item" onclick="openMindWin(this)" link="'+done.link+'&account='+done.receiveUser+'" title="'+done.title+'">';
			liStr+='<p></p>';
			/*zhaolk 20190718
			liStr+='<p>'+custom_formatDate(done.sentDate)+'</p>';
			liStr+=done.title;
			var deptName = done.creatorDeptName==null?"":done.creatorDeptName;
			var name = done.creatorName==null?"":done.creatorName;
			liStr+='<span class="time">'+deptName+' '+name+'</span>';
			*/
			/*liStr+='<p>'+custom_formatDate(done.stime)+'</p>';
			liStr+=done.title;
			var deptName = done.cdept==null?"":done.cdept;
			var name = done.creator==null?"":done.creator;
			liStr+='<span class="time">'+deptName+' '+name+'</span>';*/
			liStr+=done.title;
			var sender = "发送人："+done.sender+"<br>";
			var receiver = "接收时间："+formatDate(done.stime);
			liStr+='<span class="time">'+sender+receiver+'</span>';
			liStr+='</a>';
			liStr+='</li>';
		}
		$("#ul-done").html(liStr);
		
		var id = "ul-done";
		$('#'+id).width("100%");
		$("#ul-done").css("display","");
	}});	
}

DoneList.nextDone = function(){
	var pageCount = (DoneList.total-1)/DoneList.pageSize+1;
	pageCount = parseInt(pageCount)
	var next = DoneList.curr+1;
	if(next<pageCount){
		$("#ul-done").html("");
		DoneList.initDoneList(next*DoneList.pageSize,DoneList.pageSize);
		DoneList.curr = next;
	}
}

DoneList.prevDone = function(){
	var prev = DoneList.curr-1;
	if(prev>-1){
		$("#ul-done").html("");
		DoneList.initDoneList(prev*DoneList.pageSize,DoneList.pageSize);
		DoneList.curr = prev;
	}
}

//我的待阅
var ToreadList = {};;
ToreadList.curr = 0;
ToreadList.total = 0;
ToreadList.pageSize = 5;
ToreadList.initToreadList = function(start,count){
	/*zhaolk 20190718
	var account = pageConfig.currentUserInfo.currentUserAccount;
	var title = "";
	var isRead = 0;
	var queryColumns = "short_name as SHORT_NAME,creator_name as CREATOR_NAME,user_name as USER_NAME,send_time as SEND_TIME,read_time as READ_TIME,log_ext1 as LOG_EXT1,log_ext2 as ENTRYID,msg_id as ID,app_name as APP_NAME,app_id as APP_ID,priority as PRIORITY ";
	var orderby = "send_time DESC";
	dwrSendToReadLogService.getSendToReadLogList(account,title,isRead, queryColumns,start, count, orderby, {callback : function(ret) {
	*/
	dwrUnifiedAllActiveService.findUnifiedToReadList([], start, count, "SEND_TIME DESC", {callback : function(ret) {
		ToreadList.total = parseInt(ret.totalSize);
		$("#badge-toread").html(ret.totalSize);
		var liStr="";
		for(var i=0;i<ret.data.length;i++){
			var toread = ret.data[i];
			/*zhaolk 20190718 
			liStr+='<li class="col-md-3 col-xs-3">';
			liStr+='<a href="javascript:;" class="item redcorner" onclick="openMindWin(this,\'read\',\''+
				toread.ID+'\',\''+toread.ENTRYID+'\')" link="'+toread.LINK+'" title="'+toread.LOG_EXT1+'">';
			liStr+='<p></p>';
			liStr+='<p>'+custom_formatDate(toread.SEND_TIME)+'</p>';
			liStr+=toread.LOG_EXT1;
			var deptName = toread.creatorDeptName==null?"":toread.creatorDeptName;
			var name = toread.creatorName==null?"":toread.creatorName;
			liStr+='<span class="time">'+deptName+' '+name+'</span>';
			*/
			liStr+='<li class="col-md-3 col-xs-3">';
			liStr+='<a href="javascript:;" class="item" onclick="openMindWin(this)" link="'+toread.link.replace("mode=readed","mode=sendtoread")+'&account='+toread.receiveUser+'" title="'+toread.title+'">';
			liStr+='<p></p>';
			/*liStr+='<p>'+custom_formatDate(toread.stime)+'</p>';
			liStr+=toread.title;
			var deptName = toread.cdept==null?"":toread.cdept;
			var name = toread.creator==null?"":toread.creator;
			liStr+='<span class="time">'+deptName+' '+name+'</span>';*/
			liStr+=toread.title;
			var sender = "发送人："+toread.sender+"<br>";
			var receiver = "接收时间："+formatDate(toread.stime);
			liStr+='<span class="time">'+sender+receiver+'</span>';
			liStr+='</a>';
			liStr+='</li>';
		}
		$("#ul-toread").html(liStr);
		
		var id = "ul-toread";
		$('#'+id).width("100%");
		$("#ul-toread").css("display","");
	}});	
}

ToreadList.nextToread = function(){
	var pageCount = (ToreadList.total-1)/ToreadList.pageSize+1;
	pageCount = parseInt(pageCount)
	var next = ToreadList.curr+1;
	if(next<pageCount){
		$("#ul-toread").html("");
		ToreadList.initToreadList(next*ToreadList.pageSize,ToreadList.pageSize);
		ToreadList.curr = next;
	}
}
ToreadList.prevToread = function(){
	var prev = ToreadList.curr-1;
	if(prev>-1){
		$("#ul-toread").html("");
		ToreadList.initToreadList(prev*ToreadList.pageSize,ToreadList.pageSize);
		ToreadList.curr = prev;
	}
}


//我的邮件
var MailList = {};
MailList.curr = 0;
MailList.total = 0;
MailList.pageSize = 5;
MailList.id="ul-mail";
MailList.authorizationUrl;
MailList.link;
//因为邮件没有分页参数，因此在前端记录返回的邮件数据。做前端分页
MailList.mailData;

MailList.initMailList = function(start,count){	
	if(false){
		//前端有缓存过数据
		//分页数据，渲染页面
		MailList.drawPage(MailList.getDataList(start,count));
	}else{
		//前端没有缓存过数据
		var account =  pageConfig.currentUserInfo.currentUserAccount
		var urlParams = contextPath + "/user/product/oa/externalInterfaceCall/getListMailNotification?account="+account+"&CAS_TOKEN="+getCookie("CAS_TOKEN");	
		$.ajax({
			type: "get",
			url: urlParams,
			async:true,
			dataType: "json",
			data: {},
			success: function(result){
				//记录服务器返回的邮件数据
				MailList.mailData = result;
				if(result.maillist.length == 0){
					//return;
					//网络不通，调试用临时数据
					result = getTestMailDataList();
					MailList.mailData = result;
				}
				MailList.total = parseInt(result.unreadCount);
				$("#badge-mail").html(MailList.total);
				MailList.authorizationUrl = result.authorizationUrl.split(": ").join(":");
				MailList.link = result.link;
				
				//分页数据，渲染页面
				MailList.drawPage(MailList.getDataList(start,count));
			},
			error:function(){}
		});
	}	
}

//获取前端记录的邮件数据
MailList.getDataList=function(start,count){
	var result = MailList.mailData;	
	if(result.maillist.length == 0){
		return result;		
	}
	
	var sliceStart = start;
	var sliceEnd = (start-0) + (count-0);
	var dataList = result.maillist.slice(sliceStart,sliceEnd);
	
	var newData = {};
	$.extend(true,newData,result);
	newData.maillist = dataList;
	return newData;
}

//根据数据组织页面
MailList.drawPage=function(result){
	if(result.maillist.length == 0){
		return;		
	}
	
	var liStr="";
	for(var i=0;i<result.maillist.length;i++){
		var mail = result.maillist[i];
	
		var mailDate = mail.date.split(" ")[0].split("-");		
		var mailTime = mail.date.split(" ")[1].split(":");		
		var dateText = mailDate[1]+"-"+mailDate[2] + " " + mailTime[0]+":"+mailTime[1]; 
		
		liStr+='<li class="col-md-3 col-xs-3 ui-draggable ui-draggable-handle">';
		if(mail.readFlag){
			liStr+='<a href="javascript:;" onclick="openMail(\''+mail.mailIndex+'\',\''+mail.messageID+'\')" '+
			'title="'+mail.subject+' '+mail.from+'" class="item redcorner">';
		}else{
			liStr+='<a href="javascript:;" onclick="openMail(\''+mail.mailIndex+'\',\''+mail.messageID+'\')" '+
			'title="'+mail.subject+' '+mail.from+'" class="item">';
		}
		liStr+='<p></p>';	
		/*liStr+='<p>'+dateText+'</p>';*/
		if(mail.subject.length > 30){
			mail.subject = mail.subject.substring(0,30)+"...";
		}
		liStr+=mail.subject;	
		/*liStr+='<span class="time"> </span></a>';*/
		var sender = "发送人：";
		var receiver = "接收时间："+dateText;
		if(mail.from.length > 13){
			sender = sender + mail.from.substring(0,10)+"...<br>";
		}else{
			sender = sender + mail.from+"<br>";
		}
		liStr+='<span class="time">'+sender+receiver+'</span>';
		liStr+='</li>';
	}
				
	var id = MailList.id;
	$("#"+id).html(liStr);		
}

MailList.nextMail = function(){		
	var pageCount = (MailList.total-1)/MailList.pageSize+1;
	pageCount = parseInt(pageCount)
	var next = MailList.curr+1;
	if(next<pageCount){
		MailList.initMailList(next*MailList.pageSize,MailList.pageSize);
		MailList.curr = next;
	}	
}

MailList.prevMail = function(){
	var prev = MailList.curr-1;
	if(prev>-1){
		MailList.initMailList(prev*MailList.pageSize,MailList.pageSize);
		MailList.curr = prev;
	}
}


function getTestMailDataList(){
	var data = 
	{
			"link": "7504f32f42d6c9c5d131b8ed07585c24d07a715e62eb02096f1c57b658da408a0220f922e2badd2f4ae720241a53d982",
			"unreadCount": 2,
			"maillist": [{
				"date": "2019-06-04 14:00:58:000",
				"readFlag": true,
				"subject": "邮件测试1",
				"messageID": "1427976602.14.1559628058456.JavaMail.root@node-30",
				"from": "liuyu@cetc.in",
				"mailIndex": 3,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:40:32:000",
				"readFlag": true,
				"subject": "邮件测试2",
				"messageID": "1717623676.15.1559216432536.JavaMail.root@node-30",
				"from": "wanghuan@cetc.in",
				"mailIndex": 2,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": true,
				"subject": "邮件测试3",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": true,
				"subject": "邮件测试4",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": false,
				"subject": "邮件测试5",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": false,
				"subject": "邮件测试6",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": false,
				"subject": "邮件测试7",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": false,
				"subject": "邮件测试8",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": false,
				"subject": "邮件测试9",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": false,
				"subject": "邮件测试10",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": false,
				"subject": "邮件测试11",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			},{
				"date": "2019-05-30 19:29:06:000",
				"readFlag": false,
				"subject": "邮件测试12",
				"messageID": "1009254461.13.1559215746750.JavaMail.root@node-30",
				"from": "test1@cetc.in",
				"mailIndex": 1,
				"attachmentFlag": false
			}],
			"message": "",
			"authorizationUrl":"http: //10.254.0.5: 8080/portal/AuthorizationServlet.wpk"
		}
	return data;
}

function openMail(mailIndex,messageId){
  addAppUsedRecord("","mail","我的邮件");
	var url = MailList.authorizationUrl + '?link='+MailList.link+'&mailIndex='+mailIndex+'&messageId='+messageId+"&token="+getCookie("CAS_TOKEN");
	window.open(url,'_blank');
}

var DiskList = {};
DiskList.curr = 0;
DiskList.total = 0;
DiskList.pageSize = 5;
DiskList.id="ul-disk";
DiskList.initDiskList = function(start,end){
	$.ajax({
		type: "post",
		url: contextPath + "/user/rest/protalPage/getDiskTotal",
		async:true,
		dataType: "json",
		data: {},
		success: function(result){
			if(result){
				DiskList.dislDatas = result.data;
				DiskList.diskData = result.data.items;
				DiskList.total = result.data.total;
				$("#badge-disk").html(DiskList.total);
				
				//分页数据，渲染页面
				DiskList.drawPage(DiskList.getDataList(start,end));
			}
		},
		error:function(){}
	});
}

//获取前端记录的网盘数据
DiskList.getDataList=function(start,count){
	var result = DiskList.diskData;	
	if(DiskList.total == 0){
		return result;		
	}
	
	var sliceStart = start;
	var sliceEnd = (start-0) + (count-0);
	var dataList = result.slice(sliceStart,sliceEnd);
	
	var newData = {};
	$.extend(true,newData,result.data);
	newData.disklist = dataList;
	return newData;
}

//根据数据组织页面
DiskList.drawPage=function(result){
	if(result.length == 0){
		return;		
	}
	
	var liStr="";
	for(var i=0;i<result.disklist.length;i++){
		var disk = result.disklist[i];
	
		var diskDate = timestampToTime(disk.inputDate).split(" ")[0].split("-");		
		var diskTime = timestampToTime(disk.inputDate).split(" ")[1].split(":");		
		var dateText = diskDate[1]+"-"+diskDate[2] + " " + diskTime[0]+":"+diskTime[1]; 
		
		liStr+='<li class="col-md-3 col-xs-3 ui-draggable ui-draggable-handle">';
		liStr+='<a href="javascript:;" onclick="openDisk(\''+disk.uri+'\')" '+
				'title="'+disk.itemName+'" class="item redcorner">';
		/*liStr+='<p>共享人：'+disk.sharedUser+'</p>';	
		liStr+='<p>'+dateText+'</p>';*/
		if(disk.itemName.length > 30){
			disk.itemName = disk.itemName.substring(0,30)+"...";
		}
		liStr+=disk.itemName;	
		liStr+='<span class="time">共享人：'+disk.sharedUser+'<br>接收时间：'+dateText+'</span>';
		liStr+='</li>';
	}
				
	var id = DiskList.id;
	$("#"+id).html(liStr);		
}

DiskList.nextDisk = function(){		
	var pageCount = (DiskList.total-1)/DiskList.pageSize+1;
	pageCount = parseInt(pageCount)
	var next = DiskList.curr+1;
	if(next<pageCount){
		DiskList.initDiskList(next*DiskList.pageSize,DiskList.pageSize);
		DiskList.curr = next;
	}	
}

DiskList.prevDisk = function(){
	var prev = DiskList.curr-1;
	if(prev>-1){
		DiskList.initDiskList(prev*DiskList.pageSize,DiskList.pageSize);
		DiskList.curr = prev;
	}
}


var GroupDisk = {};
GroupDisk.total = 0;
GroupDisk.initGroupDisk = function(){
	$.ajax({
		type: "post",
		url: contextPath + "/user/rest/protalPage/getGroupDiskInfo",
		async:true,
		dataType: "json",
		data: {token:getCookie("CAS_TOKEN")},
		success: function(result){
			if(result && result.msg=="OK"){
				GroupDisk.total = result.count;
				$("#badge-groupdisk").html(GroupDisk.total);
			}
		},
		error:function(){}
	});
}

/**
 * 从移动端获取会议通知（9月3号之后替换成，从OA获取通知通告，暂时注释这里）
 */
//var Meeting = {};
//Meeting.initMeetingList = function(){
//	$.ajax({
//		type: "post",
//		url: contextPath + "/user/rest/protalPage/getMeetings",
//		async:true,
//		dataType: "json",
//		data: {},
//		success: function(result){
//			if(result && result.result){
//				var arr = [];
//				for(var i = 0;i < result.result.length;i ++){
//					var meet = result.result[i];
//					var begintime = meet.begintime;
//					begintime = begintime.substr(11,5);
//					arr.push('<dt>'+begintime+'</dt>');
//					arr.push('<dd>');
//					arr.push('<a href="#" title="'+meet.meetingname+'('+meet.address+')">'+meet.meetingname+'<br><i class="fa fa-map-pin" ></i><span>'+meet.address+'<span></a>');
//					arr.push('</dd>');
//				}
//				$(".calendar_timeline dl").html(arr.join("\n"));
//			}else{
//				//$(".calendar_timeline dl").html("暂无会议");
//			}
//		},
//		error:function(){
//			//$(".calendar_timeline dl").html("暂无会议");
//		}
//	});
//}

var Notice = {};
Notice.initNoticeList = function(){
	$.ajax({
		type: "post",
		url: contextPath + "/user/product/oa/externalInterfaceCall/getNotification",
		async:true,
		//dataType: "json",
		data: {},
		success: function(result){
			if(result && result.data){
				var arr = [];
				for(var i = 0;i < result.data.length;i ++){
					var object = result.data[i];
					var createtime = timestampToTime(object.CREATION_TIME);
					createtime = createtime.substr(0,10);
					arr.push('<dt>'+createtime+'</dt>');
					arr.push('<dd>');
					//arr.push('<a href="#" title="'+object.TITLE+'">'+object.TITLE+'<br><i class="fa fa-map-pin" ></i>');
					arr.push('<a onclick="addAppUsedRecord(\'\',\'tzgg\',\'通知公告\')" href="'+integrateOaPath+'/wp/G_1_showNotice/G_1_notice_zhanpan.htm?id='+object.ENTITYID+'" target="_blank" title="'+object.TITLE+'">'+object.TITLE+'</a>');
					arr.push('</dd>');
				}
				$(".calendar_timeline dl").html(arr.join("\n"));
			}else{
				//$(".calendar_timeline dl").html("暂无通知");
			}
		},
		error:function(){
			//$(".calendar_timeline dl").html("暂无通知");
		}
	});
}

function refreshAll(){
	$("#refresh-all").html("&emsp;刷新中...");
	$("#refresh-all").css("opacity","0.5");
	setTimeout(function(){
		$("#refresh-all").html("&emsp;刷新全部");
		$("#refresh-all").css("opacity","inherit");
	}, 3000);
	TodoList.initTodoList(0,TodoList.pageSize);
	ToreadList.initToreadList(0,ToreadList.pageSize);
	DoneList.initDoneList(0,DoneList.pageSize);
	MailList.initMailList(0,MailList.pageSize);
	DiskList.initDiskList(0,DiskList.pageSize);
	GroupDisk.initGroupDisk();
	
}

$(document).ready(function() {
	setInterval(function(){
	  var time = new Date();
  	  var h = time.getHours();
  	  h = h < 10 ? '0' + h : h;
  	  var m = time.getMinutes();
  	  m = m < 10 ? '0' + m : m;
  	  var s = time.getSeconds();
  	  s = s < 10 ? "0" + s : s;
	  time = h + ":" + m + ":" + s;
  	  $("#datetime").html(time);
    }, 1000);
	
	$(".extend-exit").click(function(e){
		$.confirm({message:'您确定要退出系统吗？',buttons:[{type:"yes",clazz:"btn-primary",click:function(){
			var key = Math.round(Math.random() * 1000000);
	        var url = contextPath + '/logout?rkey='
	                + key + "&username=" + pageConfig.currentUserInfo.currentUserAccount;
	        window.location.href = url;
		}},"no"],event:e});
	});
		
	TodoList.initTodoList(TodoList.curr,TodoList.pageSize);
	$("#prev-todo").bind("click",function(){TodoList.prevTodo();});
	$("#next-todo").bind("click",function(){TodoList.nextTodo();});
	
	$("#prev-toread").bind("click",function(){ToreadList.prevToread();});
	  $("#next-toread").bind("click",function(){ToreadList.nextToread();});
	  
	  $("#prev-done").bind("click",function(){DoneList.prevDone();});
	  $("#next-done").bind("click",function(){DoneList.nextDone();});
	
	$("#prev-mail").bind("click",MailList.prevMail);
	$("#next-mail").bind("click",MailList.nextMail);
	
	$("#prev-disk").bind("click",DiskList.prevDisk);
	$("#next-disk").bind("click",DiskList.nextDisk);
	
	setTimeout(function(){
		ToreadList.initToreadList(ToreadList.curr,ToreadList.pageSize);
		DoneList.initDoneList(DoneList.curr,DoneList.pageSize);
		MailList.initMailList(MailList.curr,MailList.pageSize);
		DiskList.initDiskList(DiskList.curr,DiskList.pageSize);
		GroupDisk.initGroupDisk();
		//暂时不调用会议通知接口,改调用OA的会议通知
		//Meeting.initMeetingList();
		Notice.initNoticeList()
	}, 1000);
	
	//自动刷新，每隔1分钟刷新一次
	setInterval(function() {
		TodoList.initTodoList(0,TodoList.pageSize);
		ToreadList.initToreadList(0,ToreadList.pageSize);
		DoneList.initDoneList(0,DoneList.pageSize);
		MailList.initMailList(0,MailList.pageSize);
		DiskList.initDiskList(0,DiskList.pageSize);
	}, 60000);
	
	$("#tab-todo").bind("click",function(){
		  $("#todo-section .more").attr("href",contextPath+"/user/product/oa/workspace/user/todolistByPortal.jsp");
      $("#todo-section .more").off("click");
	  })
	  
	  $("#tab-done").bind("click",function(){
		  $("#todo-section .more").attr("href",contextPath+"/user/product/oa/workspace/user/todolistByPortal.jsp?tab=done");
      $("#todo-section .more").off("click");
	  })
	  
	  $("#tab-toread").bind("click",function(){
		  $("#todo-section .more").attr("href",contextPath+"/user/product/oa/workspace/user/toreadlist.jsp");
		  $("#todo-section .more").off("click");
	  })
	  
	  $("#tab-mail").bind("click",function(){
		  //$.tip('敬请期待...');
		  var ip = mailIp;
		  var url = ip+"/servlet/UpmLoginServlet?type=1&token="+getCookie("CAS_TOKEN");
		  $("#todo-section .more").attr("href",url);
		  $("#todo-section .more").on("click",{"appId":"mail","appName":"我的邮件"},addAppUsedRecord);;
	  })
	  
	  var mail_url = mailIp+"/servlet/UpmLoginServlet?type=1&token="+getCookie("CAS_TOKEN");
	  $(".quickpass dd.disk a").attr("href",mail_url);
	  
	  $("#tab-disk").bind("click",function(){
		  //$.tip('敬请期待...');
		  var url = diskIp+"?token="+getCookie("CAS_TOKEN");
		  $("#todo-section .more").attr("href",url);
		  $("#todo-section .more").attr("onclick","diskMore();");
	  })
	  
	  $("#tab-groupdisk").bind("click",function(){
		  var ip = groupDiskIndexIp;
		  var url = ip+"/page/index.html?token="+getCookie("CAS_TOKEN");
		  $("#todo-section .more").attr("href",url);
	  })
	  
	  $("[href='#personschedule']").bind("click",function(){
		  //个人日程标签点击
		  $("#scheduleMore").show();
	  });
	
	  $("[href='#leaderschedule']").bind("click",function(){
		  //领导日程标签点击
		  $("#scheduleMore").hide();
	  });
	  
	  /*$(".meetingMore").bind("click",function(){
		  $.tip('敬请期待...');
	  })*/
	  
	  $(".contacts_name").bind("click",function(){
		  $.tip('敬请期待...');
		  if($(".users_t").css("display")=="none"){
			  $(".users_t").css("display","");
		  }else{
			  $(".users_t").css("display","none");
		  }
	  })
	  
	//右侧人员
	  $(".lists").hover(function(){
		  $.tip('敬请期待...');
			$(this).addClass("active");
      },function(){
          $(this).removeClass("active");
      }) 
      
	  $(".building").each(function(){
		  $(this).click(function(e){
			  $.tip('敬请期待...');
			  return false;
		  })
	  })
	  
	  $('.leftbottom input').bind('keypress',function(event){
          if(event.keyCode == "13")    
          {
        	  var text = $(".all_sear input").val();
    		  if($.trim(text)){			  
    			  if(!/^[\u4e00-\u9fa5]+$/gi.test(text)){
    				  $.tip('搜索内容只能输入中文，请重新输入！');
    				  return false;
    			  }else{
    				  var url = contextPath + "/wp/G_1_portal/G_1_WcmSearch.htm?searchText="+encodeURIComponent(text);
    				  window.open(url,"_blank");
    			  }
    		  }
    		  return false;
          }
      });
	  
	  //搜索功能
	  $(".fa-search").parents("button").click(function(e){
		  var text = $(".all_sear input").val();
		  if($.trim(text)){		
			  if(!/^[\u4e00-\u9fa5]+$/gi.test(text)){
				  $.tip('搜索内容只能输入中文，请重新输入！');
				  return false;
			  }else{
				  var url = contextPath + "/wp/G_1_portal/G_1_WcmSearch.htm?searchText="+encodeURIComponent(text);
				  window.open(url,"_blank");
			  }
		  }
		  return false;
	  });
	  
	  //初始化门户管理员的功能
	  isPortalAdmin();
	  
	  //初始化人脸识别注册
	  $("#tyyh_authface").show();
	  $("#tyyh_authface").click(showAuthFace);
	  
	  //初始化修改密码
	  initResetPassword();
	  
	  //新手指引提示信息
	  if(isShowBootAnimation){
		  setTimeout(function(){ 
			  portalViewMsg();
		  }, 3000);
	  }
	  
	  $(".dksc").hover(dksctip);
		
	  
	//编辑用户头像
	  $('ul.user_info>li:nth-child(4)>img').click(function(e){
		  $.seniorDialog({title:"头像设置",size:"",height:"300",buttons:[{label:"确定", click:function(dialog){
			  $('ul.user_info>li:nth-child(4)>img').attr('src',$('#contentFrame').contents().find('#avatar').attr('src'));
				dialog.modal("hide");
			}},"cancel"],onload:function(seniorDialog){
				var url = contextPath +"/user/avatar.jsp";
				var photoSetting = "<div class=\"row\"><div class=\"col-md-2\"></div><div class=\"col-md-8\">"
									+"<iframe id=\"contentFrame\" width=\"100%\" frameborder=\"0\" src="+url+" style=\"height: 250px;\"></iframe></div></div>"
									
//				seniorDialog.find(".modal-body").tablet({id:"logInDetails",tabs:[{id:"userPhoto",label:"",onload:function(tab,tabPanel){
//					tabPanel.append($.templates(photoSetting).render({}));
//				}}]});
				seniorDialog.find(".modal-body").append($.templates(photoSetting).render({}));
			}});
	  });
	  
	  //加载用户头像
	  userService.getUser(pageConfig.currentUserInfo.currentUserAccount,{callback : function(ret) {
		  if(ret.props['avatar'] && ret.props['avatar'] != '') {
			    var avatarUrl = contextPath + "/user/avatar/" + ret.props['avatar'];
			    $('ul.user_info>li:nth-child(4)>img').attr('src',avatarUrl);
		  }
	  }});
	  
});

//格式化时间
var custom_formatDate = function (date) {
	var s = "";
	if(date != null){
		// var y = date.getFullYear();
		var m = date.getMonth() + 1;
		m = m < 10 ? '0' + m : m;
		var d = date.getDate();
		d = d < 10 ? ('0' + d) : d;
		var hour = date.getHours();
		hour = hour < 10 ? '0' + hour : hour;
		var min = date.getMinutes();
		min = min < 10 ? '0' + min : min;
		s = m + '-' + d +" "+hour+":"+min;
	}
	return  s;
};

window.openMindWin=function(obj){
	// 待办表的打开方式
    var link = $(obj).attr("link");
    //判断URI中有包含account,并对其进行加密
    var accountEncode = getUrlParam("account",link);
    if(accountEncode != null){
    	var accountUriEncode = encodeURIComponent(accountEncode);
    	link = link.replace(accountEncode,accountUriEncode);
    	link += "&cas=yes";
    }
    var realLink = link;
    var key = new Date().getTime();
    /*zhaolk  2019-6-24 
     * 首页js ，要区分： 待办、已办、待阅
     */
    var type=arguments.length>1?arguments[1]:null;
    if(type=="read"){
    	realLink=link+'bpm/view.htm?instId='+arguments[3]+'&mode=sendtoread&id='+arguments[2]+'&isMS=0';
    }
    if (realLink.indexOf('?') == -1) {
    	realLink += '?rkey=' + key;
	} else {
		realLink += '&rkey=' + key;
	}
    realLink+="&issite=1";//标识   该链接是从门户跳转过来的，oa要区分
    if(realLink.indexOf("http://")==-1){//解决门户 本地打开url报错的问题
    	realLink=contextPath+"/"+realLink;
    }
    var w = window.screen.availWidth;
    var features = 'top=0,left=0,width=' + w + ',height=900' + ',location=yes,menubar=no,resizable=yes,scrollbars=yes,status=no,toolbar=no ';
    var win = null;
    //如果是代办，在同一个页签打开
    if(type=="todo"){
    	win = window.open(realLink,'待办');	
    }else{
    	win = window.open(realLink,'_blank');
    }
	    if(!win) {
	      alert('弹出窗口已被拦截，请手工设置为允许弹出窗口！');
	    } else {win.focus();}
};

window.openNewsDetails=function(columnId,id){
  addAppUsedRecord("","jrdk","今日电科");
	var realLink = contextPath+"/wp/G_1_portal/G_1_WcmDocList.htm?columnId="+columnId+"&id="+id;
	var win = window.open(realLink,'_self');

    if(!win) {
      alert('弹出窗口已被拦截，请手工设置为允许弹出窗口！');
    } else {win.focus();}
}


//判断是否门户管理员
function isPortalAdmin(){
	var urlParams = contextPath + "/user/product/oa/externalInterface/getUserRoleList";    	
	$.ajax({
		type: "get",
		url: urlParams,
		async:true,
		dataType: "json",
		data: {
		       "account": pageConfig.currentUserInfo.currentUserAccount
		      },
		success: function(result){    			
			if(result && result.length >0){
				$(result).each(function(){
					var role = this;
					if(role.code == "ADMINISTRATOR"){
						//显示统一认证的组织管理
						showOrgManager();
						//显示门户的文档管理
						initDocManager();
						
						//处理展示不全问题   展示列表移到三角右侧
						$(".otherActiveLi .otherActiveMenu").css("right","-115px");
						$(".otherActiveLi .otherActiveMenu").css("margin-top","-50px");
						return false;
					}
				});
			}   			
		},
		error:function(){
			//调用失败
		}
	});
	
}

//显示组织机构管理地址
function showOrgManager(){
	var urlParams = contextPath + "/user/product/oa/externalInterfaceCall/getTyrzOrgPath";    	
	$.ajax({
		type: "get",
		url: urlParams,
		async:true,
		dataType: "json",
		data: {},
		success: function(result){    			
			if(result && result.path){
				$("#tyyh_orgManage").show();
				$("#tyyh_orgManage").click(function(e){
					var orgManageUrl = result.path + "?token=" + getCookie("CAS_TOKEN");					
					window.open(orgManageUrl,"_blank");
				});
			}   			
		},
		error:function(){
			//调用失败
		}
	});
}

//初始化修改密码
function initResetPassword(){
	$("#tyyh_updatePassword").click(function(e){
		showResetPasswordDialog();
	});
}

//初始化文档管理
function initDocManager(){
	$("#portal_docManage").show();
	$("#portal_docManage").click(function(e){
		window.open("/webapp/user/product/oa/workspace/portal.jsp","_blank");
	});
}

//修改用户密码
function showResetPasswordDialog(){
	$.seniorDialog({title:"密码重置",buttons:[{label:"确定", click:function(dialog){
		var oldPwd = dialog.find('#oldPassword').val();
      var newPwd = dialog.find('#newPassword').val();
      var newPwd2 = dialog.find('#newPassword2').val();
      if(!oldPwd) {
          $.tip("旧密码不能为空！");
          return;
      }
      if(!newPwd) {
          $.tip("新密码不能为空！");
          return;
      }
      if(!newPwd2) {
          $.tip("重复新密码不能为空！");
          return;
      }
      if (newPwd != newPwd2) {
          $.tip("新密码不匹配！");
          return;
      }
             
  	var urlParams = contextPath + "/user/product/oa/externalInterfaceCall/updatePassword";    	
  	$.ajax({
  		type: "get",
  		url: urlParams,
  		async:true,
  		dataType: "json",
  		data: {"oldPwd":oldPwd,"newPwd":newPwd},
  		success: function(result){    			
  			if(result && result.state == 1){
  				$.tip("设置密码成功！");
                  dialog.modal("hide");
  			}else{
  				$.tip("设置密码失败！");
  			}    			
  		},
  		error:function(){
  			$.tip("设置密码失败！");
  		}
  	});
              
  }}],onload:function(dialog){
  dialog.find(".modal-body").append(
  		"<form action=\"#\" class=\"form-horizontal\">" +
  			"<div class=\"form-group\" >" +
  				"<label class=\"col-md-3 control-label\">输入旧密码</label>" +
  				"<div class=\"col-md-6\">" +
  					"<input name=\"oldPassword\" type=\"password\" class=\"form-control\"  value=\"\" id=\"oldPassword\">" +
  				"</div>" +
  			"</div>" +
  			"<div class=\"form-group\" >" +
  				"<label class=\"col-md-3 control-label\">输入新密码</label>" +
  				"<div class=\"col-md-6\">" +
  					"<input name=\"newPassword\" type=\"password\" class=\"form-control\"  value=\"\" id=\"newPassword\">" +
  				"</div>" +
  			"</div>" +
  			"<div class=\"form-group\" >" +
				"<label class=\"col-md-3 control-label\">重复新密码</label>" +
				"<div class=\"col-md-6\">" +
					"<input name=\"newPassword2\" type=\"password\" class=\"form-control\"  value=\"\" id=\"newPassword2\">" +
				"</div>" +
			"</div>" +
      	"</form>");
  }});
}

function showAuthFace(){
	var ip = location.href.split("/wp/")[0]
	layer.open({
	  type: 2,
	  title: '人脸识别注册',
	  shadeClose: true,
	  shade: 0.8,
	  area: ['480px', '560px'],
	  content: ip+'/resources/portal/authface/video.html' //iframe的url
	}); 
}

//获取cookie
function getCookie(name) {
	var reg = RegExp(name + '=([^;]+)');
	var arr = document.cookie.match(reg);
	if (arr) {
		return arr[1];
	} else {
		return '';
	}
};

function timestampToTime(timestamp) {
    var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
    Y = date.getFullYear() + '-';
    M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
    D = date.getDate() < 10 ? '0' + date.getDate() + ' ' : date.getDate() + ' ' ;
    h = date.getHours() + ':';
    m = date.getMinutes() + ':';
    s = date.getSeconds();
    return Y+M+D+h+m+s;
}

function portalViewMsg(){
	 $.ajax({
	      type: 'POST',
	      url: contextPath+"/user/rest/protalPage/getPortalViewMsg",
	      async:true, //异步取值\
	      success: function (data) {
	        if(!data){
	        	layer.open({
	        		type:1,
	        		skin:'layerMsg',
	        		title:false,
	        		resize:false,
	        		area:['850px','509px'],
	        		content:'<div  class="layerHeader">欢迎来到WE数字化工作环境！'
	        			+ '<br>WE数字化工作环境现已正式投入使用！</div>'
	        			+ '<div class="layerContent"><span class="layerContentT">WE简介：</span><br>&emsp;&emsp;WE数字化工作环境,是中国电科聚集全集团资源, 以“应用牵引，聚焦WE，研究与应用并重”的原则,充分发挥各家的技术优势，合力打造的基于中国芯的云上办公产品。'
	        			+ '<br>&emsp;&emsp;WE首页可提供待办、已办、待阅、我的邮件、我的网盘、效能分析、常用联系人、日程安排、今日电科等功能展示。</div>'
	        			+ '<div class="layerBottom"><span class="left">温馨提示：如有疑问可下载查看操作指南手册。</span>'
	        			+ '<span class="right"><a href="../../resources/portal/user/js/WE首页操作指南.docx">WE首页操作指南手册&emsp;点击下载<img src="../../resources/theme/base/images/xz.png"></a></span></div>'
	        	});
	        	
	        	 $.ajax({
	       	      type: 'POST',
	       	      url: contextPath+"/user/rest/protalPage/createPortalViewMsg",
	       	      async:true, //异步取值
	       	      success: function (data) {
	       	        console.log(data);
	       	      }
	       	 });
	        }
	      }
	 });
}

//打开我的邮件链接
function openMailList(){
	var ip = mailIp;
	var url = ip+"/servlet/UpmLoginServlet?type=1&token="+getCookie("CAS_TOKEN");
	window.open(url,'_blank');
}

//打开我的网盘链接
function openDisk(uri){
	var ip = diskIp;
	var url = ip+"/netdisk"+uri;
	window.open(url,'_blank');
	clearDisk();
}

function clearDisk(){
	$("#badge-disk").html(0);
	var id = DiskList.id;
	$("#"+id).html("");
	$.ajax({
 	      type: 'post',
 	      url: contextPath + "/user/rest/protalPage/clearDisk",
 	      async:true, //异步取值
 	      success: function (data) {
 	        console.log(data);
 	      }
 	 });
}

function diskMore(){
	clearDisk();
}

//格式化时间
var formatDate = function (date) {
	var s = "";
	if(date != null){
		// var y = date.getFullYear();
		var m = date.getMonth() + 1;
		m = m < 10 ? '0' + m : m;
		var d = date.getDate();
		d = d < 10 ? ('0' + d) : d;
		var mi = date.getMinutes() ;
		mi = mi < 10 ? ('0' + mi) : mi ;
		s = m + '-' + d +" "+date.getHours()+":"+mi;
	}
	return  s;
};

function dksctip(){
	//tips层
	layer.tips(
			"<img src= \"" + contextPath + "/resources/portal/common/img/dksc.jpg\" style=\"width: 55px\">",
			$(".dksc"),
			{tips:[3,'#2c4975'],area:['69px','66px'],time:4000}
	);
}

//获取url中的参数
function getUrlParam(name,url){
    // 用该属性获取页面 URL 地址从问号 (?) 开始的 URL（查询部分）
	if(url== "" || url==undefined || url == null){
		url = window.location.search;	
	}
    
    url = decodeURI(url);
    // 正则筛选地址栏
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    // 匹配目标参数
    var result = url.substr(1).match(reg);
    //返回参数值
    return result ? decodeURIComponent(result[2]) : null;
}


//首页页面元素，页面加载后即可绑定事件
var apps = {
    "mail":"我的邮件",
    "disk":"我的网盘",
    "zszx":"共享资源",
    "gongwen":"公文",
    "down":"资源下载",
    "ywtb":"一网通办",
    "tzgg":"通知公告",//通知公告更多
    "grrc":"个人日程",//个人日程更多
}
/* 特殊模块如列表异步加载需要分别单独增加
 * addAppUsedRecord("","","");
 * 领导"我的邮件"在函数：openMailList中增加，(leaderpage.js：addAppUsedRecord("","mail","我的邮件");)
 * 邮件列表点击监控在函数：openMail，(leaderpage.js、userpage.js：addAppUsedRecord("","mail","我的邮件");)
 * 全景图加载即增加记录在:CetcBiInfo.initCetcBiInfo，(leaderpage.js：addAppUsedRecord("","qjt","全景图");)
 * 今日电科在函数：openNewsDetails，(leaderpage.js、userpage.js：addAppUsedRecord("","jrdk","今日电科");)
 * 视频会议在函数：hikMessageHint.js中增加addAppUsedRecord("","sphy","视频会议");
 * 通知公告列表点击监控在：Notice.initNoticeList中增加addAppUsedRecord("","tzgg","通知公告");(userpage.js)
 * 个人日程加载即增加记录在：(schedule.js、scheduleByUser.js：addAppUsedRecord("","grrc","个人日程");)
 * 
 */


function bindSuperLink(){
  $.each(apps,function(appId,appName){
     $("."+appId).on("click",{"appId":appId,"appName":appName},addAppUsedRecord);
  })
}

//增加链接访问记录
function addAppUsedRecord(event,appId,appName){
  if(appId=="" || appId==undefined || appName=="" || appName==undefined){
    appId = event.data.appId;
    appName = event.data.appName;
  }
  if(appId=="" || appId==undefined || appName=="" || appName==undefined){
    console.log("appId、appName 不能为空。");
  }else{
    $.ajax({
      type: "post",
      url: contextPath + "/user/rest/appUsedDate/add",
      async:true,
      dataType: "json",
      data: {account:pageConfig.currentUserInfo.currentUserAccount,name:pageConfig.currentUserInfo.currentUserName,deptId:pageConfig.currentUserInfo.currentUserDeptId,deptName:pageConfig.currentUserInfo.currentUserDeptName,appId:appId,appName:appName},
      success: function(result){
        if(result && result.status=="1"){
          console.log(appName+" 已增加访问记录。");
        }else{
          console.log(result.msg);
        }
      },
      error:function(jqXHR, textStatus, errorThrown){
        console.log("增加访问记录"+jqXHR.status+"："+textStatus);
      }
    });
  }
}

//绑定链接点击事件
$(document).ready(function() {
  //首页元素事件绑定
  bindSuperLink();
  //右上角小三角资源下载
  $("#portal_srcDownload").on("click",{"appId":"down","appName":"资源下载"},addAppUsedRecord);
});