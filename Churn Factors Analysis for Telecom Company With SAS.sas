/***read data from external files using data steps****/
PROC IMPORT DATAFILE="E:\Users\jxw210049\Desktop\HW\HW4\churn_telecom.csv" out=a1 dbms=csv replace;
 getnames=yes;
 DATAROW=2;
run;
/*Shows the variable names in the data*/
PROC CONTENTS data=a1;run;
proc contents data=a1 out=var_names noprint;run;
/*Suppresses observation numbers in output.*/
PROC PRINT data=a1 (obs=20);run;

/***Data Munipulation***/
/*(1)*dealt with missing data*/
/* Calculate the amount of missing valuloges for each variable */
proc means data=a1 nmiss ;output out=missing_counts nmiss=_nmiss_;run;
/* Drop variables with too many missing data*/
data a2;set a1 (drop=tot_ret crtcount rmcalls rmmou rmrev tot_ret tot_acpt pre_hnd_price last_swap lor adults income numbcars educ1 retdays hnd_webcap);run;

/*(2)dealt with  continuous variables**/
/*PROC SORT DATA=churn; BY churn; RUN; 
PROC MEANS DATA=churn; BY churn; OUTPUT OUT=means MEAN=; RUN;*/
DATA Churners NonChurners;SET a1;IF churn = 1 THEN output Churners;IF churn = 0 THEN output NonChurners;RUN;
/* Creating datasets of means of each group*/
PROC MEANS DATA = Churners;OUTPUT OUT=Churners_Means MEAN=;RUN;
PROC MEANS DATA = NonChurners;OUTPUT OUT=NonChurners_Means MEAN=;RUN;
/*Calculating percent difference between variables of the two groups*/
PROC COMPARE BASE=Churners_Means COMPARE=NonChurners_Means OUT=Means_Diff OUTDIF OUTPERCENT;RUN;
/*Transposing dataset to prepare data for sorting*/
PROC TRANSPOSE DATA=Means_Diff OUT = Means_Diff;RUN;
/*Renaming columns of transposed data for clarity*/
DATA Means_Diff;SET Means_Diff;RENAME COL1=DIFF COL2=PERCENT;RUN;
/*Sorting by percent difference*/
PROC SORT DATA=Means_Diff;BY PERCENT;RUN;
/*Prints variables sorted by percent difference between churners and non-churners*/
PROC PRINT DATA=Means_Diff;RUN;
proc corr data=a1; var churn change_mou roam_Mean rmrev blck_dat_Mean drop_dat_Mean retdays custcare_Mean threeway_Mean mou_opkd_Mean mou_cdat_Mean callfwdv_Mean;run;
/*correlation check*/
proc corr data=a1; var churn change_mou rmrev blck_dat_Mean drop_dat_Mean retdays custcare_Mean threeway_Mean mou_opkd_Mean callfwdv_Mean;run;


/*(3)dealt with categorical variales**/
data a3;set a2;
if prizm_social_one ="c" THEN b1=1;else b1=0;
if prizm_social_one ='R' THEN b2=1;else b2=0;
if prizm_social_one ='S' THEN b3=1;else b3=0;
if prizm_social_one ='T' THEN b4=1;else b4=0;
if prizm_social_one ='U' THEN b5=1;else b5=0;

if dualband ="N" THEN dualband_N=1;else dualband_N=0;
if dualband ='T' THEN dualband_T=1;else dualband_T=0;
if dualband ='U' THEN dualband_U=1;else dualband_U=0;
if dualband ='Y' THEN dualband_Y=1;else dualband_Y=0;

if marital ="A" THEN d1=1;else d1=0;
if marital ='B' THEN d2=1;else d2=0;
if marital ='M' THEN d3=1;else d3=0;
if marital ='S' THEN d4=1;else d4=0;
if marital ='U' THEN d5=1;else d5=0;

if asl_flag ='Y' THEN asl_flag_Y=1;else asl_flag_Y=0;
if asl_flag ='N' THEN asl_flag_N=1;else asl_flag_N=0;

if new_cell ='Y' THEN F1=1;else F1=0;
if new_cell ='N' THEN F2=1;else F2=0;
if new_cell ='U' THEN F2=1;else F2=0;

if creditcd ='Y' THEN creditcd_Y=1;else creditcd_Y=0;
if creditcd ='N' THEN creditcd_N=1;else creditcd_N=0;

