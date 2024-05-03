*========================================================================*
/* ECON 13310 - Introduction to Macroeconomic Analysis */
*========================================================================*
/* Professor Oscar Galvez-Soriano */
*========================================================================*
clear
set more off
gl data= "https://raw.githubusercontent.com/galvez-soriano/Courses/main/ECON13310"
*========================================================================*
/* 
* Useful commands to create time variable:
gen time=tq(1947q1)+_n-1
format time %tq
 */
*========================================================================*
use "$data/example.dta", clear

/* First, define which one is your time variable. In our case, the time 
variable is named "time" */
tsset time
/* I highly recommend to start plotting your time series. You can do this 
easily with the command "tsline" */
tsline x
/* The next step is to plot the autocorrelogram */
ac x
/* Now, model accordingly */
arima x, ma(1)
/* Verify the autocorrelogram of the residuals */
predict resid_x, residuals
ac resid_x
/* If there is a residual significant correlation, repeat the process */
*========================================================================*
/* Now try yourself with variables y and z */
*========================================================================*
tsline y

*========================================================================*
tsline z

*========================================================================*
/* Finally, you are going to practice modeling the US GDP */
*========================================================================*
use "$data/us_q_gdp.dta", clear

/* First, define which one is your time variable. In our case, the time 
variable is named "time" */
tsset time
/* I highly recommend to start plotting your time series. You can do this 
easily with the command "tsline" */
tsline gdp

