PROC IMPORT OUT= WORK.full_data 
            DATAFILE= "E:\GM Project copy\Choice Experiment\US\Short\us_
full.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
ods rtf file= 'E:\GM Project copy\Choice Experiment\2nd Estimation\US_results.rtf';
data full_data; set work.full_data;

*Create Age variable;
*Convert age into numeric;
age=Q11_7 + 16;

*Divide income into 3 categorgies: Low (0-34,999) Medium (35,000-99,999) and high (100,000 or more);
if Q11_3 <3 then income=1;
if Q11_3 = 3 then income=2;
if Q11_3 =4 then income=2;
if Q11_3=5 then income=2;
if q11_3 >5 then income=3;

*DIvide education into three categories: High School, College, Graduate School;
if q11_8 <3 then edu=1;
if q11_8 =3 then edu=2;
if q11_8=4 then edu=2;
if q11_8 >4 then edu=3;

gender=Q11_1;

run;

proc glm data=full_data order=freq;
class income edu gender;
model WTP_mon=age income edu gender total_CD total_tech total_NES total_con mon_t emo_t sim_t ben_t  / solution ss3;
run;

proc reg data=full_data;
model WTP_mon=age income edu gender total_CD total_tech total_NES total_con mon_t emo_t sim_t ben_t ;
run;

proc means data=full_data;
var age;
run;
ods rtf close;
