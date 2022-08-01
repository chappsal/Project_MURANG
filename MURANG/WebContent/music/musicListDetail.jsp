<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/music/musicListDetail.css?ver=1">
<title>${music.music_artist} ${music.music_title} 악보</title>
<script src="//code.jquery.com/jquery-3.4.1.min.js"></script>

</head>
<script type="text/javascript">
	//악보 선택시 가격 합산
	function getCheckboxValue(){

		var result = 0;
	
	    var checkbox = $("input:checkbox[name='inst']:checked");

	    checkbox.each(function(i) {
	    	/*체크 된 td의 가장 첫번째 값을 가져옴(악기 이름)*/
	        var tr = checkbox.parent().parent().eq(i);
	        var td = tr.children();
	        var inst = td.eq(0).text();
	        /*밴드*/
	        if(inst == "기타"){
	        	result += 1200;
	        } 
	        if(inst == "베이스"){
	        	result += 1200;
	        } 
	        if(inst == "드럼"){
	        	result += 1200;
	        } 
	        if(inst == "건반"){
	        	result += 1200;
	        } 
	        /*피아노*/
	        if(inst == "피아노 3단"){
	        	result += 1000;
	        } 
	        if(inst == "피아노 2단"){
	        	result += 1000;
	        }
	        /*관현악*/
	        if(inst == "관현악"){
	        	result += 5000;
	        } 
	        /*MR*/
	        if(inst == "MR"){
	        	result += 2000;
	        } 
	        
	    });
		return document.getElementById('result').innerText = result.toLocaleString('ko-KR');
	}
</script>

<script type="text/javascript">
//체크된 악기 list에 담기

</script>

<script type="text/javascript">

	//장바구니 담기 요청시 로그인 확인
	function cartLoginCheck(){
		
		//getCheckboxValue의 함수값을 가져옴
		var result = getCheckboxValue();
		
		if(confirm("장바구니로 이동하시겠습니까?")==true){
			if(${sessionScope.u_id == null}){
				alert("로그인 후 이용 가능합니다.");
				return location="${pageContext.request.contextPath}/userLoginForm.usr";
			}else if( result == 0 ){
		        alert("상품을 선택해주세요.");
		        event.returnValue = false;
		        return;
	        }else{
		        document.f.submit();
		        return location="${pageContext.request.contextPath}/userCartList.usr";
	        }
		}else{
			if(${sessionScope.u_id == null}){
				alert("로그인 후 이용 가능합니다.");
				return location="${pageContext.request.contextPath}/userLoginForm.usr";
			}else if( result == 0 ){
		        alert("상품을 선택해주세요.");
		        event.returnValue = false;
		        return;
	        }else{
	        	 document.f.submit();
	        	 return window.location.reload();
	        }
		}
	}
</script>
<script type="text/javascript">

	//바로구매 요청시 로그인 확인
	function payLoginCheck(){
		
		var result = getCheckboxValue();
		
		if(${sessionScope.u_id == null}){
			alert("로그인 후 이용 가능합니다.");
			return location="${pageContext.request.contextPath}/userLoginForm.usr";
		}else if(result == 0){
			return alert("상품을 선택해주세요.");
		}else {
			document.f.submit();
		}
	}
