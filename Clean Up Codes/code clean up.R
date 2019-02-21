rm (list=ls())
dta <- read.csv(file="/users/Joanna/desktop/GM Project/US_Results.csv", sep =",",dec=".",header = TRUE)

data.matrix(dta)

#Keep only respondents that have answered the validation question correctly

valid<-subset(dta, Q3.5_Validation==2, select=V1:LocationAccuracy)

#Convert all data in scale questions to numeric values
for (i in 37:75){
  valid[,i]<-as.numeric(as.character(valid[,i]))
}


#Combine Foodie Questions for total
valid[,'total_con']<-valid[,'CON_1']+valid[,'CON_2']+valid[,'CON_3']+valid[,'CON_4']+valid[,'CON_5']


#Switch Reverse Coding for Scales
#1=Strongly Disagree and 7=Strongly Agree
#In reverse coding questions 1=Strongly Agree and 7=Strongly Disagree

#Corporate Distrust Scale
# Create new columns of 0 in Regular Data for Reverse Coded Numbers
valid[,"CD_4"] <- matrix(0,nrow=nrow(valid),ncol=1)
valid[,"CD_7"] <- matrix(0,nrow=nrow(valid),ncol=1)
valid[,"CD_12"] <- matrix(0,nrow=nrow(valid),ncol=1)
valid[,"CD_1"] <- matrix(0,nrow=nrow(valid),ncol=1)
valid[,"CD_13"] <- matrix(0,nrow=nrow(valid),ncol=1)
valid[,"CD_2"] <- matrix(0,nrow=nrow(valid),ncol=1)

#Reverse code questions by subtracting 8 from the reverse code
#1=7, 2=6,3=5,4=4, 5=3, 6=2, 7=1

#Start with corporate distrust scale
#Questions 4,7,12,1,13 and 2
valid[,"CD_4"]<-8-valid[,"CD_4R"]
valid[,"CD_7"]<-8-valid[,"CD_7R"]
valid[,"CD_12"]<-8-valid[,"CD_12R"]
valid[,"CD_1"]<-8-valid[,"CD_1R"]
valid[,"CD_13"]<-8-valid[,"CD_13R"]
valid[,"CD_2"]<-8-valid[,"CD_2R"]

valid[,"total_CD"]<-valid[,'CD_1'] + valid[,'CD_2'] + valid[,'CD_3']+valid[,'CD_4'] + valid[,'CD_5'] + valid[,'CD_6']+valid[,'CD_7'] + valid[,'CD_8'] + valid[,'CD_9']+valid[,'CD_10'] + valid[,'CD_11'] + valid[,'CD_12']+valid[,'CD_13']

#Reverse code tech technology scale
#Questions 3 and 5

valid[,'TECH_3']<-matrix(0,nrow=nrow(valid),ncol=1)
valid[,'TECH_5']<-matrix(0,nrow=nrow(valid),ncol=1)

valid[,'TECH_3']<-8-valid[,'TECH_3.N.']
valid[,'TECH_5']<-8-valid[,'TECH_5.N.']

valid[,'total_tech']<-valid[,'TECH_1']+valid[,'TECH_2']+valid[,'TECH_3']+valid[,'TECH_3']+valid[,'TECH_5']

#Reverse code for the New Ecological Paradigm (NEP)
#Agreement with 8 odd-numbers and disagreement with 7 even numbers are pro-NEP
#Reverse code all even numbers

valid[,'NES_2']<-matrix(0,nrow=nrow(valid),ncol=1)
valid[,'NES_4']<-matrix(0,nrow=nrow(valid),ncol=1)
valid[,'NES_6']<-matrix(0,nrow=nrow(valid),ncol=1)
valid[,'NES_8']<-matrix(0,nrow=nrow(valid),ncol=1)
valid[,'NES_10']<-matrix(0,nrow=nrow(valid),ncol=1)
valid[,'NES_12']<-matrix(0,nrow=nrow(valid),ncol=1)
valid[,'NES_14']<-matrix(0,nrow=nrow(valid),ncol=1)

valid[,'NES_2']<-8-valid[,'NES_2']
valid[,'NES_4']<-8-valid[,'NES_4']
valid[,'NES_6']<-8-valid[,'NES_6']
valid[,'NES_8']<-8-valid[,'NES_8']
valid[,'NES_10']<-8-valid[,'NES_10']
valid[,'NES_12']<-8-valid[,'NES_12']
valid[,'NES_14']<-8-valid[,'NES_14']

valid[,'total_NES']<-valid[,'NES_1']+valid[,'NES_2']+valid[,'NES_3']+
  valid[,'NES_4']+valid[,'NES_5']+valid[,'NES_6']+
  valid[,'NES_7']+valid[,'NES_8']+valid[,'NES_9']+
  valid[,'NES_10']+valid[,'NES_11']+valid[,'NES_12']+
  valid[,'NES_13']+valid[,'NES_14']+valid[,'NES_15']

require (psy)

#Check Cronbach's Alpha for all scales to test reliability
#Create Matrix for each scale to code

#Consumption Questions
con.mat<-cbind(valid[,'CON_1'] ,valid[,'CON_2'], valid[,'CON_3'], valid[,'CON_4'], valid[,'CON_5'])
colnames(con.mat)[1:5]<-c('CON_1','CON_2','CON_3','CON_4','CON_5')
cronbach(con.mat)

#Technology Scale
tech.mat<-cbind(valid[,'TECH_1'],valid[,'TECH_2'],valid[,'TECH_3'],valid[,'TECH_4'],valid[,'TECH_5'])
colnames(tech.mat)[1:5]<-c('TECH_1','TECH_2','TECH_3','TECH_4','TECH_5')
cronbach(tech.mat)

#Corporate Distrust Scale
CD.mat<-cbind(valid[,'CD_1'], valid[,'CD_2'],valid[,'CD_3'],valid[,'CD_4'] ,valid[,'CD_5'],valid[,'CD_6'],
              valid[,'CD_7'] ,valid[,'CD_8'] ,valid[,'CD_9'],valid[,'CD_10'],valid[,'CD_11'],valid[,'CD_12'],valid[,'CD_13'])
       
colnames(CD.mat)[1:13]<-c('CD_1','CD_2','CD_3','CD_4',
                          'CD_5','CD_6','CD_7','CD_8',
                          'CD_9','CD_10','CD_11','CD_12',
                          'CD_13')
cronbach(CD.mat)

#New Ecological Paradigm Scale

NES.mat<-cbind(valid[,'NES_1'],valid[,'NES_2'],valid[,'NES_3'],
               valid[,'NES_4'],valid[,'NES_5'],valid[,'NES_6'],
               valid[,'NES_7'],valid[,'NES_8'],valid[,'NES_9'],
               valid[,'NES_10'],valid[,'NES_11'],valid[,'NES_12'],
               valid[,'NES_13'],valid[,'NES_14'],valid[,'NES_15'])

colnames(NES.mat)[1:15]<-c('NES_1','NES_2','NES_3',
                           'NES_4','NES_5','NES_6',
                           'NES_7','NES_8','NES_9',
                           'NES_10','NES_11','NES_12',
                           'NES_13','NES_14','NES_15')
cronbach(NES.mat)
                    
