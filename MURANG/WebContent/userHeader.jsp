<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="../css/style.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400&display=swap" rel="stylesheet">
<title>뮤랑뮤랑</title>

</head>

<body>
<header>
	<nav class="nav">
		<ul>
			<li>
				<a href="<%=request.getContextPath()%>/index.jsp">
					<img src="${pageContext.request.contextPath}/images/logo/logo2.png" width="55px" class="logo">
				</a>
			</li>
			<li><a href="${pageContext.request.contextPath}/musicList/B01">밴드</a></li>
			<li><a href="${pageContext.request.contextPath}/musicList/P03">피아노</a></li>
			<li><a href="${pageContext.request.contextPath}/musicList/C03">관현악</a></li>
			<li><a href="${pageContext.request.contextPath}/musicList/M01">MR</a></li>
			<li><a href="${pageContext.request.contextPath}/musicRequestBoardForm.req">악보신청</a></li>
			<li><a href="${pageContext.request.contextPath}/offlineListForm.off">오프라인</a></li>
			
			<c:if test="${(u_id ne null) && (u_grade eq 'Admin') }">
				<li><a href="${pageContext.request.contextPath}/userManagementForm.adm"><font color="deepskyblue">회원관리</font></a></li>
			   	<li><a href="${pageContext.request.contextPath}/orderManage.adm"><font color="deepskyblue">주문처리</font></a></li>
			   	<li><a href="${pageContext.request.contextPath }/musicAdminList.adm"><font color="deepskyblue">상품등록</font></a></li>
			   	<li><a href="${pageContext.request.contextPath}/salesManage.adm"><font color="deepskyblue">매출조회</font></a></li>
			</c:if>
			
			<li class="ham_li">
				<input id="check-btn" type="checkbox" />  
		        <label for="check-btn" onclick="">
		            <img src="${pageContext.request.contextPath}/images/icon/user.png" width="25px" class="ham">
		        </label>	
				<c:choose>
				<c:when test="${u_id eq null}">
					<ul class="ham_nav">
						<li><a href="${pageContext.request.contextPath}/userCartList.usr">Cart</a></li>
						<li><a href="${pageContext.request.contextPath}/myPageForm.usr">MyPage</a></li>
						<li><a href="${pageContext.request.contextPath}/userLoginForm.usr">Login</a></li>
					</ul>	
				</c:when>
				
				<c:when test="${(u_id ne null) && (u_name eq null)}">
					<ul class="ham_nav">
						<li><a href="${pageContext.request.contextPath}/userCartList.usr">Cart</a></li>
						<li><a href="${pageContext.request.contextPath}/myPageForm.usr">MyPage</a></li>
						<li><a href="${pageContext.request.contextPath}/userLoginForm.usr">Login</a></li>
					</ul>	
				</c:when>
				
				<c:otherwise>
					<ul class="ham_nav">
						<li><a href="${pageContext.request.contextPath}/userCartList.usr">Cart</a></li>
						<li><a href="${pageContext.request.contextPath}/myPageForm.usr">MyPage</a></li>
						<li><a href="${pageContext.request.contextPath}/userLogout.usr">Logout</a></li>
					</ul>
				</c:otherwise>
				</c:choose>
				</li>
		</ul>
	</nav>
	
	<nav class="hidden_nav">
		<ul class="hidden_nav_ul">
			<li>
				<a href="<%=request.getContextPath()%>/index.jsp">
					<img src="${pageContext.request.contextPath}/images/logo/logo2.png" width="55px" class="logo">
				</a>
			</li>
			<li class="menu_1 menu">
				<input id="submenu_1" type="checkbox" />  
		        <label for="submenu_1" onclick="">
		         	 악보
		        </label>
				<ul class="submenu_1 submenu">
					<li><a href="${pageContext.request.contextPath}/musicList/B01">밴드</a></li>
					<li><a href="${pageContext.request.contextPath}/musicList/P03">피아노</a></li>
					<li><a href="${pageContext.request.contextPath}/musicList/C03">관현악</a></li>
					<li><a href="${pageContext.request.contextPath}/musicList/M01">MR</a></li>
				</ul>
			</li>
			<li class="menu_2 menu">
				<input id="submenu_2" type="checkbox" />  
		        <label for="submenu_2" onclick="">
					Board
				</label>	
				<ul class="submenu_2 submenu">
					<li><a href="${pageContext.request.contextPath}/musicRequestBoardForm.req">악보신청</a></li>
					<li><a href="${pageContext.request.contextPath}/offlineListForm.off">오프라인</a></li>
				</ul>
			</li>
			<c:if test="${(u_id ne null) && (u_grade eq 'Admin') }">
				<li class="menu_3 menu">
					<input id="submenu_3" type="checkbox" />  
			        <label for="submenu_3" onclick="">
						<font color="blue">Admin</font>
					</label>
					<ul class="submenu_3 submenu">
						<li><a href="${pageContext.request.contextPath}/userManagementForm.adm">회원관리</a></li>
					   	<li><a href="${pageContext.request.contextPath}/orderManage.adm">주문처리</a></li>
					   	<li><a href="${pageContext.request.contextPath }/musicAdminList.adm">상품등록</a></li>
					   	<li><a href="${pageContext.request.contextPath}/salesManage.adm">매출조회</a></li>
					</ul>
				</li>
			</c:if>
			<li>
				<input id="check-btn_2" type="checkbox" />  
		        <label for="check-btn_2" onclick="">
		            <img src="${pageContext.request.contextPath}/images/icon/user.png" width="25px" class="ham">
		        </label>	
		        
		        	<c:choose>
					<c:when test="${u_id eq null}">
						<ul class="ham_nav_2">
							<li><a href="${pageContext.request.contextPath}/userCartList.usr">Cart</a></li>
							<li><a href="${pageContext.request.contextPath}/myPageForm.usr">MyPage</a></li>
							<li><a href="${pageContext.request.contextPath}/userLoginForm.usr">Login</a></li>
						</ul>	
					</c:when>
					
					<c:when test="${(u_id ne null) && (u_name eq null)}">
						<ul class="ham_nav_2">
							<li><a href="${pageContext.request.contextPath}/userCartList.usr">Cart</a></li>
							<li><a href="${pageContext.request.contextPath}/myPageForm.usr">MyPage</a></li>
							<li><a href="${pageContext.request.contextPath}/userLoginForm.usr">Login</a></li>
						</ul>	
					</c:when>
					
					<c:otherwise>
						<ul class="ham_nav_2">
							<li><a href="${pageContext.request.contextPath}/userCartList.usr">Cart</a></li>
							<li><a href="${pageContext.request.contextPath}/myPageForm.usr">MyPage</a></li>
							<li><a href="${pageContext.request.contextPath}/userLogout.usr">Logout</a></li>
						</ul>
					</c:otherwise>
					</c:choose>
	   		</li>
			
		</ul>	
	</nav>
</header>
</body>
</html>