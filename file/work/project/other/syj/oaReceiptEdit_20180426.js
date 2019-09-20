$(function(){
	//setTimeout(function(){
	  $("#ju_leader_text").click(function(){
	    $(".ju_panel>div").remove() ;
	    dwr.engine.setAsync(false);
	    dictDesignService.getValueList("JU_LEADER",{
			callback:function(leaderArray){
			  	$.each(leaderArray,function(j,juopt){
		      			var textNodej = document.createTextNode(juopt.name);
		      			var divElej = document.createElement("div");
		      			$(divElej).addClass("ju");
		      			$(divElej).append(textNodej);
		      			$(divElej).insertBefore($("#queding"));
		      			var divElep = document.createElement("div");
		      			$(divElep).insertAfter($(divElej));
		      			$(divElep).css("text-align","left");
		      			dwr.engine.setAsync(false);
		      			dictDesignService.getValueList("PISHI",{
		      				callback:function(pishiArray){
		      					$.each(pishiArray,function(p,piopt) {      
		      						var textNodep = document.createTextNode(piopt.name);          
		      						var inputElep = document.createElement("input");
		      						$(inputElep).attr("type","radio");
		      						$(inputElep).attr("name",juopt.id);
		      						$(inputElep).attr("value",piopt.name);
		      						$(inputElep).attr("for",juopt.name);
		      						$(inputElep).attr("class","pishiradio");
		      						$(divElep).append(inputElep);                 
		      						$(textNodep).insertAfter($(inputElep));
		      					});
		      				}
		      			});
			  	});
			}
		})	    

	    if($("#ju_leader_text")[0].value!="点击选择局领导批示"){
	    	setAllCheck();
	    }
	  	$("#ju_leader_text").hide();
	  	$(".ju_panel").slideToggle("slow");
	  });
	  $("#queding").click(function(){
		  getAllCheck();
		  if($("#action_arr").val().indexOf("批示")!=-1){
			  $("#ju_opinion").css("display","")
		  }else{
			  $("#ju_opinion").css("display","none")
		  }
	      $(".ju_panel").slideUp("slow");
	      $("#ju_leader_text").show();
	    });
	  $("#quxiao").click(function(){
	      $(".ju_panel").slideUp("slow");
	      $("#ju_leader_text").show();
	    });

	  if($("#action_arr").val().indexOf("批示")!=-1){
		  $("#ju_opinion").css("display","")
	  }else{
		  $("#ju_opinion").css("display","none")
	  }
	//},200);
	  $("#main_dept_leader").attr("readOnly","readOnly");
	  $("#help_dept_leader").attr("readOnly","readOnly");
});

function getAllCheck(){
	var user = new Array();
    var action = new Array();
    var res = "";
    $.each($(".pishiradio:checked"),function(i,item){
      if(item.value!="无"){
         user[i] = $(item).attr("for");
         action[i] = item.value;
      }
    });
    dwr.engine.setAsync(false);
    dictDesignService.getValueList("PISHI",{
			callback:function(pishiData){
				$.each(pishiData,function(n,opt){
					var restmp = "";
					$.each(action,function(m,obj) {
						if(opt.name==obj){
							if(restmp==""){
								restmp = user[m];
							}else{
								restmp = restmp +"、"+ user[m];
							}
						}
					})
					if(res == "" & restmp!=""){
						res = restmp + opt.name;
					}else if(res != "" & restmp!=""){
						res = res +"，"+ restmp + opt.name;
					}       
				});
			}
    });
    $("#ju_leader_text")[0].value=res;
    $("#user_arr")[0].value=user;
    $("#action_arr")[0].value=action;
}
function setAllCheck(){
	var user = $("#user_arr")[0].value.split(",");
    var action = $("#action_arr")[0].value.split(",");
    $.each(action,function(m,obj) {
    	$(".pishiradio[for='"+ user[m] +"'][value='"+ action[m] +"']").attr("checked","true");
      })
}
//提交前校验
function submitBeforeCheck(){
	//当前业务的标题的值
	var titleValue = "";
	if($("#doc_title").length > 0){
		titleValue = $("#doc_title").val();
	}
	if(titleValue === ""){
		return ;
	}
	//拼写查询语句，name为数据中的标题字段，如果不同则修改
	var condition = {"name" : "DOC_TITLE",	"op" : "eq","stringValue":titleValue};
	//调用标题检验函数  参数 condition为查询条件对象 
	//参考样例   {"name" : "数据库标题字段",	"op" : "一般填写为eq，意思为相等，其他比较符号请参考帮助文档","stringValue":"标题的值"}
	var res = checkFormTitleIsRepeat(condition);
	if(res){
		$.tip('标题重复，请修改后提交!');
		return false;
	}
}

//选完主办部门回调设置主办部门负责人
$(document).on("person.picker.ok.click.MAIN_DEPT_NAME",function(event,data){
	setDeptBossByDeptData("main_dept_leader",data);
});
//选完协办部门回调设置协办部门负责人
$(document).on("person.picker.ok.click.HELP_DEPT_NAME",function(event,data){
	setDeptBossByDeptData("help_dept_leader",data);
});


/**
 * 根据选择的部门获取对应的负责人
 * @param nameField 	负责人姓名字段 
 * @param DeptData		选择的部门相关信息
 * @returns
 */
function setDeptBossByDeptData(nameField,DeptData){
	//获取当前部门负责人
	if($("#"+nameField).length > 0){
		
		//用于存放部门负责人名称
		var bossNames = new Array();
		var dataObj=eval(DeptData);
		$.each(dataObj,function(n,e){
				//console.log(e.code)
				//调用获取部门负责人列表方法 参数DeptId为当前部门ID，可以通过pageConfig中获取
				var userList = getDeptBossheads(e.code);
				//判断部门负责人列表是否为空
				if(userList != "" && userList.length > 0){
					//将部门负责人数据取出分别存放
					for(var i = 0 ; i< userList.length; i++){
						bossNames.push(userList[i].name);
					}
				}
			})
		
		//进行赋值
		if(bossNames.length > 0 ){
			$("#"+nameField).val(bossNames.join(","));
		}else{
			$("#"+nameField).val("");
		}
	}
}

/**
 * 根据key获取数据字典中的配置的选项
 * 依赖dwr：/dwr/interface/dictDesignService.js
 * @param strKey
 * @returns
 */
function getDictValueList(strKey,obj){
	dwr.engine.setAsync(false);
	dictDesignService.getValueList(strKey,{
		callback:function(data){
			$.each(data,function(j,juopt){
				console.log(juopt);
			})
		}
	})
}
