<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<table>
		<tr>
			<td>编号</td>
			<td>姓名</td>
			<td>密码</td>
			<td>电话</td>
			<td>地址</td>
		</tr>
		<c:forEach items="${list}" var="a">
		<tr>
			<td>${a.id}</td>
			<td>${a.name}</td>
			<td>${a.pdw}</td>
			<td>${a.tel}</td>
			<td>${a.address}</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>