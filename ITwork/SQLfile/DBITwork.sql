create database DBitviec
GO

USE DBitviec
GO

create table account
(
username		varchar(30)		not null,
password		nvarchar(20)	not null,
fName			nvarchar(20)	not null,
lName			nvarchar(20),
gender			char, -- F or M
phonenumber		varchar(20)		not null ,
email			varchar(50)		not null ,
active			int				not null, -- 1:active	| 0:
timeCreated		DATETIME, --YYYY-MM-DD HH:MI:SS	
idCardNumber	int				not null ,
LastTimeLogin	datetime, --YYYY-MM-DD HH:MI:SS	

constraint LoginTime check (LastTimeLogin >= timeCreated),
primary key (username)
);

create table skill
(
ID				int 				identity(1,1),
--type			int					not null,	-- 0: account | 1: job
other			nvarchar(max),	

primary key (ID)
);


create table fieldwork
(
ID				int					identity(1,1),
title			nvarchar(100)		not null,

primary key(ID)
);

create table city
(
zipcode			int					primary key,
name			nvarchar(30)		not null
);


create table district
(
C_zipcode		int					not null,
D_zipcode		int					not null,
name			nvarchar(30)		not null,

primary key(C_zipcode, D_zipcode),
constraint FK_dis_city foreign key (C_zipcode) references city(zipcode)
	on delete cascade			on update cascade
);

create table service
(
ID				int					identity(1,1),
price			int					not null,
title			nvarchar(30)		not null,
description		nvarchar(max),

primary key (ID)
);

create table admin
(
username		varchar(30)			primary key,
adPermission	int,

constraint FK_adUsername foreign key(username) references account(username)
	on delete cascade		on update cascade
);

create table pro_language
(
ID				int					identity(1,1),
s_ID			int,
name			nvarchar(30),
experience		float,

primary key(ID),
constraint FK_sID_proLang foreign key (s_ID) references skill(ID)
	--on delete cascade on update cascade
);

create table language
(
ID				int					identity(1,1),
s_ID			int,
name			nvarchar(10),
score			float

primary key (id),
foreign key (s_ID) references skill(ID) 
);

create table diploma
(
s_ID		int,
diploma			nvarchar(200),

primary key (s_ID, diploma),
constraint FK_sID_dip foreign key (s_ID) references skill(ID)
	on delete cascade	on update cascade
);


create table candicate
(
username		varchar(30)		not null,
s_ID			int				not null,
decription		nvarchar(max),

primary key (username),
constraint FK_cand_acc foreign key (username) references account(username)
	on delete cascade	on update cascade, 
constraint FK_cand_skill foreign key (s_ID) references skill(ID) 
	on delete cascade	on update cascade
);

create table censor(
username		varchar(30)		not null	primary key,

constraint FK_cen_acc foreign key (username) references account(username)
	on delete cascade	on update cascade
);

create table companyManager
(
username		varchar(30)		not null	primary key,

constraint FK_comMan_acc foreign key (username) references account(username)
	on delete cascade	on update cascade
);

create table ManHasService
(
ser_ID			int				not null,
man_ID			varchar(30)		not null,

primary key (ser_ID, man_ID),
constraint FK_ManHasService foreign key (ser_ID) references service(ID)
	on delete cascade	on update cascade,
constraint FK_ManHasService_comMan foreign key (man_ID) references companyManager(username)
	on delete cascade	on update cascade
);

create table company
(
ID				int				identity(1,1),
man_username	varchar(30)		not null,
name			nvarchar(100),
description		nvarchar(max),
num_employee	int,
nation			nvarchar(30),
logo			varbinary(max),
cover_image		varbinary(max),
email			varchar(30),
fax				int,
phoneNumber		int,
linkPage		nvarchar(max),

primary key(ID),
constraint FK_com_Man foreign key (man_username) references companymanager
	on delete cascade	on update cascade
);

create table canHasFieldWork
(
can_ID			varchar(30),
fw_ID			int,

primary key (can_ID, fw_ID),
constraint FK_canHasFieldWork_can foreign key (can_ID) references candicate(username)
	on delete cascade	on update cascade,
constraint FK_canHasFieldWork_field foreign key (fw_ID) references fieldwork(ID)
	on delete cascade	on update cascade
);

create table ComHasFieldWork
(
com_ID			int,
fw_ID			int,

primary key (com_ID, fw_ID),
constraint FK_ComHasFieldWork_com foreign key (com_ID) references company(ID)
	on delete cascade	on update cascade,
constraint FK_ComHasFieldWork_field foreign key (fw_ID) references fieldwork(ID)
	on delete cascade	on update cascade
);

