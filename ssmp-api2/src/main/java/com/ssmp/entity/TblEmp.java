package com.ssmp.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableLogic;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import javax.validation.constraints.Pattern;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author Yifan
 * @since 2018-01-17
 */
@TableName("tbl_emp")
public class TblEmp extends Model<TblEmp> implements Serializable{

    private static final long serialVersionUID = 1L;

	@TableId(value="emp_id", type= IdType.AUTO)
	private Integer empId;
	@TableField("emp_name")
	@Pattern(regexp=("(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)"),message="后端提示：用户名必须合法")
	private String empName;
	private String gender;
	@Pattern(regexp=("^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"),message="后端提示：邮箱必须合法")
	private String email;
	@TableField("d_id")
	private Integer dId;
	@TableField("rm_flag")
	@TableLogic
	private Integer rmFlag;
	@TableField(exist = false)
	private TblDept tblDept;
	@TableField(exist = false)
	private TblEmpPicture tblEmpPicture;

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getdId() {
		return dId;
	}

	public void setdId(Integer dId) {
		this.dId = dId;
	}

	public Integer getRmFlag() {
		return rmFlag;
	}

	public void setRmFlag(Integer rmFlag) {
		this.rmFlag = rmFlag;
	}

	public TblDept getTblDept() {
		return tblDept;
	}

	public void setTblDept(TblDept tblDept) {
		this.tblDept = tblDept;
	}

	public TblEmpPicture getTblEmpPicture() {
		return tblEmpPicture;
	}

	public void setTblEmpPicture(TblEmpPicture tblEmpPicture) {
		this.tblEmpPicture = tblEmpPicture;
	}

	@Override
	protected Serializable pkVal() {
		return this.empId;
	}

	@Override
	public String toString() {
		return "TblEmp{" +
			", empId=" + empId +
			", empName=" + empName +
			", gender=" + gender +
			", email=" + email +
			", dId=" + dId +
			", rmFlag=" + rmFlag +
			"}";
	}
}
