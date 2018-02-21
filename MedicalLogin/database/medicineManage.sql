
CREATE DATABASE `MedicalSystem`;

use `MedicalSystem`;

/*1、管理员表*/
DROP TABLE IF EXISTS `root`;
CREATE TABLE `root`(
	`rid` varchar(50) not null,
	`username` varchar(20) not null,
	`password` varchar(20) not null,
	`telephone` varchar(20) default null,
	PRIMARY KEY(`rid`)
) ENGINE = INNODB default CHARSET = UTF8;

insert into `root` values
	('001','admin','admin','12332112323'),
	('002','root','root','12345678998');


/*2、顾客表*/
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`(
	`uid` varchar(50) not null,
	`username` varchar(20) not null,
	`password` varchar(20) not null,
	`gender` int(2) default '1',	/*1:男，0:女*/
	`birthday` date default null,
	`address` varchar(50) default null,
	`telephone` varchar(20) default null,
	`email` varchar(30) default null, 
	`symptom` varchar(100) default null,
	`udate` date default null,
	`remark` varchar(100) default null,
	PRIMARY KEY(`uid`)
) ENGINE = INNODB default CHARSET = UTF8;

insert into `user` values
	('0001','test1','1234556','1','1995-09-09','中国北京','123123123','123@123.com','重型感冒','2017-10-27','我感冒了，help me.'),
	('0002','test2','1234556','1','1993-02-23','中国上海','123123123','1234556@123.com','中性感冒','2017-12-17','我感冒了，help me.'),
	('0003','test3','1234556','0','1995-11-11','中国西安','123123123','3334556@23.com','扭到脚了','2017-11-27','我扭到脚了，please help me.'),
	('0004','test4','1234556','0','1997-09-23','中国广东省茂名市','123123123','abc556@1aa.com','重型感冒','2017-08-27','我感冒了，help me.'),
	('0005','test5','1234556','1','1987-12-16','中国广东省深圳市','123123123','zzsd56@1ab.com','重型感冒','2017-10-27','我感冒了，help me.'),
	('0006','test6','1234556','0','1988-07-21','中国台湾台北','123123123','778899@789.com','鼻炎','2017-10-27','鼻炎了，怎么办。'),
	('0007','test7','1234556','1','1995-04-19','中国香港','123123123','3456@156.com','重型感冒','2017-11-11','我感冒了，help me.'),
	('0008','test8','1234556','0','1990-02-05','USA','123123123','abcdef@163.com','肠胃炎','2017-11-12','我肠胃炎，please help me.');


/*3、经办人*/
DROP TABLE IF EXISTS `agency`;
CREATE TABLE `agency`(
	`aid` varchar(50) not null,
	`username` varchar(20) not null,
	`password` varchar(20) not null,
	`gender` int(2) default '0',/*1:男，0:女*/
	`telephone` varchar(20) default null,
	`remark` varchar(100) default null,
	PRIMARY KEY(`aid`)
) ENGINE = INNODB default CHARSET = UTF8;

insert into `agency` values
	('agency001','agency1','123456','0','12345612345','购买业务平台1'),
	('agency002','agency2','123456','1','12345678909','公司管理1'),
	('agency003','agency3','123456','0','12345612345','人员梳理'),
	('agency004','agency4','123456','0','98778999870','平台整理');


/*4、药品类型*/
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`(
	`cid` varchar(50) not null,
	`cname` varchar(20) not null,
	PRIMARY KEY(`cid`)
) ENGINE = INNODB default CHARSET = UTF8;

insert into `category` values
	('1001','家庭常备'),('1002','专科用药'),('1003','医疗器械'),
	('1004','隐形眼镜'),('1005','滋补保健'),('1006','维生素钙'),
	('1007','药妆个护'),('1008','计生用品'),('1009','母婴用品');


