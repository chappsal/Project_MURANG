<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/musicSearchAll.css">

<title>검색</title>

</head>
<body>
<section>
<div class="div_sec">
	<div>
		<form action="${pageContext.request.contextPath}/musicList/search" method="post">
			<input type="text" name="search" class="search">
		</form>
	</div>
	<div class="bar">
		<h3>${name}</h3>
		<div></div>
	</div>
	<c:set var="music" value="${searchAll}" />
	<c:if test="${music ne null}">
		<table class="table_1">
			<thead>
				<tr>
					<td></td>
					<td>곡명</td>
					<td>아티스트</td>
					<td>파트</td>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="music" items="${searchAll}" varStatus="status" begin="0" end="10" step="1">
					<tr onclick="location.href='${pageContext.request.contextPath}/Detail/${music.music_no}'" style="cursor: pointer;" class="list">
						<td><img src="../images/music_thumbnail/${music.music_img}" class="thumb"></td>
						<td>${music.music_title}</td>
						<td>${music.music_artist}</td>
						<c:forEach var="iList" items="${searchAllInst[status.index]}" >
							<td class="part">
								<span class="iList${(f:contains(iList,'기타') || f:contains(iList,'베이스') || f:contains(iList,'드럼') || f:contains(iList,'건반'))? 'On' : '' }">B<span class="tooltip">밴드</span></span>
								<span class="iList${(f:contains(iList,'피아노 2단') || f:contains(iList,'피아노 3단'))? 'On' : '' }">P<span class="tooltip">피아노</span></span>
								<span class="iList${(f:contains(iList,'관현악'))? 'On' : '' }">O<span class="tooltip">관현악</span></span>
								<span class="iList${(f:contains(iList,'MR'))? 'On' : '' }">M<span class="tooltip">MR</span></span>
							</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</tbody>	
		</table>
	<c:set var="pageNum" value="${(pageNum == null)? 1: pageNum}" />
	<div class="paging">
		<c:forEach var="i" step="1" begin="1" end="${totalPage}">
			<c:if test="${displayRow < startPage}">
				<a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&&pageNum=${startPage-displayRow}">Prev</a>
			</c:if>
			<c:if test="${i != 0 || i < pageNum}">
				<a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&&pageNum=${i}" class="page${(pageNum == i ) ?'On' : '' }">${i}</a>
			</c:if>
			<c:if test="${endPage < displayRow}">
				<a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&&pageNum=${startPage+displayRow}">Next</a>
			</c:if>
		</c:forEach>	
	</div>	
	</c:if>
	<c:set var="music" value="${searchAll}" />
	<c:if test="${music eq null}">
		<div style="margin:40px;">검색 결과가 없습니다.</div>
	</c:if>	
</div>	
</section>
</body>
</html>