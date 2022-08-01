package service.music;

import static db.JdbcUtil.*;

import java.sql.Connection;
import java.util.ArrayList;

import dao.MusicDAO;
import vo.Music;

public class MusicSearchService {

	
	//곡 제목으로 검색
	public ArrayList<Music> musicSearchTitle(String search) {
		
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
		
		ArrayList<Music> searchTitle = musicDAO.musicSearchTitle(search);
		
		close(con);
		
		return searchTitle;
	}

	//곡 아티스트로 검색
	public ArrayList<Music> musicSearchArtist(String search) {
		
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
		
		ArrayList<Music> searchArtist = musicDAO.musicSearchArtist(search);
		
		close(con);
		
		return searchArtist;
	}

	
	//곡 제목으로 검색 - row 개수
	public int rowSearchTitle(String search) {
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
		
		int rowSearchTitle = musicDAO.rowSearchTitle(search);
		
		close(con);
		
		return rowSearchTitle;
	}
	
	//곡 아티스트로 검색 - row 개수
	public int rowSearchArtist(String search) {
		Connection con =  getConnection();
		
		MusicDAO musicDAO = MusicDAO.getInstance();
		musicDAO.setConnection(con);
		
		int rowSearchArtist = musicDAO.rowSearchArtist(search);
		
		close(con);
		
		return rowSearchArtist;
	}
}
