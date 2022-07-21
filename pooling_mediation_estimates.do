*Loneliness and IPVA - mixed methods paper 
*Annie Herbert November 2021
*Pooling mediation estimates within imputed datasets

*Set drives and timers
cd "Annie\Loneliness"
clear
timer clear
timer on 1

*Set globals
global exposure maltreatment
global outcome vic_1821
global medbin lonely_sc14 friends_13 lonely_13 lonely_any
global medcont mfqtot_ccs esteem
global estimate cde nde nie mte

*Get estimates created from first imputed dataset in mediation_in_imputed_data.do
import excel "female_individual_maltreatment_vic_1821_CMupdated.xlsx", sheet("1_maltreatment_vic_1821") firstrow clear
gen _mj = 1
save "female_allimputed.dta", replace

*Put all 20 together
forvalues i=2/20{
	import excel "female_individual_maltreatment_vic_1821_CMupdated.xlsx", sheet("`i'_maltreatment_vic_1821") firstrow clear
	gen _mj = `i'
	save temp.dta, replace
	use "female_allimputed.dta", clear
	append using temp.dta, force
	save "female_allimputed.dta", replace
	}
rename *, lower

*Convert betas to ORs
gen cdebeta = ln(cdeest)
gen ndebeta = ln(ndeest)
gen niebeta = ln(nieest)
gen mtebeta = ln(mteest)

*Unless the mediator is continuous
foreach med in $medcont{
	replace cdebeta = cdeest if mediator == "`med'"
	replace ndebeta = ndeest if mediator == "`med'"
	replace niebeta = nieest if mediator == "`med'"
	replace mtebeta = cdeest if mediator == "`med'"
	}
save "female_allimputed.dta", replace

*Repeat in males
import excel "male_individual_maltreatment_vic_1821_CMupdated.xlsx", sheet("1_maltreatment_vic_1821") firstrow clear
gen _mj = 1
save "male_allimputed.dta", replace

forvalues i=2/20{
		import excel "male_individual_maltreatment_vic_1821_CMupdated.xlsx", sheet("`i'_maltreatment_vic_1821") firstrow clear
	gen _mj = `i'
	save temp.dta, replace
	use "male_allimputed.dta", clear
	append using temp.dta, force
	save "male_allimputed.dta", replace
	}
rename *, lower
gen cdebeta = ln(cdeest)
gen ndebeta = ln(ndeest)
gen niebeta = ln(nieest)
gen mtebeta = ln(mteest)

foreach med in $medcont{
	replace cdebeta = cdeest if mediator == "`med'"
	replace ndebeta = ndeest if mediator == "`med'"
	replace niebeta = nieest if mediator == "`med'"
	replace mtebeta = cdeest if mediator == "`med'"
	}

save "male_allimputed.dta", replace

