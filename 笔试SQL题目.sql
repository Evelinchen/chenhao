（1）表名：购物信息
购物人      商品名称     数量
A            甲          2
B            乙          4
C            丙          1
A            丁          2
B            丙          5
……
 
给出所有购入商品为两种或两种以上的购物人记录
 
答：select * from 购物信息 where 购物人 in (select 购物人 from 购物信息 group by 购物人 having count(*) >= 2);
 
（2）表名：成绩表
姓名   课程       分数
张三     语文       81
张三     数学       75
李四     语文       56
李四     数学       90
王五     语文       81
王五     数学       100
王五     英语       49
 
 
给出成绩全部合格的学生信息（包含姓名、课程、分数），注：分数在60以上评为合格
 
答：select * from 成绩表 where 姓名 not in (select distinct 姓名 from 成绩表 where 分数 < 60)
或者：
select * from 成绩表 where 姓名 in (select 姓名 from 成绩表 group by 姓名 having min(分数) >=60)
 
 
（3）表名：商品表
名称   产地             进价
苹果   烟台                2.5
苹果   云南                1.9
苹果   四川                3
西瓜   江西                1.5
西瓜   北京                2.4
……
 
给出平均进价在2元以下的商品名称
 
答：select 名称 from 商品表 group by 名称 having avg(进价) < 2
 
（4）表名：高考信息表
准考证号   科目       成绩
2006001     语文       119
2006001     数学       108
2006002     物理       142
2006001     化学       136
2006001     物理       127
2006002     数学       149
2006002     英语       110
2006002            语文       105
2006001            英语        98
2006002     化学       129
……
 
给出高考总分在600以上的学生准考证号
 
答：select 准考证号 from 高考信息表 group by 准考证号 having sum(成绩) > 600
 
（5）表名：高考信息表
准考证号        数学        语文        英语        物理        化学
2006001                108         119         98        127         136
2006002                149         105        110        142         129
……
 
给出高考总分在600以上的学生准考证号
 
答：select 准考证号 from 高考信息表 where (数学+语文+英语+物理+化学) > 600
 
 
 
(四部分)
（一）表名：club
 
id gender age
67 M      19
68 F      30
69 F      27
70 F      16
71 M      32
……
 
查询出该俱乐部里男性会员和女性会员的总数
 
答：select gender,count(id) from club group by gender
 
（二）表名：team
ID(number型) Name(varchar2型)
1                  a
2                  b
3                  b
4                  a
5                  c
6                  c
要求:执行一个删除语句，当Name列上有相同时,只保留ID这列上值小的
例如：删除后的结果应如下:
ID(number型) Name(varchar2型)
1                  a
2                  b
5                  c
请写出SQL语句。
 
delete from team where id not in (select min(id) from team group by name)
 
（三）表名：student
 
name course score
张青 语文     72
王华 数学     72
张华 英语     81
张青 物理     67
李立 化学     98
张燕 物理     70
张青 化学     76
 
查询出“张”姓学生中平均成绩大于75分的学生信息
 
答：select * from student where name in (select name from student
where name like '张%' group by name having avg(score) > 75)
 
 
 
1.一道SQL语句面试题，关于group by表内容：
 
info 表
 
date result
 
2005-05-09 win
 
2005-05-09 lose
 
2005-05-09 lose
 
2005-05-09 lose
 
2005-05-10 win
 
2005-05-10 lose
 
2005-05-10 lose
 
如果要生成下列结果, 该如何写sql语句?
 
   　　         win lose
 
2005-05-09 2 2
 
2005-05-10 1 2
 
答案：
 
(1) select date, sum(case when result = "win" then 1 else 0 end) as "win", sum(case when result = "lose" then 1 else 0 end) as "lose" from info group by date;
 
(2) select a.date, a.result as win, b.result as lose
 
　　from
 
　　(select date, count(result) as result from info where result = "win" group by date) as a
 
　　join
 
　　(select date, count(result) as result from info where result = "lose" group by date) as b
 
　　on a.date = b.date;
 
 
 
2.表中有A B C三列,用SQL语句实现：当A列大于B列时选择A列否则选择B列，当B列大于C列时选择B列否则选择C列
 
