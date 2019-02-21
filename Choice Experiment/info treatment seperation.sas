dm "log; clear; output; clear";
%let path=E:\GM Project Copy;
libname CE &path;

*survey data;
proc import datafile="&path\Survey Results\spain_results.csv" out=survey dbms=csv replace;
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
data con_survey; set work.survey;
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

proc export data=con_survey outfile="&path\Choice Experiment\Spain\short\spain_con.csv"
dbms=csv replace ;
run;
