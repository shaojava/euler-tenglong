# Euler-Tenglong  
  
  
河南腾龙信息工程有限公司客户项目定制
  
  
## 编译镜像  
  
编译镜像并推送如私有仓库，登陆Docker宿主机，配置好私有仓库，参考下面命令：  
  
`mkdir ~/git`
`cd ~/git`  
`git clone https://github.com/Primeton-Euler/Euler-Tenglong.git`  
`cd Euler-Tenglong/registry/tomcat7`  
`chmod +x 2.0.0/build.sh 2.1.0/build.sh`  
` `  
`# see help, execute `  
`2.0.0/build.sh --help`      
` `  
`# docker build`  
`2.0.0/build.sh --REGISTRY_URL "euler-registry.primeton.com" --PUSH_IMG "yes" --RM_IMG "yes" --LATEST "yes"`  
`2.1.0/build.sh --REGISTRY_URL "euler-registry.primeton.com" --PUSH_IMG "yes" --RM_IMG "yes" --LATEST "yes"`  
  
  
## 镜像说明  
  
(1)`tomcat7:2.0.0` 用于自定义镜像，需要放在源码中（maven项目默认 `src/main/webapp` 目录下）编译产物在WAR的根目录下；参考模板[template/tomcat/Dockerfile](https://github.com/Primeton-Euler/Euler-Tenglong/blob/master/template/tomcat/Dockerfile)  
  
	# Example (src/main/webapp/Dockerfile)
	
	FROM euler-registry.primeton.com/tomcat7:2.0.0
	
	ADD . ${TOMCAT_HOME}/webapps/default/
  
(2)`tomcat7:2.1.0` 作为镜像模板，如果源码中不想放入 `Dockerfile`（对于 `javaee_app` 类型组件来说）修改 `Euler-CI`数据库表运行环境配置 `CI_RUNTIME_ENV`，把tomcat镜像版本修改成 `tomcat7:2.1.0`，使用这个镜像，部署后的应用的根目录为 `default`，如果想要定义成其他名字，请使用第一种方式——自定义 `Dockerfile`。  
  
	INSERT INTO CI_RUNTIME_ENV (RUNTIME_ENV_ID, RUNTIME_ENV_CODE, RUNTIME_ENV_TYPE, RUNTIME_ENV_NAME, 
		RUNTIME_ENV_DESC, OS, JDK, BACK_END_SERVER, FRONT_END_SERVER, BASE_IMAGE, DEL_FLAG, CREATED_USER, 
		CREATED_TIME, UPDATED_USER, UPDATED_TIME) VALUES ("tomcat70", "tomcat7.0", "tomcat", 
		"tomcat7JavaEE应用运行环境", "tomcat7.0 JavaEE应用运行环境", "ubuntu16.04", "jdk1.7", 
		"tomcat7.0", null, "tomcat7:2.1.0", '0', null, now(), null, null);
 
	INSERT INTO CI_R_RUNTIME_ENV (R_ID, R_COMPONENT_FIELD, R_COMPONENT_FIELD_VALUE, RUNTIME_ENV_ID, 
		RUNTIME_ENV_CODE, DEL_FLAG, CREATED_USER, CREATED_TIME, UPDATED_USER, UPDATED_TIME) 
		VALUES ("javaeetomcat7", "COMPONENT_TYPE", "javaee_app", "tomcat70", "tomcat7.0", '0', 
		null, now(), null, null);  
  
  
## 其他  
  
DevOps平台提供的默认编译镜像的Dockerfile模板是把WAR打入 `${TOMCAT_HOME}/webapps/ROOT` 下，鉴于腾龙使用EOS开发应用，不想部署到默认的ROOT下，所以自定义镜像。基于`tomcat7:2.0.0`, 或 `tomcat7:2.1.0` 基础镜像编译出的应用镜像，部署后访问应用的根目录会跳转到如 `/default`（具体是什么，取决于运行时通过计算 `${TOMCAT_HOME}/webapps下非ROOT目录的一个`）  
  
  