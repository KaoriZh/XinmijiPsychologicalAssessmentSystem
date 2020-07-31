/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 8.0.16 : Database - xinmiji
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`xinmiji` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `xinmiji`;

/*Table structure for table `answers` */

DROP TABLE IF EXISTS `answers`;

CREATE TABLE `answers` (
  `qid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  PRIMARY KEY (`qid`,`uid`),
  KEY `uid` (`uid`),
  CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`qid`) REFERENCES `questions` (`qid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `answers_ibfk_2` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `answers` */

insert  into `answers`(`qid`,`uid`,`score`) values 
(14,4,4),
(15,4,4),
(16,4,4),
(17,4,0),
(18,5,3),
(18,6,1),
(18,7,4),
(19,5,3),
(19,6,4),
(19,7,4),
(20,5,2),
(20,6,0),
(20,7,4),
(21,4,2),
(22,4,1),
(23,4,2),
(24,4,2);

/*Table structure for table `articles` */

DROP TABLE IF EXISTS `articles`;

CREATE TABLE `articles` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `text` varchar(4096) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

/*Data for the table `articles` */

insert  into `articles`(`nid`,`title`,`text`) values 
(19,'这是专栏标题','这是专栏正文\n这是专栏正文'),
(21,'鹿乃','鹿乃是niconico动画和bilibili上活跃的萌系女性唱见。\n鹿乃最早是niconico动画上的一位萌系女性唱见，起初因为声线很可爱而且日语发音不太标准而被观众猜测是刚学会日语不久的天朝人。\n鹿乃在翻唱的同时也有大量的原创歌曲。\n在FM-FUJI上做著个人广播节目『鹿乃のばんび～のラジオ』\n鹿乃同时也是洛天依V4日文声库的提供声源者之一，在B站也有投稿鹿乃自己作词作曲由洛天依演唱的歌曲，'),
(22,'title','text');

/*Table structure for table `conclusions` */

DROP TABLE IF EXISTS `conclusions`;

CREATE TABLE `conclusions` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `qnid` int(11) NOT NULL,
  `min` int(11) NOT NULL,
  `max` int(11) NOT NULL,
  `text` varchar(4096) NOT NULL,
  PRIMARY KEY (`cid`,`qnid`),
  KEY `qnid` (`qnid`),
  CONSTRAINT `conclusions_ibfk_1` FOREIGN KEY (`qnid`) REFERENCES `questionnaires` (`qnid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `conclusions` */

insert  into `conclusions`(`cid`,`qnid`,`min`,`max`,`text`) values 
(10,14,0,5,'结论是0到5分'),
(11,14,6,10,'结论是6到10分'),
(12,16,9,16,'你就是DD! DD斩首!'),
(13,16,0,7,'狗妈/鹿乃的单推人, 爷爱辽'),
(14,17,13,24,'>12'),
(15,17,0,11,'<12');

/*Table structure for table `questionnaires` */

DROP TABLE IF EXISTS `questionnaires`;

CREATE TABLE `questionnaires` (
  `qnid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `abstract` varchar(4096) NOT NULL,
  `def_conclusion` varchar(4096) NOT NULL,
  PRIMARY KEY (`qnid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Data for the table `questionnaires` */

insert  into `questionnaires`(`qnid`,`title`,`abstract`,`def_conclusion`) values 
(14,'测试测评1','这里是简介','系统出错了!'),
(15,'测试测评2','这里是简介','没有结论'),
(16,'测测你是DD还是单推人','DD斩首!','纯路人, 我不认识鹿乃和狗妈'),
(17,'ttile','abs','=12');

/*Table structure for table `questions` */

DROP TABLE IF EXISTS `questions`;

CREATE TABLE `questions` (
  `qid` int(11) NOT NULL AUTO_INCREMENT,
  `qnid` int(11) NOT NULL,
  `text` varchar(4096) NOT NULL,
  `power` int(11) NOT NULL,
  PRIMARY KEY (`qid`),
  KEY `qnid` (`qnid`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`qnid`) REFERENCES `questionnaires` (`qnid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `questions` */

insert  into `questions`(`qid`,`qnid`,`text`,`power`) values 
(14,14,'第一道问题',1),
(15,14,'第二道问题',1),
(16,15,'问题1',1),
(17,15,'问题2',2),
(18,16,'单推狗妈好不好呀',1),
(19,16,'单推鹿乃好不好呀',1),
(20,16,'狗妈和鹿乃贴贴好不好呀',2),
(21,17,'q1',2),
(22,17,'q2',1),
(23,17,'q33',2),
(24,17,'q4',1);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `psw` char(20) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `users` */

insert  into `users`(`uid`,`name`,`psw`,`is_admin`) values 
(1,'Name','Psw',0),
(2,'TestName','TestPsw',1),
(4,'admin','123',1),
(5,'shang','123',0),
(6,'鹿乃会发光','123',1),
(7,'鹿乃狗妈贴贴','123',1),
(8,'虾','123',0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
