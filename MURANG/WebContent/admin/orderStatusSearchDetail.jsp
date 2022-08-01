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
<style>
.detail_tbl{
	width: 30%;
	border-collapse: collapse;
	font-size: 15px;
	color: rgba(46, 46, 46, 1);
	margin-bottom: 50px;
}
.detail_tbl td{
	padding: 6px;
}
td:nth-child(3):hover {
	text-decoration: underline;
	color: skyblue;
}
@media ( max-width: 1500px ) {
	.detail_tbl{
		width: 60%;
	}
}	

@media ( max-width: 550px ) {
	.detail_tbl{
		width: 90%;
	}
}
</style>
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
<section>
<c:if test="${orderDetailList.size() != 0}">
	<table class="detail_tbl">
		<tr class="th">
			<th>주문번호</th>
			<th>악보번호</th>
			<th>아이디</th>
			<th>금액</th>
		</tr>
		<c:forEach var="order" items="${orderDetailList}">
			<tr>
				<td>${order.order_no}</td>
				<td>${order.mPaper_no}</td>
				<td onclick="location.href='${pageContext.request.contextPath}/orderStatus.adm?status=${order_status}&search_column=u_id&search_input=${order.u_id}&datepicker_1=${datepicker_1}&datepicker_2=${datepicker_2}'">${order.u_id}</td>
				<td>${order.order_price}</td>
			</tr>
		</c:forEach>
	</table>
</c:if>
</section>
</body>
</html>