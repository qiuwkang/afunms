<%@page language="java" contentType="text/html;charset=GB2312"%>
<%@page import="com.afunms.system.model.User"%>
<%@page import="com.afunms.common.base.JspPage"%>
<%@page import="java.util.List"%>
<%@page import="com.afunms.system.util.UserView"%>
<%@ include file="/include/globe.inc"%>
<%@page import="com.afunms.topology.util.NodeHelper"%>
<%@page import="com.afunms.application.model.*"%>
<%@page import="com.afunms.application.dao.*"%>
<%@page import="com.afunms.polling.base.*"%>
<%@page import="com.afunms.polling.*"%>
<%@page import="com.afunms.config.model.SlaNodeProp"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Map.Entry"%>
<%
	String rootPath = request.getContextPath();
	String menuTable = (String)request.getAttribute("menuTable");
	List list = (List)request.getAttribute("list");
	JspPage jp = (JspPage)request.getAttribute("page");
	HashMap<Integer,String> mapTelnet = (HashMap<Integer,String>)request.getAttribute("mapTelnet");
	List listSlaType = (List)request.getAttribute("listSlaType");
	Hashtable telconfigHash = (Hashtable)request.getAttribute("telconfigHash");
	Hashtable userHash = (Hashtable)request.getAttribute("userHash");
	String deviceType=(String)request.getAttribute("deviceType");
	if(deviceType==null||deviceType.equalsIgnoreCase("null")||deviceType.equals(""))
	 deviceType="h3c";
%>
<html>
<head>

<meta http-equiv="Page-Enter" content="revealTrans(duration=x, transition=y)">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript" type="text/javascript" src="<%=rootPath%>/include/navbar.js"></script>
<link href="<%=rootPath%>/resource/<%=com.afunms.common.util.CommonAppUtil.getSkinPath() %>css/global/global.css" rel="stylesheet" type="text/css" />
<LINK href="<%=rootPath%>/resource/css/style.css" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<%=rootPath%>/resource/js/page.js"></script> 
<script language="javascript">	
	var curpage= <%=jp.getCurrentPage()%>;
  	var totalpages = <%=jp.getPageTotal()%>;
  	var listAction = "<%=rootPath%>/ciscoslaproperty.do?action=list"; 
 
  function query()
  {  
     mainForm.action = "<%=rootPath%>/ciscoslaproperty.do?action=list&jp=1";
     mainForm.submit();
  }  

</script>
<script language="JavaScript">

	//��������
	var node="";
	var ipaddress="";
	var operate="";
	/**
	*���ݴ����id��ʾ�Ҽ��˵�
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
	*��ʾ�����˵�
	*menuDiv:�Ҽ��˵�������
	*width:����ʾ�Ŀ���
	*rowControlString:�п����ַ�����0��ʾ����ʾ��1��ʾ��ʾ���硰101�������ʾ��1��3����ʾ����2�в���ʾ
	*/
	function popMenu(menuDiv,width,rowControlString)
	{
	    //���������˵�
	    var pop=window.createPopup();
	    //���õ����˵�������
	    pop.document.body.innerHTML=menuDiv.innerHTML;
	    var rowObjs=pop.document.body.all[0].rows;
	    //��õ����˵�������
	    var rowCount=rowObjs.length;
	    //alert("rowCount==>"+rowCount+",rowControlString==>"+rowControlString);
	    //ѭ������ÿ�е�����
	    for(var i=0;i<rowObjs.length;i++)
	    {
	        //������ø��в���ʾ����������һ
	        var hide=rowControlString.charAt(i)!='1';
	        if(hide){
	            rowCount--;
	        }
	        //�����Ƿ���ʾ����
	        rowObjs[i].style.display=(hide)?"none":"";
	        //������껬�����ʱ��Ч��
	        rowObjs[i].cells[0].onmouseover=function()
	        {
	            this.style.background="#397DBD";
	            this.style.color="white";
	        }
	        //������껬������ʱ��Ч��
	        rowObjs[i].cells[0].onmouseout=function(){
	            this.style.background="#F1F1F1";
	            this.style.color="black";
	        }
	    }
	    //���β˵��Ĳ˵�
	    pop.document.oncontextmenu=function()
	    {
	            return false; 
	    }
	    //ѡ���Ҽ��˵���һ��󣬲˵�����
	    pop.document.onclick=function()
	    {
	        pop.hide();
	    }
	    //��ʾ�˵�
	    pop.show(event.clientX-1,event.clientY,width,rowCount*25,document.body);
	    return true;
	}
	function detail()
	{
	    location.href="<%=rootPath%>/FTP.do?action=detail&id="+node;
	}
	function cancel()
	{
		location.href="<%=rootPath%>/ciscoslaproperty.do?action=cancelrtr&id="+node;
	}
	function clickMenu()
	{
	}
