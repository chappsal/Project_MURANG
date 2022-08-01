package action.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import service.admin.OrderStatusChangeService;
import service.admin.OrderStatusService;
import vo.ActionForward;
import vo.Order;
import vo.Paging;

public class OrderStatusAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;

		//검색
		String order_status = request.getParameter("status");
		String search_column = request.getParameter("search_column");
		String search_input = request.getParameter("search_input");
		
		String datepicker_1 = request.getParameter("datepicker_1");
		String datepicker_2 = request.getParameter("datepicker_2");
		
		//검색 결과 상세목록
		String order_no = request.getParameter("order_no");
		
		//주문처리 상태 변경
		String[] order_num = request.getParameterValues("order_no_chk");
		String statusChange = request.getParameter("statusChange");

		OrderStatusService orderStatusService = new OrderStatusService();
		ArrayList<Order> orderSearchList = new ArrayList<Order>();
		
		
		//주문처리 상태 변경
		OrderStatusChangeService orderStatusChangeService = new OrderStatusChangeService();
		if(!(statusChange == null || statusChange.equals("--처리상태--"))) {
		
			for(String num : order_num) {
				orderStatusChangeService.updateOrderStatus(statusChange, num);
			}
		}
		
		//상세내역 요청이면
		ArrayList<Order> orderDetailList = new ArrayList<Order>();
		if(order_no != null) { 
			orderDetailList = orderStatusService.getOrderDetailList(order_no); 
			
		}	

		// 검색기간 포함
		if (!datepicker_1.trim().equals("기간") && !datepicker_2.trim().equals("기간") && !datepicker_1.trim().isEmpty() && !datepicker_2.trim().isEmpty() ) {
			
			orderSearchList = orderStatusService.getOrderSearchList(order_status, search_column, search_input, datepicker_1, datepicker_2);
		
		}
		
		// 검색기간 미포함
		else {
			
			orderSearchList = orderStatusService.getOrderSearchList(order_status, search_column, search_input);

			datepicker_1 = "기간";
			datepicker_2 = "기간";
		}

		

		/** 페이징 **/
		
		//전체 레코드 수
		int totalCnt = orderSearchList.size();
		
		//현재 페이지
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		//연산을 하기 위한 pageNum 형변환 / 현재 페이지
		int currentPage = Integer.parseInt(pageNum);
		
		//한 페이지에 출력할 레코드 수
		int displayRow=10; 
		
		//화면에 출력할 페이지 수
		int displayPage=3;
		
		//시작 레코드
		Paging paging = new Paging();
		int startRow = paging.startRow(currentPage, displayRow);
		
		//마지막 레코드
		int endRow = currentPage*displayRow;
		
		
		int totalPage = paging.totalPage(totalCnt, 10); //총 페이지 수
		int startPage = ((currentPage-1)/displayPage)*displayPage+1; //한 페이지에 보여줄 첫 번호
		int endPage = startPage + displayPage - 1; //한 페이지에 보여줄 끝 번호
		
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		
		int count = startRow-1;
		ArrayList<Order> displayList = new ArrayList<Order>();
		for(int i=1; i<=10; i++) {
			displayList.add(orderSearchList.get(count));
			count++;
			if(count == totalCnt) break;
		}

		
		
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startRow", startRow);
		request.setAttribute("endRow", endRow);
		request.setAttribute("currentPage", currentPage); 
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("displayPage", displayPage);
		request.setAttribute("totalPage", totalPage);
		
		
		request.setAttribute("order_status", order_status);
		request.setAttribute("search_column", search_column);
		request.setAttribute("search_input", search_input);
		request.setAttribute("datepicker_1", datepicker_1);
		request.setAttribute("datepicker_2", datepicker_2);

		request.setAttribute("displayList", displayList);
		request.setAttribute("orderDetailList", orderDetailList);
	 	request.setAttribute("orderListDetailPage", "/admin/orderStatusSearchDetail.jsp");
	 	
		forward = new ActionForward("/admin/orderStatusManage.jsp", false);
		
		return forward;
	}

}
