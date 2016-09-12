-- 用户信息表
DROP TABLE IF EXISTS sys_user;
CREATE TABLE sys_user(
  id INT NOT NULL AUTO_INCREMENT COMMENT '用户信息主键ID',
  uid VARCHAR(40) DEFAULT '' NOT NULL COMMENT '用户编码',
  user_name VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名,用于用户登陆',
  password VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci NOT NULL COMMENT '用户登陆密码',
  nick_name VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户昵称',
  sex TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '用户性别',
  birthday DATETIME DEFAULT NULL COMMENT '用户出生日期',
  mobile VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户手机号',
  phone VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '固定电话',
  email VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户邮箱',
  fax VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户传真',
  address VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户常住地址',
  company VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户就职公司名称',
  photo_path VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户头像路径',
  blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '用户是否冻结',
  deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '用户是否逻辑删除',
  create_date DATETIME DEFAULT now() COMMENT '用户创建时间',
  update_date TIMESTAMP DEFAULT now() COMMENT '用户信息更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 初始化一个用户信息
INSERT INTO sys_user(uid,user_name,password,nick_name,sex,birthday,mobile,phone,email,fax,address,company,blocked,deleted,create_date)
    VALUES ('uid10000','root','root','男神小尤',0,'1989-11-15 09:15:00','15800362528','021-62128030','dongooo@yahoo.com','021-62128038','上海市长宁区定西路1100号11楼','用友汽车(上海)科技股份有限公司',0,0,now());

-- SELECT * FROM sys_user;


-- 用户认证表
DROP TABLE IF EXISTS sys_authentication;
CREATE TABLE sys_authentication(
  id INT NOT NULL AUTO_INCREMENT COMMENT '用户认证主键ID',
  uid VARCHAR(40) DEFAULT '' NOT NULL COMMENT '关联用户信息表标示,用户唯一标识',
  access_token VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户登陆认证token',
  refresh_token VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户登陆认证刷新token,access_token超时后,可以使用refresh_token进行刷新,refresh_token有效期为7天',
  expires_in TIMESTAMP DEFAULT now() COMMENT '接口调用凭证超时时间,单位（秒）',
  scope VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户授权作用域',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- SHOW FULL COLUMNS FROM sys_authentication;

-- SELECT * FROM sys_authentication;

-- 用户登陆日志表
DROP TABLE IF EXISTS sys_login_log;
CREATE TABLE sys_login_log(
  id INT NOT NULL  AUTO_INCREMENT COMMENT '登陆日志主键ID',
  uid VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci NOT NULL COMMENT '关联用户表ID',
  enter_time TIMESTAMP DEFAULT now() NOT NULL COMMENT '登陆时间',
  enter_ip VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '登陆IP',
  status TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '登陆是否成功的标示',
  browser VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '登陆浏览器',
  screen_resolution VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '登陆的屏幕分辨率',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- SELECT * FROM sys_login_log;