--to simulate ORA-01000: maximum open cursors exceeded
--create 100 tables from script createMultipleTablesInLoop.sql
--Step1: set max cursors on 50 on test environment to quick reach maximum open cursors exeeded 
--alter system set open_cursors = 50;
--Step2: loop without closing the cursors
--open 50 cursors without closing (execute part1 till part5) 

--part1: open 10 from 50
--1
declare
  cursor mycurr1 is
  select  USERNAME from hr.my_table1;
  v_name1 varchar2(100);
begin
open mycurr1;
loop
   fetch mycurr1 into v_name1;
   exit when mycurr1%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--2
declare
  cursor mycurr2 is
  select  USERNAME from hr.my_table2;
  v_name1 varchar2(100);
begin
open mycurr2;
loop
   fetch mycurr2 into v_name1;
   exit when mycurr2%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--3
declare
  cursor mycurr3 is
  select  USERNAME from hr.my_table3;
  v_name1 varchar2(100);
begin
open mycurr3;
loop
   fetch mycurr3 into v_name1;
   exit when mycurr3%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--4
declare
  cursor mycurr4 is
  select  USERNAME from hr.my_table4;
  v_name1 varchar2(100);
begin
open mycurr4;
loop
   fetch mycurr4 into v_name1;
   exit when mycurr4%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--5
declare
  cursor mycurr5 is
  select  USERNAME from hr.my_table5;
  v_name1 varchar2(100);
begin
open mycurr5;
loop
   fetch mycurr5 into v_name1;
   exit when mycurr5%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--6
declare
  cursor mycurr6 is
  select  USERNAME from hr.my_table6;
  v_name1 varchar2(100);
begin
open mycurr6;
loop
   fetch mycurr6 into v_name1;
   exit when mycurr6%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--7
declare
  cursor mycurr7 is
  select  USERNAME from hr.my_table7;
  v_name1 varchar2(100);
begin
open mycurr7;
loop
   fetch mycurr7 into v_name1;
   exit when mycurr7%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--8
declare
  cursor mycurr8 is
  select  USERNAME from hr.my_table8;
  v_name1 varchar2(100);
begin
open mycurr8;
loop
   fetch mycurr8 into v_name1;
   exit when mycurr8%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--9
declare
  cursor mycurr9 is
  select  USERNAME from hr.my_table9;
  v_name1 varchar2(100);
begin
open mycurr9;
loop
   fetch mycurr9 into v_name1;
   exit when mycurr9%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--10
declare
  cursor mycurr10 is
  select  USERNAME from hr.my_table10;
  v_name1 varchar2(100);
begin
open mycurr10;
loop
   fetch mycurr10 into v_name1;
   exit when mycurr10%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--part2 open 10 from 50 (total 20)

--11
declare
  cursor mycurr11 is
  select  USERNAME from hr.my_table11;
  v_name1 varchar2(100);
begin
open mycurr11;
loop
   fetch mycurr11 into v_name1;
   exit when mycurr11%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--12
declare
  cursor mycurr12 is
  select  USERNAME from hr.my_table12;
  v_name1 varchar2(100);
begin
open mycurr12;
loop
   fetch mycurr12 into v_name1;
   exit when mycurr12%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--13
declare
  cursor mycurr13 is
  select  USERNAME from hr.my_table13;
  v_name1 varchar2(100);
begin
open mycurr13;
loop
   fetch mycurr13 into v_name1;
   exit when mycurr13%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--14
declare
  cursor mycurr14 is
  select  USERNAME from hr.my_table14;
  v_name1 varchar2(100);
begin
open mycurr14;
loop
   fetch mycurr14 into v_name1;
   exit when mycurr14%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--15
declare
  cursor mycurr15 is
  select  USERNAME from hr.my_table15;
  v_name1 varchar2(100);
begin
open mycurr15;
loop
   fetch mycurr15 into v_name1;
   exit when mycurr15%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--16
declare
  cursor mycurr16 is
  select  USERNAME from hr.my_table16;
  v_name1 varchar2(100);
