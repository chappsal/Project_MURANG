package service.admin;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.AdminDAO;
import vo.Order;

public class OrderStatusService {

	//주문처리 검색 - 기간 포함
	public ArrayList<Order> getOrderSearchList(String order_status, String search_column, String search_input, String datepicker_1, String datepicker_2) {
		
		Connection con =  getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
	
		ArrayList<Order> orderSearchList = adminDAO.orderSearchList(order_status, search_column, search_input, datepicker_1, datepicker_2);
		
		close(con);

		return orderSearchList;
	}

	//주문처리 검색 - 기간 미포함
	public ArrayList<Order> getOrderSearchList(String order_status, String search_column, String search_input) {
		
		Connection con =  getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
	
		ArrayList<Order> orderSearchList = adminDAO.orderSearchList(order_status, search_column, search_input);
		
		close(con);

		return orderSearchList;
	}

	//검색결과 주문 상세내역
	public ArrayList<Order> getOrderDetailList(String order_no) {
		ArrayList<Order> orderDetailList = new ArrayList<Order>();
	
		Connection con =  getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
	
		orderDetailList = adminDAO.getOrderDetailList(order_no);
		
		close(con);
		
		return orderDetailList;
	}

	
}
