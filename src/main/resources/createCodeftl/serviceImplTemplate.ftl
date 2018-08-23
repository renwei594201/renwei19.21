package ${rootPath}.service.impl.${packageName};

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ${rootPath}.dao.${packageName}.${objectName}Dao;
import ${rootPath}.model.${packageName}.${objectName};
import ${rootPath}.service.${packageName}.${objectName}Service;
@Service
public class ${objectName}ServiceImpl implements ${objectName}Service {
	
	@Autowired
	private ${objectName}Dao ${packageName}Dao;
	
	@Override
	public int insert(${objectName} ${packageName}) {
		return ${packageName}Dao.insert(${packageName});
	}

	@Override
	public ${objectName} getOne(String id) {
		return ${packageName}Dao.getOne(id);
	}

	@Override
	public int update(${objectName} ${packageName}) {
		return ${packageName}Dao.update(${packageName});
	}

	@Override
	public List<${objectName}> getList(${objectName} ${packageName}) {
		return ${packageName}Dao.getList(${packageName});
	}

	@Override
	public int getCout(${objectName} ${packageName}) {
		return ${packageName}Dao.getCout(${packageName});
	}

	@Override
	public int delete(String[] id) {
		return ${packageName}Dao.delete(id);
	}

}