/*5、供应商*/
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier`(
	`sid` varchar(50) not null,
	`sname` varchar(20) not null,
	`address` varchar(50) default null,
	`telephone` varchar(20) default null,
	PRIMARY KEY(`sid`)
) ENGINE = INNODB default CHARSET = UTF8;

insert into `supplier` values
	('medi001','江西远东药业有限公司','江西贵溪','0701-3795666'),
	('medi002','山东加华制药有限公司','山东泰安','0538-6919999'),
	('medi003','爱索尔广州包装有限公司','广东广州','020-32221200'),
	('medi004','九江医药总公司','江西九江','0792-8215849'),
	('medi005','北京同仁堂有限责任公司','北京','89898989');


/*6、药品*/
DROP TABLE IF EXISTS `medicine`;
CREATE TABLE `medicine`(
	`mid` varchar(50) not null,
	`mname` varchar(20) not null,
	`shop_price` double default null,
	`quantity` int(10) default '100', /*库存量*/
	`mmode` int(2) default '1',	/*1:外用，0:内用*/
	`mefficacy` varchar(200) default null,/*功效*/
	`product_date` date default null,/*药品生产日期*/
	`purchase_date` date default null,/*药品进货日期*/
	`shelf_life` int(5) default null,/*保质期，单位为月*/
	`cid` varchar(50) default null,/*属于哪个药品类别cid*/
	`sid` varchar(50) default null,/*属于哪个供应商sid*/
	PRIMARY KEY(`mid`),
	key `fk_0001`(`cid`),
	key `fk_0002`(`sid`),
	CONSTRAINT `fk_0001` FOREIGN KEY (`cid`) REFERENCES `category`(`cid`),
	CONSTRAINT `fk_0002` FOREIGN KEY (`sid`) REFERENCES `supplier`(`sid`)
) ENGINE = INNODB default CHARSET = UTF8;

insert into `medicine` values
	('5898212112','三九胃泰颗粒无糖','59','50','0','清热燥湿，行气活血，柔肝止痛。用于湿热内蕴、气滞血瘀所致的胃痛，症见脘腹隐痛、饱胀反酸、恶心呕吐、嘈杂纳减；浅表性胃炎见上述证候者。','2017-09-09','2017-10-10','60','1001','medi001'),
	('5898212135','铝碳酸镁片','59','50','0','本品用于慢性胃炎；与胃酸有关的胃部不适症状，如胃痛、胃灼热感（烧心）、酸性嗳气、饱胀等。','2017-08-08','2017-10-10','60','1001','medi001'),
	('5898245450','库博 佰视明隐形眼镜月抛','59','50','1','保护眼睛','2017-08-08','2017-10-10','12','1004','medi002'),
	('5898245455','百越 明隐形眼镜月抛','59','50','1','保护眼睛','2017-08-08','2017-10-10','12','1004','medi004'),
	('5891235455','缬沙坦氨氯地平片','59','50','1','治疗原发性高血压。倍博特用于单药治疗不能充分控制血压的患者。','2016-08-08','2017-10-10','60','1002','medi003'),
	('5891267855','氨氯地平片','59','50','1','治疗原发性高血压。倍博特用于单药治疗不能充分控制血压的患者。','2016-08-08','2017-10-10','60','1003','medi004');


/*7、订单*/
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`(
	`oid` varchar(32) not null,
	`name` varchar(20) default null,/*收货人姓名*/
	`address` varchar(30) default null,/*收货人地址*/
	`telephone` varchar(20) default null,/*收货人联系方式*/
	`ordertime` datetime default null,/*下单时间*/
	`state` int(2) default null,	/*是否支付，1:支付，0:未支付*/
	`total` double default null,	/*订单总金额*/
	`uid` varchar(50) default null,   /*属于哪个user*/
	`aid` varchar(50) default null,	  /*属于哪个agency*/	
	PRIMARY KEY(`oid`),
	KEY `fk_0005` (`uid`),
	KEY `fk_0006` (`aid`),
	CONSTRAINT `fk_0005` FOREIGN KEY (`uid`) REFERENCES `user` (`uid`),
	CONSTRAINT `fk_0006` FOREIGN KEY (`aid`) REFERENCES `agency` (`aid`)
) ENGINE = INNODB default CHARSET = UTF8;


/*8、订单项*/
DROP TABLE IF EXISTS `orderItem`;
CREATE TABLE `orderItem`(
	`itemid` varchar(50) not null,
	`count` int(5) default null,/*购买数量*/
	`total` double default null,/*小计*/
	`mid` varchar(50) default null,/*买了哪个medicine*/
	`oid` varchar(50) default null,/*属于哪个orders*/
	PRIMARY KEY(`itemid`),
	KEY `fk_0003` (`mid`),
	KEY `fk_0004` (`oid`),
	CONSTRAINT `fk_0003` FOREIGN KEY (`mid`) REFERENCES `medicine` (`mid`),
	CONSTRAINT `fk_0004` FOREIGN KEY (`oid`) REFERENCES `orders` (`oid`)
) ENGINE = INNODB default CHARSET = UTF8;


