package com.ssmp.service;

import com.baomidou.mybatisplus.service.IService;
import com.ssmp.entity.TblDept;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author Yifan
 * @since 2018-01-17
 */
public interface TblDeptService extends IService<TblDept> {
    public List<TblDept> getDepts();
}
