FROM 10.10.70.65/base/davidcaste/alpine-tomcat:jdk8tomcat8
COPY vimrc /root/.vimrc
COPY starttomcat.sh /usr/local/bin/starttomcat.sh
COPY context.xml /opt/tomcat/conf/
RUN chmod 777 /usr/local/bin/starttomcat.sh
EXPOSE 8080
CMD ["/bin/bash","/usr/local/bin/starttomcat.sh"]
