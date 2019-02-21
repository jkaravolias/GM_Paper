*Import Data;

proc import
out=work.us_results
datafile= "\\Client\H$\Desktop\GM Project\Results_US.txt"
dbms=tab replace;
getnames=yes;


datarow=2;

run;

*Delete respondents taht did not follow Validation Question;
*Please select disagree, Q3_5_Validation;

data validation_pass;
   set work.Us_results;
   if Q3_5_Validation ne 2 then delete;

;

*Combine Scale questions to create new total Scale score;
*Start with Foodie Scale;
* Row titles: CON_3,CON_1,CON_4,CON_5,CON_2;
total_con= CON_1 + CON_2 + CON_3 +CON_4 + CON_5;

*Corporate Distruct Scale;
*Reverse Code Questions: Switch so that 7=strong Disagree and 1=Strongly Agree;
*Reverse Questions:CD_4R, CD_7R, CD_12R,CD_1R, CD_13R, CD_2R;

if CD_4R = 7 then CD_4 =1;
if CD_4R = 6 then CD_4 =2;
if CD_4R = 5 then CD_4 =3;
if CD_4R = 4 then CD_4 =4;
if CD_4R = 3 then CD_4 =5;
if CD_4R = 2 then CD_4 =6;
if CD_4R = 1 then CD_4 =7;

if CD_7R = 7 then CD_7 =1;
if CD_7R = 6 then CD_7 =2;
if CD_7R = 5 then CD_7 =3;
if CD_7R = 4 then CD_7 =4;
if CD_7R = 3 then CD_7 =5;
if CD_7R = 2 then CD_7 =6;
if CD_7R = 1 then CD_7 =7;

if CD_12R = 7 then CD_12 =1;
if CD_12R = 6 then CD_12 =2;
if CD_12R = 5 then CD_12 =3;
if CD_12R = 4 then CD_12 =4;
if CD_12R = 3 then CD_12 =5;
if CD_12R = 2 then CD_12 =6;
if CD_12R = 1 then CD_12 =7;

if CD_1R = 7 then CD_1 =1;
if CD_1R = 6 then CD_1 =2;
if CD_1R = 5 then CD_1 =3;
if CD_1R = 4 then CD_1 =4;
if CD_1R = 3 then CD_1 =5;
if CD_1R = 2 then CD_1 =6;
if CD_1R = 1 then CD_1 =7;

if CD_13R = 7 then CD_13 =1;
if CD_13R = 6 then CD_13 =2;
if CD_13R = 5 then CD_13 =3;
if CD_13R = 4 then CD_13 =4;
if CD_13R = 3 then CD_13 =5;
if CD_13R = 2 then CD_13 =6;
if CD_13R = 1 then CD_13 =7;

if CD_2R = 7 then CD_2 =1;
if CD_2R = 6 then CD_2 =2;
if CD_2R = 5 then CD_2 =3;
if CD_2R = 4 then CD_2 =4;
if CD_2R = 3 then CD_2 =5;
if CD_2R = 2 then CD_2 =6;
if CD_2R = 1 then CD_2 =7;

total_CD=CD_1+CD_2 + CD_3 + CD_4 + CD_5 + CD_6 +CD_7 + CD_8 + CD_9 + CD_10 + CD_11 + CD_12 + CD_13;


*Technology Scale;
*Reverse Scoring: TECH_5_N_, TECH_3_N_;

if TECH_3_N=7 then TECH_3=1;
if TECH_3_N=6 then TECH_3=2;
if TECH_3_N=5 then TECH_3=3;
if TECH_3_N=4 then TECH_3=4;
if TECH_3_N=3 then TECH_3=5;
if TECH_3_N=2 then TECH_3=6;
if TECH_3_N=1 then TECH_3=7;

if TECH_5_N=7 then TECH_5=1;
if TECH_5_N=6 then TECH_5=2;
if TECH_5_N=5 then TECH_5=3;
if TECH_5_N=4 then TECH_5=4;
if TECH_5_N=3 then TECH_5=5;
if TECH_5_N=2 then TECH_5=6;
if TECH_5_N=1 then TECH_5=7;

tech_total=TECH_1 + TECH_2 + TECH_3 + TECH_4 + TECH_5;

*New Ecological Paradigm;
*Agreement with 8 odd-numbers and disagreement with 7 even numbers are pro-NEP;
*Reverse code are all the even numbered questions;

if NES_2=1 then NES_2=7;
if NES_2=2 then NES_2=6;
if NES_2=3 then NES_2=5;
if NES_2=4 then NES_2=4;
if NES_2=5 then NES_2=3;
if NES_2=6 then NES_2=2;
if NES_2=7 then NES_2=1;

if NES_4=1 then NES_4=7;
if NES_4=2 then NES_4=6;
if NES_4=3 then NES_4=5;
if NES_4=4 then NES_4=4;
if NES_4=5 then NES_4=3;
if NES_4=6 then NES_4=2;
if NES_4=7 then NES_4=1;

if NES_6=1 then NES_6=7;
if NES_6=2 then NES_6=6;
if NES_6=3 then NES_6=5;
if NES_6=4 then NES_6=4;
if NES_6=5 then NES_6=3;
if NES_6=6 then NES_6=2;
if NES_6=7 then NES_6=1;

if NES_8=1 then NES_8=7;
if NES_8=2 then NES_8=6;
if NES_8=3 then NES_8=5;
if NES_8=4 then NES_8=4;
if NES_8=5 then NES_8=3;
if NES_8=6 then NES_8=2;
if NES_8=7 then NES_8=1;

if NES_10=1 then NES_10=7;
if NES_10=2 then NES_10=6;
if NES_10=3 then NES_10=5;
if NES_10=4 then NES_10=4;
if NES_10=5 then NES_10=3;
if NES_10=6 then NES_10=2;
if NES_10=7 then NES_10=1;

if NES_12=1 then NES_12=7;
if NES_12=2 then NES_12=6;
if NES_12=3 then NES_12=5;
if NES_12=4 then NES_12=4;
if NES_12=5 then NES_12=3;
if NES_12=6 then NES_12=2;
if NES_12=7 then NES_12=1;

if NES_14=1 then NES_14=7;
if NES_14=2 then NES_14=6;
if NES_14=3 then NES_14=5;
if NES_14=4 then NES_14=4;
if NES_14=5 then NES_14=3;
if NES_14=6 then NES_14=2;
if NES_14=7 then NES_14=1;

total_NES=NES_1 + NES_2 + NES_3 + NES_4 + NES_5 + NES6 + NES_7 + NES_8 + NES_9 + NES_10 + NES_11 + NES_12 +NES_13 + NES_14 + NES_1;

;

proc corr
title 'Food Scale Cronbachs Alpha';
data=Validation_pass alpha;
var CON_1 CON_2 CON_3 CON_4 CON_5;

run;


