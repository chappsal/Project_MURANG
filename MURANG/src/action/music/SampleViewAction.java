package action.music;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import service.music.MusicDetailService;
import service.music.MusicInstService;
import service.music.SampleViewService;
import vo.ActionForward;
import vo.Music;

public class SampleViewAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		String music_no = request.getParameter("no");
		String inst = request.getParameter("inst");
		
		//악보 샘플 찾기 
		SampleViewService sampleViewService = new SampleViewService();
		String mPaper_img = sampleViewService.getMusicPaper(music_no, inst);
		
		//곡 정보 찾기
		MusicDetailService musicDetailService = new MusicDetailService();
		Music music = musicDetailService.musicDetail(music_no);
		

		
		request.setAttribute("mPaper_img", mPaper_img);
		request.setAttribute("music", music);
		request.setAttribute("inst", inst);		

		
		forward = new ActionForward("/music/musicSampleView.jsp", false);
		return forward;
	}

}
