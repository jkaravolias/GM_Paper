*ods close, ods html clears old version of context;
options ls=75 formdlim = '_';


* Clean Up for US Data;
*Country =1;
proc import
datafile="\\Client\H$\Desktop\GM Project\US_Results.csv"
out=work.us_results
dbms=csv replace;
getnames=yes;
datarow=3;
run;

data us_validation_pass;
   set work.Us_results;
   if Q3_5_Validation ne 2 then delete;

;

* Row titles: CON_3,CON_1,CON_4,CON_5,CON_2;
total_con= CON_1 + CON_2 + CON_3 +CON_4 + CON_5;

*Corporate distrust scale;
*Reverse Code Questions;

CD_4=8-CD_4R;
CD_7=8-CD_7R;
CD_12=8-CD_12R;
CD_1=8-CD_1R;
CD_13=8-CD_13R;
CD_2=8-CD_2R;

total_CD=CD_1 + CD_2 + CD_3 + CD_4 + CD_5 + CD_6 + CD_7 + CD_8 + CD_9 + CD_10 + CD_11 + CD_12 + CD_13;

*Technology Scale;

TECH_3=8-TECH_3_N_;
TECH_5=8-TECH_5_N_;

total_tech=TECH_1 + TECH_2 + TECH_3 + TECH_4 + TECH_5;

*New Environmental Paradigm;

NES_2=8-NES_2;
NES_4=8-NES_4;
NES_6=8-NES_6;
NES_8=8-NES_8;
NES_10=8-NES_10;
NES_12=8-NES_12;
NES_14=8-NES_14;

total_NES= NES_1 + NES_2 + NES_3 + NES_4 +NES_5 + NES_6 + NES_7 + NES_8 + NES_9 + NES_10 + NES_11 + NES_12 + NES_13 +NES_14 + NES_15;

country=1;
run;

title 'NES Cronbach Alpha';
proc corr
data=us_Validation_pass nomiss alpha;
var NES_1 NES_2 NES_3 NES_4 NES_5 NES_6 NES_7 NES_8 NES_9 NES_10 NES_11 NES_12 NES_13 NES_14 NES_15;

run;


title 'Foodie Cronbach Alpah';
proc corr
data=us_Validation_pass  nomiss alpha;
var CON_1 CON_2 CON_3 CON_4 CON_5;
title 'Cronbach Alpha for Foodies';
run;

title 'Corporate Distust Cronbach Alpha';
proc corr
data=us_Validation_pass  nomiss alpha;
var CD_1 CD_2 CD_3 CD_4 CD_5 CD_6 CD_7 CD_8 CD_9 CD_10 CD_11 CD_12 CD_13;
title 'Cronbach Alpha for CD';
run;

title 'Tech Cronbach Alpah';
proc corr
data=us_Validation_pass  nomiss alpha;
var TECH_1 TECH_2 TECH_3 TECH_4 TECH_5;
title 'Cronbach Alpha for TECH';
run;

proc means
data=us_Validation_pass n mean std;
var Q4_1 Q5_1 Q6_1 Q7_2 Q8_1;
title 'US Info Treatment Means';
run;











