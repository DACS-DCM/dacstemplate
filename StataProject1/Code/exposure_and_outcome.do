


* Read LPR data
use "${LPRdata}/lpr_adm.dta", replace

* Exposure: Incident ICD10 A*** diagnosis compared to incident ICD10 B*** and C***
generate exposure = regexm(C_ADIAG,"^DA")

* Outcome: ???
generate outcome = 1

* Time to outcome event
generate eventdate = D_UDDTO
format %td eventdate 

* Save modified data
save "${tmpdata}/exposure_and_outcome.dta", replace
