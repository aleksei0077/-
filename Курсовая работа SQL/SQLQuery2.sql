-- �������� ������� � �����������
CREATE TABLE Company (
 ID_company INT PRIMARY KEY,
 c_Name VARCHAR(50),
 Contact_Address VARCHAR(255),
 Phone VARCHAR(15)
);

-- �������� ������� � ��������
CREATE TABLE Video (
 ID_video INT PRIMARY KEY,
 v_Name VARCHAR(50),
 Company_ID INT,
 Duration INT, -- ������������ ������ � ��������
 FOREIGN KEY (Company_ID) REFERENCES Company(ID_company)
);

-- �������� ������� � ������������
CREATE TABLE Advertisment (
 ID_adv INT PRIMARY KEY,
 Company_ID INT,
 Word_Count INT,
 Content VARCHAR(255),
 FOREIGN KEY (Company_ID) REFERENCES Company(ID_company)
);

--�������� ������� � ��������
CREATE TABLE Channel (
 ID_channel INT PRIMARY KEY,
 ch_Name VARCHAR(50)
);

--�������� ������� � ������� ��������
CREATE TABLE Broadcast_Time (
 ID_time INT PRIMARY KEY,
 t_Name VARCHAR(50)
);

-- �������� ������� � �������� ���
--CREATE TABLE Television_Period (
-- ID INT PRIMARY KEY,
-- tp_Name VARCHAR(50)
--);

-- �������� ������� ����� ������
CREATE TABLE Video_Show (
 id_show INT PRIMARY KEY,
 id_video INT,
 
 id_channel INT,
 
 video_duration INT,
 price_per_minute INT,
 broadcast_time INT,
 
 video_show_count INT,

 FOREIGN KEY (id_channel) REFERENCES Channel(ID_channel),
 FOREIGN KEY (broadcast_time) REFERENCES Broadcast_Time(ID_time)
);



--alter table Video_show add constraint number1 
--foreign key (id_video, video_duration) references Video(ID_video, Duration);


-- �������� ������� ����� ����������
CREATE TABLE Advertisment_Show (
 id_show INT PRIMARY KEY,
 id_adv INT,
 id_channel INT,
 FOREIGN KEY (id_channel) REFERENCES Channel(ID_channel),
 price_per_word INT,
 word_count INT,
 adv_show_count INT
);

--alter table Video_show add constraint number1 
--foreign key (id_adv, word_count) references Video(ID_adv, Word_Count);

-- ���������� ������� � �����������
INSERT INTO Company (ID_company, c_Name, Contact_Address, Phone)
VALUES 
(1, 'Company1', '��. ������, 55', '1234567890'),
(2, 'Company2', '��. ������, 22', '0987654321'),
(3, 'Company3', '��. �������, 11', '1122334455'),
(4, 'Company4', '��. �������, 44', '5544433221');

insert into video (ID_video, v_Name, Company_ID, Duration)
values
(1, 'video1', 1, 25),
(2, 'video2', 1, 30),
(3, 'video3', 2, 35),
(4, 'video4', 3, 60),
(5, 'video5', 1, 75),
(6, 'video6', 2, 90),
(7, 'video7', 4, 40),
(8, 'video8', 4, 50),
(9, 'video9', 2, 100),
(10, 'video10', 3, 150);

insert into Advertisment (ID_adv, Company_ID, Word_Count, Content)
values
(1, 1, 25, '������� ����������'),
(2, 2, 45, '������� ����'),
(3, 3, 47, '������� ��������'),
(4, 1, 50, '������� ���������� �������'),
(5, 4, 60, '������� �����'),
(6, 3, 105, '������� ��������'),
(7, 4, 120, '����������� �� ������'),
(8, 1, 150, '������� ������������ ������������');

insert into Channel (ID_channel, ch_Name)
values
(1, 'Channel1'),
(2, 'Channel2'),
(3, 'Channel3'),
(4, 'Channel4');

insert into Broadcast_Time (ID_time, t_Name)
values
(1, 'Weather'),
(2, 'News'),
(3, 'Day'),
(4, 'Morning'),
(5, 'Night'),
(6, 'PrimeTime');

