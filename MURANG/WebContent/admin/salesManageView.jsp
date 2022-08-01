<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.Calendar" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/salesManageView.css">

<title>매출조회 : 뮤랑뮤랑</title>

</head>
<body>
<section>
<div class="div_sec">
	<table class="cal_tbl">
		<caption class="cap">
			<button type="button" onclick="location='${pageContext.request.contextPath}/salesManage.adm?year=${year}&month=${month}'"><img src="./images/icon/arrow-left.png"></button>
			<form action="${pageContext.request.contextPath}/salesManage.adm" name="f" method="post">
				<select name="year" onchange="this.form.submit()">
					<c:forEach var="y" begin="2018" end="${yearNow}">
						<option value="${y}" ${(year==y)? "selected" : ""} >${y}년</option>
					</c:forEach>
				</select>
				<select name="month" onchange="this.form.submit()">
					<c:forEach var="m" begin="1" end="12">
						<option value="${m}" ${((month+1)==m)? "selected" : ""}>${m}월</option>
					</c:forEach>
				</select>
			</form>	
			<button type="button" onclick="location='${pageContext.request.contextPath}/salesManage.adm?year=${year}&month=${month+2}'"><img src="./images/icon/arrow-right.png"></button>
			<br>
		</caption>
		<br><br>
		<tr>
			<th>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
		</tr>
		<tr>
			<% int cnt = 0;	%>
			<c:forEach begin="1" end="${dayOfWeek-1}">
				<td></td>
				<% cnt++; %>
			</c:forEach>			
			<c:forEach var="day" begin="1" end="${lastday}">
			<% if(cnt%7 == 0) out.print("</tr><tr>"); %>
				<td class="${(dayR == day)? 'clickDay' : '' }">
					<div>${day}</div>
					<c:if test="${dayTotalList[day-1] != '0'}">
						<div class="dayTotal">
							<a href="${pageContext.request.contextPath}/salesManage.adm?year=${year}&month=${month+1}&day=${day}">${dayTotalList[day-1]}</a>
						</div>
					</c:if>	
					<c:if test="${dayTotalList[day-1] == '0'}">
						<div></div><br>
					</c:if>	
				</td>
				<% cnt++; %>
			</c:forEach>
		</tr>
	</table>
	
	<!-- 일 매출 리스트 -->
	<table class="list_tbl" style="text-align: center;">
	<caption class="cap_2"></caption>
	<colgroup>
	   <col width="17%"/>
	   <col width="17%"/>
	   <col width="15%"/>
	   <col width="28%"/>
	   <col width="28%"/>
	</colgroup>
		<tr class="th">
			<th>주문번호</th>
			<th>아이디</th>
			<th>금액</th>
			<th>주문일</th>
			<th>주문상태</th>
		</tr>
		<c:forEach var="order" items="${dayPriceList}">
			<tr>
				<td>${order.order_no}</td>
				<td>${order.u_id}</td>
				<td>${order.order_totalPrice}</td>
				<td>${order.order_date}</td>
				<td>${order.order_status}</td>
			</tr>
		</c:forEach>
	</table>
</div>		
</section>	
</body>
</html>