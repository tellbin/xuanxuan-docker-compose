# 喧喧 docker-compose 部署

### 实验环境：
* wsl2: ubuntu 18.04
* docker: Docker version 19.03.7, build 7141c199a2
* docker-compose: docker-compose version 1.17.1, build unknown

### 喧喧官网
https://www.xuanim.com  
官方QQ群：367833155

# STEP BY STEP
### 1. 克隆
```git clone https://github.com/jiangslee/xuanxuan-docker-compose.git```

### 2. 进入目录
```cd xuanxuan-docker-compose```

### 3. 音视频镜像下载:
- https://dl.cnezsoft.com/xuanxuan/owt/owt.1.1.docker.tar.xz
- https://pan.baidu.com/share/init?surl=2ockrQawlZE83tRhqvhPHA 提取码：nrdv

### 4. 导入音视频镜像教程
```docker load -i owt.1.1.docker.tar.xz```
> Loaded image: owt:latest

### 5. 查看镜像是否已导入
```docker images | grep owt```
> owt                        latest              656e19a71f17        7 months ago        2.58GB
* 或者参考官方教程 https://www.xuanim.com/book/xuanxuanserver/64.html

### 6. 更换为你宿主机的 IP 地址，一般为网卡IP，或者云服务器的公网IP
```sed -i 's/192.168.192.10/你本机的ip地址/g' docker-compose.yaml```

### 7. 首次或者更新了版本号后build下xuan镜像
```docker-compose build --no-cache```

### 8. 后台运行
```docker-compose up -d```

### 9. 更换为你宿主机IP
```sudo sed -i 's/127.0.0.1/你的IP地址:11180/g' xxd/run/xxd/config/xxd.conf```

* 或者访问http://你ip地址:11180，初始账号:admin，密码123456
* 下载xxd配置文件xxd.conf，保存到xuanxuan-docker-compose/xxd/run/xxd/config/xxd.conf

### 10. 停止并重新运行
```docker-compose down && docker-compose up -d```
##### 或者只重新运行xuan
~~docker-compose stop xuan && docker-compose start xuan~~  


```docker-compose restart xuan```  

# 音视频配置
### 1. 获取音视频的 sampleServiceId、sampleServiceKey: 
```docker-compose logs owt | grep sample```
```
~/xuanxuan-docker-compose$ docker-compose  logs owt | grep sample
owt      | sampleServiceId: 5f8843b********3cc757dc0
owt      | sampleServiceKey: jG*********************************uH/s=
owt      | sampleRoom Id: 5f8843c7099bcc0414c3c1de
```
### 2.登录xxb填写音视频配置信息
> http://你ip地址:11180 初始账号:admin，密码123456
```
OWT 服务器地址:填你的IP地址
OWT API 端口:13004	
OWT 管理端口:13300
OWT ID:填上面的sampleServiceId
OWT 密钥:填上面的sampleServiceKey
```

# 喧喧浏览器版部署
```
~/xuanxuan-docker-compose$ wget -O xxc/xxc.zip https://dl.cnezsoft.com/xuanxuan/3.3/xuanxuan.3.3.browser.zip --no-check-certificate

~/xuanxuan-docker-compose$ cd xxc

~/xuanxuan-docker-compose/xxc$ sudo unzip xxc.zip
```

或者访问 https://www.xuanim.com/page/download.html  
点击【浏览器端部署包（.zip）】  
解压到xuanxuan-docker-compose/xxc/xuanxuan-browser/


# 其它

### 查看所有日志
```docker-compose logs```

### 查看xuanxuan一键安装包的日志
```docker-compose logs xuan```

### 相关端口说明：
* 8080 owt音视频端口，注意这个端口目前不可以更换及被其它进程占用，否则音视频会失败
* 13004 owt音视频端口
* 13300 owt音视频端口
* 11443 xxd 消息服务器端口
* 11444 xxd 消息服务器端口
* 13306 mysql 初始用户名root，密码为123456。
* 11180 xxb 喧喧后端 http://ip地址:11180/xxb 初始账号:admin，密码123456
* 11181 xxc 浏览器端 http://ip地址:11181/
