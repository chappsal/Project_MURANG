package action.music;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import service.music.MusicInstService;
import service.music.MusicListService;
import service.music.MusicSearchService;
import vo.ActionForward;
import vo.Music;
import vo.Paging;

public class TitleSearchAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		int totalCnt = 0;
		String inst = request.getParameter("inst");
		String search = request.getParameter("search");
		
		MusicSearchService musicSearchService = new MusicSearchService();
		ArrayList<Music> searchAll = musicSearchService.musicSearchTitle(search);
		
		ArrayList<String> searchAllInst = null;
		
		if(searchAll == null) {}
			
		//곡의 악기 종류 불러오기 - 제목검색
		MusicInstService musicInstService = new MusicInstService();

		String AllInst = null;
		searchAllInst = new ArrayList<String>();

		for(int i=0; i < searchAll.size(); i++) {
			
			for(Music mList:searchAll) {
				
				int music_no = mList.getMusic_no();
				AllInst = musicInstService.selectMusicInst(music_no);
				searchAllInst.add(AllInst);
			}	
		}
		
		//페이징 
		//전체 레코드 수
		musicSearchService = new MusicSearchService();
		totalCnt = musicSearchService.rowSearchTitle(search);
		
		//현재 페이지 정보
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		//한 페이지에 출력할 레코드 수
		int displayRow=5; 
		
		//첫 행 번호 계산
		Paging paging = new Paging();
		int startRow = paging.startRow(Integer.parseInt(pageNum), displayRow);
		
		//목록 10개씩 불러오기
		MusicListService musicListService = new MusicListService();
		ArrayList<Music> musicList = musicListService.selectMusicList(inst,startRow);
		

		int totalPage = paging.totalPage(totalCnt, 10); //총 페이지 수
		int startPage = ((Integer.parseInt(pageNum)-1)/10)*10+1; //첫 페이지
		int endPage = startPage + 10 - 1; //마지막 페이지
	
		
		request.setAttribute("name", "Song");
		request.setAttribute("searchAll", searchAll);
		request.setAttribute("searchAllInst", searchAllInst); 
		
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("paging", paging);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startRow", startRow);
		request.setAttribute("displayRow", displayRow);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("musicList", musicList);

		request.setAttribute("showPage", "music/musicSearchAll.jsp");
		
		forward = new ActionForward("/userTemplate.jsp", false);
		return forward;
	}

}