begin
open mycurr16;
loop
   fetch mycurr16 into v_name1;
   exit when mycurr16%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--17
declare
  cursor mycurr17 is
  select  USERNAME from hr.my_table17;
  v_name1 varchar2(100);
begin
open mycurr17;
loop
   fetch mycurr17 into v_name1;
   exit when mycurr17%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--18
declare
  cursor mycurr18 is
  select  USERNAME from hr.my_table18;
  v_name1 varchar2(100);
begin
open mycurr18;
loop
   fetch mycurr18 into v_name1;
   exit when mycurr18%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--19
declare
  cursor mycurr19 is
  select  USERNAME from hr.my_table19;
  v_name1 varchar2(100);
begin
open mycurr19;
loop
   fetch mycurr19 into v_name1;
   exit when mycurr19%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--20
declare
  cursor mycurr20 is
  select  USERNAME from hr.my_table20;
  v_name1 varchar2(100);
begin
open mycurr20;
loop
   fetch mycurr20 into v_name1;
   exit when mycurr20%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--part3 open 10 from 50 (total: 30 from 50)
--21
declare
  cursor mycurr21 is
  select  USERNAME from hr.my_table21;
  v_name1 varchar2(100);
begin
open mycurr21;
loop
   fetch mycurr21 into v_name1;
   exit when mycurr21%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--22
declare
  cursor mycurr22 is
  select  USERNAME from hr.my_table22;
  v_name1 varchar2(100);
begin
open mycurr22;
loop
   fetch mycurr22 into v_name1;
   exit when mycurr22%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--23
declare
  cursor mycurr23 is
  select  USERNAME from hr.my_table23;
  v_name1 varchar2(100);
begin
open mycurr23;
loop
   fetch mycurr23 into v_name1;
   exit when mycurr23%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--24
declare
  cursor mycurr24 is
  select  USERNAME from hr.my_table24;
  v_name1 varchar2(100);
begin
open mycurr24;
loop
   fetch mycurr24 into v_name1;
   exit when mycurr24%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--25
declare
  cursor mycurr25 is
  select  USERNAME from hr.my_table25;
  v_name1 varchar2(100);
begin
open mycurr25;
loop
   fetch mycurr25 into v_name1;
   exit when mycurr25%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--26
declare
  cursor mycurr26 is
  select  USERNAME from hr.my_table26;
  v_name1 varchar2(100);
begin
open mycurr26;
loop
   fetch mycurr26 into v_name1;
   exit when mycurr26%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--27
declare
  cursor mycurr27 is
  select  USERNAME from hr.my_table27;
  v_name1 varchar2(100);
begin
open mycurr27;
loop
   fetch mycurr27 into v_name1;
   exit when mycurr27%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--28
declare
  cursor mycurr28 is
  select  USERNAME from hr.my_table28;
  v_name1 varchar2(100);
begin
open mycurr28;
loop
   fetch mycurr28 into v_name1;
   exit when mycurr28%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--29
declare
  cursor mycurr29 is
  select  USERNAME from hr.my_table29;
  v_name1 varchar2(100);
begin
open mycurr29;
loop
   fetch mycurr29 into v_name1;
   exit when mycurr29%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--30
declare
  cursor mycurr30 is
  select  USERNAME from hr.my_table30;
  v_name1 varchar2(100);
begin
open mycurr30;
loop
   fetch mycurr30 into v_name1;
   exit when mycurr30%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/


--part4: open 10 from 50 (total 40 from 50)
--31
declare
  cursor mycurr31 is
  select  USERNAME from hr.my_table31;
  v_name1 varchar2(100);
begin
open mycurr31;
loop
   fetch mycurr31 into v_name1;
   exit when mycurr31%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--32
declare
  cursor mycurr32 is
  select  USERNAME from hr.my_table32;
  v_name1 varchar2(100);
begin
open mycurr32;
loop
   fetch mycurr32 into v_name1;
   exit when mycurr32%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--33
declare
  cursor mycurr33 is
  select  USERNAME from hr.my_table33;
  v_name1 varchar2(100);