/*find the importance*/
PROC glm DATA=a3;CLASS prizm_social_one dualband marital asl_flag new_cell creditcd ;
MODEL churn = prizm_social_one dualband marital asl_flag new_cell creditcd ;run;
/*based on result-select between asl_flag(asl_flag_Y, asl_flag_N),dualband(dualband_N dualband_T dualband_U dualband_Y),marital(d1 d2 d3 d4 d5),creditcd(creditcd_Y creditcd_N),,prizm_social_one(b1 b2 b3 b4 b5)*/


/*Q1-Create a random sample of 70,000 customers using PROC SURVEYSELECT*/
/*Creating training sample*/
PROC SURVEYSELECT
DATA=a3
METHOD=srs
n=70000
seed=39647
OUT=Training_Sample;
RUN;
/*Marking all rows in training sample*/
DATA Training_Sample;
SET Training_Sample;
selected = 1;
RUN;
/*Joining training sample with original dataset*/
DATA combined;
MERGE a3 Training_Sample;
BY Customer_ID;
RUN;
/*Creating holdout test sample by deleting training sample rows*/
DATA Test_sample;
SET combined;
IF selected = 1 THEN DELETE;
RUN;

/*Q2-Create a holdout sample with the rest of the 30000 customers (test sample)*/.
PROC PRINT DATA=Test_sample;RUN;

/*Q3-1-model exploration- logistic regression model*/
/*model-1*/
proc logistic data=Training_Sample descending; model churn = change_mou roam_Mean eqpdays  mtrcycle vceovr_Range 
cc_mou_Mean unan_dat_Mean iwylis_vce_Mean;run;
/*model 2*/
proc logistic data=Training_Sample descending; model churn = change_mou roam_Mean eqpdays  mtrcycle vceovr_Range 
cc_mou_Mean unan_dat_Mean iwylis_vce_Mean asl_flag_Y;run;
/*model 3-FINAL MODEL*/
proc logistic data=Training_Sample descending; model churn = change_mou roam_Mean eqpdays  mtrcycle vceovr_Range 
cc_mou_Mean unan_dat_Mean iwylis_vce_Mean asl_flag_Y creditcd_Y ;run;
/*check correlation*/
proc corr data=Training_Sample; var churn change_mou roam_Mean eqpdays  mtrcycle vceovr_Range
cc_mou_Mean unan_dat_Mean iwylis_vce_Mean ;run;
/*T-value*/
/* Output the T-values and confidence intervals to a dataset using ODS OUTPUT and PLM option */
ods output ParameterEstimates=ModelParams;
proc logistic data=Training_Sample descending;model churn = change_mou roam_Mean eqpdays mtrcycle vceovr_Range cc_mou_Mean unan_dat_Mean iwylis_vce_Mean asl_flag_Y creditcd_Y / cl;run;
ods output close;
/* Calculate T-values manually using the parameter estimates and standard errors */
data T_Values;set ModelParams;T_Value = Estimate / StdErr;run;
/* View the T-values in the T_Values dataset */
proc print data=T_Values;run;

/*Q3-2-*/
proc logistic data=Training_Sample descending; model churn = change_mou roam_Mean eqpdays  mtrcycle vceovr_Range cc_mou_Mean unan_dat_Mean iwylis_vce_Mean 
asl_flag_Y creditcd_Y/stb;run;


/*Q3-4*/
proc logistic data=Training_Sample descending outmodel=logistic_model; model churn = change_mou roam_Mean eqpdays  mtrcycle vceovr_Range cc_mou_Mean unan_dat_Mean iwylis_vce_Mean asl_flag_Y creditcd_Y;run;

proc logistic data=Training_Sample descending;
model churn = change_mou roam_Mean eqpdays  mtrcycle vceovr_Range cc_mou_Mean unan_dat_Mean iwylis_vce_Mean asl_flag_Y creditcd_Y;
output out = temp p=new;
store logistic_model;
run;

/* Testing test data with our model */
proc plm source=logistic_model;
score data=Test_Sample out=test_scored predicted=p / ilink;
run;

data test_scored;
set test_scored;
if p > 0.5 then predict = 1;
else predict = 0;
if predict = churn then correct_prediction = 1;
keep Customer_ID churn p predict correct_prediction;
run;

proc means data=test_scored sum;
    var correct_prediction;
run;

/* Testing train data with our model */
proc plm source=logistic_model;
score data=Training_Sample out=training_scored predicted=p / ilink;
run;

data training_scored;
set training_scored;
if p > 0.5 then predict = 1;
else predict = 0;
if predict = churn then correct_prediction = 1;
keep Customer_ID churn p predict correct_prediction;
run;

proc means data=training_scored sum;
    var correct_prediction;
run;
