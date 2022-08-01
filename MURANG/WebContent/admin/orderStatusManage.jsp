<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- datepicker -->
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.1/jquery.min.js"></script>
<link type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/orderStatusManage.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/datepicker.css">

<title>주문처리 : 뮤랑뮤랑</title>
</head>
<script>

	$(function(){
    	$('.datepicker').datepicker();
  	})
  
    $.datepicker.setDefaults({
      closeText: "닫기",
      prevText: "이전달",
      nextText: "다음달",
      currentText: "오늘",
      monthNames: ["1월", "2월", "3월", "4월", "5월", "6월",
        "7월", "8월", "9월", "10월", "11월", "12월"
      ],
      monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월",
        "7월", "8월", "9월", "10월", "11월", "12월"
      ],
      dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
      dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
      dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
      weekHeader: "주",
      dateFormat: "yy.m.d", // 날짜형태 예)yy년 m월 d일
      firstDay: 0,
      isRTL: false,
      showMonthAfterYear: true,
      yearSuffix: "년"
    })

</script>
<script>

	$(document).ready(function() {
	    
	 		var status = '<c:out value='${order_status}'/>'; 
			var search_column = '<c:out value='${search_column}'/>'; 
	
			if(status != "" && search_column != ""){
	
		 		$("#status").val(status).prop("selected", true); 
		 		$("#search_column").val(search_column).prop("selected", true);
			}
	});

</script>
<script>

	function selectAll(selectAll)  {
	  const checkboxes 
	       = document.getElementsByName('order_no_chk');
	  
	  checkboxes.forEach((checkbox) => {
	    checkbox.checked = selectAll.checked;
	  })
	}

</script>
<body>
<jsp:include page="../userHeader.jsp" />
<section>
<div class="div_sec">
	<form action="orderStatus.adm" method="get" name="f">
		<table class="search_tbl">
			<tr>
				<td>검색</td>
				<td>
					<select name="status" id="status">
						<option value="all">--전체--</option>
						<option value="주문완료">주문완료</option>
						<option value="결제완료">결제완료</option>
						<option value="배송완료">배송완료</option>
						<option value="결제취소">결제취소</option>
					</select>
					<select name="search_column" id="search_column">
						<option value="all">--전체--</option>
						<option value="order_no">주문번호</option>    
						<option value="u_id">아이디</option>
						<option value="order_totalPrice">주문금액</option>
					</select>
					<input type="text" name="search_input" id="search_input" value="${search_input}">
				</td>                        
			</tr>
			<tr>
				<td>주문일자</td>
				<td>
			        <input type="text" name="datepicker_1" value="${datepicker_1}" id="datepicker_1" class="datepicker inp" placeholder="기간" readonly="true" />~ 
					<input type="text" name="datepicker_2" value="${datepicker_2}" id="datepicker_2" class="datepicker inp" placeholder="기간" readonly="true" />
				</td>
			</tr>
		</table>
		<button type="submit" >검색</button>
		<button type="button" onclick="reset();">초기화</button>
	<div class="container">
		<c:choose>
			<c:when test="${displayList==null}">
				<div class="null_div">
					검색 결과가 없습니다.
				</div>
			</c:when>
			<c:otherwise>
					<table class="order_tbl">
						<tr class="th">
							<th><input type='checkbox' name='order_no_chk' value='selectall' onclick='selectAll(this)'></th>
							<th>주문번호</th>
							<th>아이디</th>
							<th>금액</th>
							<th>주문일</th>
							<th>주문상태</th>
						</tr>
						<c:forEach var="order" items="${displayList}">
							<tr style="cursor: pointer;" onclick="location.href='${pageContext.request.contextPath}/orderStatus.adm?status=${order_status}&search_column=${search_column}&search_input=${search_input}&datepicker_1=${datepicker_1}&datepicker_2=${datepicker_2}&pageNum=${pageNum}&order_no=${order.order_no}'">
								<td onclick="event.cancelBubble=true"><input type="checkbox"  name="order_no_chk" value="${order.order_no}"></td>
								<td>${order.order_no}</td>
								<td onclick="event.cancelBubble=true; location.href='${pageContext.request.contextPath}/orderStatus.adm?status=${order_status}&search_column=u_id&search_input=${order.u_id}&datepicker_1=${datepicker_1}&datepicker_2=${datepicker_2}'">${order.u_id}</td>
								<td>${order.order_totalPrice}</td>
								<td>${order.order_date}</td>
								<td>${order.order_status}</td>
							</tr>
						</c:forEach>
					</table>
					<div class="order_tbl_div">
						선택 주문건 
						<select name="statusChange" onchange="this.form.submit()">
							<option>--처리상태--</option>
							<option value="주문완료">주문완료</option>
							<option value="결제완료">결제완료</option>
							<option value="배송완료">배송완료</option>
							<option value="결제취소">결제취소</option>
						</select>
						로 변경
					</div>
				</form>
			</c:otherwise>
		</c:choose>
		<c:set var="pageNum" value="${(currentPage == null)? 1: currentPage}" />
		<div class="paging">
			<c:if test="${displayPage < startPage}">
				<a href="${pageContext.request.contextPath}/orderStatus.adm?status=${order_status}&search_column=${search_column}&search_input=${search_input}&datepicker_1=${datepicker_1}&datepicker_2=${datepicker_2}&pageNum=${startPage-displayPage}">Prev</a>
			</c:if>
			
			<c:forEach var="i" step="1" begin="${startPage}" end="${endPage}">
				<c:if test="${i != 0 || i <= currentPage}">
					<a href="${pageContext.request.contextPath}/orderStatus.adm?status=${order_status}&search_column=${search_column}&search_input=${search_input}&datepicker_1=${datepicker_1}&datepicker_2=${datepicker_2}&pageNum=${i}" class="page${(pageNum == i ) ?'On' : '' }">${i}</a>
				</c:if>
			</c:forEach>
			
			<c:if test="${endPage < totalPage}">
				<a href="${pageContext.request.contextPath}/orderStatus.adm?status=${order_status}&search_column=${search_column}&search_input=${search_input}&datepicker_1=${datepicker_1}&datepicker_2=${datepicker_2}&pageNum=${startPage+displayPage}">Next</a>
			</c:if>
		</div>
	</div>
	
	
	
	<jsp:include page="${orderListDetailPage}" />	

</div>	
</section>
<jsp:include page="../userFooter.jsp" />
</body>
</html>