package action.music;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import service.music.MusicInstService;
import service.music.MusicListService;
import service.music.MusicPagingService;
import vo.ActionForward;
import vo.Inst;
import vo.Music;
import vo.Paging;

public class MusicListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		String inst = request.getParameter("inst");
		
		
		//전체 레코드 수 
		MusicPagingService musicPagingService = new MusicPagingService();
		int totalCnt = musicPagingService.getMusicListPaging(inst);
				
		if(totalCnt == 0) {
			request.setAttribute("showPage", "music/musicListNull.jsp");
			forward = new ActionForward("userTemplate.jsp", false); 
			return forward;
		}
		
		
		//현재 페이지 정보
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		//연산을 하기 위한 pageNum 형변환 / 현재 페이지
		int currentPage = Integer.parseInt(pageNum);
		
		//한 페이지에 출력할 레코드 수
		int displayRow=10; 
		
		//화면에 출력할 페이지 수
		int displayPage=3;
		
		//시작 레코드
		Paging paging = new Paging();
		int startRow = paging.startRow(currentPage, displayRow);
		
		//마지막 레코드
		int endRow = currentPage*displayRow;
		
		
		//목록 10개씩 불러오기 (최신순 or 인기순)
		String order = request.getParameter("order");
		
		if(order == null) order = "1";
		
		MusicListService musicListService = new MusicListService();;
		ArrayList<Music> musicList = new ArrayList<Music>();
		
		if(order.equals("1")) { //최신순 정렬
			musicList = musicListService.selectMusicList(inst,startRow);
			
		}else if(order.equals("2")) { //인기순 정렬
			musicList = musicListService.selectMusicHitList(inst,startRow);
		}
		
		
		
		int totalPage = paging.totalPage(totalCnt, 10); //총 페이지 수
		int startPage = ((currentPage-1)/displayPage)*displayPage+1; //한 페이지에 보여줄 첫 번호
		int endPage = startPage + displayPage - 1; //한 페이지에 보여줄 끝 번호
		
		if(endPage > totalPage){
			endPage = totalPage;
		}
		
		
		//곡의 악기 종류 불러오기
		MusicInstService musicInstService = new MusicInstService();

		String instList = null;
		ArrayList<String> musicInstList = new ArrayList<String>();

		for(int i=0; i < musicList.size(); i++) {
			
			for(Music mList:musicList) {
				
				int music_no = mList.getMusic_no();
				instList = musicInstService.selectMusicInst(music_no);
				musicInstList.add(instList);
			}	
		}
		
	
		request.setAttribute("order", order);
		request.setAttribute("totalCnt", totalCnt); //총 레코드 수
		request.setAttribute("currentPage", currentPage); //현재 페이지
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("paging", paging);
		request.setAttribute("startRow", startRow);
		request.setAttribute("displayRow", displayRow);
		request.setAttribute("displayPage", displayPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("musicList", musicList);
		request.setAttribute("musicInstList", musicInstList);
		
		forward = new ActionForward("music/musicList.jsp", false);
		
		return forward;
	}

}
