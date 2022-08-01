package service.music;

import static db.JdbcUtil.*;
import java.sql.Connection;

import dao.MusicDAO;
import vo.Music;

public class MusicDetailService {

	
	public Music musicDetail(String music_no) {

		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
	
		Music musicInfo = musicDAO.selectMusicInfo(music_no);
		
		close(con);

		return musicInfo;
	
	}

}
