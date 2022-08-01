package action.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import service.admin.SalesManageService;
import vo.ActionForward;
import vo.Order;

import java.util.ArrayList;
import java.util.Calendar;

public class SalesManageAction implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		Calendar cal = Calendar.getInstance();
		
		String yearR = request.getParameter("year");
		String monthR = request.getParameter("month");

		//기본값
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH);
		
		int yearNow = cal.get(Calendar.YEAR);

		
		if(yearR != null && monthR != null){
			year = Integer.parseInt(yearR);
			month = Integer.parseInt(monthR)-1; 
		}
		
		cal.set(year, month, 1);
		
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
		int lastday = cal.getActualMaximum(Calendar.DATE);
		
		//이전, 이후
		if(month == 0){ 
			year = year-1;
			month = 11;
		}
		if(month == 12){ 
			year = year+1; 
			month = 0;
		}

		//일 매출 합계 월별로 조회
		SalesManageService salesManageService = new SalesManageService();
		ArrayList<String> dayTotalList = new ArrayList<String>();
		
		for(int i=1; i<=lastday; i++) {
			String dayTotalPrice = salesManageService.dayTotalPrice(year,month,i);
			
			dayTotalList.add(dayTotalPrice);
		}
		
		//일 매출 리스트
		String dayR = request.getParameter("day");
		ArrayList<Order> dayPriceList = new ArrayList<Order>();
		
		if(dayR != null) {
			
			int day = Integer.parseInt(dayR);
		
			salesManageService = new SalesManageService(); 
			dayPriceList = salesManageService.dayPriceList(year, month, day);
		} 
		
		
		request.setAttribute("dayR", dayR);
		request.setAttribute("yearNow", yearNow);
		request.setAttribute("year", year);
		request.setAttribute("month", month);
		
		request.setAttribute("dayTotalList", dayTotalList);
		request.setAttribute("dayPriceList", dayPriceList);
		request.setAttribute("dayOfWeek", dayOfWeek);
		request.setAttribute("lastday", lastday);
		
		request.setAttribute("showPage", "/admin/salesManageView.jsp");
		
		forward = new ActionForward("/userTemplate.jsp", false);
		return forward;
		
	}

}