begin
open mycurr33;
loop
   fetch mycurr33 into v_name1;
   exit when mycurr33%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--34
declare
  cursor mycurr34 is
  select  USERNAME from hr.my_table34;
  v_name1 varchar2(100);
begin
open mycurr34;
loop
   fetch mycurr34 into v_name1;
   exit when mycurr34%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--35
declare
  cursor mycurr35 is
  select  USERNAME from hr.my_table35;
  v_name1 varchar2(100);
begin
open mycurr35;
loop
   fetch mycurr35 into v_name1;
   exit when mycurr35%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--36
declare
  cursor mycurr36 is
  select  USERNAME from hr.my_table36;
  v_name1 varchar2(100);
begin
open mycurr36;
loop
   fetch mycurr36 into v_name1;
   exit when mycurr36%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--37
declare
  cursor mycurr37 is
  select  USERNAME from hr.my_table37;
  v_name1 varchar2(100);
begin
open mycurr37;
loop
   fetch mycurr37 into v_name1;
   exit when mycurr37%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--38
declare
  cursor mycurr38 is
  select  USERNAME from hr.my_table38;
  v_name1 varchar2(100);
begin
open mycurr38;
loop
   fetch mycurr38 into v_name1;
   exit when mycurr38%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--39
declare
  cursor mycurr39 is
  select  USERNAME from hr.my_table39;
  v_name1 varchar2(100);
begin
open mycurr39;
loop
   fetch mycurr39 into v_name1;
   exit when mycurr39%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--40
declare
  cursor mycurr40 is
  select  USERNAME from hr.my_table40;
  v_name1 varchar2(100);
begin
open mycurr40;
loop
   fetch mycurr40 into v_name1;
   exit when mycurr40%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--part5: open 10 from 50 (total 50 from 50)
--41
declare
  cursor mycurr41 is
  select  USERNAME from hr.my_table41;
  v_name1 varchar2(100);
begin
open mycurr41;
loop
   fetch mycurr41 into v_name1;
   exit when mycurr41%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--42
declare
  cursor mycurr42 is
  select  USERNAME from hr.my_table42;
  v_name1 varchar2(100);
begin
open mycurr42;
loop
   fetch mycurr42 into v_name1;
   exit when mycurr42%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--43
declare
  cursor mycurr43 is
  select  USERNAME from hr.my_table43;
  v_name1 varchar2(100);
begin
open mycurr43;
loop
   fetch mycurr43 into v_name1;
   exit when mycurr43%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--44
declare
  cursor mycurr44 is
  select  USERNAME from hr.my_table44;
  v_name1 varchar2(100);
begin
open mycurr44;
loop
   fetch mycurr44 into v_name1;
   exit when mycurr44%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--45
declare
  cursor mycurr45 is
  select  USERNAME from hr.my_table45;
  v_name1 varchar2(100);
begin
open mycurr45;
loop
   fetch mycurr45 into v_name1;
   exit when mycurr45%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--46
declare
  cursor mycurr46 is
  select  USERNAME from hr.my_table46;
  v_name1 varchar2(100);
begin
open mycurr46;
loop
   fetch mycurr46 into v_name1;
   exit when mycurr46%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--47
declare
  cursor mycurr47 is
  select  USERNAME from hr.my_table47;
  v_name1 varchar2(100);
begin
open mycurr47;
loop
   fetch mycurr47 into v_name1;
   exit when mycurr47%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--48
declare
  cursor mycurr48 is
  select  USERNAME from hr.my_table48;
  v_name1 varchar2(100);
begin
open mycurr48;
loop
   fetch mycurr48 into v_name1;
   exit when mycurr48%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--49
declare
  cursor mycurr49 is
  select  USERNAME from hr.my_table49;
  v_name1 varchar2(100);
begin
open mycurr49;
loop
   fetch mycurr49 into v_name1;
   exit when mycurr49%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--50
declare
  cursor mycurr50 is
  select  USERNAME from hr.my_table50;
  v_name1 varchar2(100);
begin
open mycurr50;
loop
   fetch mycurr50 into v_name1;
   exit when mycurr50%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--part5 open 10 
