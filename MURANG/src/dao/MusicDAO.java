package dao;

import static db.JdbcUtil.*;

import java.sql.*;
import java.util.ArrayList;

import vo.Music;

public class MusicDAO {

	private Connection con;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private MusicDAO() {}
	
	private static MusicDAO musicDAO;
	
	public static MusicDAO getInstance(){ 
		
		if(musicDAO == null) { 
			musicDAO = new MusicDAO(); 
		}
		
		return musicDAO; 
	}
	
	public void setConnection(Connection con){
		this.con = con;
	}
	
	
	
	//특정 카테고리(악기) 노래 목록 10개씩 조회 - 최신순
	public ArrayList<Music> selectMusicList(String inst, int startRow){
		ArrayList<Music> musicList = null;

		String sql = "select * from music_tbl natural join music_paper_tbl where inst ='" + inst + "' order by music_no desc limit "+ (startRow-1) +",10";  
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				musicList = new ArrayList<Music>();
				
				do {
					musicList.add(new Music(rs.getInt("music_no"),
											rs.getString("music_type"),
											rs.getString("music_title"),
											rs.getString("music_artist"),
											rs.getString("music_img"),
											rs.getInt("music_hit"),
											rs.getString("music_date")
									));
				} while(rs.next());
			}
		} catch (Exception e) {
			System.out.println("[MusicDAO] selectMusicList error : " + e);
		} finally {
			close(rs);
			close(pstmt);
		}		
		return musicList;
	}
	
	
	//특정 카테고리(악기) 노래 목록 10개씩 조회 - 인기순
	public ArrayList<Music> selectMusicHitList(String inst, int startRow) {
		ArrayList<Music> musicList = null;

		String sql = "select * from music_tbl natural join music_paper_tbl where inst ='" + inst + "' order by music_hit desc limit "+ (startRow-1) +",10";  
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				musicList = new ArrayList<Music>();
				
				do {
					musicList.add(new Music(rs.getInt("music_no"),
											rs.getString("music_type"),
											rs.getString("music_title"),
											rs.getString("music_artist"),
											rs.getString("music_img"),
											rs.getInt("music_hit"),
											rs.getString("music_date")
									));
				} while(rs.next());
			}
		} catch (Exception e) {
			System.out.println("[MusicDAO] selectMusicList error : " + e);
		} finally {
			close(rs);
			close(pstmt);
		}		
		return musicList;
	}
	
	
	
	
	//특정 카테고리(악기) row 개수 조회 
	public int musicListCnt(String inst){
		int totalCnt=0;
		
		String sql = "select count(*) from music_tbl natural join music_paper_tbl where inst ='" + inst + "'";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			
			totalCnt = rs.getInt(1);
			
		} catch (Exception e) {
			System.out.println("[MusicDAO] musicListCnt error : " + e);
		} finally {
			close(pstmt);
			close(rs);
			
		}		
		
		return totalCnt;
	}

	
	//곡이 보유한 악보 장르
	public String selectMusicInst(int music_no) {
		String inst = "";

		String sql = "select inst from music_paper_tbl where music_no=" + music_no;
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				do {
					inst += rs.getString("inst") + " "; 
					
				}while(rs.next());
			}

		} catch(Exception e) {
			System.out.println("[MusicDAO] selectMusicInst error : " + e);
		} finally {
			close(rs);
			close(pstmt);
		}
		return inst;
	}
	
	
	//곡 정보 조회(곡 번호)
	public Music selectMusicInfo(String music_no) {
		Music musicInfo = null;
		
		String sql = "select * from music_tbl where music_no = '" + music_no + "'";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				musicInfo = new Music(
						rs.getInt("music_no"), 
						rs.getString("music_type"), 
						rs.getString("music_title"), 
						rs.getString("music_artist"), 
						rs.getString("music_img"), 
						rs.getInt("music_hit"), 
						rs.getString("music_date"));
			}
		} catch (Exception e) {
			System.out.println("[MusicDAO] selectMusicInfo error : " + e);
		} finally {
			close(rs);
			close(pstmt);
		}
		return musicInfo;
	}

	
	//곡 제목으로 검색
	public ArrayList<Music> musicSearchTitle(String search) {
		ArrayList<Music> searchTitle = null;

		String sql = "select * from music_tbl where music_title like '%" + search + "%' order by music_date desc";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				searchTitle = new ArrayList<Music>();
				
				do {
					Music music = new Music(rs.getInt("music_no"),
							rs.getString("music_type"),
							rs.getString("music_title"),
							rs.getString("music_artist"),
							rs.getString("music_img"),
							rs.getInt("music_hit"),
							rs.getString("music_date"));
					
					searchTitle.add(music);
				} while(rs.next());
			}
			
		} catch (Exception e) {
			System.out.println("[MusicDAO] musicSearchTitle error : " + e);
		} finally {
			close(pstmt);
			close(rs);			
		}		

		return searchTitle;	
	}
	
	
	//곡 제목으로 검색 - 총 row 개수
	public int rowSearchTitle(String search) {
		int rowSearchTitle = 0;
		
		String sql = "select count(*) from music_tbl where music_title like '%" + search + "%'";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			rowSearchTitle = rs.getInt(1);

		} catch (Exception e) {
			System.out.println("[MusicDAO] rowSearchTitle error : " + e);
		} finally {
			close(pstmt);
			close(rs);			
		}		
		
		return rowSearchTitle;	
	}
	
	
	
	//곡 아티스트로 검색
	public ArrayList<Music> musicSearchArtist(String search) {
		ArrayList<Music> searchArtist = null;
		
		String sql = "select * from music_tbl where music_artist like '%" + search + "%' order by music_date desc";
		
		try {
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				searchArtist = new ArrayList<Music>();
				
				do {
					Music music = new Music(rs.getInt("music_no"),
							rs.getString("music_type"),
							rs.getString("music_title"),
							rs.getString("music_artist"),
							rs.getString("music_img"),
							rs.getInt("music_hit"),
							rs.getString("music_date"));
					searchArtist.add(music);
				} while(rs.next());
			}
		} catch (Exception e) {
			System.out.println("[MusicDAO] musicSearchArtist error : " + e);
		} finally {
			close(pstmt);
			close(rs);
		}		
		return searchArtist;	
	}

	
	//곡 아티스트로 검색 - 총 row 개수
	public int rowSearchArtist(String search) {
		int rowSearchArtist = 0;
		
		String sql = "select count(*) from music_tbl where music_artist like '%" + search + "%'";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			
			rowSearchArtist = rs.getInt(1);

		} catch (Exception e) {
			System.out.println("[MusicDAO] rowSearchTitle error : " + e);
		} finally {
			close(pstmt);
			close(rs);			
		}		
		
		return rowSearchArtist;	
	}

	
	//악보 샘플 이미지 찾기
	public String getMusicPaper(String music_no, String inst) {
		String mPaper_img = null;
		
		System.out.println("music_no : " + music_no);
		System.out.println("inst : " + inst);
		
		
		String sql = "select * from music_paper_tbl where music_no='" + music_no + "' and inst= '" + inst + "'";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next();
			mPaper_img = rs.getString("mPaper_img");
			
		} catch (Exception e) {
			System.out.println("[MusicDAO] getMusicPaper error : " + e);
		} finally {
			close(pstmt);
			close(rs);			
		}		

		return mPaper_img;
	}

	//조회수 증가
	public int updateHitCount(int music_no) {
		int hitCount = 0; //업데이트 성공 1, 실패 0
		
		String sql = "update music_tbl set music_hit=music_hit+1 where music_no="+music_no;
		
		try {
			pstmt = con.prepareStatement(sql);
			
			hitCount = pstmt.executeUpdate(); 

		} catch (Exception e) {
			System.out.println("[MusicDAO]updateHitCount error : " + e); // e: 예외종류 + 예외 메세지
		}finally {
			close(pstmt);
		}
		return hitCount;
	}

	
	//메인화면 - 인기차트
	public ArrayList<Music> getMusicChart() {
		ArrayList<Music> musicChartList = null;
		
		String sql = "select * from music_tbl order by music_hit desc limit 0,9";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {			
				musicChartList = new ArrayList<Music>();
	
				do {
					Music music = new Music(
							rs.getInt("music_no"), 
							rs.getString("music_type"), 
							rs.getString("music_title"), 
							rs.getString("music_artist"), 
							rs.getString("music_img"), 
							rs.getInt("music_hit"), 
							rs.getString("music_date"));
					musicChartList.add(music);
				}while(rs.next());
			}
		} catch (Exception e) {
			System.out.println("[MusicDAO] getMusicChart error : " + e);
		} finally {
			close(pstmt);
			close(rs);			
		}	
		return musicChartList;
	}


	//메인화면 - 최신곡 (슬라이드)
	public ArrayList<Music> getlatestMusicList() {
		ArrayList<Music> slideMusicList = null;
		
		String sql = "select * from music_paper_tbl natural join music_tbl"; 
		   		sql += " group by music_title, music_artist";
		   		sql += " order by mPaper_no desc limit 0,5";
		
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {			
				slideMusicList = new ArrayList<Music>();
	
				do {
					Music music = new Music(
							rs.getInt("music_no"), 
							rs.getString("music_type"), 
							rs.getString("music_title"), 
							rs.getString("music_artist"), 
							rs.getString("music_img"), 
							rs.getInt("music_hit"), 
							rs.getString("music_date"));
					slideMusicList.add(music);
				}while(rs.next());
			}
		} catch (Exception e) {
			System.out.println("[MusicDAO] getlatestMusicList error : " + e);
		} finally {
			close(pstmt);
			close(rs);			
		}	
		return slideMusicList;
	}


	
	
	
	
	
	
}

