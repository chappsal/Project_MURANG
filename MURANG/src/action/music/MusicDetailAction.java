package action.music;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import service.music.HitCountService;
import service.music.MusicDetailService;
import service.music.MusicInstService;
import vo.ActionForward;
import vo.Music;

public class MusicDetailAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		ActionForward forward = null;
		
		String music_no = (String) request.getAttribute("music_no");
		
		//곡 정보
		MusicDetailService musicDetailService = new MusicDetailService();
		Music music = musicDetailService.musicDetail(music_no);
		
		int music_no2 = Integer.parseInt(music_no);
		
		//곡이 보유한 악보 정보
		MusicInstService musicInstService = new MusicInstService();
		String iList = musicInstService.selectMusicInst(music_no2);
		
		//조회수 증가
		HitCountService hitCountService = new HitCountService();
		hitCountService.updateHitCount(music_no2);
		
		request.setAttribute("music", music);
		request.setAttribute("iList", iList);

		forward = new ActionForward("/music/musicListDetail.jsp", false);
	
		return forward;
	}

}
