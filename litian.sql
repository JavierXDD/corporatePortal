/*
SQLyog Ultimate v8.32 
MySQL - 5.5.36 : Database - litian
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`litian` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `litian`;

/*Table structure for table `about` */

DROP TABLE IF EXISTS `about`;

CREATE TABLE `about` (
  `aId` varchar(200) DEFAULT NULL,
  `aType` varchar(200) DEFAULT NULL,
  `aTitle` varchar(50) DEFAULT NULL,
  `aTime` varchar(20) DEFAULT NULL,
  `aEditor` varchar(10) DEFAULT NULL,
  `aText` text,
  `aImage` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `about` */

insert  into `about`(`aId`,`aType`,`aTitle`,`aTime`,`aEditor`,`aText`,`aImage`) values ('8CDC215930A345BC89DE3111EEB292C2','asdawdasdadasdasdasdasdasdasdas','董事长致辞','2015-10-21','admin','<p>\r\n	<strong>董事长中秋致辞一</strong></p><p>\r\n	各位领导、同志们、大家好：</p><p>\r\n	海上升明月，天涯共此时。值中秋佳节，我代表灌西盐场投资公司向全体员工致以节日的问候，向所有关心支持灌西投资公司发展的同志们，致以节日的祝福，愿各位及你们的家人中秋快乐，工作顺利、事业发达。</p><p>\r\n	每逢佳节倍思亲，在这个团圆的日子里，在座各位都远离亲人相聚在这里，为我酒店的建设与发展默默的奉献着，辛勤的耕耘着。此时此刻我心潮澎湃，为大家的这\r\n种以店为家的主人翁精神而深深感动着。同时更要感谢所有员工的家人，因为有了他们的理解，使得广大员工得以安心工作，因为有了他们的支持，使得欧美豪厅国\r\n际酒店得以持续健康的发展。在这里我向他们致以最真挚的节日问候和美好祝福，祝愿他们身体健康，心想事成!</p><p>\r\n	月是中秋明，情是中秋浓，在这象征收获、团圆和喜庆的日子里，让我们共同祝愿我们集团公司越来越强大，祝愿我们酒店越来越美好，祝愿我们的家人生活越来越幸福，祝愿我们的明天更加辉煌灿烂! 预祝今天的中秋晚会圆满成功!谢谢大家!</p><p><br/></p>',''),('853E00798E2243979FF114083DECED5F','asdawdasdadasdasdasdasdasdasdas','品牌介绍','2015-10-21','admin','<p>哈哈<br/></p>',''),('28B023B5FF03496FB87AE79E84723DE9','asdawdasdadasdasdasdasdasdasdas','发展历程','2015-10-21','admin','<p>哈哈<br/></p>','');

/*Table structure for table `classify` */

DROP TABLE IF EXISTS `classify`;

CREATE TABLE `classify` (
  `cId` varchar(50) NOT NULL,
  `cName` varchar(50) DEFAULT NULL,
  `pId` varchar(50) DEFAULT NULL,
  `cAddr` varchar(80) DEFAULT NULL,
  `isUse` tinyint(1) DEFAULT '0',
  `cDesc` varchar(80) DEFAULT NULL,
  UNIQUE KEY `mid` (`cId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `classify` */

insert  into `classify`(`cId`,`cName`,`pId`,`cAddr`,`isUse`,`cDesc`) values ('1','新闻中心',NULL,'',0,'新闻中心'),('2','产品中心',NULL,'',0,'产品中心'),('3','友情链接',NULL,NULL,0,'友情链接'),('396FAD8CDC434B6B88016E167A0D7288','专题报道','1','findNews',0,''),('3F98FE7F381B43EDBF6DCC1BA123BA98','技术支持','2','findP',0,''),('4','关于力天',NULL,'',0,'关于力天'),('40D28D4F46144BCD90BA1DE143C87705','物流贸易','2','findP',0,''),('7E328ED5868B423A8FDB6A4E325EA542','新闻资讯','1','findNews',0,''),('813753FA8A474DDF801C439F607332A4','主要产品','2','findP',0,''),('8B8A7481984D44C2A023638B3AE3F7D7','行业新闻','1','findNews',0,''),('8F1B9F926AA44EABB9ED968DD8D0DB6D','服务支持','2','findP',0,''),('asdawdasdadasdasdasdasdasdasdas','文章','4','',0,NULL);

/*Table structure for table `indexs` */

DROP TABLE IF EXISTS `indexs`;

CREATE TABLE `indexs` (
  `iId` varchar(40) DEFAULT NULL,
  `iName` varchar(50) DEFAULT NULL,
  `iValue` varchar(100) DEFAULT NULL,
  `isImage` varchar(200) DEFAULT NULL,
  `iLocation` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `indexs` */

insert  into `indexs`(`iId`,`iName`,`iValue`,`isImage`,`iLocation`) values ('12661106AB8D4C298B8CC4332EA1B645','矿石粉碎机','http://www.baidu.com','2','0'),('0C81E7783C754387BA79B3CEAF62204B','陕西省环保局','http://www.baidu.com','2','0'),('312EDC638DD54DD382663A12F06A7295','陕西省公路局','http://www.baidu.com','2','0'),('AE1777C129A7408E941175F1D0DFD9F4','销售热线','13319285512','0',NULL),('C758A6A0A37D4FF58A034C5E3FD30345','咨询电话','15891004444','0',NULL),('571CD6A64246429191EE5F1CD57FF507','地址','陕西省西安市户县渭丰镇真南村','0',NULL),('A75E53C98ABA4AAE830322D3A91F4503','邮编','710300','0',NULL),('88CA97EA147643AFA29BA000FF76B623','w','/LiTian/editor/jsp/upload/image/1462173956943pro1.jpg','1','1'),('5B1A836D9BA349E2B31A8660D4FAB231','d','/LiTian/editor/jsp/upload/image/1462173918902pro2.jpg','1','2'),('0F2165DF9CA54168A1ACB53F0ABD4466','f','/LiTian/editor/jsp/upload/image/1462173929186pro3.jpg','1','3'),('0359E0D8731048418EB2AAA19945BFA6','d','/LiTian/editor/jsp/upload/image/1462173893751pro4.jpg','1','4'),('85801E2DF2504717BCFF57507907245F','1','/LiTian/editor/jsp/upload/image/1462173842274banner1.jpg','3',NULL),('485D57A01DC847228A61B01E39D0A8FA','2','/LiTian/editor/jsp/upload/image/1462173849721banner2.jpg','3',NULL),('55988069EE50420392BA6F2597E6CAF8','3','/LiTian/editor/jsp/upload/image/1462173855475banner3.jpg','3',NULL);

/*Table structure for table `link` */

DROP TABLE IF EXISTS `link`;

CREATE TABLE `link` (
  `lId` varchar(40) DEFAULT NULL,
  `lName` varchar(20) DEFAULT NULL,
  `lAddr` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `link` */

insert  into `link`(`lId`,`lName`,`lAddr`) values ('1','edfs','fdsfs');

/*Table structure for table `news` */

DROP TABLE IF EXISTS `news`;

CREATE TABLE `news` (
  `nId` varchar(50) DEFAULT NULL,
  `nTheme` varchar(50) DEFAULT NULL,
  `nTime` varchar(50) DEFAULT NULL,
  `nEditor` varchar(50) DEFAULT NULL,
  `nType` varchar(50) DEFAULT NULL,
  `nSource` varchar(50) DEFAULT NULL,
  `nText` text,
  `nImage` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `news` */

insert  into `news`(`nId`,`nTheme`,`nTime`,`nEditor`,`nType`,`nSource`,`nText`,`nImage`) values ('AF4D4A52C04D4634B69B1FA3E6141444','中国工程机械企业再获南美认可','2015-10-21','admin','396FAD8CDC434B6B88016E167A0D7288','litian.com','<p>　5月，上海世邦机器有限公司在南美洲市场再次斩获一笔3000多万的订单，以世邦为代表的中国<a class=\"hotlinkmode\" href=\"http://www.cm.hc360.com/\" target=\"_blank\">工程机械</a>企业也再一次得到了南美洲市场的认可。</p><p>　　据悉，通过世邦机器上海总部和世邦南美洲分公司的齐力<a class=\"hotlinkmode\" href=\"http://sell.hc360.com/offer/A9C708654F1289EB.html\" target=\"_blank\">合作</a>，凭借着在当地的品牌认可度，仅耗时4个月世邦便与该客户签订了订单。<a class=\"hotlinkmode\" href=\"http://www.biz.hc360.com/\" target=\"_blank\">销售</a>人员介绍，世邦专业的产品配线设计和技术工程师提供的相关建议是赢得该名南美客户信任的关键。</p><p>　　自告别“黄金十年”后，产能过剩和内需不足让工程机械行业陷入困境，不少有实力的工程机械企业越发注重海外市场的开拓。随着东南亚市场的竞争日益激烈，非洲市场的需求逐渐饱和，南美洲市场无疑展现出了巨大机遇。</p><p>　　据悉，包括世界第六大经济体巴西在内的南美洲各国，近些年来一直保持着旺盛的基建需求，且南美洲矿藏丰富，市场潜力巨大。根据智利投资信息咨询\r\n机构近日报告，智利、秘鲁、哥伦比亚和巴西等南美四国在2012-2021年间将在基础设施领域投资5008亿美元，重点建设交通、市政设施、电信、饮用\r\n水和卫生设施、水利基础设施和城际公路等。对中国的工程机械企业来说这无疑是一个不可多得的机会。</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 作为第一批实行全球化战略的中国工程机械企业之一，世邦机器的产品70%都销往海外市场。据世邦国贸中心总监崔经理介绍，世邦早已敏锐的洞察南美洲工程机\r\n械市场的巨大潜力，通过近几年的发展耕耘，世邦南美洲分公司已初具规模。“南美洲分公司主要由巴西、秘鲁、哥伦比亚、智利四个办事处组成，全面辐射智利、\r\n阿根廷、巴西、秘鲁、墨西哥、委内瑞拉、乌拉圭等南美洲国家。目前，世邦在南美各个国家都拥有了一定数量的稳定客户源，且享有较高的品牌认可度。南美洲市\r\n场已成为世邦主要的中高端设备需求市场之一。”</p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img alt=\"logo.jpg\" src=\"/LiTian/editor/jsp/upload/image/20151021/1445441386558073340.jpg\" title=\"1445441386558073340.jpg\"/></p>','/LiTian/editor/jsp/upload/image/20151021/1445441386558073340.jpg,'),('AAF9E48A0560407DB1041C1E3C5406A0','中国工程机械企业再获南美认可','2015-10-21','admin','7E328ED5868B423A8FDB6A4E325EA542','litian.com','<p>s蒂法<br/></p>',''),('DF62FED8E3704FD4BEB8A3AB89434E93','中国工程机械企业再获南美认可','2015-10-21','admin','8B8A7481984D44C2A023638B3AE3F7D7','litian.com','<p>似的发射点发射点发生<br/></p>',''),('7E3C665F895F4C0A8CDA9C5DD549D93E','中国工程机械企业再获南美认可','2016-03-06','admin','396FAD8CDC434B6B88016E167A0D7288','litian.com','<p>中国工程机械企业再获南美认可</p>',''),('F38390E6B6924538ABD064B28959918A','中国工程机械企业再获南美认可','2016-03-06','admin','8B8A7481984D44C2A023638B3AE3F7D7','litian.com','<p>中国工程机械企业再获南美认可</p>',''),('5083382EAA9147DEA6E7285B1F393E5E','中国工程机械企业再获南美认可','2016-03-06','admin','7E328ED5868B423A8FDB6A4E325EA542','litian.com','<p>中国工程机械企业再获南美认可</p>',''),('0390127E297C48D49CB2BBCE522B8897','中国工程机械企业再获南美认可','2016-03-06','admin','396FAD8CDC434B6B88016E167A0D7288','litian.com','<p>中国工程机械企业再获南美认可</p>',''),('C1C91CCD437349DDB102A62AB666259E','中国工程机械企业再获南美认可','2016-03-06','admin','396FAD8CDC434B6B88016E167A0D7288','litian.com','<p>中国工程机械企业再获南美认可</p>',''),('07A8FD138C444FF4986459F7558836A9','中国工程机械企业再获南美认可','2016-03-06','admin','396FAD8CDC434B6B88016E167A0D7288','litian.com','<p>中国工程机械企业再获南美认可</p>',''),('A22FC56C1BC74636944FD9F07862D404','中国工程机械企业再获南美认可','2016-03-06','admin','7E328ED5868B423A8FDB6A4E325EA542','litian.com','<p>中国工程机械企业再获南美认可</p>',''),('44F4E4FA50944E218AF3D9A26FB95AC7','sdfasfdsaf','2016-05-18','admin','396FAD8CDC434B6B88016E167A0D7288','litian.com','<p>fdsafdsafd<br/></p>',''),('08B9958A7A654773978A196255CA1E19','safdsfasdsa','2016-05-24','admin','7E328ED5868B423A8FDB6A4E325EA542','litian.com','<p>fsdafdsaf<br/></p>',''),('9C6FB45A47F54BAF9F2812E350F9B21A','fdsafdsfsaf','2016-05-19','admin','8B8A7481984D44C2A023638B3AE3F7D7','litian.com','<p>fdsafdsaf<br/></p>',''),('545B2849DD0F40609B131E38C0BA2643','21311','2016-05-04','admin','396FAD8CDC434B6B88016E167A0D7288','litian.com','<p>32131231<br/></p>',''),('A88B41011CC34363B7A4875CBDB0EF5B','321313','2016-05-18','admin','396FAD8CDC434B6B88016E167A0D7288','litian.com','<p>32131321312<br/></p>',''),('88B2922D6DC94195B41CE400BD9AA175','231213','2016-05-04','admin','396FAD8CDC434B6B88016E167A0D7288','litian.com','<p>2313213<br/></p>','');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `pId` varchar(50) DEFAULT NULL,
  `pName` varchar(50) DEFAULT NULL,
  `pType` varchar(50) DEFAULT NULL,
  `pImage` varchar(200) DEFAULT NULL,
  `pText` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `products` */

insert  into `products`(`pId`,`pName`,`pType`,`pImage`,`pText`) values ('B155A4C2B22C4D12A85CD4103103F9FC','中国工程机械企业再获南美认可','3F98FE7F381B43EDBF6DCC1BA123BA98','/LiTian/editor/jsp/upload/image/20151021/1445441426244059982.jpg,','<p><img alt=\"pro3.jpg\" src=\"/LiTian/editor/jsp/upload/image/20151021/1445441426244059982.jpg\" title=\"1445441426244059982.jpg\"/>似的发射点发生<br/></p>'),('1667C8F4C79643CCB8C00B6221B4A305','我是物流贸易 倒计时','40D28D4F46144BCD90BA1DE143C87705','/LiTian/editor/jsp/upload/image/20151021/1445441450455087799.jpg,','<p>范德萨发<img alt=\"pro1.jpg\" src=\"/LiTian/editor/jsp/upload/image/20151021/1445441450455087799.jpg\" title=\"1445441450455087799.jpg\"/></p>'),('8C40CC0B06044214855659450014E0A4','打就覅就急急急急急急','813753FA8A474DDF801C439F607332A4','/LiTian/editor/jsp/upload/image/20151021/1445441477665095694.jpg,','<p>第三方<img alt=\"pro4.jpg\" src=\"/LiTian/editor/jsp/upload/image/20151021/1445441477665095694.jpg\" title=\"1445441477665095694.jpg\"/><br/></p>'),('26D9AF5A0B5B4EDB9183593116D82699','速度vsadvdsv','8F1B9F926AA44EABB9ED968DD8D0DB6D','/LiTian/editor/jsp/upload/image/20151021/1445441500505001672.jpg,','<p><img alt=\"pro3.jpg\" src=\"/LiTian/editor/jsp/upload/image/20151021/1445441500505001672.jpg\" title=\"1445441500505001672.jpg\"/></p>');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `uId` varchar(35) DEFAULT NULL,
  `isSuper` tinyint(1) DEFAULT NULL,
  `uName` varchar(20) DEFAULT NULL,
  `uPassword` varchar(50) DEFAULT NULL,
  `uTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`uId`,`isSuper`,`uName`,`uPassword`,`uTime`) values ('admin',2,'超级管理员','21232f297a57a5a743894a0e4a801fc3','2015-09-27 18:42:03');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
