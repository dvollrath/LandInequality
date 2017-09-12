* Do file to be used with agprodols.dta from "Land Distribution and International 
* Agricultural Productivity".  This do-file recreates Table 5 in the paper
* A note on variable names.  Variables with an "i" prefix include values that were
* interpolated, please see Appendix A for a description of the technique used

* Table 5 - OLS regressions
* Column 1 
reg ilnouth dsgini lnavgfarm ///
	if ipercpast~=. & inst~=. & leg_french~=. & plqi~=. & ipercirr~=., robust

* Column 2 - including inputs only
reg ilnouth dsgini lnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ///
    if ipercpast~=. & inst~=. & leg_french~=. & plqi~=. & ipercirr~=., robust

* Column 3 - including inputs, land quality, and irrigation
reg ilnouth dsgini lnavgfarm ilnstockh ilnferth ilntracth ilnlaborh plqi ipercirr ///
    if ipercpast~=. & inst~=. & leg_french~=. , robust

* Column 4 - including inputs, land quality, irrigation, and percent pasture
reg ilnouth dsgini lnavgfarm ilnstockh ilnferth ilntracth ilnlaborh plqi ipercirr ///
    ipercpast if inst~=. & leg_french~=.  , robust

* Column 5 - including all controls but without percent pasture
reg ilnouth dsgini lnavgfarm ilnstockh ilnferth ilntracth ilnlaborh plqi ipercirr ///
    ilexp itfr inst leg_french leg_soc leg_scan leg_germ if ipercpast~=., robust

* Column 6 - including all controls with percent pasture
reg ilnouth dsgini lnavgfarm ilnstockh ilnferth ilntracth ilnlaborh plqi ipercirr ///
    ipercpast ilexp itfr inst leg_french leg_soc leg_scan leg_germ, robust

* Column 7 - including all controls with percent pasture
reg ilnouth dsgini lnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ilnrdh plqi ipercirr ///
    ipercpast ilexp itfr inst leg_french leg_soc leg_scan leg_germ, robust


    

