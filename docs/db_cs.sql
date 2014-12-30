/**********************************************************************************
* File Name: db_linux.sql
*----------------------------------------------------------------------------------
* Created Date: 2014-05-28 20:42:37
* Created By:Jensyn
* Version: 1.0
*----------------------------------------------------------------------------------
* Modified Date:2014-06-07 15:20:22
* Modified By:Jensyn
* Version:1.1
***********************************************************************************/

-- --------------------------------------------------------------------------------
-- create the database if not exists
-- [linux_project] database name 
-- --------------------------------------------------------------------------------

-- DROP DATABASE IF EXISTS `cs_linux`;

-- CREATE DATABASE `cs_linux` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


use `cs_linux`;


-- --------------------------------------------------------------------------------
-- create user table
-- [cs_user] table name
-- --------------------------------------------------------------------------------
-- columns
-- [uid]        the unique identification of user, auto incrment, and start from 1001
-- [name]       user name not null, and unchanged
-- [permisson]  0: normal; 1:admin
-- [password]   user password
-- [sex]        unchanged
-- [phone]
-- [mail]
-- [qq]
-- [wechat]
-- [blog]
-- [github]
-- [native]     native place, birth place
-- [graduation] graduation year
-- [major]
-- [workplace]
-- [job]
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `cs_user`;

CREATE TABLE `cs_user` (
	uid         INT UNSIGNED  PRIMARY KEY AUTO_INCREMENT NOT NULL, 
	name        CHAR(10)  NOT NULL,
	permisson   INT(1)    NOT NULL DEFAULT 0,
	password    CHAR(32)  NOT NULL, 
	sex         INT(1)    NOT NULL, 
	phone       CHAR(20)  NULL UNIQUE, 
	mail        CHAR(50)  NOT NULL UNIQUE, 
	qq          CHAR(12)  NULL, 
	wechat      CHAR(32)  NULL,
	blog        CHAR(128) NULL, 
	github      CHAR(128) NULL, 
	native      CHAR(128) NULL, 
	grade       CHAR(4)   NOT NULL, 
	major       CHAR(32)  NOT NULL, 
	workplace   CHAR(128) NULL,
	job         CHAR(32)  NULL
) AUTO_INCREMENT=1001, DEFAULT CHARSET=utf8; 

-- --------------------------------------------------------------------------------
-- create cs_mail table
-- [cs_mail] table name
-- --------------------------------------------------------------------------------
-- columns
-- [mid]  identification
-- [fromuid] from uid
-- [sdate] Date
-- [title] title
-- [content] content
-- [isdraft] point to whether draft
-- [touid] json string,like {'uid' => 'status'}
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `cs_mail`;

CREATE TABLE `cs_mail` (
	mid     INT UNSIGNED  PRIMARY KEY AUTO_INCREMENT NOT NULL, 
	fromuid INT UNSIGNED  NOT NULL DEFAULT 1000,
	sdate   TIMESTAMP      NOT NULL DEFAULT now(),
	title   CHAR(64)      NOT NULL,
	content TEXT          NOT NULL,
	isdraft INT(1)		NOT NULL DEFAULT 0,
	touid	MEDIUMTEXT	NOT NULL
)AUTO_INCREMENT=1, DEFAULT CHARSET=utf8; 

-- --------------------------------------------------------------------------------
-- create app list table
-- [cs_app_list] table name
-- --------------------------------------------------------------------------------
-- columns
-- [appid] app id ,the key of app 
-- [name]  app name
-- [index_file]  app index file
-- [icon]  app icon number in iconfile
-- [status]  app status 0: not active; 1: activei
-- --------------------------------------------------------------------------------
DROP TABLE IF EXISTS `cs_app`;

CREATE TABLE `cs_app` (
	appid		INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	name    CHAR(32)		NOT NULL UNIQUE,
	status  INT(1)			NOT NULL DEFAULT 1,
	icon	INT				NOT NULL,		 
	index_file	CHAR(32)		NOT NULL		 
)AUTO_INCREMENT=1, DEFAULT CHARSET=utf8; 

-- --------------------------------------------------------------------------------
-- create user center message updata table
-- [cs_updata_info] table name
-- --------------------------------------------------------------------------------
-- columns
-- [mid] message id, the key of the table
-- [uid] id of user
-- [rdata] release time of the message
-- [app] name of app
-- [message] content of updata message
-- --------------------------------------------------------------------------------

DROP TABLE IF EXISTS `cs_updata_info`;

CREATE TABLE `cs_updata_info`(
	mid			INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
	uid			INT UNSIGNED	NOT NULL,
	appid		INT UNSIGNED	NOT NULL,
	rdate		TIMESTAMP		NOT NULL DEFAULT now(),
	mdescribe	VARCHAR(64)		NOT NULL,
	action		INT(1)			NOT NULL,
	message		VARCHAR(255)	NOT NULL,
	href		VARCHAR(128)	NOT NULL,
	INDEX		cs_user(uid),
	INDEX		cs_app(appid),
	FOREIGN KEY(uid) REFERENCES cs_user(uid) ON DELETE CASCADE,
	FOREIGN KEY(appid) REFERENCES cs_app(appid) ON DELETE CASCADE
)AUTO_INCREMENT=1,DEFAULT CHARSET=utf8;
