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
use "$data/us_q_gdp.dta", clear

/* First, define which one is your time variable. In our case, the time 
variable is named "time" */
tsset time
/* I highly recommend to start plotting your time series. You can do this 
easily with the command "tsline" */
tsline gdp
/* Augmented Dickey–Fuller unit-root test */
dfuller gdp // this test is not including a trend
dfuller gdp, trend // this test is more appropiate as it includes a trend
/* Phillips–Perron unit-root test */
pperron gdp, trend
