****Copy Right, Zhifeng Gao, (zfgao@ufl.edu) ********************
****Food and Resource Economics Department*****
****University of Florida**********************;


dm "log; clear; output; clear";
%let path=E:\GM Project Copy;
libname CE &path;
*survey data;
proc import file="&path\Survey Results\US_monsanto2.csv" out=survey dbms=csv replace
; getnames=yes;
run;

*CE design;
proc import datafile="&path\Choice Experiment\GM_CE_design.xlsx"
out=CE_Design dbms=xlsx replace;
run;
*First Attribute of the CE;
proc transpose data=CE_Design out=CE_D1; by set; var p1-p3; run; 
DATA CE_D1; SET CE_D1; RENAME COL1=PRICE; drop _NAME_ _Label_; run;
proc print data=CE_D1; run;
*2rd Attribute of the CE;
proc transpose data=CE_Design out=CE_D2; by set; var pr1-pr3; run;
DATA CE_D2; SET CE_D2; RENAME COL1=Producer;drop _NAME_ _Label_; run;
*3th Attribute of the CE;
proc transpose data=CE_Design out=CE_D3; by set; var s1-s3; run;
DATA CE_D3; SET CE_D3; RENAME COL1=Seeds;drop _NAME_ _Label_; run;

*Merge all the attributes;
data CE_F; merge CE_D1 CE_D2 CE_D3; by set; run;
proc print data=CE_F; title 'GM_CE_F'; run;
*Create alternative variable;
data CE_F1; 
do set=1 to 9;
   do alt=1 to 3;
   output;
   end;
end;
run;
proc print data=CE_F1; title 'GM_CE_F1'; run;
*Add alternative variable to the CE design;
proc sort data=CE_F1; by set; run;
data CE_F2; merge CE_F1 CE_F; by set; run;
proc sort data= CE_F2; by set alt; run;
proc print data=CE_F2; title 'GM_CE_F2'; run;

*Duplicate the CE by 410 times because there are 410 respondents;
*410 resondents;
data CE_F3; set CE_F2;
do RID=1 to 410;
output;
end;
run;
proc sort data=CE_F3; by RID SET Alt; run;
proc print data=CE_F3(obs=100); title 'GM_CE_F3';run;

*creat respondent ID in survey data to merge with CE data;
*also need to rename the variable indicating the choices to SETi;
data survey2; set survey;
array name1 Q9_1-Q9_9; *original name of choices;
array name2 Set1-Set9; *new name of choices;
*Rename the choice variables;
do i=1 to 9;
name2(i)=name1(i);
end;
output;
drop Q9_1-Q9_9;
*create respondent ID;
run;
data survey2; set survey2;
RID=_N_;
run;

*duplicate the choice sets;
data CE_DEMO; set survey2;
array CEs[9] SET1-SET9; *set1-set7 is the chosen alternative for choice set 1 to 7;
Do SETS=1 to 9;
      Choose=CEs[SETS]; 
	  output;  
end;
run;
proc print data=CE_DEMO(obs=100); title 'GM_CE DEMO'; run;

*duplicate the alternatives;
data CE_DEMO2; set CE_DEMO;
do alt=1 to 3;
output;
end;
run;
proc print data=CE_DEMO2(obs=100);title'GM_CE DEMO2'; run;

*merge demo with CE;
data CE_DEMO3; merge CE_DEMO2 CE_F3; by RID;
choice=0;
if choose=alt then choice=1;       *using 0 and 1 to indicate the choices of respondents;
if alt=3 then NONE=1; else None=0; *new variable none was created in order to estimate the alternative specific constant for the none options in choice set;
drop set1-set9 sets i; 
run;
proc print data=CE_DEMO3(obs=100); title 'GM_CE DEMO 3'; run;

proc export data=CE_DEMO3 outfile="&path\CE_DEMO3.xlsx"
dbms=xlsx replace ;
run;

*WTP Analysis;
proc phreg data=ce_demo3 brief;
class  producer seeds /descending;
model choice*choice(1)= price producer seeds /ties=breslow;
strata RID set ;
title 'Without Price as class Varible';
run;

proc phreg data=ce_demo3 brief;
class price producer seeds /descending;
model choice*choice(1)= price producer seeds /ties=breslow;
strata RID set ;
title 'With Price as Class Variable';
run;

proc catmod data=ce_demo3;
model choice=price producer seeds;
run;

data ce_demo3; set ce_demo3;
if choose=. then delete;
run; 

*PROC MDC;
proc mdc data=ce_demo3;
model choice=price producer seeds / type=mixedlogit
nchoice=3 mixed=(normalparm=price);
id RID;
run;
