package com.ssmp.entity;

import com.baomidou.mybatisplus.plugins.Page;

import java.io.Serializable;

public class ResultEntity implements Serializable{
    private int code;
    private String msg;
    private int count;
    private Object data;

    public ResultEntity() {
        this.code = 0;
        this.msg = "";
        this.count = 0;
        this.data = null;
    }

    public ResultEntity(Page pt) {
        this.code = 0;
        this.msg = "";
        this.count = pt.getTotal();
        this.data = pt.getRecords();
    }

    public ResultEntity(int code, String msg, int count, Page pt) {
        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = pt.getRecords();
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