</script>		
<body>
<jsp:include page="../userHeader.jsp" />
<section>
<div class="div_sec">
	<div class="info">
		<span><img src="${pageContext.request.contextPath}/images/music_thumbnail/${music.music_img}" class="thumb"></span>
		<div class="info_div">
			<div class="title">${music.music_title}</div>
			<div class="artist">${music.music_artist}</div>
			<div class="type">${music.music_type}</div>
			<div class="inst">
				<span class="iList${(f:contains(iList,'기타') || f:contains(iList,'베이스') || f:contains(iList,'드럼') || f:contains(iList,'건반'))? 'On' : '' }">B<span class="tooltip">밴드</span></span>
				<span class="iList${(f:contains(iList,'피아노 2단') || f:contains(iList,'피아노 3단'))? 'On' : '' }">P<span class="tooltip">피아노</span></span>
				<span class="iList${(f:contains(iList,'관현악'))? 'On' : '' }">O<span class="tooltip">관현악</span></span>
				<span class="iList${(f:contains(iList,'MR'))? 'On' : '' }">M<span class="tooltip">MR</span></span>
			</div>
		</div>
	</div>
	<iframe id="iframe1" name="iframe1" style="display:none"></iframe>
	<form action="${pageContext.request.contextPath}/userCart.usr?music_no=${music.music_no}" name="f" method ="post"  enctype="" target="iframe1">
	<table>
		<thead>
			<tr class="thead">
				<td>파트</td>
				<td>샘플</td>
				<td>가격</td>
				<td>선택</td>
			</tr>
		</thead>
		
		<tbody>
			<c:if test="${(f:contains(iList,'기타') || f:contains(iList,'베이스') || f:contains(iList,'드럼') || f:contains(iList,'건반'))}">
				<tr class="tbody">
					<td colspan="4">밴드</td>
				</tr>
				<c:if test="${f:contains(iList,'기타')}">
					<tr>
						<td>기타</td>
						<td><button onclick="window.open('${pageContext.request.contextPath}/sampleView.music?no=${music.music_no}&&inst=기타','window_name','width=800,height=500,location=no,status=no,scrollbars=yes');"><img src="../images/icon/sheet.png"></button></td>
						<td>1,200원</td>
						<td><input type="checkbox" name="inst" value="기타" onclick="getCheckboxValue();" /></td>
					</tr>
				</c:if>
				<c:if test="${f:contains(iList,'베이스')}">
					<tr>
						<td>베이스</td>
						<td><button onclick="window.open('${pageContext.request.contextPath}/sampleView.music?no=${music.music_no}&&inst=베이스','window_name','width=800,height=500,location=no,status=no,scrollbars=yes');"><img src="../images/icon/sheet.png"></button></td>
						<td>1,200원</td>
						<td><input type="checkbox" name="inst" value="베이스" onclick="getCheckboxValue();" /></td>
					</tr>
				</c:if>
				<c:if test="${f:contains(iList,'드럼')}">
					<tr>
						<td>드럼</td>
						<td><button onclick="window.open('${pageContext.request.contextPath}/sampleView.music?no=${music.music_no}&&inst=드럼','window_name','width=800,height=500,location=no,status=no,scrollbars=yes');"><img src="../images/icon/sheet.png"></button></td>
						<td>1,200원</td>
						<td><input type="checkbox" name="inst" value="드럼" onclick="getCheckboxValue();" /></td>
					</tr>
				</c:if>
				<c:if test="${f:contains(iList,'건반')}">
					<tr>
						<td>건반</td>
						<td><button onclick="window.open('${pageContext.request.contextPath}/sampleView.music?no=${music.music_no}&&inst=건반','window_name','width=800,height=500,location=no,status=no,scrollbars=yes');"><img src="../images/icon/sheet.png"></button></td>
						<td>1,200원</td>
						<td><input type="checkbox" name="inst" value="건반" onclick="getCheckboxValue();" /></td>
					</tr>   
				</c:if>
			</c:if>	
			
			<c:if test="${(f:contains(iList,'피아노 2단') || f:contains(iList,'피아노 3단'))}">
				<tr class="tbody">
					<td colspan="4">피아노</td>
				</tr>
				<c:if test="${f:contains(iList,'피아노 3단')}">
					<tr>
						<td>피아노 3단</td>
						<td><button onclick="window.open('${pageContext.request.contextPath}/sampleView.music?no=${music.music_no}&&inst=피아노 3단','window_name','width=800,height=500,location=no,status=no,scrollbars=yes');"><img src="../images/icon/sheet.png"></button></td>
						<td>1,000원</td>
						<td><input type="checkbox" name="inst" value="피아노 3단" onclick="getCheckboxValue();" /></td>
					</tr>
				</c:if>
				<c:if test="${f:contains(iList,'피아노 2단')}">
					<tr>
						<td>피아노 2단</td>
						<td><button onclick="window.open('${pageContext.request.contextPath}/sampleView.music?no=${music.music_no}&&inst=피아노 2단','window_name','width=800,height=500,location=no,status=no,scrollbars=yes');"><img src="../images/icon/sheet.png"></button></td>
						<td>1,000원</td>
						<td><input type="checkbox" name="inst" value="피아노 2단" onclick="getCheckboxValue();" /></td>
					</tr>
				</c:if>
			</c:if>
			<c:if test="${(f:contains(iList,'관현악'))}">
				<tr class="tbody">
					<td colspan="4">관현악</td>
				</tr>
				<tr>
					<td>관현악</td>
					<td><button onclick="window.open('${pageContext.request.contextPath}/sampleView.music?no=${music.music_no}&&inst=관현악','window_name','width=800,height=500,location=no,status=no,scrollbars=yes');"><img src="../images/icon/sheet.png"></button></td>
					<td>5,000원</td>
					<td><input type="checkbox" name="inst" value="관현악" onclick="getCheckboxValue();" /></td>
				</tr>
			</c:if>
			<c:if test="${(f:contains(iList,'MR'))}">
				<tr class="tbody">
					<td colspan="4">MR</td>
				</tr>
				<tr>
					<td>MR</td>
					<td><button onclick="window.open('${pageContext.request.contextPath}/sampleView.music?no=${music.music_no}&&inst=MR','window_name','width=800,height=500,location=no,status=no,scrollbars=yes');"><img src="../images/icon/sheet.png"></button></td>
					<td>2,000원</td>
					<td><input type="checkbox" name="inst" value="MR" onclick="getCheckboxValue();" /></td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<div class="totalPrice">
		total<span id="result">0</span>
		<button type="button" onclick="cartLoginCheck();" class="addBtn">장바구니</button>
		<button type="button" onclick="payLoginCheck();" class="payBtn">바로구매</button>
	</div>
	</form>
</div>	
</section>
<jsp:include page="../userFooter.jsp" />
</body>

</html>