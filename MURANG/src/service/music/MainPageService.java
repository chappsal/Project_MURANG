package service.music;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MusicDAO;
import vo.Music;

public class MainPageService {

	//인기차트
	public ArrayList<Music> getMusicChart() {
		
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
	
		ArrayList<Music> musicChartList = musicDAO.getMusicChart();
		
		close(con);

		return musicChartList;
	}

	//최신악보
	public ArrayList<Music> getlatestMusicList() {
		
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
	
		ArrayList<Music> slideMusicList = musicDAO.getlatestMusicList();
		
		close(con);

		return slideMusicList;
	}

}
