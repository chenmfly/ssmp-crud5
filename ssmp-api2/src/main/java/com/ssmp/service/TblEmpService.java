package com.ssmp.service;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.ssmp.entity.TblEmp;

import java.util.Map;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Yifan
 * @since 2018-01-17
 */
public interface TblEmpService extends IService<TblEmp> {
    public Page<TblEmp> selectTblEmpList(Page<TblEmp> page);
    public Map insertEmp(TblEmp tblEmp, String fileName, String fileExt, byte[] file);
    public TblEmp selectEmpAndFile(Integer empId);
}
