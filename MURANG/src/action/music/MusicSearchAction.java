package action.music;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import service.music.MusicInstService;
import service.music.MusicSearchService;
import vo.ActionForward;
import vo.Music;

public class MusicSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;

		String search = request.getParameter("search");
		
		MusicSearchService musicSearchService = new MusicSearchService();
		
		
		//검색 결과
		ArrayList<Music> searchTitle = musicSearchService.musicSearchTitle(search);
		ArrayList<Music> searchArtist = musicSearchService.musicSearchArtist(search);
		
		ArrayList<String> titleInstList = null;
		ArrayList<String> artistInstList = null;
		
		if(searchTitle != null) {
			
			//곡의 악기 종류 불러오기 - 제목검색
			MusicInstService musicInstService = new MusicInstService();

			String titleInst = null;
			titleInstList = new ArrayList<String>();

			for(int i=0; i < searchTitle.size(); i++) {
				
				for(Music mList:searchTitle) {
					
					int music_no = mList.getMusic_no();
					titleInst = musicInstService.selectMusicInst(music_no);
					titleInstList.add(titleInst);
				}	
			}
		} 
		
		if(searchArtist != null) {
		
			//곡의 악기 종류 불러오기 - 가수검색
			MusicInstService musicInstService = new MusicInstService();

			String artistInst = null;
			artistInstList = new ArrayList<String>();
			
			for(int i=0; i < searchArtist.size(); i++) {
				
				for(Music mList:searchArtist) {
					
					int music_no = mList.getMusic_no();
					artistInst = musicInstService.selectMusicInst(music_no);
					artistInstList.add(artistInst);
				}	
			}
		}
		

		
		request.setAttribute("searchTitle", searchTitle);
		request.setAttribute("searchArtist", searchArtist);
		request.setAttribute("titleInstList", titleInstList); 
		request.setAttribute("artistInstList", artistInstList);
		request.setAttribute("showPage", "music/musicSearch.jsp");
		
		forward = new ActionForward("/userTemplate.jsp", false);
		
		return forward;
	}

}
