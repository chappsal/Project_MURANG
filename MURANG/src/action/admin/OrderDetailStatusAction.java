package action.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import service.admin.OrderDetailStatusService;
import vo.ActionForward;
import vo.Order;

public class OrderDetailStatusAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		String order_no = request.getParameter("order_no");
		
		OrderDetailStatusService orderDetailStatusService = new OrderDetailStatusService();
		ArrayList<Order> orderDetailList = orderDetailStatusService.getOrderDetailList(order_no);
		
		request.setAttribute("orderDetailList", orderDetailList);
		request.setAttribute("orderListDetailPage", "/admin/orderStatusSearchDetail.jsp");
		
		forward = new ActionForward("/admin/orderStatusManage.jsp", false);
		return forward;
	}

}
