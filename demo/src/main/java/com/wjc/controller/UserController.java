package com.wjc.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.alibaba.fastjson.JSONObject;
import com.wjc.dao.IUserDao;
import com.wjc.pojo.Photo;
import com.wjc.pojo.User;
import com.wjc.service.IUserService;

@Controller
public class UserController {
	
	private static Logger logger = Logger.getLogger(UserController.class);
	
	@Autowired
    private IUserDao userDao;
	
	@Autowired
    private IUserService userService;
	
	
	/**
	 * 查询用户列表
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/queryUsers.do")
	@ResponseBody
	public Object queryUsers(HttpServletRequest request){
		
		Map<String, Object> pageMap = new HashMap<String, Object>();
		int page;
		try {
			page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page = 1;
		}
		int pagesize;
		try {
			pagesize = Integer.parseInt(request.getParameter("pagesize"));
		} catch (NumberFormatException e) {
			pagesize = 10;
		}
		pageMap.put("page", page);
		pageMap.put("pagesize", pagesize);
		
		List<User> list = new ArrayList<User>();
		list = userDao.queryUsers(pageMap);
		
		int total = userDao.queryUsersCount();

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		return map;
	}
	

	/**
	 * 查询图片列表
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/queryPhotos.do")
	@ResponseBody
	public Object queryPhotos(HttpServletRequest request){
		
		Map<String, Object> pageMap = new HashMap<String, Object>();
		int page;
		try {
			page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page = 1;
		}
		int pagesize;
		try {
			pagesize = Integer.parseInt(request.getParameter("pagesize"));
		} catch (NumberFormatException e) {
			pagesize = 10;
		}
		pageMap.put("page", page*pagesize);
		pageMap.put("pagesize", pagesize);
		pageMap.put("picture_name", request.getParameter("name"));
		pageMap.put("picture_type", request.getParameter("picture_type"));
		
		List<Photo> list = new ArrayList<Photo>();
		list = userDao.queryPhotos(pageMap);
		
		int total = userDao.queryPhotosCount(pageMap);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", list);
		map.put("page", page);
		return map;
	}
	/**
	 * 用户登录验证
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/check.do")
	@ResponseBody
	public Object check(User user){
			String name = user.getName();
			User newUser  = userDao.selectByName(name);
			Map<String, Object> map=new HashMap<String, Object>();
			if(newUser==null){ 
				map.put("msg", "用户名不正确");
			}else if(Double.parseDouble(newUser.getScore())!=Double.parseDouble(user.getScore())){
				map.put("msg", "密码不正确");
			}else{
				map.put("msg", "正确");
			}
			return map;
			//request.getRequestDispatcher("/index.jsp").forward(request, response);
	}
	/**
	 * 添加用户
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/addUser.do")
	@ResponseBody
	public Object addUser(User user) throws Exception{
			userService.addUser(user);
			return null;
	}
	
	/**
	 * 用户登录
	 * @param session
	 * @param user
	 * @param request
	 * @param response
	 */
	@RequestMapping("/login.do")
	public void login(HttpSession session,User user,HttpServletRequest request,HttpServletResponse response){
			String name = user.getName();
			session.setAttribute("user", name);
			try {
				request.getRequestDispatcher("/WEB-INF/jsp/showUser.jsp").forward(request, response);
			} catch (ServletException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
	
	
	/**
	 * 上传图片第二
	 * @param request
	 * @param file
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("/upload.do")
	@ResponseBody
	public String upload(HttpServletRequest request,@RequestParam(value="file",required=false) MultipartFile[] file) throws IllegalStateException, IOException{
		String path = "";
		for(MultipartFile fi:file){
			if(!fi.isEmpty()){
				 //获得文件类型（可以判断如果不是图片，禁止上传）
                String contentType=fi.getContentType();
                //获得文件后缀名称
                String imageName=contentType.substring(contentType.indexOf("/")+1);
                fi.getName();
                fi.getOriginalFilename();
                String uuid = UUID.randomUUID().toString().replace("-", "");
                
                path="G:\\photo"+ File.separator +uuid+"."+imageName;
                fi.transferTo(new File(path));
			}
		}
		return "成功";
	}
	/**
	 * 下载图片
	 * @param request
	 * @param response
	 */
	@RequestMapping("/download.do")
    public ResponseEntity<byte[]> download(HttpServletRequest request,  
            HttpServletResponse response) throws Exception {  
       String path = request.getSession().getServletContext().getRealPath("/") + "uploadDir" + File.separator + "abc.jpg";  
//		String path="D:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\springMVC\\WEB-INF\\uploadDir\\abc.jpg";  
        File file=new File(path);  
        HttpHeaders headers = new HttpHeaders();    
        String fileName=new String("你好.jpg".getBytes("UTF-8"),"iso-8859-1");//为了解决中文名称乱码问题  
        headers.setContentDispositionFormData("attachment", fileName);   
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);   
        return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),    
                                          headers, HttpStatus.CREATED);  
    }
    
	
    public void  encryptBASE64() throws Exception {  
    	 System.out.println((new BASE64Decoder()).decodeBuffer("4545").length); 
    	 byte[] bt = {2,3,2};
        System.out.println((new BASE64Encoder()).encodeBuffer(bt));    
    }
    
    /**
     * 最新上传
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/toUpload.do")
    public void FileUploadServlet(HttpServletRequest request,  
            HttpServletResponse response) throws IOException{  
    	//创建一个通用的多部分解析器  
    			CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
    			//判断 request 是否有文件上传,即多部分请求 
    			if(multipartResolver.isMultipart(request)){
    				//转换成多部分request    
    	            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
    	            Iterator<String> iter = multiRequest.getFileNames();
    	            while(iter.hasNext()){  
    	                //取得上传文件  
    	                MultipartFile file = multiRequest.getFile(iter.next());  
    	                if(file != null){  
    	                    //取得当前上传文件的文件名称  
    	                    String myFileName = file.getOriginalFilename();  
    	                    //如果名称不为“”,说明该文件存在，否则说明该文件不存在  
    	                    if(myFileName.trim() !=""){  
    	                        //重命名上传后的文件名  
    	                        String fileName = file.getOriginalFilename();  
    	                        //定义上传路径  
    	                        String path = "G:"+File.separator+"photo"+ File.separator  + fileName;  
    	                        //String path = File.separator+"usr"+File.separator+"local"+ File.separator +"photo"+ File.separator +fileName;  
    	                        File localFile = new File(path);  
    	                        try {
    								file.transferTo(localFile);
    								 //返回结果  
    					            JSONObject obj = new JSONObject();  
    					            obj.put("fileName", fileName);  
    					            response.getWriter().print(obj.toJSONString());
    							} catch (IllegalStateException e) {
    								e.printStackTrace();
    							} catch (IOException e) {
    								e.printStackTrace();
    							}  
    	                    }  
    	                }  
    			}
    		  }
              
        }  
    
    /**
     * 图片信息上传
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/addPhoto.do")
    public void addPhoto(HttpServletRequest request,  
            HttpServletResponse response,String name,String comment,String picture_path,String picture_information,String picture_type) throws IOException{  
              Map<String,String> map = new HashMap<String, String>();
              map.put("picture_name", name);
              map.put("comment", comment);
              map.put("picture_type", picture_type);
              map.put("picture_path", picture_path);
              map.put("picture_information", picture_information);
              try {
				userDao.addPhoto(map);
				JSONObject obj = new JSONObject();  
	            obj.put("status", "success");  
	            response.getWriter().print(obj.toJSONString());
			} catch (Exception e) {
				JSONObject obj = new JSONObject();  
	            obj.put("status", "fail");  
	            response.getWriter().print(obj.toJSONString());
				e.printStackTrace();
			}
        }  
        /**
         * 图片信息上传
         * @param request
         * @param response
         * @throws IOException
         */
        @RequestMapping("/deletePhoto.do")
        public void deletePhoto(HttpServletRequest request,  
                HttpServletResponse response,String id) throws IOException{  
                  Map<String,String> map = new HashMap<String, String>();
                  map.put("id", id);
                  try {
    				userDao.deletePhoto(map);
    				JSONObject obj = new JSONObject();  
    	            obj.put("status", "success");  
    	            response.getWriter().print(obj.toJSONString());
    			} catch (Exception e) {
    				JSONObject obj = new JSONObject();  
    	            obj.put("status", "fail");  
    	            response.getWriter().print(obj.toJSONString());
    				e.printStackTrace();
    			}
         }
        
        /**
         * 动态刷新列表
         * @param request
         * @param response
         * @throws Exception 
         */
        @ResponseBody
        @RequestMapping("/countLevel.do")
        public int countLevel(HttpServletRequest request,  
                HttpServletResponse response) throws Exception{  
    				return userDao.countLevel();
         }
        
}


