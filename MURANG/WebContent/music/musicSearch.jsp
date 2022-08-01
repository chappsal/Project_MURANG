<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/musicSearch.css">

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
	<br>
	<div class="bar">
		<h3>Song</h3>
		<a href="${pageContext.request.contextPath}/musicList/tie?search=${param.search}">All</a>
	</div>
	<c:set var="title" value="${searchTitle}" />
	<c:if test="${title ne null}">
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
				<c:forEach var="music" items="${searchTitle}" varStatus="status" begin="0" end="5" step="1">
					<tr onclick="location.href='${pageContext.request.contextPath}/Detail/${music.music_no}'" style="cursor: pointer;" class="list">
						<td><img src="${pageContext.request.contextPath}/images/music_thumbnail/${music.music_img}" class="thumb"></td>
						<td>${music.music_title}</td>
						<td>${music.music_artist}</td>
						<c:forEach var="iList" items="${titleInstList[status.index]}" >
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
		<tr>
	</c:if>
	<c:if test="${title eq null}">
		<div style="margin:40px;">검색 결과가 없습니다.</div>
	</c:if>
	<div class="bar">
		<h3>Artist</h3>
		<a href="${pageContext.request.contextPath}/musicList/art?search=${param.search}">All</a>
	</div>
	<c:set var="artist" value="${searchArtist}" />
	<c:if test="${artist ne null}">
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
				<c:forEach var="music" items="${searchArtist}" varStatus="status" begin="0" end="5" step="1">
					<tr onclick="location.href='${pageContext.request.contextPath}/Detail/${music.music_no}'" style="cursor: pointer;" class="list">
						<td><img src="${pageContext.request.contextPath}/images/music_thumbnail/${music.music_img}" class="thumb"></td>
						<td>${music.music_title}</td>
						<td>${music.music_artist}</td>
						<c:forEach var="iList" items="${artistInstList[status.index]}" >
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
		</c:if>
		<c:if test="${artist eq null}">
			<div style="margin:40px;">검색 결과가 없습니다.</div>
		</c:if>
</div>		
</section>
</body>
</html>