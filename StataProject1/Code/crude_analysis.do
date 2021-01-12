
graph drop _all

* Store arguments
local longestfollowup = `1'

* Read data for analysis
use "${tmpdata}/exposure_and_outcome.dta", replace

* Redefine outcome according to longest follow up
generate tmp_outcome = outcome
replace tmp_outcome = (eventdate <= ${inclusion} + 365.25*`longestfollowup' & outcome == 1)

* Set exit date: at outcome event or administrative censoring
generate exit = eventdate
replace exit = ${inclusion} + 365.25*`longestfollowup' if eventdate > ${inclusion} + 365.25*`longestfollowup'

* Set up for survival analysis - time since inclusion date
stset eventdate, failure(tmp_outcome) origin(time ${inclusion}) scale(365.25) exit(exit)

* Conduct Cox regression
stcox exposure

* Generate Kaplan-Meier plot and export to png
sts graph, by(exposure) name(KM`longestfollowup')
graph export "${output}/KM`longestfollowup'.png", replace

* Put results in a docx document
putdocx begin
* Rerun cox put results in docx
stcox exposure
putdocx table reg = etable, title("Cox regression analysis") note("`longestfollowup' year follow-up")
* Put Kaplan-Meier plot in docx
putdocx paragraph, halign(center)
putdocx image "${output}/KM`longestfollowup'.png"
putdocx pagebreak
* Save document
putdocx save "${output}/results.docx", append


