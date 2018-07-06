package com.ssmp.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableLogic;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author Yifan
 * @since 2018-01-17
 */
@TableName("tbl_dept")
public class TblDept extends Model<TblDept> implements Serializable{

    private static final long serialVersionUID = 1L;

	@TableId(value="dept_id", type= IdType.AUTO)
	private Integer deptId;
	@TableField("dept_name")
	private String deptName;
	@TableField("rm_flag")
	@TableLogic
	private Integer rmFlag;


	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public Integer getRmFlag() {
		return rmFlag;
	}

	public void setRmFlag(Integer rmFlag) {
		this.rmFlag = rmFlag;
	}

	@Override
	protected Serializable pkVal() {
		return this.deptId;
	}

	@Override
	public String toString() {
		return "TblDept{" +
			", deptId=" + deptId +
			", deptName=" + deptName +
			", rmFlag=" + rmFlag +
			"}";
	}
}