--51
declare
  cursor mycurr51 is
  select  USERNAME from hr.my_table51;
  v_name1 varchar2(100);
begin
open mycurr51;
loop
   fetch mycurr51 into v_name1;
   exit when mycurr51%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--52
declare
  cursor mycurr52 is
  select  USERNAME from hr.my_table52;
  v_name1 varchar2(100);
begin
open mycurr52;
loop
   fetch mycurr52 into v_name1;
   exit when mycurr52%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--53
declare
  cursor mycurr53 is
  select  USERNAME from hr.my_table53;
  v_name1 varchar2(100);
begin
open mycurr53;
loop
   fetch mycurr55 into v_name1;
   exit when mycurr53%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--54
declare
  cursor mycurr54 is
  select  USERNAME from hr.my_table54;
  v_name1 varchar2(100);
begin
open mycurr54;
loop
   fetch mycurr54 into v_name1;
   exit when mycurr54%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--55
declare
  cursor mycurr55 is
  select  USERNAME from hr.my_table55;
  v_name1 varchar2(100);
begin
open mycurr55;
loop
   fetch mycurr55 into v_name1;
   exit when mycurr55%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--56
declare
  cursor mycurr56 is
  select  USERNAME from hr.my_table56;
  v_name1 varchar2(100);
begin
open mycurr56;
loop
   fetch mycurr56 into v_name1;
   exit when mycurr56%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--57
declare
  cursor mycurr57 is
  select  USERNAME from hr.my_table57;
  v_name1 varchar2(100);
begin
open mycurr57;
loop
   fetch mycurr57 into v_name1;
   exit when mycurr57%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--58
declare
  cursor mycurr58 is
  select  USERNAME from hr.my_table58;
  v_name1 varchar2(100);
begin
open mycurr58;
loop
   fetch mycurr58 into v_name1;
   exit when mycurr58%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--59
declare
  cursor mycurr59 is
  select  USERNAME from hr.my_table59;
  v_name1 varchar2(100);
begin
open mycurr59;
loop
   fetch mycurr59 into v_name1;
   exit when mycurr59%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--60
declare
  cursor mycurr60 is
  select  USERNAME from hr.my_table60;
  v_name1 varchar2(100);
begin
open mycurr60;
loop
   fetch mycurr60 into v_name1;
   exit when mycurr60%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--part6 open 10 cursors
--61
declare
  cursor mycurr61 is
  select  USERNAME from hr.my_table61;
  v_name1 varchar2(100);
begin
open mycurr61;
loop
   fetch mycurr61 into v_name1;
   exit when mycurr61%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--62
declare
  cursor mycurr62 is
  select  USERNAME from hr.my_table62;
  v_name1 varchar2(100);
begin
open mycurr62;
loop
   fetch mycurr62 into v_name1;
   exit when mycurr62%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--63
declare
  cursor mycurr63 is
  select  USERNAME from hr.my_table63;
  v_name1 varchar2(100);
begin
open mycurr63;
loop
   fetch mycurr63 into v_name1;
   exit when mycurr63%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--64
declare
  cursor mycurr64 is
  select  USERNAME from hr.my_table64;
  v_name1 varchar2(100);
begin
open mycurr64;
loop
   fetch mycurr64 into v_name1;
   exit when mycurr64%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--65
declare
  cursor mycurr65 is
  select  USERNAME from hr.my_table65;
  v_name1 varchar2(100);
begin
open mycurr65;
loop
   fetch mycurr65 into v_name1;
   exit when mycurr65%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--66
declare
  cursor mycurr66 is
  select  USERNAME from hr.my_table66;
  v_name1 varchar2(100);
begin
open mycurr66;
loop
   fetch mycurr66 into v_name1;
   exit when mycurr66%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--67
declare
  cursor mycurr67 is
  select  USERNAME from hr.my_table67;
  v_name1 varchar2(100);
begin
open mycurr67;
loop
   fetch mycurr67 into v_name1;
   exit when mycurr67%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--68
declare
  cursor mycurr68 is
  select  USERNAME from hr.my_table68;
  v_name1 varchar2(100);
