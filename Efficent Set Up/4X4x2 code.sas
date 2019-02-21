
title "4X4X2 Choice set up";
proc plan ordered seed=900;
factors price=4 Funding=4  Attribute=2;
output out=enum
Price  nvals=(1.24 1.54 1.99 2.34)
Funding cvals=("Public" "Private" "Monsanto" "No Biotech")
Attribute cvals=("Seedless" "With Seeds")

run;
proc print data=enum; run;

title "Correlation between Attributes";
proc plan ordered seed=900;
factors price=4  Funding=3 Attribute=2;
output out=enum;
run;
*Correlation between attributes;
proc corr data=enum; run;

title "Block factorial design";
*Block factorial desing into 24 blocks;
*First we want to randomly arrange the orders of the 
product profiles because without randomization, there are 
certain pattern in the profiles;
data rand; set enum;
RID= rand("Uniform");;    **In this part do we still want to design 24 blocks?;
run;						** What do the blocks mean?;
data B1; set rand;
if _N_<=10;
run;
data B2; set rand;
if 10<_N_<=20;
run;

* ...........................
.............................;
*randomly drawn certain numbers of profiles from the full factorial design, with replacement;
title "Certain Profiles from full factorial design";
proc surveyselect data=enum out=Sample2 NOPRINT 
     seed=1                                         /* 1 */
     method=urs sampsize=10                          /* 2 */
     outhits;                                       /* 3 */
run;


title "Generated max D-efficiency/A-efficienty saturated design";
proc optex data=enum  coding=orth  seed=27; 
        class   price Funding Attribute;
		model price Fudning Attribute;
		generate  n=saturated method=m_federov;
		output out=Dsgn;
run;

proc print data=Dsgn; run;
*correlation between attributes;
proc corr data=Dsgn;
run;

title "Specifiy number of choice sets";
proc optex data=enum  coding=orth  seed=27; 
        class   price Funding Attribute;
		model price Funding Attribute;
		generate  n=16 method=m_federov; *Choice set specified at 16;
		output out=Dsgn;
run;

proc print data=Dsgn; run;
*correlation between attributes;
proc corr data=Dsgn;
run;

title "Do not specify number of choice sets";
proc optex data=enum  coding=orth  seed=27; 
        class   price Funding Attribute;
		model price Funding Attribute;
		generate n=26  method=m_federov;
		output out=Dsgn;
run;

proc print data=Dsgn; run;
*correlation between attributes;
proc corr data=Dsgn;
run;


