package service.music;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.MusicDAO;
import vo.Paging;

public class MusicPagingService {

	public int getMusicListPaging(String inst) {
		
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
	
		int totalCnt = musicDAO.musicListCnt(inst);
		
		close(con);
		
		return totalCnt;
	}

}
