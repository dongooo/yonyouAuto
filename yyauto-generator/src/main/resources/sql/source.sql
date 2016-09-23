-- 用户信息表
DROP TABLE IF EXISTS sys_user;
CREATE TABLE sys_user(
  id INT NOT NULL AUTO_INCREMENT COMMENT '用户信息主键ID',
  uid VARCHAR(40) DEFAULT '' NOT NULL COMMENT '用户编码,关联用户认证表,登录日志表',
  org_id VARCHAR(40) DEFAULT '' NOT NULL COMMENT '组织ID,关联公司信息表,客户表等',
  user_name VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名,用于用户登陆',
  password VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci NOT NULL COMMENT '用户登陆密码',
  nick_name VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户昵称',
  sex TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '用户性别',
  birthday DATETIME DEFAULT NULL COMMENT '用户出生日期',
  identity_no VARCHAR(40) NOT NULL DEFAULT '' COMMENT '身份证号',
  passport_no VARCHAR(40) NOT NULL DEFAULT '' COMMENT '护照号',
  mobile VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户手机号',
  phone VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '固定电话',
  email VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户邮箱',
  fax VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户传真',
  province_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '所在省',
  city_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '所在市',
  county_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '所在县',
  address_detail VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '详细住址',
  longitude VARCHAR(40) DEFAULT '' COMMENT '住址经度',
  latitude VARCHAR(40) DEFAULT '' COMMENT '住址纬度',
  company VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户就职公司名称',
  photo_path VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户头像路径,原图',
  photo_path_min VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户头像路径,压缩',
  is_blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '用户是否冻结,1是,0否',
  is_deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '用户是否逻辑删除,1是删除,0未删除',
  create_date DATETIME DEFAULT now() COMMENT '用户创建时间',
  update_date TIMESTAMP DEFAULT now() COMMENT '用户信息更新时间',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 初始化俩个用户信息
INSERT INTO sys_user(uid,org_id,user_name,password,nick_name,sex,birthday,mobile,phone,email,fax,address_detail,company,is_blocked,is_deleted,create_date)
VALUES ('uid10000','gid0001','root','root','男神小尤',0,'1989-11-15 09:15:00','15800362921','021-62128038','dongooo@yahoo.com','021-62128038','上海市长宁区定西路1100号11楼','用友汽车(上海)科技股份有限公司',0,0,now());

INSERT INTO sys_user(uid,org_id,user_name,password,nick_name,sex,birthday,mobile,phone,email,fax,address_detail,company,is_blocked,is_deleted,create_date)
VALUES ('uid10001','gid0002','dev','dev','女神花谷',1,'1987-09-15 11:12:00','18801892665','021-62109823','huagu@gmail.com','021-62109823','上海市浦东新区张杨路108号','正大(上海)科技股份有限公司',0,0,now());

-- SELECT * FROM sys_user;


-- 用户认证表
DROP TABLE IF EXISTS sys_authentication;
CREATE TABLE sys_authentication(
  id INT NOT NULL AUTO_INCREMENT COMMENT '用户认证主键ID',
  uid VARCHAR(40) DEFAULT '' NOT NULL COMMENT '关联用户信息表标示,用户唯一标识',
  access_token VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户登陆认证token',
  refresh_token VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户登陆认证刷新token,access_token超时后,可以使用refresh_token进行刷新,refresh_token有效期为7天',
  expires_in INT DEFAULT 3600  COMMENT '接口调用凭证超时时间,单位（秒）',
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


-- 组织机构表
DROP TABLE IF EXISTS pf_org;
CREATE TABLE pf_org(
  id INT NOT NULL AUTO_INCREMENT COMMENT '表主键ID',
  org_id VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci NOT NULL COMMENT '关联用户表与客户表等',
  pid VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '总分店关联ID',
  org_type VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci NOT NULL COMMENT '公司/门店类型,如FF,FS店',
  org_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci NOT NULL COMMENT '公司推荐码',
  org_name VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司名称',
  province_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司所在省',
  city_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司所在市',
  county_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司所在县',
  org_address_detail VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司详细地址',
  longitude VARCHAR(40) DEFAULT '' COMMENT '公司位置经度',
  latitude VARCHAR(40) DEFAULT '' COMMENT '公司位置纬度',
  legal_person VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司/企业法人/负责人',
  org_mail VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司/企业邮箱',
  org_phone VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司/企业电话',
  bank_deposit_name VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司/企业开户银行名称',
  bank_deposit_no VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司/企业开户银行帐号',
  license_no VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '营业执照号',
  license_photo_path VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '营业执照上传图片路径',
  org_business VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '主营业务',
  good_at_brand VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司擅长维修品牌,关联车辆品牌表code',
  open_time TIME DEFAULT NULL COMMENT '开始营业时间',
  close_time TIME DEFAULT NULL COMMENT '结束营业时间',
  shop_area VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司/企业占地面积',
  workstation VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '公司/企业工位数',
  staff_number VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '员工人数',
  create_date DATETIME DEFAULT now() NOT NULL COMMENT '当前记录创建日期',
  update_date TIMESTAMP DEFAULT now() NOT NULL COMMENT '当前记录更新日期',
  is_blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '组织是否冻结,1是,0否,总店可冻结或删除分店,若被冻结或删除则分店所有帐号不可用,门店不可自我冻结或删除',
  is_deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '组织是否逻辑删除,1是删除,0未删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 数据字典表
DROP TABLE IF EXISTS sys_data_dictionary;
CREATE TABLE sys_data_dictionary(
  id INT NOT NULL AUTO_INCREMENT COMMENT '表主键ID',
  org_id VARCHAR(20) NOT NULL DEFAULT '' COMMENT '关联组织机构org_id',
  dict_code VARCHAR(20) NOT NULL DEFAULT '' COMMENT '数据字段项编码,系统生成唯一主键',
  division_code VARCHAR(20) NOT NULL DEFAULT '' COMMENT '区分字段,如订单类型相关ORDERTYPE,CUSTYPE,CUSLEVEL',
  code VARCHAR(20) NOT NULL DEFAULT '' COMMENT '类型编码',
  name VARCHAR(20) NOT NULL DEFAULT '' COMMENT '类型名称',
  description VARCHAR(50) NOT NULL DEFAULT '' COMMENT '记录项描述',
  is_system TINYINT(1) UNSIGNED ZEROFILL DEFAULT 1 COMMENT '是否是系统初始数据,0为否,1为是,系统初始数据不可修改与删除,可以启用或禁用',
  is_blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '是否禁用,0为启用状态,1为禁用状态',
  is_deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '是否逻辑删除,1为删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 省市县表
-- DROP TABLE IF EXISTS pf_region;
CREATE TABLE pf_region(
  id INT NOT NULL AUTO_INCREMENT COMMENT '表主键ID',
  region_code varchar(20) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '地区编码,系统使用主键',
  name varchar(100) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '地区名称',
  parent_code varchar(20) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '上级地区编码',
  description varchar(100) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '地区描述',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 客户表
DROP TABLE IF EXISTS pf_customer;
CREATE TABLE pf_customer(
  id INT NOT NULL AUTO_INCREMENT COMMENT '客户表主键ID',
  org_id VARCHAR(40) NOT NULL DEFAULT '' COMMENT '客户表中org_id,关联组织机构表',
  customer_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '客户编号,系统生成唯一主键,cus+orgCode+1001或vip+orgCode+1001',
  customer_type VARCHAR(20) NOT NULL DEFAULT '' COMMENT '客户类型,集团客户或个人客户',
  customer_level VARCHAR(20) NOT NULL DEFAULT '' COMMENT '客户等级,钻石,白金,白银,黄铜,vip,普通',
  customer_name VARCHAR(40) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '客户名称',
  customer_phone VARCHAR(20) NOT NULL DEFAULT '' COMMENT '客户固定电话',
  origin_code VARCHAR(40) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '客户来源编码,本店或连锁',
  remark VARCHAR(255) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '客户备注',
  create_date DATETIME DEFAULT now() NOT NULL COMMENT '当前记录创建日期',
  update_date TIMESTAMP DEFAULT now() NOT NULL COMMENT '当前记录更新日期',
  is_blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '客户是否禁用,0为启用状态,1为禁用状态',
  is_deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '客户是否逻辑删除,1为删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 客户联系人表
DROP TABLE IF EXISTS pf_customer_contacts;
CREATE TABLE pf_customer_contacts(
  id INT NOT NULL AUTO_INCREMENT COMMENT '客户联系人主键ID',
  org_id VARCHAR(40) NOT NULL DEFAULT '' COMMENT '关联客户表org_id,组织ID',
  contacts_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '联系人编码,系统生成唯一主键',
  customer_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '关联客户表中客户编码',
  open_id VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'open_id,接入微信时使用',
  contacts_name VARCHAR(20) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '联系人姓名',
  sex TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '联系人性别',
  birthday DATETIME DEFAULT NULL COMMENT '联系人出生日期',
  identity_no VARCHAR(40) NOT NULL DEFAULT '' COMMENT '身份证号',
  passport_no VARCHAR(40) NOT NULL DEFAULT '' COMMENT '护照号',
  mobile VARCHAR(20) NOT NULL DEFAULT '' COMMENT '联系人手机号',
  phone VARCHAR(20) NOT NULL DEFAULT '' COMMENT '联系人固定电话',
  province_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '联系人所在省',
  city_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '联系人所在市',
  county_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '联系人所在县',
  org_address_detail VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '联系人详细地址',
  longitude VARCHAR(40) DEFAULT '' COMMENT '联系人位置经度',
  latitude VARCHAR(40) DEFAULT '' COMMENT '联系人位置纬度',
  email VARCHAR(20) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '联系人邮箱',
  qq_no VARCHAR(20) NOT NULL DEFAULT '' COMMENT 'QQ号',
  wechat_no VARCHAR(20) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '微信号',
  driving_license_no VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '驾驶证号',
  driving_license_photo VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '驾驶证上传图片路径,原图',
  driving_license_photo_min VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '驾驶证上传图片路径,压缩图',
  create_date DATETIME DEFAULT now() NOT NULL COMMENT '当前记录创建日期',
  update_date TIMESTAMP DEFAULT now() NOT NULL COMMENT '当前记录更新日期',
  is_deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '客户是否逻辑删除,1为删除',
  is_blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '客户联系人是否禁用,0为启用状态,1为禁用状态,若所属客户被禁用,则被禁用',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 客户会员/储值卡
DROP TABLE  IF EXISTS pf_vip_card;
CREATE TABLE pf_vip_card(
  id INT NOT NULL AUTO_INCREMENT COMMENT '会员卡主键ID',
  org_id VARCHAR(40) NOT NULL DEFAULT '' COMMENT '关联客户表org_id,组织ID',
  contacts_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '联系人编码,系统生成唯一主键',
  customer_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '关联客户表中客户编码',
  card_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '会员卡编码,系统生成唯一主键',
  stored_value DOUBLE(16,2) NOT NULL DEFAULT 0.00 COMMENT '会员卡储值金额',
  type_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '会员卡类型编码,普卡,金卡,银卡,白金卡',
  description VARCHAR(255) NOT NULL DEFAULT '' COMMENT '会员卡描述',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 会员/储值卡消费流水表

-- 车辆信息表
DROP TABLE IF EXISTS pf_vehicle;
CREATE TABLE pf_vehicle(
  id INT NOT NULL AUTO_INCREMENT COMMENT '车辆信息表主键',
  vehicle_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '车辆编码,系统产生唯一主键',
  org_id VARCHAR(40) NOT NULL DEFAULT '' COMMENT '关联客户表org_id,组织ID',
  customer_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '关联客户表中customer_code',
  contacts_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '关联联系人表中contacts_code,集团用户下联系人与车辆关系',
  plate_no VARCHAR(20) DEFAULT '' COMMENT '车牌号',
  engine_no VARCHAR(40) DEFAULT '' COMMENT '发动机号',
  mileage VARCHAR(40) DEFAULT '' COMMENT '车辆行驶里程',
  vin VARCHAR(40) DEFAULT '' COMMENT '车辆VIN码',
  brand_code VARCHAR(40) DEFAULT '' COMMENT '车辆品牌编码',
  series_code VARCHAR(40) DEFAULT '' COMMENT '车辆车系编码',
  model_code VARCHAR(40) DEFAULT '' COMMENT '车辆车型编码',
  displacement_code VARCHAR(40) DEFAULT '' COMMENT '车辆排量编码',
  year_code VARCHAR(40) DEFAULT '' COMMENT '车辆年份编码',
  insurance_name VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '保险公司名称',
  insurance_date DATE DEFAULT NULL COMMENT '保险到期日',
  insurance_description VARCHAR(255) DEFAULT '' COMMENT '保险描述',
  limited_date DATE DEFAULT NULL COMMENT '年审到期日',
  driving_license_date DATE DEFAULT NULL COMMENT '驾照到期日',
  create_date DATETIME DEFAULT now() NOT NULL COMMENT '车辆信息创建日期',
  update_date TIMESTAMP DEFAULT now() NOT NULL COMMENT '车辆信息更新日期',
  blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '车辆是否禁用,0为启用,1为禁用',
  deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '车辆是否逻辑删除,1为删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 车辆图片
DROP TABLE IF EXISTS pf_vehicle_photo;
CREATE TABLE pf_vehicle_photo(
  id INT NOT NULL AUTO_INCREMENT COMMENT '车辆图片表主键',
  vp_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '车辆图片编码,系统生成唯一主键',
  vehicle_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '车辆编码,关联车辆信息表',
  vehicle_photo VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '车辆上传图片路径,原图',
  vehicle_photo_min VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '车辆上传图片路径,压缩',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 员工信息表
DROP TABLE IF EXISTS pf_staff;
CREATE TABLE pf_staff(
  id INT NOT NULL AUTO_INCREMENT COMMENT '员工表主键',
  staff_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '员工编码,系统生成唯一主键',
  org_id VARCHAR(40) NOT NULL DEFAULT '' COMMENT '组织ID,关联组织机构表',
  staff_name VARCHAR(20) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '员工姓名',
  staff_no VARCHAR(20) NOT NULL DEFAULT '' COMMENT '工号',
  hiredate DATETIME DEFAULT NULL COMMENT '入职时间',
  leavedate DATETIME DEFAULT NULL COMMENT '离职时间',
  sex TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '员工性别',
  age INT(4) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '员工年龄',
  height INT(4) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '身高/cm',
  weight INT(4) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '体重/kg',
  degree_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '文化程度编码,关联系统数据字典表',
  birthday DATETIME DEFAULT NULL COMMENT '用户出生日期',
  job_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '职位/工种编码,关联系统数据字典表',
  seniority INT(4) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '工龄',
  identity_no VARCHAR(40) NOT NULL DEFAULT '' COMMENT '身份证号',
  passport_no VARCHAR(40) NOT NULL DEFAULT '' COMMENT '护照号',
  mobile VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '用户手机号',
  phone VARCHAR(20) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '固定电话',
  email VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '邮箱',
  fax VARCHAR(50) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '传真',
  province_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '所在省',
  city_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '所在市',
  county_code VARCHAR(40) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '所在县',
  address_detail VARCHAR(100) DEFAULT '' COLLATE utf8_unicode_ci COMMENT '员工常住详细地址',
  emergency_contacts_name VARCHAR(20) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '紧急联系人姓名',
  emergency_contacts_mobile VARCHAR(20) NOT NULL DEFAULT '' COMMENT '紧急联系人手机号',
  emergency_contacts_phone VARCHAR(20) NOT NULL DEFAULT '' COMMENT '紧急联系人固话',
  create_date DATETIME DEFAULT now() NOT NULL COMMENT '当前记录创建日期',
  update_date TIMESTAMP DEFAULT now() NOT NULL COMMENT '当前记录更新日期',
  blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '员工是否禁用,0为启用状态,1为禁用状态',
  deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '员工是否逻辑删除,1为删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 员工绩效表

-- 配件表
DROP TABLE IF EXISTS pf_parts;
CREATE TABLE pf_parts(
  id INT NOT NULL AUTO_INCREMENT COMMENT '配件表主键ID',
  org_id VARCHAR(40) NOT NULL DEFAULT '' COMMENT '组织ID,关联组织机构表',
  parts_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件编码,系统生成唯一主键',
  name VARCHAR(255) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '配件名称',
  main_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件大类编码',
  sub_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件二级子类编码',
  last_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件三级子类编码',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 配件一级大类表
DROP TABLE IF EXISTS pf_parts_classify_main;
CREATE TABLE pf_parts_classify_main(
  id INT NOT NULL AUTO_INCREMENT COMMENT '表主键',
  org_id VARCHAR(40) DEFAULT '' COMMENT '组织ID',
  main_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件大类编码,系统使用主键',
  name VARCHAR(255) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '配件大类名称',
  type_id TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT ',0项目工时分类,1配件分类,2代表其它',
  is_system TINYINT(1) UNSIGNED ZEROFILL DEFAULT 1 COMMENT '是否是系统初始化分类,0为否,1为是,系统初始分类不可修改与删除,可以启用或禁用',
  is_blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '是否禁用,0为启用状态,1为禁用状态',
  is_deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '是否逻辑删除,1为删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 配件二级子类表
DROP TABLE IF EXISTS pf_parts_classify_sub;
CREATE TABLE pf_parts_classify_sub(
  id INT NOT NULL AUTO_INCREMENT COMMENT '表主键',
  org_id VARCHAR(40) DEFAULT '' COMMENT '组织ID',
  main_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件大类编码,系统使用主键',
  sub_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件二级子类编码,系统使用主键',
  name VARCHAR(255) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '配件二级子类名称',
  type_id TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT ',0项目工时分类,1配件分类,2代表其它',
  is_system TINYINT(1) UNSIGNED ZEROFILL DEFAULT 1 COMMENT '是否是系统初始化分类,0为否,1为是,系统初始分类不可修改与删除,可以启用或禁用',
  is_blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '是否禁用,0为启用状态,1为禁用状态',
  is_deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '是否逻辑删除,1为删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 配件三级子类表
DROP TABLE IF EXISTS pf_parts_classify_last;
CREATE TABLE pf_parts_classify_last(
  id INT NOT NULL AUTO_INCREMENT COMMENT '表主键',
  org_id VARCHAR(40) DEFAULT '' COMMENT '组织ID',
  main_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件大类编码,系统使用主键',
  sub_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件二级子类编码,系统使用主键',
  last_code VARCHAR(40) NOT NULL DEFAULT '' COMMENT '配件三级子类编码,系统使用主键',
  name VARCHAR(255) NOT NULL DEFAULT '' COLLATE utf8_unicode_ci COMMENT '配件三级子类名称',
  type_id TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT ',0项目工时分类,1配件分类,2代表其它',
  is_system TINYINT(1) UNSIGNED ZEROFILL DEFAULT 1 COMMENT '是否是系统初始化分类,0为否,1为是,系统初始分类不可修改与删除,可以启用或禁用',
  is_blocked TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '是否禁用,0为启用状态,1为禁用状态',
  is_deleted TINYINT(1) UNSIGNED ZEROFILL DEFAULT 0 COMMENT '是否逻辑删除,1为删除',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 维修项目工时表