insert into Video_Show (id_show, id_video, id_channel, price_per_minute, video_duration, broadcast_time, video_show_count)
values
(1, 1, 2, 15000, 25, 1, 6),
(2, 3, 1, 14000, 35, 6, 5),
(3, 7, 4, 22000, 40, 3, 1),
(4, 5, 3, 23000, 75, 6, 6),
(5, 9, 2, 17500, 100, 6, 2),
(6, 2, 1, 11000, 30, 2, 1),
(7, 8, 4, 20000, 50, 3, 4),
(8, 6, 3, 24000, 90, 5, 3),
(9, 10, 1, 13000, 150, 4, 5),
(10, 4, 2, 17500, 60, 6, 2),
(11, 1, 3, 21000, 25, 2, 1),
(12, 3, 2, 15000, 35, 1, 4),
(13, 2, 4, 19000, 30, 2, 3),
(14, 4, 1, 13000, 60, 4, 5),
(15, 6, 3, 24000, 90, 5, 2);



insert into Advertisment_Show (id_show, id_adv, id_channel, word_count, price_per_word, adv_show_count)
values
(1, 1, 2, 25, 20, 4),
(2, 3, 1, 47, 25, 3),
(3, 5, 4, 60, 40, 5),
(4, 7, 3, 120, 30, 2),
(5, 2, 2, 45, 20, 4),
(6, 4, 1, 50, 25, 3),
(7, 6, 3, 105, 30, 5),
(8, 8, 4, 150, 40, 2),
(9, 1, 1, 25, 25, 1),
(10, 3, 2, 47, 20, 3);





--1 �� ����� ������ �������� ��������� ��������� ������ � �����-����? 
SELECT ch.ch_Name, avg(vs.price_per_minute * vs.video_duration / 60) as �������_���������
FROM Video_Show vs
JOIN Channel ch ON ch.id_channel = vs.id_channel
JOIN Broadcast_Time bt ON bt.ID_time = vs.broadcast_time
WHERE vs.broadcast_time = 6
GROUP BY ch.ch_Name
ORDER BY �������_��������� ASC;

--2 ��� ���� � ����� ���������� ������������ ����������?  
SELECT ch.ch_Name , sum(ads.adv_show_count) AS ����������_����������
FROM Advertisment_Show ads
JOIN Channel ch ON ch.ID_channel = ads.id_channel
GROUP BY ch.ch_Name
ORDER BY ����������_���������� DESC;
 
-- � ��� �������?
SELECT ch.ch_Name, avg(ads.price_per_word * ads.word_count * ads.adv_show_count)
as �������_����_����������
FROM Advertisment_Show ads
JOIN Channel ch ON ch.id_channel = ads.id_channel
GROUP BY ch.ch_Name
ORDER BY �������_����_���������� ASC;

--3 �� ����� ����� ����� ��������� ������������ ���������� �� ����� �? 
SELECT SUM(ads.price_per_word * ads.word_count * ads.adv_show_count) as �����
FROM Advertisment_Show ads
JOIN Channel CH ON ch.ID_channel = ads.id_channel
JOIN Advertisment adv ON ads.id_adv = adv.ID_adv
JOIN Company c ON c.ID_company = adv.Company_ID
where c.c_Name = 'Company2'
GROUP BY ch.ch_Name;


--4 ������ ��������� ������ ���������� ������ � � ������ ����� ����� �� ������ �� ��������� ���������� �������? 
SELECT c.c_Name, ch.ch_Name, bt.t_Name, (vs.price_per_minute * vs.video_duration / 60)  AS ���������_������
FROM Video_Show vs
JOIN Company c ON vs.id_video = c.ID_company
JOIN Channel ch ON vs.id_channel = ch.ID_channel
JOIN Broadcast_Time bt ON vs.broadcast_time = bt.ID_time
WHERE vs.id_video = 1;

--5 ����� ������� ���� ����� ������ ���������� ������� �� ������ �� �������? �������� ���������� � ������� �������� ������� ����. 
SELECT ch.ch_Name, AVG(vs.price_per_minute) AS �������_����_��_������
FROM Video_Show vs
JOIN Channel ch ON vs.id_channel = ch.ID_channel
GROUP BY ch.ch_Name
ORDER BY �������_����_��_������ DESC;

--6 ������ ����� ��������� ���������� ������ � �� ���������� �������? 
SELECT v.v_Name as �����, c.ch_Name as �����, 
(vs.price_per_minute * vs.video_duration / 60) as �����_���������
FROM Video v
JOIN Video_Show vs ON v.ID_video = vs.id_video
JOIN Channel c ON vs.id_channel = c.ID_channel
WHERE v.v_Name = 'video4'

--7 ������� ���������� ���� ��������� ������ �� ����?
SELECT c.c_Name, COUNT(a.ID_adv) as �����_����������
FROM Company c
JOIN Advertisment a ON c.ID_company = a.Company_ID
GROUP BY c.c_Name;