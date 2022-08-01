<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/musicList.css">
<title>${param.inst} 악보 : 뮤랑뮤랑</title>
</head>
<body>
<jsp:include page="../userHeader.jsp" />
<section>
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
	<div class="order">
		<span>
			<c:choose>
				<c:when test="${order == '2'}">
					<span><a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&order=1">최신순</a></span>
					<span>|</span>
					<span><a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&order=2" class="orderOn">인기순</a></span>
				</c:when>
				<c:otherwise>
					<span><a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&order=1" class="orderOn">최신순</a></span>
					<span>|</span>
					<span><a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&order=2">인기순</a></span>
				</c:otherwise>
			</c:choose>
		</span>
		<span>
			<form action="${pageContext.request.contextPath}/musicList/search" method="post">
				<input type="text" name="search" class="search">
			</form>
		</span>
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
			<c:forEach var="music" items="${musicList}" varStatus="status">
				<tr onclick="location.href='${pageContext.request.contextPath}/Detail/${music.music_no}'" style="cursor: pointer;" class="list">
					<td><img src="${pageContext.request.contextPath}/images/music_thumbnail/${music.music_img}" class="thumb"></td>
					<td>${music.music_title}</td>
					<td>${music.music_artist}</td>
					<c:forEach var="iList" items="${musicInstList[status.index]}" >
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
	<c:set var="pageNum" value="${(currentPage == null)? 1: currentPage}" />
	<div class="paging">
		<c:if test="${displayPage < startPage}">
			<a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&pageNum=${startPage-displayPage}&order=${order}">Prev</a>
		</c:if>
		
		<c:forEach var="i" step="1" begin="${startPage}" end="${endPage}">
			<c:if test="${i != 0 || i <= currentPage}">
				<a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&pageNum=${i}&order=${order}" class="page${(pageNum == i ) ?'On' : '' }">${i}</a>
			</c:if>
		</c:forEach>
		
		<c:if test="${endPage < totalPage}">
			<a href="${pageContext.request.contextPath}/musicList.music?inst=${param.inst}&pageNum=${startPage+displayPage}&order=${order}">Next</a>
		</c:if>
	</div>		

</section>
<jsp:include page="../userFooter.jsp" />
</body>
</html>

