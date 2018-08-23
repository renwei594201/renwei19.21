<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    request.setAttribute("ctx", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${r"${"}ctx}/jquery-easyui-1.5/themes/default/easyui.css">   
<link rel="stylesheet" type="text/css" href="${r"${"}ctx}/jquery-easyui-1.5/themes/icon.css">   
<script type="text/javascript" src="${r"${"}ctx}/jquery-easyui-1.5/jquery-1.9.1.min.js"></script>   
<script type="text/javascript" src="${r"${"}ctx}/jquery-easyui-1.5/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${r"${"}ctx}/jquery-easyui-1.5/locale/easyui-lang-zh_CN.js"></script> 
<script type="text/javascript" src="${r"${"}ctx}/jquery-easyui-1.5/validatetools.js"></script> 

</head>
<body>
<!-- 列表工具栏 -->
<div id="${packageName}_datagrid_toolbar">
<a href="##" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="edit('')">新增</a> 
<a href="##" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="del('')">批量删除</a> 
<input class="easyui-textbox" name="keyword" id="keyword"> 
<input  id="startTime" name="startTime"  type= "text" class= "easyui-datebox"> </input>  
-
<input  id="endTime"  name="endTime" type= "text" class= "easyui-datebox"> </input>  
<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="query()">查询</a> 
</div>
<!-- 列表 -->
<table id="${packageName}_datagrid" class="easyui-datagrid" 
        data-options="url:'${r"${"}ctx}/${packageName}/getData.action',rownumbers:true,toolbar:'#${packageName}_datagrid_toolbar',fitColumns:true,pagination:true">   
    <thead>   
        <tr>   
            <th data-options="field:'id',checkbox:true">编码</th>   
            <#list fieldList as var>
            	<#if var_index &gt; 0 >
					 <th data-options="field:'${var[0]}',width:100">${var[2]}</th>  
				</#if>
            </#list>
            <th data-options="field:'caozuo',width:100,formatter:caozuo">操作</th>   
        </tr>  
    </thead>   
</table> 
<!-- 新增修改弹框 --> 
<div id="${packageName}_dialog" class="easyui-dialog" title="My Dialog" style="width:400px;height:auto;"   
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#${packageName}_dialog_bottons'">   
    <form id="${packageName}_form" method="post">  
    	<input type="hidden" name="id"> 
    	<table>
    	<#list fieldList as var>
    	   <#if (var_index > 0)>
    		<#if var[1] == "Date">
    			<tr>
	    			<td>${var[2]}:</td>
	    			<td><input type="text" class="easyui-datebox" name="${var[0]}" data-options="required:true"/></td>
	    		</tr>
    		<#else>
			   	<tr>
	    			<td>${var[2]}:</td>
	    			<td><input class="easyui-validatebox" type="text" name="${var[0]}" data-options="required:true"/></td>
	    		</tr>
			</#if>
    		</#if>
    	</#list>
    	</table>
    	 
<!--	      单选  <input type="radio" name="sex" value="0" checked="checked"/>男 <input type="radio" name="sex" value="1"/>女   
	   下拉<input id="hobby_combobox" class="easyui-combobox" name="hobby" data-options="required:true,valueField:'code',textField:'name',url:'${r"${"}ctx}/dict/geByPid.action?pid=1',multiple:true" />  
-->	
</form>  
</div>
<!-- 弹框按钮 -->
<div id="${packageName}_dialog_bottons">
<a href="javascript:;" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="save()">保存</a> 
<a href="javascript:$('#${packageName}_dialog').dialog('close');" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a> 
</div>
<script type="text/javascript">
//操作
function caozuo(value,row,index){
	return '<a href="javascript:;" onclick="edit(\''+index+'\')">修改</a><a style="margin-left:2px" href="javascript:;" onclick="del(\''+row.id+'\')">删除</a>';
}
//进入新增修改页面
function edit(index){
	if(index == ''){
		$("#${packageName}_dialog").dialog("open").dialog("setTitle","新增");
		$("#hobby_combobox").combobox("clear");
		$("#${packageName}_form").form("clear");
	} else{
		$("#${packageName}_dialog").dialog("open").dialog("setTitle","修改");
		//根据index选中当前行
		$("#${packageName}_datagrid").datagrid("uncheckAll");
		$("#${packageName}_datagrid").datagrid("checkRow",index);//选中index行
		var row = $("#${packageName}_datagrid").datagrid("getSelected");//获取当前行数据
		$("#${packageName}_form").form("load",row);
	}
}
function save(){
	$('#${packageName}_form').form('submit', {    
	    url:"${r"${"}ctx}/${packageName}/save.action",    
	    onSubmit: function(){    
	    	return $(this).form('validate');
	    },    
	    success:function(data){  
	    	var data = eval("("+data+")");
	        if(data.success){
	        	$('#${packageName}_dialog').dialog('close');
	        	$("#${packageName}_datagrid").datagrid("reload");
	        } 
	    }    
	});  

}
function del(id){
	if(id==''){
		var rows = $("#${packageName}_datagrid").datagrid("getChecked");
		var ids=[];
		for(var i=0;i<rows.length;i++){
			ids.push(rows[i].id);
		}
		id=ids.join();
	}
	$.messager.confirm('确认','您确认想要删除记录吗？',function(r){    
	    if (r){    
	    	$.post("${r"${"}ctx}/${packageName}/delete.action",{ids:id},function(data){
	    		if(data.success){
	    			$("#${packageName}_datagrid").datagrid("reload");
	    		}
	    	})  
	    }    
	});  

}
function query(){
	$("#${packageName}_datagrid").datagrid("reload",{keyword:$("#keyword").val(),startTime:$("[name=startTime]").val(),endTime:$("[name=endTime]").val()})
}
</script>
</body>
</html>