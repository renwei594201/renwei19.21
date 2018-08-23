package com.rw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.rw.dao.MyDao;
import com.rw.dto.Student;
@Service
public class MyServiceImpl implements MyService {

	@Autowired
	private MyDao myDao;
	@Override
	public List<Student> list() {
		// TODO Auto-generated method stub
		
		return myDao.list();
	}

}
