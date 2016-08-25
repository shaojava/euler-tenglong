#
# Copyright (c) 2001-2016 Primeton Technologies, Ltd.
# All rights reserved.
#
# author: ZhongWen Li (mailto:lizw@primeton.com)
#

FROM euler-registry.primeton.com/tomcat7:1.0.0

#
# while bootstrap, move ROOT to default, move ROOT_TEMPLATE to ROOT
#
ADD ./resources/ROOT/ ${TOMCAT_HOME}/webapps/ROOT_TEMPLATE/

ADD ./resources/entrypoint.sh ${TOMCAT_HOME}/bin/

RUN chmod +x ${TOMCAT_HOME}/bin/entrypoint.sh