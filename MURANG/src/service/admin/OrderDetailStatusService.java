package service.admin;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.AdminDAO;
import vo.Order;

public class OrderDetailStatusService {

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
