package service.music;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MusicDAO;
import vo.Music;

public class MusicListService {
	
	//목록 10개씩 조회 - 최신순
	public ArrayList<Music> selectMusicList(String inst, int startRow) {
		
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
	
		ArrayList<Music> musicInfo = musicDAO.selectMusicList(inst, startRow);
		
		close(con);
	
		return musicInfo;
	}	

	//목록 10개씩 조회 - 인기순
	public ArrayList<Music> selectMusicHitList(String inst, int startRow) {
		
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
		
		ArrayList<Music> musicInfo = musicDAO.selectMusicHitList(inst, startRow);
		
		close(con);
		
		return musicInfo;
	}	
		
}
