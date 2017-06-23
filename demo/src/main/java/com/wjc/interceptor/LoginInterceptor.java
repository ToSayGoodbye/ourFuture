package com.wjc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		Object user=request.getSession().getAttribute("user");  
        String returnUrl = request.getRequestURI();  
        if(null==user){  
            if(returnUrl.indexOf("/index.jsp")>0||returnUrl.indexOf("/check.do")>0||returnUrl.indexOf("/login.do")>0){  
                return true;  
            }else{  
            	request.getRequestDispatcher("/index.jsp").forward(request, response);
                return false;  
            }  
        }  
        return true;  
	}

	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

}
