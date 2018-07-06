package com.ssmp.entity;

public enum ErrorCodeType {
	SUCCESS(0),//成功
	P_FAILURE(1),//数据异常
	P_OVERTIME(2);//密码失效

	private int value;

	private ErrorCodeType(int val){
		this.value = val;
	}

	public int getValue() {
		return value;
	}
}