begin
open mycurr68;
loop
   fetch mycurr68 into v_name1;
   exit when mycurr68%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--69
declare
  cursor mycurr69 is
  select  USERNAME from hr.my_table69;
  v_name1 varchar2(100);
begin
open mycurr69;
loop
   fetch mycurr69 into v_name1;
   exit when mycurr69%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--70
declare
  cursor mycurr70 is
  select  USERNAME from hr.my_table70;
  v_name1 varchar2(100);
begin
open mycurr70;
loop
   fetch mycurr70 into v_name1;
   exit when mycurr70%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--part7 open 10 cursors
--71
declare
  cursor mycurr71 is
  select  USERNAME from hr.my_table71;
  v_name1 varchar2(100);
begin
open mycurr71;
loop
   fetch mycurr71 into v_name1;
   exit when mycurr71%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--72
declare
  cursor mycurr72 is
  select  USERNAME from hr.my_table72;
  v_name1 varchar2(100);
begin
open mycurr72;
loop
   fetch mycurr72 into v_name1;
   exit when mycurr72%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--73
declare
  cursor mycurr73 is
  select  USERNAME from hr.my_table73;
  v_name1 varchar2(100);
begin
open mycurr73;
loop
   fetch mycurr73 into v_name1;
   exit when mycurr73%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--74
declare
  cursor mycurr74 is
  select  USERNAME from hr.my_table74;
  v_name1 varchar2(100);
begin
open mycurr74;
loop
   fetch mycurr74 into v_name1;
   exit when mycurr74%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--75
declare
  cursor mycurr75 is
  select  USERNAME from hr.my_table75;
  v_name1 varchar2(100);
begin
open mycurr75;
loop
   fetch mycurr75 into v_name1;
   exit when mycurr75%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--76
declare
  cursor mycurr76 is
  select  USERNAME from hr.my_table76;
  v_name1 varchar2(100);
begin
open mycurr76;
loop
   fetch mycurr76 into v_name1;
   exit when mycurr76%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--77
declare
  cursor mycurr77 is
  select  USERNAME from hr.my_table77;
  v_name1 varchar2(100);
begin
open mycurr77;
loop
   fetch mycurr77 into v_name1;
   exit when mycurr77%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--78
declare
  cursor mycurr78 is
  select  USERNAME from hr.my_table78;
  v_name1 varchar2(100);
begin
open mycurr78;
loop
   fetch mycurr78 into v_name1;
   exit when mycurr78%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--79
declare
  cursor mycurr79 is
  select  USERNAME from hr.my_table79;
  v_name1 varchar2(100);
begin
open mycurr79;
loop
   fetch mycurr79 into v_name1;
   exit when mycurr79%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/
--80
declare
  cursor mycurr80 is
  select  USERNAME from hr.my_table80;
  v_name1 varchar2(100);
begin
open mycurr80;
loop
   fetch mycurr80 into v_name1;
   exit when mycurr80%notfound;
   dbms_output.put_line(v_name1);
end loop;
--close <cursor_name>;
end;
/

--Question: stil can not reach open cursors limit. Why?
--check query:
 select p.value as def_max, (p.value-a.value) as diff, a.value, s.username, s.machine, s.sid, s.serial#, (select sysdate from dual) as time
  from v$sesstat a, v$statname b, v$session s, v$parameter p
  where a.statistic# = b.statistic#
  and s.sid=a.sid
  and b.name = 'opened cursors current'
 -- and s.username is not null
  and p.name= 'open_cursors'
  order by a.value desc
  fetch first 5 rows only;

-- execute extra selects to open cursors 
select * from USER_TABLES;

select * from USER_OBJECT_TABLES;

select * from USER_ALL_TABLES;

select * from USER_SYNONYMS;

select * from USER_SEQUENCES;

select * from USER_CATALOG;

select * from USER_INDEXES;

select * from USER_VIEWS;

select * from USER_TYPES;

select * from USER_CONSTRAINTS;

select * from USER_PROCEDURES;

select * from USER_TRIGGERS;
