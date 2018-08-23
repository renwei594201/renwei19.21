package com.rw.dto;

public class Student {

	private Integer id;
	private String name;
	private String pdw;
	private String tel;
	private String address;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPdw() {
		return pdw;
	}
	public void setPdw(String pdw) {
		this.pdw = pdw;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Student(Integer id, String name, String pdw, String tel, String address) {
		super();
		this.id = id;
		this.name = name;
		this.pdw = pdw;
		this.tel = tel;
		this.address = address;
	}
	public Student() {
		super();
		// TODO Auto-generated constructor stub
	}
	@Override
	public String toString() {
		return "Student [id=" + id + ", name=" + name + ", pdw=" + pdw + ", tel=" + tel + ", address=" + address + "]";
	}
	
}
