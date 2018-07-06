package com.ssmp.controller;

import com.ssmp.entity.Msg;
import com.ssmp.entity.TblDept;
import com.ssmp.service.TblDeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 * 
 * @author Yifan
 * @since 2018-01-17
 */
@Controller
@RequestMapping("/tblDept")
public class TblDeptController {
//    @Reference
    @Autowired
    private TblDeptService tblDeptService;

	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(HttpServletRequest request, HttpServletResponse response) {
		List<TblDept> list = tblDeptService.getDepts();
		return Msg.success().add("depts", list);
	}
}
