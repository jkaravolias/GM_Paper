****Copy Right, Zhifeng Gao, (zfgao@ufl.edu) ********************
****Food and Resource Economics Department*****
****University of Florida**********************;


dm "log; clear; output; clear";
%let path=E:\GM Project Copy;
libname CE &path;

*survey data;
proc import datafile="&path\Survey Results\Spain_results.csv" out=survey dbms=csv replace;
 getnames=yes; datarow=3;
run;


*Replace all . in numeric columns with 0; 
proc stdize data=survey reponly MISSING=0 out=survey;
var _numeric_; run;

*Clean up data;

*Eliminate Observations of all but one information treatment;
*Q4_1 is Monsanto treatment;
*Q5_1 is Emotional Citrus Greening;
*Q6_1 is Simple Citrus Greening;
*Q7_2 is Health Information;
*Q8_1 is control group;
data survey; set work.survey;
if Q8_1 <1 then delete;


*Change Reverse Coding and Calculate total scale scores;
*Corporate Distrust Scale;
CD_4=8-CD_4R;
CD_7=8-CD_7R;
CD_12=8-CD_12R;
CD_1=8-CD_1R;
CD_13=8-CD_13R;
CD_2=8-CD_2R;

total_CD=CD_1 + CD_2 + CD_3 + CD_4 + CD_5 + CD_6 + CD_7 + CD_8 + CD_9 + CD_10 + CD_11 + CD_12 + CD_13;

*Technology Acceptance Scale;
TECH_3=8-TECH_3_N_;
TECH_5=8-TECH_5_N_;

total_tech=TECH_1 + TECH_2 + TECH_3 + TECH_4 + TECH_5;

*New Ecological Paradigm;
NES_2=8-NES_2;
NES_4=8-NES_4;
NES_6=8-NES_6;
NES_8=8-NES_8;
NES_10=8-NES_10;
NES_12=8-NES_12;
NES_14=8-NES_14;

total_NES= NES_1 + NES_2 + NES_3 + NES_4 +NES_5 + NES_6 + NES_7 + NES_8 + NES_9 + NES_10 + NES_11 + NES_12 + NES_13 +NES_14 + NES_15;

*Foodie Scale;
total_con= CON_1 + CON_2 + CON_3 +CON_4 + CON_5;
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

proc export data=CE_DEMO3 outfile="&path\Choice Experiment\Spain\Spain_control.csv"
dbms=csv replace ;
run;