*Pool all estimates, working out mean, SE, CI, and p-values
local x = 1	
foreach exp in $exposure {
	foreach out in $outcome {
		foreach med in $medbin $medcont {
			use female_allimputed.dta, clear
			keep if mediator == "`med'"
			putexcel set "female_individual_`exp'_`out'_CMupdated", sheet("pooled_`exp'_`out'") modify
			putexcel A1="Exposure" B1="Outcome" C1="Mediator" ///
				D1="CDE Beta" E1="CDE SE" F1="CDE P Value" ///
				G1="NDE Beta" H1="NDE SE" I1="NDE P Value" ///
				J1="NIE Beta" K1="NIE SE" L1="NIE P Value" ///
				M1="MTE Beta" N1="MTE SE" O1="MTE P Value" ///
				P1 = "MTE LCI" Q1 = "MTE UCI" R1 = "NDE LCI" ///
				S1 = "NDE UCI"
			
			quietly: summ cdebeta
			local cde_mean = r(mean)
			gen cdese_sq = cdese^2
			quietly: summ cdese
			local cde_vw = r(sum)/20
			gen cde_diff = (cdebeta-`cde_mean')^2
			quietly: summ cde_diff
			local cde_vb = r(sum)/19
			local cde_se = `cde_vw' + `cde_vb' + (`cde_vb'/20)
			quietly: summ cdepvalue
			local cde_p = r(mean)

			quietly: summ ndebeta
			local nde_mean = r(mean)
			gen ndese_sq = ndese^2
			quietly: summ ndese
			local nde_vw = r(sum)/20
			gen nde_diff = (ndebeta-`nde_mean')^2
			quietly: summ nde_diff
			local nde_vb = r(sum)/19
			local nde_se = `nde_vw' + `nde_vb' + (`nde_vb'/20)
			quietly: summ ndepvalue
			local nde_p = r(mean)
			
			quietly: summ niebeta
			local nie_mean = r(mean)
			gen niese_sq = niese^2
			quietly: summ niese
			local nie_vw = r(sum)/20
			gen nie_diff = (niebeta-`nie_mean')^2
			quietly: summ nie_diff
			local nie_vb = r(sum)/19
			local nie_se = `nie_vw' + `nie_vb' + (`nie_vb'/20)
			quietly: summ niepvalue
			local nie_p = r(mean)
			
			quietly: summ mtebeta
			local mte_mean = r(mean)
			gen mtese_sq = mtese^2
			quietly: summ mtese
			local mte_vw = r(sum)/20
			gen mte_diff = (mtebeta-`mte_mean')^2
			quietly: summ mte_diff
			local mte_vb = r(sum)/19
			local mte_se = `mte_vw' + `mte_vb' + (`mte_vb'/20)
			quietly: summ mtepvalue
			local mte_p = r(mean)
			
			local mte_lci = `mte_mean'-1.96*`mte_se'
			local mte_uci = `mte_mean'+1.96*`mte_se'
			
			local nde_lci = `nde_mean'-1.96*`nde_se'
			local nde_uci = `nde_mean'+1.96*`nde_se'
			
			local x=`x'+1
						
			putexcel A`x'="`exp'" B`x'="`out'" C`x'="`med'" ///
			D`x'=`cde_mean' E`x'=`cde_se' F`x'=`cde_p' ///
			G`x'=`nde_mean' H`x'=`nde_se' I`x'=`nde_p' ///
			J`x'=`nie_mean' K`x'=`nie_se' L`x'=`nie_p' ///
			M`x'=`mte_mean' N`x'=`mte_se' O`x'=`mte_p' ///
			P`x'=`mte_lci'  Q`x'=`mte_uci' R`x'=`nde_lci' ///
			S`x'=`nde_uci'
			}
		}
	}

*Repeat in men
local x = 1	
foreach exp in $exposure {
	foreach out in $outcome {
		foreach med in $medbin $medcont {
			use male_allimputed.dta, clear
			rename *, lower
			keep if mediator == "`med'"
			putexcel set "male_individual_`exp'_`out'_CMupdated", sheet("pooled_`exp'_`out'") modify
			putexcel A1="Exposure" B1="Outcome" C1="Mediator" ///
				D1="CDE Beta" E1="CDE SE" F1="CDE P Value" ///
				G1="NDE Beta" H1="NDE SE" I1="NDE P Value" ///
				J1="NIE Beta" K1="NIE SE" L1="NIE P Value" ///
				M1="MTE Beta" N1="MTE SE" O1="MTE P Value" ///
				P1 = "MTE LCI" Q1 = "MTE UCI" R1 = "NDE LCI" ///
				S1 = "NDE UCI"
		
			quietly: summ cdebeta
			local cde_mean = r(mean)
			gen cdese_sq = cdese^2
			quietly: summ cdese
			local cde_vw = r(sum)/20
			gen cde_diff = (cdebeta-`cde_mean')^2
			quietly: summ cde_diff
			local cde_vb = r(sum)/19
			local cde_se = `cde_vw' + `cde_vb' + (`cde_vb'/20)
			quietly: summ cdepvalue
			local cde_p = r(mean)

			quietly: summ ndebeta
			local nde_mean = r(mean)
			gen ndese_sq = ndese^2
			quietly: summ ndese
			local nde_vw = r(sum)/20
			gen nde_diff = (ndebeta-`nde_mean')^2
			quietly: summ nde_diff
			local nde_vb = r(sum)/19
			local nde_se = `nde_vw' + `nde_vb' + (`nde_vb'/20)
			quietly: summ ndepvalue
			local nde_p = r(mean)
			
			quietly: summ niebeta
			local nie_mean = r(mean)
			gen niese_sq = niese^2
			quietly: summ niese
			local nie_vw = r(sum)/20
			gen nie_diff = (niebeta-`nie_mean')^2
			quietly: summ nie_diff
			local nie_vb = r(sum)/19
			local nie_se = `nie_vw' + `nie_vb' + (`nie_vb'/20)
			quietly: summ niepvalue
			local nie_p = r(mean)
			
			quietly: summ mtebeta
			local mte_mean = r(mean)
			gen mtese_sq = mtese^2
			quietly: summ mtese
			local mte_vw = r(sum)/20
			gen mte_diff = (mtebeta-`mte_mean')^2
			quietly: summ mte_diff
			local mte_vb = r(sum)/19
			local mte_se = `mte_vw' + `mte_vb' + (`mte_vb'/20)
			quietly: summ mtepvalue
			local mte_p = r(mean)
			
			local mte_lci = `mte_mean'-1.96*`mte_se'
			local mte_uci = `mte_mean'+1.96*`mte_se'
			
			local nde_lci = `nde_mean'-1.96*`nde_se'
			local nde_uci = `nde_mean'+1.96*`nde_se'
			
			local x=`x'+1
						
			putexcel A`x'="`exp'" B`x'="`out'" C`x'="`med'" ///
			D`x'=`cde_mean' E`x'=`cde_se' F`x'=`cde_p' ///
			G`x'=`nde_mean' H`x'=`nde_se' I`x'=`nde_p' ///
			J`x'=`nie_mean' K`x'=`nie_se' L`x'=`nie_p' ///
			M`x'=`mte_mean' N`x'=`mte_se' O`x'=`mte_p' ///
			P`x'=`mte_lci'  Q`x'=`mte_uci' R`x'=`nde_lci' ///
			S`x'=`nde_uci'
			}
		}
	}
	
timer off 1
timer list