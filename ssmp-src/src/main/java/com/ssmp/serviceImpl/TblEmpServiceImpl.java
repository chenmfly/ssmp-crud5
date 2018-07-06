package com.ssmp.serviceImpl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.ssmp.dao.TblEmpMapper;
import com.ssmp.entity.TblEmp;
import com.ssmp.entity.TblEmpPicture;
import com.ssmp.service.TblEmpPictureService;
import com.ssmp.service.TblEmpService;
import com.ssmp.util.FastDFS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 *  服务实现类
 *
 * @author Yifan
 * @since 2018-01-17
 */
@Service
public class TblEmpServiceImpl extends ServiceImpl<TblEmpMapper, TblEmp> implements TblEmpService {
    @Autowired
    private TblEmpPictureService tblEmpPictureService;

    public Page<TblEmp> selectTblEmpList(Page<TblEmp> page) {
        return page.setRecords(baseMapper.selectTblEmpList(page));
    }

    public TblEmp selectEmpAndFile(Integer empId){
        return baseMapper.selectEmpAndFile(empId);
    }

    @Override
    public Map insertEmp(TblEmp tblEmp,String fileName,String fileExt,byte[] file) {
        Map map = new HashMap();

        tblEmp.setRmFlag(1);// 逻辑未删除标识为1
        baseMapper.insertEmp(tblEmp);
        Integer empId = tblEmp.getEmpId();

        if(!"".equals(fileName) && empId != null){
            String[] strings = FastDFS.updateByUrl(file, fileExt,null);

            if(strings!=null){
                TblEmpPicture tep = new TblEmpPicture();
                tep.setGroup(strings[0]);
                tep.setEmpId(empId);
                tep.setExt(fileExt);
                tep.setUrl(strings[1]);
                tep.setType(1);
                tblEmpPictureService.insert(tep);
            }else{
                map.put("errorField","图片上传失败");
            }
        }
        return map;
    }
}
