dm "log; clear; output; clear";


*Import all small data sets to concatenate into one large data set;

*Monsanto Info Treatment;
PROC IMPORT OUT= WORK.monsanto 
            DATAFILE= "E:\GM Project copy\Choice Experiment\US\Short\us_monsanto.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc stdize data=monsanto reponly MISSING=0 out=monsanto;
var _numeric_; run;

*Emotional Info Treatment;
PROC IMPORT OUT= WORK.emotional
            DATAFILE= "E:\GM Project copy\Choice Experiment\US\Short\us_emo.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc stdize data=emotional reponly MISSING=0 out=emotional;
var _numeric_; run;

*Simple Info Treatment;
PROC IMPORT OUT= WORK.simple
            DATAFILE= "E:\GM Project copy\Choice Experiment\US\Short\us_sim.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc stdize data=simple reponly MISSING=0 out=simple;
var _numeric_; run;

*Benefit Info Treatment;
PROC IMPORT OUT= WORK.benefit
            DATAFILE= "E:\GM Project copy\Choice Experiment\US\Short\us_ben.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc stdize data=benefit reponly MISSING=0 out=benefit;
var _numeric_; run;

*Control;
PROC IMPORT OUT= WORK.control
            DATAFILE= "E:\GM Project copy\Choice Experiment\US\Short\us_control.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

proc stdize data=control reponly MISSING=0 out=control;
var _numeric_; run;

*Stack all information treatments on top of each other to get full country sample;
data us_full;
set benefit control emotional monsanto simple;
run;
