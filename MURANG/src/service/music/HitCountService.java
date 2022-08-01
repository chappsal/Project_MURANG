package service.music;

import static db.JdbcUtil.*;
import java.sql.Connection;

import dao.MusicDAO;

public class HitCountService {

	
	//조회수 증가
	public void updateHitCount(int music_no) {
		
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
	
		int hitCount = musicDAO.updateHitCount(music_no);
		
		if(hitCount > 0 ) {
			commit(con);
			System.out.println("조회수 증가");
		}else {
			rollback(con);
			System.out.println("조회수 증가 실패");
		}

		close(con);
		
	}
}
