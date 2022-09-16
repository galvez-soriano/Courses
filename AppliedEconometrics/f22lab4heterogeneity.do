cap log close
log using f22lab4heterogeneity.log, replace
* Lines beginning with asterisk are ignored by Stata
* I use them to provide comments/notes about the analysis
* Lab 4 do file for allowing for heterogeneity in treatment effects
use nswmaledata
describe
summarize

* A1
regress re78 treated

* A2
regress re78 treated if black==1

* A3
regress re78 treated if black==0

* A4
gen treatxblack=treated*black
regress re78 treated treatxblack black
* Look at the coefficient for the interaction between treated and black, this gives the difference in program treatment effect between blacks and non-blacks. Although this coefficient is large in practical terms, we cannot reject the null hypothesis that this difference in treatment effect by race is zero (i.e., we cannot reject the null hypothesis that the treatment effect is the same for these two groups) at the 5% level of significance.  Note the SE for the coefficient for the interaction term is big: 1176.  The smallest difference in treatment effect that you could detect as significant at the 5% level is 1.96*1176, which is $2305.  Given the sample sizes (it is not only total sample size that matters, but the size of each of the four racextreatment status groups, here the smallest group is non-black treated individuals).  

* Note: Suppose I had formed an interaction between dummy for treated and dummy for being non-black (as opposed to above, which interacted treated with dummy for being black).  The data are the same, the analysis is the same, the only thing different is who is the omitted reference group.  So when you look at results, you should understand that they give same conclusions as above, but of course the sign of the coefficient for the interaction term is reversed because in above you are calculating black treatment effect minus nonblack treatment effect, and here you are calculating non-black treatment effect minus black treatment effect.

gen nonblack=1-black
gen treatxnonblack=treated*nonblack
regress re78 treated treatxnonblack nonblack


* B1 
sum re75
gen lowearn=re75<r(mean)
gen treatxlow=treated*lowearn


* B2
regress re78 treated if lowearn==1

* B3
regress re78 treated if lowearn==0

* B4
regress re78 treated treatxlow lowearn
* The point estimates suggest the program raises the later (1978) earnings of individuals who were low earners at the baseline, and does not impact the later earnings of individuals who were high earners at the baseline. Looking at the coefficient for the interaction between treated and dummy for earning below mean in 1975 in part B4, this gives the difference in program treatment effect by baseline income. Although this coefficient is large in practical terms, we cannot reject the null hypothesis that this difference in treatment effect by baseline income is zero (i.e., we cannot reject the null hypothesis that the treatment effect is the same for these two groups) at the 5% level of significance.    

* C1
gen interact1=treated*re75
regress re78 treated interact1 re75
display _b[treated]
display _b[interact1]
sum re75
display r(mean)
display _b[treated]+_b[interact1]*r(mean)
* For individuals with $0 earnings in 1975, the treatment effect is $1564. Each additional dollar of baseline income lowers the treatment effect by $0.22.  For an individual with the average baseline income of $3043, the predicted program treatment effect according to this model is $881.

* C2
gen dmre75=re75-r(mean)
gen interact2=treated*dmre75
regress re78 treated interact2 re75
* Observe that the coefficient for treated here is $881, just as we calculated in C1 using the regression coefficients and plugging in re75=$3043.

log close
