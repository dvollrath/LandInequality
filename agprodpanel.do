* Do file to be used with agprodpanel.dta from "Land Distribution and International 
* Agricultural Productivity".  This do-file recreates Table 7 in the paper, and then provides
* several further regressions showing robustness checks not reported in the paper

* Table 7 - Panel regressions
* Column 1 - fixed effects - without pasture percent
xi: xtreg ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ipercirr itfr ilexp ///
    i.year if plqi~=. & leg_french~=. & ipercpast~=., fe robust

* Column 2 - fixed effects - with pasture percent
xi: xtreg ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ipercirr ///
    ipercpast itfr ilexp i.year if plqi~=. & leg_french~=. & ipercpast~=., fe robust

* Column 3 - random effects - without pasture percent
xi: xtreg ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ipercirr ///
    itfr ilexp plqi inst leg_french leg_soc leg_germ leg_scan i.year if ipercpast~=., re robust

* Column 4 - random effects - with pasture percent
xi: xtreg ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ipercirr ///
    ipercpast itfr ilexp plqi inst leg_french leg_soc leg_germ leg_scan i.year, re robust

* Column 5 - GLS with AR(1) disturbances - without pasture percent
xi: xtgls ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ipercirr ///
    itfr ilexp plqi inst leg_french leg_soc leg_germ leg_scan i.year if ipercpast~=., ///
    panels(hetero) corr(psar1)

* Column 6 - GLS with AR(1) disturbances - with pasture percent
xi: xtgls ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ipercirr ///
    ipercpast itfr ilexp plqi inst leg_french leg_soc leg_germ leg_scan i.year, ///
    panels(hetero) corr(psar1)

* Column 7 - GLS with AR(1) disturbances - including R&D control
xi: xtgls ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ipercirr ///
    ipercpast itfr ilexp ilnrdh plqi inst leg_french leg_soc leg_germ leg_scan i.year, ///
    panels(hetero) corr(psar1)


* Robustness Checks

* Random effects - using data only from every 5 years 
xi: xtreg ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ipercirr ///
    ipercpast itfr ilexp plqi inst leg_french leg_soc leg_germ leg_scan i.year ///
    if (year==1960 | year==1965 | year==1970 | year==1975 | year==1980 | year==1985 ///
    | year ==1990), re robust

* Random effects - using clustered standard errors
xi: xtreg ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ipercirr ///
    ipercpast itfr ilexp plqi inst leg_french leg_soc leg_germ leg_scan i.year ///
    , re cluster(id)

* GLS with AR(1) disturbances - including the absolute amount of land
* The production function is therefore not constrained to be constant returns to scale
xi: xtgls ilnouth idsgini ilnavgfarm ilnstockh ilnferth ilntracth ilnlaborh ilnagricland ipercirr ///
    ipercpast itfr ilexp plqi inst leg_french leg_soc leg_germ leg_scan i.year, ///
    panels(hetero) corr(psar1)





    

