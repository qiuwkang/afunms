<%@page language="java" contentType="text/html;charset=GB2312"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.topology.util.NodeHelper"%>
<%@page import="com.afunms.application.model.Resin"%>
<%@page import="com.afunms.polling.base.*"%>
<%@page import="com.afunms.polling.*"%>
<%@ include file="/include/globe.inc"%>
<%@page import="com.afunms.inform.util.SystemSnap"%>
<%
	List list = (List) request.getAttribute("list");
	int rc = list.size();
	String rootPath = request.getContextPath();
	String menuTable = (String) request.getAttribute("menuTable");
%>
<html>
	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<script language="JavaScript" type="text/javascript"
			src="<%=rootPath%>/include/navbar.js"></script>
		<link
			href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath()%>css/global/global.css"
			rel="stylesheet" type="text/css" />
		<LINK href="<%=rootPath%>/resource/css/style.css" type="text/css"
			rel="stylesheet">
		<script type="text/javascript" src="<%=rootPath%>/resource/js/page.js"></script>

		<script language="javascript">
  var delAction = "<%=rootPath%>/resin.do?action=delete";
  var listAction = "<%=rootPath%>/resin.do?action=list";
  
    function toDelete2()
  {
  if(confirm('是否确定删除这条记录?')) {
     mainForm.action = "<%=rootPath%>/resin.do?action=delete";
     mainForm.submit();
    }
  }
  
  function toAdd()
  {
     mainForm.action = "<%=rootPath%>/resin.do?action=ready_add";
     mainForm.submit();
  }
  
  function detail(id)
  {
	mainForm.action = "<%=rootPath%>/resin.do?action=detail&id="+id;
	mainForm.submit();
  }
  
</script>
		<script language="JavaScript">

	//公共变量
	var node="";
	var ipaddress="";
	var operate="";
	/**
	*根据传入的id显示右键菜单
	*/
	function showMenu(id,nodeid,ip)
	{	
		ipaddress=ip;
		node=nodeid;
		//operate=oper;
	    if("" == id)
	    {
	        popMenu(itemMenu,100,"100");
	    }
	    else
	    {
	        popMenu(itemMenu,100,"1111");
	    }
	    event.returnValue=false;
	    event.cancelBubble=true;
	    return false;
	}
	/**
	*显示弹出菜单
	*menuDiv:右键菜单的内容
	*width:行显示的宽度
	*rowControlString:行控制字符串，0表示不显示，1表示显示，如“101”，则表示第1、3行显示，第2行不显示
	*/
	function popMenu(menuDiv,width,rowControlString)
	{
	    //创建弹出菜单
	    var pop=window.createPopup();
	    //设置弹出菜单的内容
	    pop.document.body.innerHTML=menuDiv.innerHTML;
	    var rowObjs=pop.document.body.all[0].rows;
	    //获得弹出菜单的行数
	    var rowCount=rowObjs.length;
	    //alert("rowCount==>"+rowCount+",rowControlString==>"+rowControlString);
	    //循环设置每行的属性
	    for(var i=0;i<rowObjs.length;i++)
	    {
	        //如果设置该行不显示，则行数减一
	        var hide=rowControlString.charAt(i)!='1';
	        if(hide){
	            rowCount--;
	        }
	        //设置是否显示该行
	        rowObjs[i].style.display=(hide)?"none":"";
	        //设置鼠标滑入该行时的效果
	        rowObjs[i].cells[0].onmouseover=function()
	        {
	            this.style.background="#397DBD";
	            this.style.color="white";
	        }
	        //设置鼠标滑出该行时的效果
	        rowObjs[i].cells[0].onmouseout=function(){
	            this.style.background="#F1F1F1";
	            this.style.color="black";
	        }
	    }
	    //屏蔽菜单的菜单
	    pop.document.oncontextmenu=function()
	    {
	            return false; 
	    }
	    //选择右键菜单的一项后，菜单隐藏
	    pop.document.onclick=function()
	    {
	        pop.hide();
	    }
	    //显示菜单
	    pop.show(event.clientX-1,event.clientY,width,rowCount*25,document.body);
	    return true;
	}
	function detail1()
	{
	    location.href="<%=rootPath%>/resin.do?action=detail&id="+node;
	}
	function edit()
	{
		location.href="<%=rootPath%>/resin.do?action=ready_edit&id="+node;
	}
	function cancelalert()
	{
		location.href="<%=rootPath%>/resin.do?action=cancelalert&id="+node;
	}
	function addalert()
	{
		location.href="<%=rootPath%>/resin.do?action=addalert&id="+node;
	}
	function clickMenu()
	{
	}
</script>


		<script language="JavaScript" type="text/JavaScript">
var show = true;
var hide = false;
//修改菜单的上下箭头符号
function my_on(head,body)
{
	var tag_a;
	for(var i=0;i<head.childNodes.length;i++)
	{
		if (head.childNodes[i].nodeName=="A")
		{
			tag_a=head.childNodes[i];
			break;
		}
	}
	tag_a.className="on";
}
function my_off(head,body)
{
	var tag_a;
	for(var i=0;i<head.childNodes.length;i++)
	{
		if (head.childNodes[i].nodeName=="A")
		{
			tag_a=head.childNodes[i];
			break;
		}
	}
	tag_a.className="off";
}
//添加菜单	
function initmenu()
{
	var idpattern=new RegExp("^menu");
	var menupattern=new RegExp("child$");
	var tds = document.getElementsByTagName("div");
	for(var i=0,j=tds.length;i<j;i++){
		var td = tds[i];
		if(idpattern.test(td.id)&&!menupattern.test(td.id)){					
			menu =new Menu(td.id,td.id+"child",'dtu','100',show,my_on,my_off);
			menu.init();		
		}
	}

}

