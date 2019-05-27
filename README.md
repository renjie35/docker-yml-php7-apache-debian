# DEBIAN-PHP5.6-APACHE

## 基于Docker的本地PHP开发环境

1. [项目开源地址](https://github.com/renjie35/docker-yml-php7-apache-debian)

2. 环境目录结构

    ```
    .
    ├── README.md                           // 说明文档
    ├── config
    │   ├── composer                        // composer 可执行文件
    │   ├── apache2
    │   │   ├── apache2.conf                // apache配置
    │   │   ├── sites-available               // http/https站点配置目录
    │   ├── php
    │   │   ├── php                         // php 相关配置目录
    │   └── supervisor
    │       └── conf.d                      // supervisor 扩展配置目录
    ├── docker-compose.yml                  // docker容器启动配置
    ├── logs                                // 运行日志输出目录
    └── www                                 // 站点代码目录
        └── phpinfo.localhost.com           // 示例phpinfo站点目录
            └── index.php
    ```
    
3. 环境基本说明

  * 已安软件装服务
  
      |     |名称       |版本   | 
      |:---:|:--------:|:-----:|
      |1    |apache    |2.4.25 |
      |2    |php       |7  |
      |3    |supervisor|3.3.1  |
        
    * 其他已安装内容

      * 已安装PHP模块列表(php -m 命令查看,未标注版本号的组件位php内置组件,编译安装时使用相关的enable编译参数加入,同php一同编译安装):
      
          | PHP Modules |||||||
          |:---:|:---:|:---:|:---:|:---:|:---:|:---:|
          | bcmath | Core | ctype | curl | date | dom | ereg |
          | exif | fileinfo | filter | ftp | gd | hash | iconv |
          | json | libxml | mbstring | mcrypt | mongodb | mysqli | mysqlnd |
          | oci8 | openssl | pcre | PDO | pdo_mysql | PDO_OCI | pdo_sqlite |
          | Phar | posix | readline | redis | Reflection | session | shmop |
          | SimpleXML | soap | sockets | SPL | sqlite3 | standard | sysvsem |
          | tokenizer | xml | xmlreader | xmlrpc | xmlwriter | Zend OPcache | zip |
          | zlib |
            
     * 如果有需要另外安装其他扩展的,可以参考[DockerHub](https://hub.docker.com/_/php/)上的php镜像的官方页面在"How to install more PHP extensions"章节有详细讲解如何安装模块扩展.
     
        * 已安装APACHE模块
            
          | APACHE Modules ||||||
          |:---:|:---:|:---:|:---:|:---:|:---:|
          | core_module | so_module | watchdog_module | http_module | log_config_module | logio_module |
          | version_module | unixd_module | access_compat_module | alias_module | auth_basic_module |
          | authn_core_module | authn_file_module | authz_core_module | authz_host_module | authz_user_module | autoindex_module |
          | deflate_module | dir_module | env_module | expires_module | filter_module | mime_module |
          | mpm_prefork_module | negotiation_module | php5_module | reqtimeout_module | rewrite_module | setenvif_module |
          | status_module |
      * 如果有需要另外的扩展可如下操作
      
        > ln -s /etc/apache2/mods-available/xxxx.load /etc/apache2/mods-enabled/xxxx.load
        
        > PS: /etc/apache2/mods-available 为可用模块, /etc/apache2/mods-enabled 为已开启模块


4. 常见问题

  * 如何启动本地开发环境

    启动phpinfo站点检查环境运行情况:
    
    > 在终端进入当文档所在的目录
    
    >  执行命令
    
    > \# docker-compose up -d
    
    > 配置hosts 127.0.0.1 phpinfo.localhost.com
    
    > 打开浏览器访问http://phpinfo.localhost.com
    
    可以看到phpinfo输出的环境信息.
    
    ***
    
    启动本地站点:

    > 进入本说明文件所在目录
    
    > 1.在www目录下新建站点目录或在www目录下添加站点目录的软连接.
    
    > 2.添加站点的nginx配置文件到config/nginx/conf.d目录,格式可以参考已存在的phpinfo.localhost.com.conf文件
    
    > 3.cd回本docker-compose.yml文件所在目录
    
    > 4.执行命令
    
    > \# docker-compose up -d
    
    > 或使用-f参数指定yml文件
    
    > \# docker-compose -f [docmer-compose.yml路径] up -d
    
    > 配置自己站点的hosts,访问站点
    
    > **注意**:如果本地多个站点之间需要互相进行http通信,则需要在docker-compose.yml文件末尾的extra_hosts中添加所有站点的hosts配置.
        
        
  * docker容器启动后我要如何启动里面的apache和php?
        
    > 不需要手动进入容器启动apache和php
    
    > 本镜像在制作时已经考虑到该问题,容器启动后,会自动启动supervisor进程管理器
    
    > 管理器的默认配置会启动apache和supervisor进程会自动启动
    
    > 如果发现apache并未正常启动,请仔细检查挂载进去的apache站点配置文件
    
    > 修改正确后,apachectl restart进程即可
        
    > ps:docker-php-ext-opcache.ini 缓存配置文件