create table review
(
ID				int				identity(1,1),
can_username	varchar(30)		not null,
com_ID			int				not null,
rate			float,
content			nvarchar(max),

primary key (ID),
constraint rateRev check (rate >= 0 and rate <= 5),
constraint FK_review_can foreign key (can_username) references candicate(username)
	on delete cascade	on update cascade,
constraint FK_review_com foreign key (com_ID) references company(ID)
	--on delete cascade	on update cascade
);

-- ??
create table location
(
ID				int				identity(1,1),
username		varchar(30)	,
ID_company		int,
c_zipcode		int				not null,
d_zipcode		int				not null,
type			int,

primary key (ID),
constraint FK_loc_acc foreign key (username) references account(username)
	on delete cascade	on update cascade,
constraint FK_loc_com foreign key (ID_company) references company(ID),
	--on delete cascade	on update cascade,
constraint FK_loc_dis foreign key (c_zipcode, d_zipcode) references district(c_zipcode, d_zipcode)
	on delete cascade	on update cascade
);

create table present
(
username		varchar(30)			primary key,
man_username	varchar(30)			not null,
com_ID			int					not null,

constraint FK_pre_acc foreign key (username) references account(username)
	on delete cascade	on update cascade,
constraint FK_pre_comMan foreign key (man_username) references companyManager(username),
	--on delete cascade	on update cascade,
constraint FK_pre_com foreign key (com_ID) references company(ID)
	--on delete cascade	on update cascade
);

create table job
(
ID				int					identity(1,1),
cen_username	varchar(30)			not null,
pre_username	varchar(30)			not null,
com_ID			int					not null,
s_ID			int					not null,
fw_ID			int					not null,
title			nvarchar(100)		not null,
salary			int,
timepost		datetime			not null,
numberApplication int,
timework		float,
description		nvarchar(max),

primary key (ID),
constraint FK_job_cen foreign key (cen_username) references censor(username)
	on delete cascade	on update cascade,
constraint FK_job_pre foreign key (pre_username) references present(username),
	--on delete cascade	on update cascade,
constraint FK_job_com foreign key (com_ID) references company(ID),
	--on delete cascade	on update cascade,
constraint FK_job_skill foreign key (s_ID) references skill(ID)
	on delete cascade	on update cascade,
constraint FK_job_fw foreign key (fw_ID) references fieldwork(ID)
	on delete cascade	on update cascade,
);

create table can_apply_job
(
j_ID			int					primary key,
can_username	varchar(30)			not null,
time			datetime			not null,

constraint FK_canAppJob_job foreign key (j_ID) references job(ID)
	on delete cascade	on update cascade,
constraint FK_canAppJob_can foreign key (can_username) references candicate(username),
	--on delete cascade	on update cascade
);
GO

insert into account values ('ungvanduy','123', N'Duy', 'Ung', 'M', '0168749831', 'duy@gmail.com', 1, '2018-06-12 08:02:01', 21544123, '2018-06-12 09:02:01');
insert into account values ('phamthanhphat','123',N'Phat', 'Pham', 'M', '0906749831', 'phat@gmail.com', 1, '2018-05-22 18:02:01', 2144552, '2018-12-30 21:02:01');
insert into account values ('levinhchi','123','Chi', 'Le', 'M', '01221831', 'chi@gmail.com', 1, '2018-01-30 18:02:01', 2324412, '2018-05-30 12:02:01');
insert into account values ('hongocha','aaa',N'Hồ', N'Ngọc Hà', 'F', '012545831', 'nam@gmail.com', 1, '2018-05-30 18:02:01', 214442412, '2018-11-30 12:12:01');
insert into account values ('camly','baadbv', N'Ly', N'Cẩm', 'F', '01234539831', 'chiaa@gmail.com', 1, '2018-02-20 18:02:01', 212594312, '2018-02-28 11:02:01');
insert into account values ('quangle','123', N'Lê', N'Quang', 'M', '01237878831', 'cianh@gmail.com', 0, '2018-01-03 11:02:01', 218824898, '2018-01-28 08:02:01');
insert into account values ('lequyen','123abc', N'Quyên', N'Lệ', 'F', '012378831', 'doai@gmail.com', 1, '2018-01-10 18:03:01', 212213122, '2018-02-10 12:12:01');
insert into account values ('mytam','123111', N'Tâm', N'Mỹ', 'M', '012312831', 'dung@gmail.com', 0, '2018-05-30 12:02:01', 289889412, '2018-05-30 19:02:01');
insert into account values ('dongnhi','123123', N'Nhi', N'Đông', 'M', '01238779831', 'anhhi@gmail.com', 1, '2018-06-10 18:04:01', 213271132, '2018-06-30 07:02:01');
insert into account values ('bichphuong','123111', N'Phương', 'Bích', 'F', '012789831', 'lequyen@gmail.com', 0, '2018-05-30 18:01:01', 288891211, '2018-11-30 03:02:01');
insert into account values ('phuongthanh','1231311',N'Thanh', 'Phương', 'F', '0112569831', 'hongocha@gmail.com', 0, '2018-05-30 18:01:01', 71772412, '2018-09-30 22:02:01');
insert into account values ('damvinhhung','123','Hưng', 'Đàm Vĩnh', 'M', '01545749831', 'mytam@gmail.com', 1, '2018-05-21 18:02:01', 45452412, '2018-10-01 16:02:01');

