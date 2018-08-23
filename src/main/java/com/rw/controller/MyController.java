package com.rw.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rw.dto.Student;
import com.rw.service.MyService;

@Controller
public class MyController {
	@Autowired
	private MyService myService;
	@RequestMapping("list")
	public String list(Model model,HttpServletRequest request) {
		List<Student> list=myService.list();
		model.addAttribute("list", list);
		return "list";
	}
	
	
	
}
