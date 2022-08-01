package service.admin;

import static db.JdbcUtil.close;
import static db.JdbcUtil.commit;
import static db.JdbcUtil.getConnection;
import static db.JdbcUtil.rollback;

import java.sql.Connection;

import dao.AdminDAO;

public class OrderStatusChangeService {

	public int updateOrderStatus(String status, String order_no) {
		
		Connection con =  getConnection();
		
		AdminDAO adminDAO = AdminDAO.getInstance();
		adminDAO.setConnection(con);
	
		int statusCount = adminDAO.updateOrderStatus(status, order_no);
		
		if(statusCount > 0 ) {
			commit(con);
			System.out.println("변경 성공");
		}else {
			rollback(con);
			System.out.println("변경 실패");
		}
		close(con);
		
		return statusCount;
	}

}
