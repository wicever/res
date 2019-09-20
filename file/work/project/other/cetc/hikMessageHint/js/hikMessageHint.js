/**
 * <p> 海康会易通:客户端唤醒、会议通知消息提醒
 *
 * @author <a href="mailto:songjw@smartdot.com.cn">JiWen</a>
 * @version 1.0, 2019-09-17
 */

$(document).ready(function() {

  //门户首页唤醒客户端图标
  if(location.href.indexOf("G_1_leaderIndex.htm")>-1){
    var iconHtml = "<a href=\"#\" class=\"\" id=\"hkhyt\"><i class=\"extend-shipin-leader\"></i>海康会易通</a>";
    $("form nav").append(iconHtml);
  }else{
    var iconHtml = "<dd class=\"hkhyt\" id=\"hkhyt\">\n" +
        "             <i class=\"fas extend-shipin_2\" style=\"color: #ff5ce0;\"></i>\n" +
        "             <br>海康会易通\n" +
        "           </dd>";
    $("dl.quick.pass").append(iconHtml);
  }
  //海康会易通客户端唤起
  $("#hkhyt").on("click",function () {
    var userInfo = {
      "userInfo":{
        "name":pageConfig.currentUserInfo.currentUserAccount,
        "password":"password",
        "token":pageConfig.currentUserInfo.currentUserName
      }
    }

    var request = $.ajax({
      type: "POST",
      url: "/hikVideoConference/v1/pcClient/login",
      data: userInfo,
      dataType: "json"
    }).done(function(msg) {
      console.log(msg.code);
      if(msg.code == "0-0"){
        $.tip("唤起客户端成功");
      }else{
        $.tip("唤起客户端失败:"+msg.code);
      }
    }).fail(function(jqXHR, textStatus) {
      $.tip("唤起客户端失败"+jqXHR.status+"："+textStatus);
    });

  });

  /*$("#hkhyt").on("click",function () {
    var request = $.ajax({
      type: "GET",
      url: contextPath + "/user/product/oa/hikVideoConference/login",
      data: {"account":pageConfig.currentUserInfo.currentUserAccount},
      dataType: "json"
    }).done(function(msg) {
      console.log(msg.code);
      if(msg.code == "0-0"){
        $.tip("唤起客户端成功");
      }else{
        $.tip("唤起客户端失败:"+msg.code);
      }
    }).fail(function(jqXHR, textStatus) {
      $.tip("唤起客户端失败"+jqXHR.status+"："+textStatus);
    });

  });*/

  var msgData = {};
  var HikMsg = {};
  HikMsg.id = 0;
  HikMsg.senderName = "张三";
  HikMsg.createTime = new Date();
  HikMsg.title = "海康会易通的测试消息";
  HikMsg.content = "海康会易通海康会易通海康会易通海康会易通海康会易通海康会易通海康会易通海康会易通海康会易通海康会易通。";
  msgData.HikMsg = HikMsg;
  //showMsg(msgData.HikMsg);

});

lsm = setInterval(function () {
  /* 每5分钟获取下最新的提醒信息 */
  //getHikMsg();

}, 300000);
function getHikMsg(){
  dwrHikMsgService.getHikMsg({
    callback: function (ret) {
      if(ret != null){
        var HikMsg = ret.HikMsg;
        if(HikMsg != null){
          showMsg(HikMsg);
        }
      }
    }
  });
}

function showMsg(HikMsg) {
  var bottom = 15;
  var index = $(".hikMessageHint[active=true]").length;
  if(index>0){
    bottom = 165*index+bottom;
  }
  var time =  HikMsg.createTime.format("yyyy-MM-dd HH:mm:ss");
  var hitHtml = "<div class='hikMessageHint' hitIndex="+index+" id='hikMessageHint_"+HikMsg.id+"' active='false' style='bottom:"+bottom+"px;'>" +
      " <div class='hintInfo'>" +
      "  <div class='hintInfoTitle clearfix'>" +
      "   <span class='sender'>发送人："+HikMsg.senderName+index+"</span><span class='sendTime'>发送时间："+time+"</span><span class='pull-right closeHint' onclick='closehikMessageHint(this)'>X</span>" +
      "  </div>" +
      "  <div class='hintInfoContent clearfix'>" +
      "   <div class='hintInfoIcon pull-left'>" +
      "    <img alt='' src='"+contextPath+"/resources/portal/hikMessageHint/img/infoal.png' width='100%'>" +
      "   </div>" +
      "   <div class='messageInfoContent pull-left' onclick='openHikMsg("+HikMsg.id+");'>" + HikMsg.content +"</div>" +
      "  </div>" +
      " </div>" +
      "</div>"

  $("body").append(hitHtml);
  $("#hikMessageHint_"+HikMsg.id).fadeIn();
  $("#hikMessageHint_"+HikMsg.id).attr("active","true");
}

/* 关闭右下角提醒 */
function closehikMessageHint(obj){
  $(obj).parents(".hikMessageHint").fadeOut();
  $(obj).parents(".hikMessageHint").attr("active","false");
  var hitIndex = $(obj).parents(".hikMessageHint").attr("hitIndex");
  $.each($(".hikMessageHint"),function (i,o) {
    var curIndex = $(o).attr("hitIndex");
    if(parseInt(curIndex)>parseInt(hitIndex)){
      var bottom = $(o).css("bottom").replace("px","");
      bottom = (parseInt(bottom)-165);
      // $(o).css("bottom",bottom+"px");
      $(o).animate({bottom:bottom+'px'}, 500);
    }
  })
}


function openHikMsg(id) {
  var strUrl = contextPath + "/xxx?id=" + id;
  var win = window.open(strUrl);
  if (!win) {
    $.tip('弹出窗口已被拦截，请手工设置为允许弹出窗口！');
  } else {
    win.focus();
  }
}
