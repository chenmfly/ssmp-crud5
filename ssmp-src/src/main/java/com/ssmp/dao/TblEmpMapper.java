package com.ssmp.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.ssmp.entity.TblEmp;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author Yifan
 * @since 2018-01-17
 */
public interface TblEmpMapper extends BaseMapper<TblEmp> {
    List<TblEmp> selectTblEmpList(Pagination page);
    Boolean insertEmp(TblEmp tblEmp);
    TblEmp selectEmpAndFile(Integer empId);
}
