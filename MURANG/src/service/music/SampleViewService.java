package service.music;

import static db.JdbcUtil.*;
import java.sql.Connection;

import dao.MusicDAO;
import vo.Music;

public class SampleViewService {

	public String getMusicPaper(String music_no, String inst) {

		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
	
		String mPaper_img = musicDAO.getMusicPaper(music_no, inst);
		
		close(con);

		return mPaper_img;
	}


}
