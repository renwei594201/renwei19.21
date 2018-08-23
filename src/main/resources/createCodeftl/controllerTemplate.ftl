package ${rootPath}.controller.${packageName};

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ${rootPath}.model.${packageName}.${objectName};
import ${rootPath}.service.${packageName}.${objectName}Service;


@Controller
@RequestMapping("${packageName}")
public class ${objectName}Controller {
	
	@Autowired
	private ${objectName}Service ${packageName}Service;
	/**
	 * 进入列表页面
	 * wangyu
	 * @return
	 * 2018年4月17日上午9:53:04
	 */
	@RequestMapping("list")
	public ModelAndView list(){
		return new ModelAndView("${packageName}/list");
	}
	/**
	 * 获取列表数据
	 * wangyu
	 * @param ${packageName}
	 * @return
	 * 2018年4月17日上午9:56:34
	 */
	@RequestMapping("getData")
	@ResponseBody
	public Map<String,Object> getData(${objectName} ${packageName}){
		Map<String,Object> map = new HashMap<String, Object>();
		int count = ${packageName}Service.getCout(${packageName});
		//${packageName}.setCount(count);
		List<${objectName}> list = ${packageName}Service.getList(${packageName});
		map.put("total", count);
		map.put("rows", list);
		return map;
	}
	/**
	 * 新增
	 * wangyu
	 * @param ${packageName}
	 * @return
	 * 2018年4月17日上午10:01:46
	 */
	@RequestMapping("save")
	@ResponseBody
	public Map<String,Object> save(${objectName} ${packageName}){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String now = sdf.format(new Date());
			String id=${packageName}.getId();
			if(id != null && !id.equals("")){
//				${packageName}.setUpdate_time(now);
				${packageName}Service.update(${packageName});
			} else{
				${packageName}.setId(UUID.randomUUID().toString());
//				${packageName}.setCreate_time(now);
//				${packageName}.setUpdate_time(now);
				${packageName}Service.insert(${packageName});
			}
			map.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("errmsg", e.getMessage());
		}
		return map;
	}
	/**
	 * 删除
	 * wangyu
	 * @param ids
	 * @return
	 * 2018年4月17日上午10:02:06
	 */
	@RequestMapping("delete")
	@ResponseBody
	public Map<String,Object> delete(String ids){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			if(ids != null && !ids.equals("")){
				ids=ids.trim();
				String[] id = ids.split(",");
				${packageName}Service.delete(id);
			}
			map.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("errmsg", e.getMessage());
		}
		return map;
	}
	
	/**
	 * 导出
	 * wangyu
	 * @param ids
	 * @return
	 * 2018年4月17日上午10:02:06
	 */
	@RequestMapping("exportexcel")
	public void exportexcel(HttpServletResponse response){
		List<${objectName}> list = ${packageName}Service.getDc();
		String columnNames[] = new String[${fieldList?size}];
		String columns[] = new String[${fieldList?size}];
		<#list fieldList as var>
		     columns[${var_index}]="${var[0]}";
		</#list>
	//	String columns[] = {"name","sex"};
		ExcelUtils.exportExcel(response, list, columnNames,columns, "学生信息", "学生信息");
	}
	
	/**
	 * 导入excel
	 * wangyu
	 * 2018年4月26日上午9:25:19
	 */
	@RequestMapping("importexcel")
	@ResponseBody
	public Map<String,Object> importexcel(MultipartFile file){
		Map<String,Object> map = new HashMap<String, Object>();
		
		try {
			//用工具类
			String[][] data = ExcelUtils.readexcellByInput(file.getInputStream(), file.getOriginalFilename(), 1);
			for(int i=0;i<data.length;i++){
				${objectName} ${packageName} = new ${objectName}();
				${packageName}.setId(UUID.randomUUID().toString());
				<#list fieldList as var>
				<#if (var_index > 0)>
					${packageName}.set${var[4]}(data[i][${var_index}]+"02");
				</#if>
				</#list>
				${packageName}Service.insert(${packageName});
			}
			map.put("success", true);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("success", false);
			map.put("errmsg", e.getMessage());
		}
		return map;
	}
}