select (case when a > b then a else b end), (case when b > c then b else c end) from table;
 
3.请取出tb_send表中日期(SendTime字段)为当天的所有记录? (SendTime字段为datetime型，包含日期与时间)
 
select * from tb where datediff(dd,SendTime,getdate())=0
 
4.有一张表，里面有3个字段：chinese，math，english。其中有一条记录chinese 70分，math 80分，english 58分，请用一条sql语句查询出所有记录并按以下条件显示出来（并写出您的思路）： 
 
   大于或等于80表示excellent，大于或等于60表示pass，小于60分表示fail。 
 
       显示格式： 以上面的chinese 70分，math 80分，english 58分
 
       chinese              math                english 
 
       pass                  excellent           fail
 
 
 
select (case when chinese >= 80 then "excellent" when chinese >= 60 then "pass" else "fail" end) as chinese,
 
　　(case when math >= 80 then "excellent" when math >= 60 then "pass" else "fail" end) as math,
 
　　(case when english >= 80 then "excellent" when english >= 60 then "pass" else "fail" end) as english
 
　　from grade;
 
 
 
5.请用一个sql语句得出结果
 
从table1,table2中取出如table3所列格式数据，注意提供的数据及结果不准确，只是作为一个格式向大家请教。
 
如使用存储过程也可以。
 
table1
 
月份mon 部门dep 业绩yj
 
-------------------------------
 
一月份      01      10
 
一月份      02      10
 
一月份      03      5
 
二月份      02      8
 
二月份      04      9
 
三月份      03      8
 
 
 
table2
 
部门dep      部门名称dname
 
--------------------------------
 
      01      国内业务一部
 
      02      国内业务二部
 
      03      国内业务三部
 
      04      国际业务部
 
table3 （result）
 
部门dep 一月份      二月份      三月份
 
--------------------------------------
 
      01      10        null      null
 
      02      10         8        null
 
      03      null       5        8
 
      04      null      null      9
 
------------------------------------------
 
select t1.dep,
 
sum(case when mon = 1 then yj else 0 end) as jun,
 
sum(case when mon = 2 then yj else 0 end) as feb,
 
sum(case when mon = 3 then yj else 0 end) as mar
 
from
 
t1 right join t2 on t1.dep = t2.dep
 
group by t1.dep;
 
题目一、
有两个表：
 
TableX有三个字段Code、 Name、 Age、 其中Code为主键；
TableY有三个字段Code、 Class、Score, 其中Code + Class 为主键。两表记录如下：
 
Code Name Age Code Class Score
97001 张三 22 97001 数学 80
97002 赵四 21 97002 计算机 59
97003 张飞 20 97003 计算机 60
97004 李五 22 97004 数学 55
 
 
1、请写出SQL，找出所有姓张的学生，并按年龄从小到大排列；
 
 
2、请写出SQL，取出计算机科考成绩不及格的学生；
 
 
3、通过等值联接，取出Name、Class、Score，请写出SQL即输出结果
 
 
4、通过外联接，取出每个学生的Name、Class、Score、请写SQL输出结果
 
 
5、请写SQL，在TableX 表中增加一条学生记录(学号：97005 姓名：赵六 年龄：20)；
 
 
6、李五的年龄记录错了，应该是21，请写SQL，根据主键进行更新；
 
 
7、请写SQL，删除TableX中没有考试成绩的学生记录，请使用not in条件；
 
 
题目二、
有两个表定义如下：
create tableindividual (
firstname  varchar2(20) not null
lastname    vatchar2(20) not null
birthdate  date
gender      varchar2(1)
initial    number(2)
farorite    varchar2(6)
type        varchar2(8)
);
 
在此表中建唯一索引 firstname + lastname
 
create table chile_detail(
firstname  varchar2(20)
lastname    varchar2(20)
cname      varchar2(8)
coment      varchar2(2)
type        varchar2(8)
);
 
 
1、写一个简单的SQL语句实现：删除表individual中一条出生日期（brithdate）为 1990年10月2日 出生的人的记录
 
2、写一修改语句实现： 将表child_detail 中的type 为 “kkd” 的记录的Cname 值为“declear”，coment的值为“02”
TableX有三个字段Code、 Name、 Age、 其中Code为主键；
TableY有三个字段Code、 Class、Score, 其中Code + Class 为主键。两表记录如下：
 
