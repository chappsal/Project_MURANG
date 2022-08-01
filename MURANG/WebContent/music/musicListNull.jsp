<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/musicListNull.css">
<title>뮤랑뮤랑</title>
</head>
<body>
<section>
<div class="div_sec">
	<div class="category">
		<c:if test="${param.inst == '기타' || param.inst == '베이스' || param.inst == '드럼' || param.inst == '건반'}"> 
			<a href="${pageContext.request.contextPath}/musicList/B01" class="${(param.inst == '기타')? 'on' : ''}">기타</a>
			<a href="${pageContext.request.contextPath}/musicList/B02" class="${(param.inst == '베이스')? 'on' : ''}">베이스</a>
			<a href="${pageContext.request.contextPath}/musicList/B03" class="${(param.inst == '드럼')? 'on' : ''}">드럼</a>
			<a href="${pageContext.request.contextPath}/musicList/B04" class="${(param.inst == '건반')? 'on' : ''}">건반</a>
		</c:if>
		<c:if test="${param.inst == '피아노 3단' || param.inst == '피아노 2단'}"> 
			<a href="${pageContext.request.contextPath}/musicList/P03" class="${(param.inst == '피아노 3단')? 'on' : ''}">피아노 3단</a>
			<a href="${pageContext.request.contextPath}/musicList/P02" class="${(param.inst == '피아노 2단')? 'on' : ''}">피아노 2단</a>
		</c:if>
		<c:if test="${param.inst == '관현악'}"> 
			<a href="${pageContext.request.contextPath}/musicList/P03" class="${(param.inst == '관현악')? 'on' : ''}">관현악</a>
		</c:if>
		<c:if test="${param.inst == 'MR'}"> 
			<a href="${pageContext.request.contextPath}/musicList/P03" class="${(param.inst == 'MR')? 'on' : ''}">MR</a>
		</c:if>
	</div>
	<div>
		<form action="${pageContext.request.contextPath}/musicList/search" method="post">
			<input type="text" name="search" class="search">
		</form>
	</div>
	<table class="musicList_tbl">
		<thead>
			<tr>
				<td></td>
				<td>곡명</td>
				<td>아티스트</td>
				<td>파트</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td colspan="4">등록된 악보가 없습니다.</td>
			</tr>
		</tbody>
	</table>
</div>		
</section>
</body>
</html>