</script>
<script language="JavaScript" type="text/JavaScript">
var show = true;
var hide = false;
//�޸Ĳ˵������¼�ͷ����
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
//���Ӳ˵�	
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
<BODY leftmargin="0" topmargin="0" bgcolor="#cedefa" onload="initmenu();">

<!-- ��������������Ҫ��ʾ���Ҽ��˵� -->
	<div id="itemMenu" style="display: none";>
	<table border="1" width="100%" height="100%" bgcolor="#F1F1F1"
		style="border: thin;font-size: 12px" cellspacing="0">
		<tr>
			<td style="cursor: default; border: outset 1;" align="center"
				onclick="parent.cancel()">ȡ��SLA����</td>
		</tr>	
	
	</table>
	</div>
	<!-- �Ҽ��˵�����-->
<form method="post" name="mainForm">
<table id="body-container" class="body-container">
	<tr>
		<td width="200" valign=top align=center>
			<%=menuTable%>
		
		</td>
            <td align="center" valign=top>
			<table style="width:98%"  cellpadding="0" cellspacing="0" algin="center">
			<tr>
				<td background="<%=rootPath%>/common/images/right_t_02.jpg" width="100%"><table width="100%" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="left"><img src="<%=rootPath%>/common/images/right_t_01.jpg" width="5" height="29" /></td>
                    <td class="content_title"><span style="font-weight: 700">��������>>���񼶱����>>SLA�豸�����б�</span></td>
                    <td align="right"><img src="<%=rootPath%>/common/images/right_t_03.jpg" width="5" height="29" /></td>
                  </tr>
              </table>
			  </td>					
				
		<tr>
										<td>
											<table id="content-body" class="content-body">
												
					        					<tr>
					        						<td>
														<table>
															<tr>
																<td  class="detail-data-body-title" style="text-align: left;">
																    &nbsp;&nbsp;
																	�豸����
																	<select name="deviceType">
																	 <option value="h3c" selected>H3C</option>
																	 <option value="cisco">CISCO</option>
																	</select>	
																	&nbsp;&nbsp;
																	SLA����
																	<select name="slatype">
																	<option value="-1">����</option>
																	<%
																		for (int i=0;i<listSlaType.size();i++) {
																				String slaType = (String)listSlaType.get(i);
																			%>
																				<option value="<%=slaType%>"><%=slaType%></option>
																			<%
																		} 
																	%>
																	</select>
																	&nbsp;&nbsp;
																	IP
																	<select name="telnet">
																	<option value="-1">����</option>
																	<%
																		for (Iterator iter = mapTelnet.entrySet().iterator();iter.hasNext();) {
																			Entry entry = (Entry) iter.next();
																	 %>
																				<option value="<%=entry.getKey()%>"><%=entry.getValue()%></option>
																			<%
																		} 
																	%>
																	</select>
																	&nbsp;&nbsp;<input type="button" value="��  ѯ" onclick="query()">
																</td>
																
															</tr>
															</table>
							  						</td>                       
					        					</tr>
					        					<tr>
													<td>
														<table>
															<tr>
																<td class="detail-data-body-title">
											    					<jsp:include page="../../common/page.jsp">
											     						<jsp:param name="curpage" value="<%=jp.getCurrentPage()%>"/>
											     						<jsp:param name="pagetotal" value="<%=jp.getPageTotal()%>"/>
											   						</jsp:include>
											          			</td>
											        		</tr>
														</table>
													</td>
												</tr> 
					        					<tr>
													<td>
														<table>
															<tr>
																<td class="detail-data-body-title" width="5%"><INPUT type="checkbox" name="checkall" onclick="javascript:chkall()">���</td>
        														<td class="detail-data-body-title" width="20%">IP</td>
        														<%if(deviceType.equalsIgnoreCase("h3c")){
        															%>
        															<td class="detail-data-body-title" width="15%">������</td>
        															<td class="detail-data-body-title" width="15%">������ʶ</td>
        															<%
        														   }else if(deviceType.equalsIgnoreCase("cisco")){
        															%>
        															<td class="detail-data-body-title" width="15%">��ں�</td>
        														<%}%>
														    	<td class="detail-data-body-title" width="20%">SLA����</td>
														    	<td class="detail-data-body-title" width="15%">������</td>
														    	<td class="detail-data-body-title" width="15%">����ʱ��</td>
														    	<td class="detail-data-body-title" width="5%">����</td>
														    </tr>
															<%
																if(list!=null && list.size()>0){
																	for(int i = 0 ; i < list.size(); i++){
																		SlaNodeProp cisco = (SlaNodeProp)list.get(i);
															%>
																		<tr <%=onmouseoverstyle%>>
																			<td class="detail-data-body-list"><INPUT type="checkbox" name="checkbox" value="<%=cisco.getId() %>"><%=i+1%></td>
																			<%
																				String ipaddress = "--";
																				if(telconfigHash.containsKey(cisco.getTelnetconfigid()))ipaddress =(String) telconfigHash.get (cisco.getTelnetconfigid());
																			%>
																			<td class="detail-data-body-list" ><%=ipaddress %></td>
																			<%if(deviceType.equalsIgnoreCase("h3c")){
        															%>
        															<td class="detail-data-body-list" ><%=cisco.getAdminsign()%></td>
        															<td class="detail-data-body-list" ><%=cisco.getOperatesign() %></td>
        															<%
        														   }else if(deviceType.equalsIgnoreCase("cisco")){
        															%>
        															<td class="detail-data-body-list" ><%=cisco.getEntrynumber() %></td>
        														<%}%>
																			
																			<td class="detail-data-body-list" ><%=cisco.getSlatype() %></td>
																			<%
																				String username = "--";
																				try{
																					if(userHash.containsKey(cisco.getOperatorid()))username =(String) userHash.get (cisco.getOperatorid());
																				}catch(Exception e){
																					e.printStackTrace();
																				}
																			%>
																			<td class="detail-data-body-list" >
																				<a href="#" style="cursor: hand" onclick="window.showModalDialog('<%=rootPath%>/user.do?action=read&id=<%=cisco.getOperatorid()%>',window,',dialogHeight:400px;dialogWidth:600px')">
																					<%=username %>
																				</a></td>
			        														<td class="detail-data-body-list" ><%=cisco.getCreatetime() %></td>
			        														<td class="detail-data-body-list" >&nbsp;
																			<img src="<%=rootPath%>/resource/image/status.gif" border="0" width=15 oncontextmenu=showMenu('2','<%=cisco.getId()%>','<%=cisco.getId()%>') alt="�Ҽ�����">
																			</td>
			        													</tr>
																		<%
																	}
																} 
															%>
														</table>
													</td>
												</tr>				
											</table>
										</td>
									</tr>
		<tr>
              <td background="<%=rootPath%>/common/images/right_b_02.jpg" >
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td align="left" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_01.jpg" width="5" height="12" /></td>
                    <td align="right" valign="bottom"><img src="<%=rootPath%>/common/images/right_b_03.jpg" width="5" height="12" /></td>
                  </tr>
              </table></td>
            </tr>
	</table>
</td>
			</tr>
		</table>
</BODY>
</HTML>