insert into skill ( other) values ( N'Biết đi ca hát');
insert into skill ( other) values ( N'Có khả năng đọc hiểu tài liệu bằng tiếng Anh.');
insert into skill ( other) values ( N'Đam mê về IOT, AI, Big Data Technologies');
insert into skill ( other) values ( N'Biết linux là một lợi thế');
insert into skill ( other) values ( N'Có tư duy hệ thống, tư duy logic tốt, tiếp thu kiến thức mới nhanh, có khả năng đề xuất vấn đề và giải quyết vấn đề');
insert into skill ( other) values ( N'Nhanh nhẹn, tính tình vui vẻ, hòa đồng, chăm chỉ, ham học hỏi, có trách nhiệm trong công việc');
insert into skill ( other) values ( N'Biết IOT, AI, Big Data Technologies');
insert into skill ( other) values ( N'KHÔNG YÊU CẦU KINH NGHIỆM. Được đào tạo kỹ thuật để thích nghi tốt với công việc.');
insert into skill ( other) values ( N'Có khả năng đọc hiểu tài liệu bằng tiếng Anh.');
insert into skill ( other) values ( N'SINH VIÊN NĂM CUỐI.');

-- Phân vân công ty có nên có fieldwork không?

insert into fieldwork (title) values (N'Senior jQuery Developer');
insert into fieldwork (title) values (N'Senior Javascript Developer');
insert into fieldwork (title) values (N'PHP Web Developer');
insert into fieldwork (title) values (N'Sales Technical');
insert into fieldwork (title) values (N'BI Database Developer ');
insert into fieldwork (title) values (N'Mobile Apps Devs');
insert into fieldwork (title) values (N'Back-end Developer');
insert into fieldwork (title) values (N'.NET Developers');
insert into fieldwork (title) values (N'Senior Designer');
insert into fieldwork (title) values (N'Windows Phone Developer');
insert into fieldwork (title) values (N'Web Designer');
insert into fieldwork (title) values (N'Front End Web Developer');

insert into city values (2200, N'Hòa Bình');
insert into city values (1100, N'Quảng Nam');
insert into city values (8800, N'New York');
insert into city values (3300, N'Hồ Chí Minh');
insert into city values (2000, N'Đà Nẵng');
insert into city values (4500, N'Cần Thơ');
insert into city values (6000, N'Quảng Ninh');
insert into city values (9000, N'Tokyo');
insert into city values (2500, N'Hà Nội');

insert into district values (2200, 22100, N'Quận 1');
insert into district values (2500, 25100, N'Quận 1');
insert into district values (2500, 25200, N'Quận Đống Đa');
insert into district values (2500, 25300, N'Quận Hoàn Kiếm');
insert into district values (3300, 33300, N'Quận 1');
insert into district values (3300, 33100, N'Quận 10');
insert into district values (3300, 33200, N'Quận Thủ Đức');
insert into district values (3300, 33500, N'Quận 2');
insert into district values (2000, 20100, N'Quận 6');

insert into service (price, title, description) values (10, 'Standard', N'Tiếp cận bài đăng trong phạm vi 1.000 người trong phạm vi thành phố của bạn.');
insert into service (price, title, description) values (20, 'Pro', N'Tiếp cận bài đăng cho 10.000 người trong phạm vi thành phố của bạn.');
insert into service (price, title, description) values (100, 'Premium', N'Tiếp cận bài đăng cho tất cả mọi người trong phạm vi tất cả thành phố.');

insert into admin values ('phamthanhphat', 1);
insert into admin values ('levinhchi', 1);

