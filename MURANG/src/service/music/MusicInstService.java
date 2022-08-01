package service.music;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MusicDAO;
import vo.Inst;

public class MusicInstService {

	//곡이 보유한 악보 장르
	public String selectMusicInst(int music_no) {
		
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
	
		String inst = musicDAO.selectMusicInst(music_no);
		
		close(con);
		return inst;
	}
	
}
