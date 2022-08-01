package service.admin;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.AdminDAO;
import vo.Order;

public class SalesManageService {

	//월 매출 조회
	public ArrayList<Order> monthOrderList(int year, int month, int lastday) {
		
		Connection con =  getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
	
		ArrayList<Order> orderList = adminDAO.monthOrderList(year, month, lastday);
		
		close(con);

		return orderList;
	}
	
	
	//일 매출 합계
	public String dayTotalPrice(int year, int month, int day) {
		
		Connection con =  getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		String dayTotalPrice = adminDAO.dayTotalPrice(year, month, day);
		
		close(con);
		
		return dayTotalPrice;
	}
	
	
	//일 매출 리스트
	public ArrayList<Order> dayPriceList(int year, int month, int day) {
		
		Connection con =  getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
		
		ArrayList<Order> dayPriceList = adminDAO.dayPriceList(year, month, day);
		
		close(con);
		
		return dayPriceList;
	}

	
	
}