-- DƯ THỪA DỮ LIỆU
insert into pro_language (s_ID, name, experience) values (1, N'C#', 1);
insert into pro_language (s_ID, name, experience) values (2, N'Python', 2);
insert into pro_language (s_ID, name, experience) values (4, N'Java', 4);
insert into pro_language (s_ID, name, experience) values (1, N'C++', 1);
insert into pro_language (s_ID, name, experience) values (5, N'Matlab', 0.5);
insert into pro_language (s_ID, name, experience) values (3, N'Java Script', 3);
insert into pro_language (s_ID, name, experience) values (3, N'Java Script', 3);
insert into pro_language (s_ID, name, experience) values (3, N'CSS', 1);

-- Dư thừa dữ liệu
insert into language (s_ID, name) values (1, N'English');
insert into language (s_ID, name) values (2, N'Japanese');
insert into language (s_ID, name) values (4, N'Korea');

insert into diploma values (1, N'Bằng Kỹ sư Khoa học máy tính, tốt nghiệp trường Đại học Bách Khoa Tp HCM');
insert into diploma values (2, N'Bằng Kỹ sư Kỹ thuật máy tính, tốt nghiệp trường Đại học Bách Khoa Tp HCM ');
insert into diploma values (5, N'Bằng Cử nhân Công nghệ thông tin, tốt nghiệp trường Công nghệ thông tin ');

insert into candicate values ('hongocha', 4, N'');
insert into candicate values ('quangle', 1, N'');
insert into candicate values ('mytam', 2, N'');
insert into candicate values ('dongnhi', 3, N'');

insert into censor values ('ungvanduy');

insert into companyManager values ('camly');
insert into companyManager values ('lequyen');

insert into ManHasService values (1, 'camly');
insert into ManHasService values (2, 'lequyen');

insert into company (man_username, name, num_employee, nation, email, phoneNumber) values ('camly',N'FPT Software', 1000, N'Việt Nam', 'fptsoftware@gmail.com', 0899848731);
insert into company (man_username, name, num_employee, nation, email, phoneNumber) values ('lequyen',N'Evolable Asia VietNam', 1000, N'Việt Nam', 'EvolableAsia@gmail.com', 089984872);

insert into canHasFieldWork values ('hongocha', 1);
insert into canHasFieldWork values ('quangle', 2);
insert into canHasFieldWork values ('mytam', 5);
insert into canHasFieldWork values ('dongnhi', 1);

insert into ComHasFieldWork values (1, 1);
insert into ComHasFieldWork values (1, 5);
insert into ComHasFieldWork values (2, 6);
insert into ComHasFieldWork values (1, 4);
insert into ComHasFieldWork values (2, 2);

insert into review(can_username, com_ID, rate, content) values ('hongocha', 1, 4.5, N'Chế độ phúc lợi tốt, anh em trong team đoàn kết. môi trường thoải mái');
insert into review(can_username, com_ID, rate, content) values ('hongocha', 2, 5, N'Thích hợp cho người mới ra trường')

insert into location(username, ID_company, c_zipcode, d_zipcode, type) values ('hongocha', NULL, 2000, 20100, 1);
insert into location(username, ID_company, c_zipcode, d_zipcode, type) values ('lequyen', NULL, 3300, 33500, 1);
insert into location(username, ID_company, c_zipcode, d_zipcode, type) values (NULL, 1, 2500, 25100, 1);
insert into location(username, ID_company, c_zipcode, d_zipcode, type) values (NULL, 2, 3300, 33100, 1)

insert into present values ('phuongthanh', 'lequyen', 2);
insert into present values ('damvinhhung', 'lequyen', 2);
insert into present values ('dongnhi', 'camly', 1)

