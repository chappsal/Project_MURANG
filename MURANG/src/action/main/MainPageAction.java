package action.main;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import service.music.MainPageService;
import service.offline.OfflineListService;
import vo.ActionForward;
import vo.Music;
import vo.Offline;

public class MainPageAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		MainPageService musicChartService = new MainPageService();
		
		//인기차트
		ArrayList<Music> musicChartList = new ArrayList<Music>();
		musicChartList = musicChartService.getMusicChart();
		
		//최신악보 / 슬라이드
		ArrayList<Music> slideMusicList = new ArrayList<Music>();
		slideMusicList = musicChartService.getlatestMusicList();
		
		//오프라인
		ArrayList<Offline> offlineList = new ArrayList<Offline>();
		OfflineListService offlineListService = new OfflineListService();
		offlineList = offlineListService.selectOfflineList();
		
		request.setAttribute("musicChartList", musicChartList);
		request.setAttribute("slideMusicList", slideMusicList);
		request.setAttribute("offlineList", offlineList);
		
		forward = new ActionForward("/main.jsp", false);
		
		return forward;
	}

}