</script>
	</head>
	<BODY leftmargin="0" topmargin="0" bgcolor="#cedefa"
		onload="initmenu();">

		<!-- 这里用来定义需要显示的右键菜单 -->
		<div id="itemMenu" style="display: none";>
			<table border="1" width="100%" height="100%" bgcolor="#F1F1F1"
				style="border: thin; font-size: 12px" cellspacing="0">
				<tr>
					<td style="cursor: default; border: outset 1;" align="center"
						onclick="parent.edit()">
						修改信息
					</td>
				</tr>
				<tr>
					<td style="cursor: default; border: outset 1;" align="center"
						onclick="parent.detail1();">
						监视信息
					</td>
				</tr>
				<tr>
					<td style="cursor: default; border: outset 1;" align="center"
						onclick="parent.cancelalert()">
						取消监视
					</td>
				</tr>
				<tr>
					<td style="cursor: default; border: outset 1;" align="center"
						onclick="parent.addalert()">
						添加监视
					</td>
				</tr>
			</table>
		</div>
		<!-- 右键菜单结束-->
		<form method="post" name="mainForm">
			<table id="body-container" class="body-container">
				<tr>
					<td width="200" valign=top align=center>
						<%=menuTable%>
					</td>
					<td align="center" valign=top>
						<table style="width: 98%" cellpadding="0" cellspacing="0"
							algin="center">
							<tr>
								<td background="<%=rootPath%>/common/images/right_t_02.jpg"
									width="100%">
									<table width="100%" cellspacing="0" cellpadding="0">
										<tr>
											<td align="left">
												<img src="<%=rootPath%>/common/images/right_t_01.jpg"
													width="5" height="29" />
											</td>
											<td class="add-content-title">
												应用 >> 中间件管理 >> Resin监视列表
											</td>
											<td align="right">
												<img src="<%=rootPath%>/common/images/right_t_03.jpg"
													width="5" height="29" />
											</td>
										</tr>
									</table>
								</td>
							<tr>
								<td>
									<table width="100%" cellpadding="0" cellspacing="1">
										<tr>
											<td bgcolor="#ECECEC" width="100%" align='right'>
												<a href="#" onclick="toAdd()">添加</a>
												<a href="#" onclick="toDelete2()">删除</a>&nbsp;&nbsp;&nbsp;
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<table cellspacing="1" cellpadding="0" width="100%">
										<tr class="microsoftLook0" height=28>
											<th width='22'></th>
											<th width='5%'>
												序号
											</th>
											<th width='20%'>
												名称
											</th>
											<th width='20%'>
												IP地址
											</th>
											<th width='15%'>
												端口
											</th>
											<th width='15%'>
												是否监视
											</th>
											<th width='15%'>
												当前状态
											</th>
											<th width='10%'>
												编辑
											</th>
										</tr>
										<%
											String monStr = "未监视";
											for (int i = 0; i < rc; i++) {
												monStr = "未监视";
												Resin vo = (Resin) list.get(i);
												Node node = PollingEngine.getInstance().getResinByID(vo.getId());
												int status = 0;
												if (node != null) {
													status = SystemSnap.getNodeStatus(node);
													if (node.isManaged() == true)
														monStr = "已监视";
												}
										%>
										<tr bgcolor="#FFFFFF" <%=onmouseoverstyle%>
											class="microsoftLook">
											<td>
												<INPUT type="radio" class=noborder name=radio
													value="<%=vo.getId()%>">
											</td>
											<td>
												&nbsp;
												<font color='blue'><%=1 + i%></font>
											</td>
											<td>
												&nbsp;<%=vo.getAlias()%></td>
											<td>
												&nbsp;<%=vo.getIpAddress()%></td>
											<td>
												&nbsp;<%=vo.getPort()%></td>
											<td>
												&nbsp;<%=monStr%></td>
											<td align='center' valign=middle>
												&nbsp;
												<img src="<%=rootPath%>/resource/<%=NodeHelper.getCurrentStatusImage(status)%>" border="0">
												&nbsp;<%=NodeHelper.getStatusDescr(status)%></td>
											<td align='center'>
												&nbsp;&nbsp;
												<img src="<%=rootPath%>/resource/image/status.gif" border="0" width=15 oncontextmenu=showMenu('2','<%=vo.getId()%>','<%=vo.getIpAddress()%>') title="右键菜单">

											</td>



										</tr>
										<%
											}
										%>
									</table>
								</td>
							</tr>
							<tr>
								<td background="<%=rootPath%>/common/images/right_b_02.jpg">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td align="left" valign="bottom">
												<img src="<%=rootPath%>/common/images/right_b_01.jpg"
													width="5" height="11" />
											</td>
											<td></td>
											<td align="right" valign="bottom">
												<img src="<%=rootPath%>/common/images/right_b_03.jpg"
													width="5" height="11" />
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</BODY>
</HTML>
