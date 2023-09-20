use "C:\Users\JXW210049\Desktop\dataset (1).dta"
describe
summarize

#y
histogram crimerate, discrete width(500) percent addlabel
(start=0, width=500)

#umem-log -postive
gen lcrimerate=log( crimerate )
reg crimerate unem
regress crimerate unem pop inc age poverty police drop church iswhite
twoway (scatter crimerate unem)
reg lcrimerate unem
twoway (scatter lcrimerate unem)

#age-negetive-significant
reg crimerate age
reg lcrimerate age
regress lcrimerate unem pop inc age poverty police drop church iswhite
twoway (scatter lcrimerate age)
twoway (scatter crimerate age)

#poverty-not significant-horizontal distribution
reg  crimerate poverty
reg  lcrimerate poverty
twoway (scatter crimerate poverty )
twoway (scatter lcrimerate poverty )

gen lpoverty =log(poverty)
reg  lcrimerate lpoverty

#drop out rate-log-postive-significant
reg crimerate drop
reg lcrimerate drop
twoway (scatter lcrimerate  drop )
twoway (scatter crimerate  drop )


#income-media income-sample bias-horizontal distribution
twoway (scatter lcrimerate inc )
twoway (scatter crimerate inc )
reg crimerate inc
reg lcrimerate inc

#police-log-negetive-significant
reg crimerate police
twoway (scatter lcrimerate police )
twoway (scatter crimerate police )
reg crimerate police
reg lcrimerate police

#church-log-negetive-significant
reg lcrimerate church
reg crimerate church
twoway(scatter crimerate church)
twoway(scatter lcrimerate church)
reg crimerate church

#race-log-significant-dummy variable
graph pie, over(iswhite)
graph box white
reg crimerate iswhite
reg lcrimerate iswhite

#model with Quadratics-income-no log-negetive-significant
gen insqr=inc^2
reg lcrimerate inc insqr
reg crimerate inc insqr
reg lcrimerate insqr
regress crimerate unem pop inc age poverty police drop church iswhite insqr 
regress lcrimerate unem pop inc age poverty police drop church iswhite insqr 

#model with interation

gen ageinc= inc * age
reg lcrimerate age inc ageinc
regress lcrimerate unem pop inc age poverty police drop church iswhite ageinc

gen incunem= inc * unem
reg lcrimerate inc unem incunem
regress lcrimerate unem pop inc age poverty police drop church iswhite incunem

gen incpoverty= inc * poverty
reg lcrimerate inc poverty incpoverty
regress lcrimerate unem pop inc age poverty police drop church iswhite incpoverty

regress crimerate unem pop inc age poverty police drop church iswhite ageinc


#Above are Static Models:A time series model where only contemporaneous explanatory variables affect the dependent variable.


#FDL model-A dynamic model where one or more explanatory variables are allowed to have lagged effects on the dependent variable-div rate

reg crimerate div2015
reg lcrimerate div2015

reg lcrimerate div2010
reg crimerate div2010

reg div2015 div2010
test div2015 div2010
 
#Instrumental variables 2SLS regression 
regress lcrimerate unem  inc age poverty police drop church iswhite ageinc div2015 div2010
ivregress 2sls lcrimerate unem  inc age poverty police drop church iswhite ageinc (div2015=div2010)

#final
regress lcrimerate unem  inc age poverty police drop church iswhite ageinc div2015








