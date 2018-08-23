package ${rootPath}.dao.${packageName};

import java.util.List;

import ${rootPath}.model.${packageName}.${objectName};

public interface ${objectName}Dao {

    int delete(String[] id);

    int insert(${objectName} ${packageName});

    ${objectName} getOne(String id);

    int update(${objectName} ${packageName});
    
    List<${objectName}> getList(${objectName} ${packageName});
    
    int getCout(${objectName} ${packageName});
    
}