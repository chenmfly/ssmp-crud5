package com.ssmp.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.ssmp.entity.Msg;
import com.ssmp.entity.ResultEntity;
import com.ssmp.entity.TblDept;
import com.ssmp.entity.TblEmp;
import com.ssmp.service.TblDeptService;
import com.ssmp.service.TblEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 前端控制器
 * 
 * @author Yifan
 * @since 2018-01-17
 */
@Controller
@RequestMapping("/tblEmp")
public class TblEmpController {
//    @Reference
	@Autowired
	private TblEmpService tblEmpService;
	@Autowired
	private TblDeptService tblDeptService;


	/**
	 * 列表
	 * @param page
	 * @return
	 */
	@RequestMapping("/empsnew")
	@ResponseBody
	public ResultEntity getEmpsWithJson(Page<TblEmp> page) {
		Page<TblEmp> pt = tblEmpService.selectTblEmpList(page);
		ResultEntity re = new ResultEntity(pt);
		return re;
	}

	/**
	 * 编辑
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	public String editById(HttpServletRequest request,@PathVariable Integer id){
		TblEmp tblEmp = tblEmpService.selectEmpAndFile(id);
		List<TblDept> tblDepts = tblDeptService.getDepts();
		request.setAttribute("ip","http://192.168.42.128:84/");
		request.setAttribute("tblEmp",tblEmp);
		request.setAttribute("tblDepts",tblDepts);
		return "edit";
	}

	/**
	 * 新增页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/toAdd",method = RequestMethod.GET)
	public String add(HttpServletRequest request){
		List<TblDept> tblDepts = tblDeptService.getDepts();
		request.setAttribute("tblDepts",tblDepts);
		return "edit";
	}

	/**
	 * 新增
	 * @param tblEmp
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@RequestParam(required=false)MultipartFile file, @Valid TblEmp tblEmp, BindingResult result) throws IOException {
		Map<String, Object> map = new HashMap<String, Object>();
		if (result.hasErrors()) {
			// 校验失败，返回失败，在模态框中显示失败的错误信息
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名：" + fieldError.getField());
				System.out.println("错误信息：" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorField", map);
		} else {
			String fileName = file.getOriginalFilename();
			String fileExt = fileName!=""?fileName.substring(fileName.lastIndexOf(".")+1,fileName.length()):null;
			byte[] fileByte = fileName!=""?file.getBytes():null;
			map = tblEmpService.insertEmp(tblEmp,fileName,fileExt,fileByte);
			if(!map.isEmpty()){
				Msg.fail().add("errorField",map.get("errorField"));
			}
			return Msg.success();
		}
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(HttpServletRequest request, TblEmp tblEmp) {
		Boolean b = tblEmpService.updateById(tblEmp);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail();
		}
	}

	/**
	 * 单个删除 + 批量删除
	 */
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("ids") String ids) {
		if (ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			tblEmpService.deleteBatchIds(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			tblEmpService.deleteById(id);
		}
		return Msg.success();
	}

	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(HttpServletRequest request, HttpServletResponse response, TblEmp tblEmp) {
		List<TblEmp> list = tblEmpService.selectList(new EntityWrapper<TblEmp>().eq("emp_name", tblEmp.getEmpName()));
		if (list.size() < 1) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "后端提示：用户名不可用");
		}
	}
}
