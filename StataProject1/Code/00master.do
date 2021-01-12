* Set Stata version
version 15

**************************************************
* project 1
* Developed by: Jan Valentin
* Date: 2019-08-20
**************************************************

log close _all

* Set current path
cd "K:\AUH-DACS-Research\TEMPLATE_Projectstructure\Project1\Code"

* Set global paths
global output = "../Output/"
global log = "../Log/"
global tmpdata = "../TempData/"
global rawdata = "../../Rawdatacopy/"
global LPRdata = "${rawdata}/LPR/"

* Set global values
global inclusion = mdy(01,01,2012)

* Set global strings


* Generate date of inclusion, exposure variable, date of event/censoring and outcome variable
log using "${log}/exposure_and_outcome", replace smcl name(exposure_and_outcome)
do exposure_and_outcome.do
log close exposure_and_outcome

* Preperation
putdocx clear
putdocx begin
putdocx save "${output}/results.docx", replace

* Run crude analysis
* Argument 1: longest follow-up in years
log using "${log}/crude_analysis", replace smcl name(crude_analysis)
* one year follow-up
do crude_analysis.do 1
* two year follow-up
do crude_analysis.do 2
log close crude_analysis