insert into job (cen_username, pre_username, com_ID, s_ID, fw_ID, title, salary, timepost, numberApplication, description)
values ('ungvanduy', 'phuongthanh', 2, 4, 3, N'Web Designer (UI-UX, JavaScript)', 1000, '2018-10-01 16:02:01', 5, 
N'Discussing and developing new design concepts, graphics and layouts with Sales department
Web design for company official Websites/Ads/any other product for promotion/branding.
Developing company websites and landing page using HTML/CSS/Javascript.
Playing as UI/UX advisor in another projects');

insert into job (cen_username, pre_username, com_ID, s_ID, fw_ID, title, salary, timepost, numberApplication, description)
values ('ungvanduy', 'phuongthanh', 2, 4, 1, N'UI-UX Designer', 800, '2018-09-01 21:02:01', 5, 
N'Thiết kế giao diện website
Thiết kế các ấn phẩm quảng cáo trên kênh digital marketing (email, facebook, youtube…) như banner flash, email template,…
Thiết kế các ấn phẩm như backdrop, standee, banner cho các chương trình sự kiện, hội thảo, các buổi training của công ty;
Thực hiện các công việc khác theo yêu cầu của trưởng bộ phận.');

insert into job (cen_username, pre_username, com_ID, s_ID, fw_ID, title, salary, timepost, numberApplication, description)
values ('ungvanduy', 'damvinhhung', 2, 2, 2, N'iOS Developer (Swift, Objective C)', 2000, '2018-10-10 06:02:01', 1, 
N'- Tham gia xây dựng và phát triển các dự án phần mềm trên nền tảng iOS
- Lập trình, phát triển các phần mềm trên hệ điều hành ios theo yêu cầu
- Công việc sẽ được trao đổi cụ thể hơn trong quá trình phỏng vấn.');

insert into job (cen_username, pre_username, com_ID, s_ID, fw_ID, title, salary, timepost, numberApplication, description)
values ('ungvanduy', 'dongnhi', 1, 3, 2, N'Bảo Mật Thông Tin (Python, Database)', 1500, '2018-01-10 06:02:01', 5, 
N'- Đảm bảo an toàn, an ninh thông tin trong hoạt động sản xuất kinh doanh của Tập đoàn.
- Tham mưu, vận hành, quản trị và tổ chức, triển khai thực hiện các giải pháp đảm bảo an ninh, an toàn thông tin trong hệ thống CNTT&VT thuộc Tập đoàn và các công ty trực thuộc được giao, bao gồm: An ninh mạng, hệ thống bảo mật dữ liệu, hệ thống máy chủ, các ứng dụng CNTT, hệ thống Tổng đài điện thoại phục vụ hoạt động kinh doanh, điều hành sản xuất của Tập đoàn,…
- Xây dựng các quy trình, chính sách bảo mật cho hệ thống máu chủ, hệ thống ứng dụng và Cơ sở dữ liệu. Triển khai các chính sách bảo mật cho Tập đoàn và các công ty thành viên.
- Kiểm tra, đánh giá các lỗ hỏng bảo mật của hệ thống và lập phương án xử lý, vá lỗ hỏng bảo mật đã phát hiện
- Nghiên cứu, đánh giá giải pháp và xây dựng các hệ thống thống cho các dự án mới của Tập đoàn như: FLC Quảng Ninh, FLC Ngọc Vừng, FLC Đà Nẵng …
- Quản trị và vận hành hệ thống email Exchange Server 2016, DNS, Domain Controller, DHCP
- Triển khai, cấu hình các thiết bị bảo mật: Firewall, IDP, IPS, DdoS
- Đảm bảo kỹ thuật ở mức chuyên sâu trong việc quản lý, vận hành, giám sát và xử lý sự cố liên quan đến an toàn, bảo mật thông tin');

insert can_apply_job values (1, 'mytam', '2018-05-02 15:22:01')
insert can_apply_job values (3, 'quangle', '2018-11-02 22:22:12')
GO

--Procedure

CREATE PROC joinTableTest
AS
BEGIN
	SELECT *
	FROM dbo.job
	INNER JOIN dbo.company ON dbo.job.com_ID = dbo.company.ID
END
GO
CREATE PROC logInUser
	@username nvarchar(100),
	@password NVARCHAR(100)
AS
BEGIN
	DECLARE @row INT
	SET @row = 0
	SET @row =  (SELECT COUNT(*) FROM dbo.account WHERE @username = username AND @password = password)
	
	--SELECT @@ROWCOUNT
	IF(@row != 0)
	BEGIN
		SELECT 1

		UPDATE dbo.account
		SET LastTimeLogin = CAST(GETDATE() AS  DATETIME)
		WHERE @username = username
	END
	ELSE SELECT 0
END
GO
CREATE PROC findJobAndLocation
	@job NVARCHAR(100),
	@company NVARCHAR(100),
	@location NVARCHAR(100)
AS
BEGIN
	SELECT title, company.name, job.description, city.name
	FROM dbo.company
	INNER JOIN dbo.location ON	company.ID=ID_company
	INNER JOIN dbo.job ON company.ID = job.com_ID
	INNER JOIN dbo.city ON c_zipcode = zipcode
	WHERE title LIKE '%' + @job + '%' AND company.name LIKE '%' + @company + '%' AND city.name LIKE '%' + @location + '%'
END
GO

insert into account values ('phthasdfasdphat','123456',N'Phat', 'Pham', 'M', '0906749831', 'phat@gmail.com', 1, '2017-05-22 18:02:01', 2144552, '2018-12-30 21:02:01');