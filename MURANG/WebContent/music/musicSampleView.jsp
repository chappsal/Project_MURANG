<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>악보 샘플 : 뮤랑뮤랑</title>
</head>
<style>
*{
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}
.sheet{
	width: 500px;
	padding: 10px 0;
	float: left;
	display: inline-block;
	box-shadow: 0 30px 30px rgba(235, 235, 235, 1);
	margin-right: 30px;
}
.box{
	padding-top: 10px;	
}
.thumb{
	width: 150px;
	height: 150px;
	border-radius: 20px;
	margin-right: 10px; 
	margin-bottom: 10px;
	box-shadow: 0 30px 30px rgba(235, 235, 235, 1), -30 0 30px rgba(235, 235, 235, 1);
}
hr{
	width: 130px;
	height: 0;
	margin: 10px;
	border: none;
	border-top: 1px solid lightgrey;
	
}
.inst{
	padding-left: 50px;
}
.inst > div:first-child {
	
}
.inst > div:nth-child(2) {
	font-size: 14px;
	margin-top: 10px;

}
</style>
<body>
<section>
	<div><img src="${pageContext.request.contextPath}/images/music_sheet/${mPaper_img}" class="sheet"></div>

	<div class="box">
		<div class="info">
			<div><img src="${pageContext.request.contextPath}/images/music_thumbnail/${music.music_img}" class="thumb"></div>
			<h3>${music.music_title}</h3>
			<div>${music.music_artist}</div>
		</div>
		<hr>
		<div class="inst">	
		
			<c:if test="${inst =='기타' || inst =='베이스' || inst =='드럼' || inst =='건반'}">
				<div>${inst}</div>
				<div>1,200원</div>
			</c:if>	
			<c:if test="${f:contains(inst,'피아노')}">
				<div>${inst}</div>
				<div>1,000원</div>
			</c:if>
			<c:if test="${inst == '관현악'}">
				<div>${inst}</div>
				<div>5,000</div>
			</c:if>
			<c:if test="${inst == 'MR'}">
				<div>${inst}</div>
				<div>2,000</div>
			</c:if>
		
		</div>
	</div>	
</section>
</body>
</html>