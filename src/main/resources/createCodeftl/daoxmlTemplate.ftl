<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${rootPath}.dao.${packageName}.${objectName}Dao" >
  <!-- 插入 -->
  <insert id="insert" parameterType="${rootPath}.model.${packageName}.${objectName}" >
    insert into ${tablename}(
	<#list fieldList as var>
		<#if var_has_next>
			${var[0]},	
		<#else>
		    ${var[0]}
		</#if>
	</#list>
		) values (
	<#list fieldList as var>
		<#if var_has_next>
		   ${r"#"}{${var[0]}},
		<#else>
		    ${r"#"}{${var[0]}}
		</#if>			
	</#list>
		)
  </insert>
<!-- 修改 -->
  <update id="update" parameterType="${rootPath}.model.${packageName}.${objectName}" >
    update  ${tablename}
	    	 <set> 
		<#list fieldList as var>
		  <#if var_index &gt; 0>
			<if test="${var[0]} != null and ${var[0]} != '' ">
				${var[0]} = ${r"#"}{${var[0]}},
			</if>
		  </#if>
		</#list> 
			</set>
		where  id = ${r"#"}{id}
  </update>
  <!--查询-->
  <select id="getList" parameterType="${rootPath}.model.${packageName}.${objectName}" resultType="${rootPath}.model.${packageName}.${objectName}">
  	select
	<#list fieldList as var>
		<#if var_has_next>
			<#if var[1] == 'Date'>
			   DATE_FORMAT( a.${var[0]},'%Y-%m-%d %H:%i:%s')  ${var[0]},
			<#else>
			   a.${var[0]},
		 	</#if>
		<#else>
			<#if var[1] == 'Date'>
			   DATE_FORMAT( a.${var[0]},'%Y-%m-%d %H:%i:%s')  ${var[0]}
			<#else>
			   a.${var[0]}
		 	</#if>
		</#if>
	</#list>
		from 
				${tablename} a
		<where>
			<if test="keyword != null and keyword !=''">
				and a.name like ${r"'%${keyword}%'"}
			</if>
			<if test="startTime != null and startTime != '' ">
				and a.create_time <![CDATA[>=]]> ${r"#{startTime}"}
			</if>
			<if test="endTime != null and endTime != '' ">
				and a.create_time <![CDATA[<=]]> ${r"#{endTime}"}
			</if>
		</where>
		order by id desc limit ${r"#{"}start${r"}"},${r"#{"}rows${r"}"}
  </select>
   <!--查询总数-->
  <select id="getCout" resultType="int" parameterType="${rootPath}.model.${packageName}.${objectName}">
  	select count(1) from ${tablename} a
  	<where>
			<if test="keyword != null and keyword !=''">
				and a.name like ${r"'%${keyword}%'"}
			</if>
			<if test="startTime != null and startTime != '' ">
				and a.create_time <![CDATA[>=]]> ${r"#{startTime}"}
			</if>
			<if test="endTime != null and endTime != '' ">
				and a.create_time <![CDATA[<=]]> ${r"#{endTime}"}
			</if>
		</where>
  </select>
  <!--批量删除-->
  <delete id="delete">
  	  delete from ${tablename} where id in
  	  <foreach collection="array" item="item" open="(" close=")" separator=",">
  	  		${r"#"}{item}
  	  </foreach>
  </delete>
</mapper>