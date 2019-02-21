*ods close, ods html clears old version of context;
options ls=75 formdlim = '_';

*ods close, ods html clears old version of context;
options ls=75 formdlim = '_';


* Clean Up for US Data;
*Country =1;
proc import
datafile="E:\GM Project Copy\Survey Results\us_results.csv"
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
Q2_2_2_1=input(Q2_2_2,8.);
drop Q2_2_2;
rename Q2_2_2_1=Q2_2_2;

Q2_2_4_1=input(Q2_2_4,8.);
drop Q2_2_4;
rename Q2_2_4_1=Q2_2_4;

Q2_2_5_1=input(Q2_2_5,8.);
drop Q2_2_5;
rename Q2_2_5_1=Q2_2_5;

Q2_2_6_1=input(Q2_2_6,8.);
drop Q2_2_6;
rename Q2_2_6_1=Q2_2_6;

Q2_2_9_1=input(Q2_2_9,8.);
drop Q2_2_9;
rename Q2_2_9_1=Q2_2_9;


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
title 'US-Cronbach Alpha for Foodies';
run;

title 'Corporate Distust Cronbach Alpha';
proc corr
data=us_Validation_pass  nomiss alpha;
var CD_1 CD_2 CD_3 CD_4 CD_5 CD_6 CD_7 CD_8 CD_9 CD_10 CD_11 CD_12 CD_13;
title 'US-Cronbach Alpha for CD';
run;

title 'Tech Cronbach Alpah';
proc corr
data=us_Validation_pass  nomiss alpha;
var TECH_1 TECH_2 TECH_3 TECH_4 TECH_5;
title 'US-Cronbach Alpha for TECH';
run;

proc means
data=us_Validation_pass n mean std;
var Q4_1 Q5_1 Q6_1 Q7_2 Q8_1;
title 'US Info Treatment Means';
run;

* Clean Up for AUS Data;
*Country =2;
proc import
datafile="E:\GM Project Copy\Survey Results\austria_results.csv"
out=work.aus_results
dbms=csv replace;
getnames=yes;
datarow=3;
run;

data aus_validation_pass;
   set work.aus_results;
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

country=2;

Q4_1_1=input(Q4_1,8.);
drop Q4_1;
rename Q4_1_1=Q4_1;

Q2_2_1_1=input(Q2_2_1,8.);
drop Q2_2_1;
rename Q2_2_1_1=Q2_2_1;

Q2_2_6_1=input(Q2_2_6,8.);
drop Q2_2_6;
rename Q2_2_6_1=Q2_2_6;

Q2_2_7_1=input(Q2_2_7,8.);
drop Q2_2_7;
rename Q2_2_7_1=Q2_2_7;

Q4_2_1=input(Q4_2,8.);
drop Q4_2;
rename Q4_2_1=Q4_2;



run;

title 'NES Cronbach Alpha';
proc corr
data=aus_Validation_pass nomiss alpha;
var NES_1 NES_2 NES_3 NES_4 NES_5 NES_6 NES_7 NES_8 NES_9 NES_10 NES_11 NES_12 NES_13 NES_14 NES_15;

run;


title 'Foodie Cronbach Alpah';
proc corr
data=aus_Validation_pass  nomiss alpha;
var CON_1 CON_2 CON_3 CON_4 CON_5;
title 'AUS-Cronbach Alpha for Foodies';
run;

title 'Corporate Distust Cronbach Alpha';
proc corr
data=aus_Validation_pass  nomiss alpha;
var CD_1 CD_2 CD_3 CD_4 CD_5 CD_6 CD_7 CD_8 CD_9 CD_10 CD_11 CD_12 CD_13;
title 'AUS-Cronbach Alpha for CD';
run;

title 'Tech Cronbach Alpah';
proc corr
data=aus_Validation_pass  nomiss alpha;
var TECH_1 TECH_2 TECH_3 TECH_4 TECH_5;
title 'AUS-Cronbach Alpha for TECH';
run;

proc means
data=aus_Validation_pass n mean std;
var Q4_1 Q5_1 Q6_1 Q7_2 Q8_1;
title 'AUS Info Treatment Means';
run;


