FROM 10.10.70.65/base/andreptb/maven:3.3.9-jdk8
COPY settings.xml /usr/share/maven/conf/settings.xml
COPY linux-x64-48_binding.node /usr/local/
ENV SASS_BINARY_PATH=/usr/local/linux-x64-48_binding.node 
COPY  node-v6.11.0-linux-x64.tar.gz /home/node-v6.11.0-linux-x64.tar.gz
WORKDIR /home/
RUN tar xvf node-v6.11.0-linux-x64.tar.gz \
    && mv node-v6.11.0-linux-x64/ /usr/local/
RUN echo '' > /etc/apt/sources.list.d/jessie-backports.list \
  && echo "deb http://mirrors.aliyun.com/debian jessie main contrib non-free" > /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/debian jessie-updates main contrib non-free" >> /etc/apt/sources.list \
  && echo "deb http://mirrors.aliyun.com/debian-security jessie/updates main contrib non-free" >> /etc/apt/sources.list
    
RUN apt-get update && apt-get install -y libltdl7
RUN  export PATH=/usr/local/node-v6.11.0-linux-x64/bin:$PATH \
   && npm config set registry https://registry.npm.taobao.org \
   && npm install -g @angular/cli \
   && npm install uglify-js -g \
   && npm install -g cordova \
   && npm install -g ionic
ENV PATH=/usr/local/node-v6.11.0-linux-x64/bin:$PATH