Code Name Age Code Class Score
97001 张三 22 97001 数学 80
97002 赵四 21 97002 计算机 59
97003 张飞 20 97003 计算机 60
97004 李五 22 97004 数学 55
 
 
1、请写出SQL，找出所有姓张的学生，并按年龄从小到大排列；
select * from TableX where name like '张%' order by age
 
2、请写出SQL，取出计算机科考成绩不及格的学生；
select * from tableX where code in (select code from tableY WEHRE class='计算机' and score <60)
 
3、通过等值联接，取出Name、Class、Score，请写出SQL即输出结果
select a.name,b.class,b.score from tableX a,tableY b where a.code=b.code 
 
4、通过外联接，取出每个学生的Name、Class、Score、请写SQL输出结果
select a.name,b.class,b.score from tableX full join tableY on a.code=b.code
 
5、请写SQL，在TableX 表中增加一条学生记录(学号：97005 姓名：赵六 年龄：20)；
insert into tablex values('97005','赵六',20)
 
 
6、李五的年龄记录错了，应该是21，请写SQL，根据主键进行更新；
update tablex set age=21 where code='97004'
 
7、请写SQL，删除TableX中没有考试成绩的学生记录，请使用not in条件；
delete tablex where code not in (select code from tabley)
 
DELETE TABLEX WHERE CODE IN (
SELECT CODE FROM TABLEX WHERE CODE NOT IN(SELECT Y.CODE FROM TABLEY))
但看了其它人的写法,感觉自己写的不简洁,学习一下.
 
1、请写出SQL，找出所有姓张的学生，并按年龄从小到大排列；
SELECT * FROM TableX WHERE Name LIKE '张%' ORDER BY Age;
 
 
2、请写出SQL，取出计算机科考成绩不及格的学生；
SELECT * FROM TableX x, TableY y WHERE x.Code = y.Code AND Class = '计算机' AND Score < 60;
 
 
3、通过等值联接，取出Name、Class、Score，请写出SQL即输出结果
SELECT x.Name, y.Class, y.Score FROM TableX x, TableY y WHERE x.Code = y.Code
 
 
4、通过外联接，取出每个学生的Name、Class、Score、请写SQL输出结果
Left Out:SELECT x.Name, y.Class, y.Score FROM TableX x, TableY y WHERE x.Code = y.Code(+)
Right Out: SELECT x.Name, y.Class, y.Score FROM TableX x, TableY y WHERE x.Code(+) = y.Code
Full Out:Left join union all right join
 
 
5、请写SQL，在TableX 表中增加一条学生记录(学号：97005 姓名：赵六 年龄：20)；
INSERT INTO TableX(Code, Name, Age) VALUES('97005','赵六',20);
COMMIT;
 
6、李五的年龄记录错了，应该是21，请写SQL，根据主键进行更新；
UPDATE TableX SET Age = 21 WHERE Code in (SELECT Code FROM TableX WHERE Name = '李五')
 
 
7、请写SQL，删除TableX中没有考试成绩的学生记录，请使用not in条件；
DELETE FROM TableX WHERE Code Not in (SELECT Code FROM TableY WHERE NVL(Score,0) = 0)
 
 
在此表中建唯一索引 firstname + lastname
CREATE UNIQUE INDEX NAME_UNINDEX ON individual(firstname,lastname)
 
 
1、写一个简单的SQL语句实现：删除表individual中一条出生日期（brithdate）为 1990年10月2日 出生的人的记录
DELETE FROM individual WHERE TO_CHAR(birthdate,'YYYY-MM-DD') = '1990-10-02';
COMMIT;
 
2、写一修改语句实现： 将表child_detail 中的type 为 “kkd” 的记录的Cname 值为“declear”，coment的值为“02”
UPDATE chile_detail SET Cname = 'declear', coment = '02'
WHERE type = 'kkd';
COMMIT;
 
 
 
 
http://www.51testing.com/?uid-165528-action-viewspace-itemid-99563
 
http://www.cnblogs.com/zemliu/archive/2012/10/09/2717629.html
http://bbs.csdn.NET/topics/270058476