* Clean Up for spain Data;
*Country =3;
proc import
datafile="E:\GM Project Copy\Survey Results\spain_results.csv"
out=work.spain_results
dbms=csv replace;
getnames=yes;
datarow=3;
run;

data spain_validation_pass;
   set work.spain_results;
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

country=3;

*Q4_1_1=input(Q4_1,8.);
*drop Q4_1;
*rename Q4_1_1=Q4_1;

*Q2_2_1_1=input(Q2_2_1,8.);
*drop Q2_2_1;
*rename Q2_2_1_1=Q2_2_1;

*Q2_2_6_1=input(Q2_2_6,8.);
*drop Q2_2_6;
*rename Q2_2_6_1=Q2_2_6;

*Q2_2_7_1=input(Q2_2_7,8.);
*drop Q2_2_7;
*rename Q2_2_7_1=Q2_2_7;

*Q4_2_1=input(Q4_2,8.);
*drop Q4_2;
*rename Q4_2_1=Q4_2;



run;

title 'NES Cronbach Alpha';
proc corr
data=spain_Validation_pass nomiss alpha;
var NES_1 NES_2 NES_3 NES_4 NES_5 NES_6 NES_7 NES_8 NES_9 NES_10 NES_11 NES_12 NES_13 NES_14 NES_15;

run;


title 'Foodie Cronbach Alpah';
proc corr
data=spain_Validation_pass  nomiss alpha;
var CON_1 CON_2 CON_3 CON_4 CON_5;
title 'SPAIN-Cronbach Alpha for Foodies';
run;

title 'Corporate Distust Cronbach Alpha';
proc corr
data=spain_Validation_pass  nomiss alpha;
var CD_1 CD_2 CD_3 CD_4 CD_5 CD_6 CD_7 CD_8 CD_9 CD_10 CD_11 CD_12 CD_13;
title 'SPAIN-Cronbach Alpha for CD';
run;

title 'Tech Cronbach Alpah';
proc corr
data=spain_Validation_pass  nomiss alpha;
var TECH_1 TECH_2 TECH_3 TECH_4 TECH_5;
title 'SPAIN-Cronbach Alpha for TECH';
run;

proc means
data=spain_Validation_pass n mean std;
var Q4_1 Q5_1 Q6_1 Q7_2 Q8_1;
title 'Spain Info Treatment Means';
run;


*Concatenate US Pass and AUS Pass Data sets;

data combined;
set us_validation_pass aus_validation_pass;
run;

*Calculate Cronbach Alphas for combined data set;
title 'NES Cronbach Alpha';
proc corr
data=combined nomiss alpha;
var NES_1 NES_2 NES_3 NES_4 NES_5 NES_6 NES_7 NES_8 NES_9 NES_10 NES_11 NES_12 NES_13 NES_14 NES_15;
title 'all data';

run;


title 'Foodie Cronbach Alpah';
proc corr
data=combined  nomiss alpha;
var CON_1 CON_2 CON_3 CON_4 CON_5;
title 'ALL DATA-Cronbach Alpha for Foodies';
run;

title 'Corporate Distust Cronbach Alpha';
proc corr
data=combined  nomiss alpha;
var CD_1 CD_2 CD_3 CD_4 CD_5 CD_6 CD_7 CD_8 CD_9 CD_10 CD_11 CD_12 CD_13;
title 'ALL DATA-Cronbach Alpha for CD';
run;

title 'Tech Cronbach Alpah';
proc corr
data=combined  nomiss alpha;
var TECH_1 TECH_2 TECH_3 TECH_4 TECH_5;
title 'ALL DATA-Cronbach Alpha for TECH';
run;

proc means
data=combined n mean std;
var Q4_1 Q5_1 Q6_1 Q7_2 Q8_1;
title 'ALL DATA Info Treatment Means';
run;

*Compare means of info treatments for each country;
proc ttest data=combined plots=summary;
class country;
var Q4_1 Q5_1 Q6_1 Q7_2 Q8_1;
title 'Side by Side Country Comparison of IT';
run;

*Chi-square test to see differences within country's response to infor treatments;
proc freq data=combined;
tables country*Q4_1/chisq;
title 'Monsanto IT v. Countries';
run;

