package com.ssmp.serviceImpl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.ssmp.dao.TblDeptMapper;
import com.ssmp.entity.TblDept;
import com.ssmp.service.TblDeptService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author Yifan
 * @since 2018-01-17
 */
//@Component
@Service
public class TblDeptServiceImpl extends ServiceImpl<TblDeptMapper, TblDept> implements TblDeptService {
    public List<TblDept> getDepts() {
        List<TblDept> list = baseMapper.selectList(new EntityWrapper<TblDept>());
        return list;
    }
}
