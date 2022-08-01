package controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import action.music.ArtistSearchAction;
import action.music.MusicDetailAction;
import action.music.MusicListAction;
import action.music.MusicSearchAction;
import action.music.TitleSearchAction;
import vo.ActionForward;

/**
 * Servlet implementation class FrontController
 */
@WebServlet("/musicList/*")
public class MusicListFrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MusicListFrontController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(request, response);
	}
	
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		
		String command = requestURI.substring(contextPath.length());
		
		Action action = null;
		ActionForward forward = null;
		

		//곡 목록 불러오기 
		//카테고리 - 밴드 기타
		if(command.equals("/musicList/B01")) {
			forward = new ActionForward("/musicList_forward/B01.jsp", false);
		}else
		//카테고리 - 밴드 베이스
		if(command.equals("/musicList/B02")) {
			forward = new ActionForward("/musicList_forward/B02.jsp", false);
		}else
		//카테고리 - 밴드 드럼
		if(command.equals("/musicList/B03")) {
			forward = new ActionForward("/musicList_forward/B03.jsp", false);
		}else
		//카테고리 - 밴드 건반
		if(command.equals("/musicList/B04")) {
			forward = new ActionForward("/musicList_forward/B04.jsp", false);
		}else	
		//카테고리 - 피아노 3단
		if(command.equals("/musicList/P03")) {
			forward = new ActionForward("/musicList_forward/P03.jsp", false);
		}else
		//카테고리 - 피아노 2단
		if(command.equals("/musicList/P02")) {
			forward = new ActionForward("/musicList_forward/P02.jsp", false);
		}else
		//카테고리 - 관현악 
		if(command.equals("/musicList/C03")) {
			forward = new ActionForward("/musicList_forward/C03.jsp", false);
		}else
		//카테고리 - MR 
		if(command.equals("/musicList/M01")) {
			forward = new ActionForward("/musicList_forward/M01.jsp", false);
		}else
			
		
		//검색
		if(command.equals("/musicList/search")) {

			action = new MusicSearchAction();
			
			String search = request.getParameter("search");
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		
		//검색결과 전체 보기 - 곡
		if(command.equals("/musicList/tie")) {
			
			action = new TitleSearchAction();
			
			String search = request.getParameter("search");
			String inst = request.getParameter("inst");
			String pageNum = request.getParameter("pageNum");
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//검색결과 전체 보기 - 가수
		if(command.equals("/musicList/art")) {
			
			action = new ArtistSearchAction();
			
			String search = request.getParameter("search");
			String inst = request.getParameter("inst");
			String pageNum = request.getParameter("pageNum");
			
			try {
				forward = action.execute(request, response);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		

	

			
	/* 포워딩 ***************************************/
	
	if(forward != null) {
		
		if(forward.isRedirect() == true) {
			response.sendRedirect(forward.getPath());
		}else {
			request.getRequestDispatcher(forward.getPath()).forward(request, response);
		}
	}
	
	}
}