proc freq data=combined;
tables country*Q5_1/chisq;
title 'Altrustic Emotional IT v. Countries';
run;

proc freq data=combined;
tables country*Q6_1/chisq;
title 'Altrustic Simple IT v. Countries';
run;

proc freq data=combined;
tables country*Q7_2/chisq;
title 'Health IT v. Countries';
run;

proc freq data=combined;
tables country*Q8_1/chisq;
title 'Control IT v. Countries';
run;
*Check relationship of age to information treatments;
proc freq data=combined;
tables Q2_3*Q4_1/chisq;
title 'Age to Monsanto IT';
run;

proc freq data=combined;
tables Q2_3*Q5_1/chisq;
title 'Age to Altrustic Emotional IT';
run;

proc freq data=combined;
tables Q2_3*Q6_1/chisq;
title 'Age to Altrustrics Simple IT';
run;

proc freq data=combined;
tables Q2_3*Q7_2/chisq;
title 'Age to Health IT';
run;

proc freq data=combined;
tables Q2_3*Q8_1/chisq;
title 'Age to COntrol  IT';
run;

*Run a Spearman Pho to see if scale scores effect comfort level;
*Start with corporate distrust scale:
*Monsanto info treatment;
proc corr data=combined SPEARMAN;
var total_CD Q4_1;
title 'Combined-Corporate Distrust v. Monsanto Info';
run;

proc corr data=us_validation_pass SPEARMAN;
var total_CD Q4_1;
title 'US-Corporate Distrust v. Monsanto Info';
run;

proc corr data=aus_validation_pass SPEARMAN;
var total_CD Q4_1;
title 'Austria-Corporate Distrust v. Monsanto Info';
run;

*Altruristic emotional info treatment;
proc corr data=combined SPEARMAN;
var total_CD Q5_1;
title'Combined-Corporate Distrust v. Emotional Altrustic';
run;

proc corr data=us_validation_pass SPEARMAN;
var total_CD Q5_1;
title'US-Corporate Distrust v. Emotional Altrustic';
run;

proc corr data=aus_validation_pass SPEARMAN;
var total_CD Q5_1;
title'Austria-Corporate Distrust v. Emotional Altrustic';
run;


*Summary Demographic Statistics;

*US;
proc freq data=us_validation_pass;
table country*q11_3;
title 'US-income';
run;

proc freq data=us_validation_pass;
table country*q11_2;
title 'US-Employment';
run;

proc freq data=us_validation_pass;
table country*q11_8;
title 'US-Education';
run;

proc means data=us_validation_pass;
var q11_7 q11_4 q11_5;
title 'US-Age,Family Size, Kids';
run;

*Austira;
proc freq data=aus_validation_pass;
table country*q11_3;
title 'AUS-income';
run;

proc freq data=Aus_validation_pass;
table country*q11_2;
title 'AUS-Employment';
run;

proc freq data=Aus_validation_pass;
table country*q11_7;
title 'AUS-Education';
run;

proc means data=Aus_validation_pass;
var q11_6 q11_4 q11_5;
title 'AUS-Age,Family Size, Kids';
run;

*Spain;
proc freq data=spain_validation_pass;
table country*q11_3;
title 'Spain-income';
run;

proc freq data=spain_validation_pass;
table country*q11_2;
title 'Spain-Employment';
run;

proc freq data=spain_validation_pass;
table country*q11_8;
title 'Spain-Education';
run;

proc means data=spain_validation_pass;
var q11_7 q11_4 q11_5;
title 'Spain-Age,Family Size, Kids';
run;

* Average Comfortability Levels for Information Treatments and countries;
proc means data=us_validation_pass;
var q4_1 q5_1 q6_1 q7_2 q8_1 total_cd total_tech total_nes;
title 'US-Average Comfortable Info Treatments'; 
run;

proc means data=aus_validation_pass;
var q4_1 q5_1 q6_1 q7_2 q8_1 total_cd total_tech total_nes;
title 'AUS-Average Comfortable Info Treatments'; 
run;

proc means data=spain_validation_pass;
var q4_1 q5_1 q6_1 q7_2 q8_1 total_cd total_tech total_nes;
title 'spain-Average Comfortable Info Treatments'; 
run;
