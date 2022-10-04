*Loneliness and IPVA - mixed methods paper 
*Annie Herbert November 2021
*Mediation within imputed datasets

timer clear
timer on 1

cd "Annie\Loneliness\Mediation"

ssc install paramed
set more off

*Setting global macros 
global exposure maltreatment

global outcome vic_1821

global medbin lonely_sc14 friends_13 lonely_13 lonely_any

global covar mz028b b032 mated singleparent

*WOMEN - take each imputed datset, use paramed, and feed out different effects, SEs, and p-values into an Excel file
local filelist: dir . files "*_female.dta"
foreach exp in $exposure {
	foreach out in $outcome {
		
		local y=0
		
		foreach file of local filelist {
			use `file', clear
	
			local x = 1	
			local y = `y'+1
		
			putexcel  set "female_ind_`exp'_`out'", sheet("`y'_`exp'_`out'") modify
			putexcel A1="Exposure" B1="Outcome" C1="Mediator" ///
			D1="CDE Est" E1="CDE SE" F1="CDE P Value" ///
			G1="NDE Est" H1="NDE SE" I1="NDE P Value" ///
			J1="NIE Est" K1="NIE SE" L1="NIE P Value" ///
			M1="MTE Est" N1="MTE SE" O1="MTE P Value"
	
			foreach med in $medbin {
				bootstrap, reps(1000) seed(91857785):   ///  
				 paramed `out', avar(`exp') mvar(`med') ///
				 cvars(`covar') ///
				 a0(0) a1(1) m(0) yreg(logistic) mreg(logistic) 
			
				mat results = e(effects)
					local cde = results[1,1]
					local cde_se = results[1,2]
					local cde_p = results[1,3]
					local nde = results[2,1]
					local nde_se = results[2,2]
					local nde_p = results[2,3]
					local nie = results[3,1]
					local nie_se = results[3,2]
					local nie_p = results[3,3]
					local mte = results[4,1]
					local mte_se = results[4,2]
					local mte_p = results[4,3]
	
				local x=`x'+1
				
				putexcel A`x'="`exp'" B`x'="`out'" C`x'="`med'" ///
				D`x'=`cde' E`x'=`cde_se' F`x'=`cde_p' ///
				G`x'=`nde' H`x'=`nde_se' I`x'=`nde_p' ///
				J`x'=`nie' K`x'=`nie_se' L`x'=`nie_p' ///
				M`x'=`mte' N`x'=`mte_se' O`x'=`mte_p'
				} 
			}
		}
	}

*Repeat for MEN	
global covar2 mz028b b032 i.mated
local filelist: dir . files "*_male.dta"

foreach exp in $exposure {
	foreach out in $outcome {
		
		local y=0
		
		foreach file of local filelist {
			use `file', clear
	
			local x = 1	
			local y = `y'+1
		
			putexcel  set "male_ind_`exp'_`out'", sheet("`y'_`exp'_`out'") modify
			putexcel A1="Exposure" B1="Outcome" C1="Mediator" ///
			D1="CDE Est" E1="CDE SE" F1="CDE P Value" ///
			G1="NDE Est" H1="NDE SE" I1="NDE P Value" ///
			J1="NIE Est" K1="NIE SE" L1="NIE P Value" ///
			M1="MTE Est" N1="MTE SE" O1="MTE P Value"
	
			foreach med in $medbin {
				bootstrap, reps(1000) seed(91857785):   ///  
				 paramed `out', avar(`exp') mvar(`med') ///
				 cvars(`covar2') ///
				 a0(0) a1(1) m(0) yreg(logistic) mreg(logistic) 
			
				mat results = e(effects)
					local cde = results[1,1]
					local cde_se = results[1,2]
					local cde_p = results[1,3]
					local nde = results[2,1]
					local nde_se = results[2,2]
					local nde_p = results[2,3]
					local nie = results[3,1]
					local nie_se = results[3,2]
					local nie_p = results[3,3]
					local mte = results[4,1]
					local mte_se = results[4,2]
					local mte_p = results[4,3]
	
				local x=`x'+1
				
				putexcel A`x'="`exp'" B`x'="`out'" C`x'="`med'" ///
				D`x'=`cde' E`x'=`cde_se' F`x'=`cde_p' ///
				G`x'=`nde' H`x'=`nde_se' I`x'=`nde_p' ///
				J`x'=`nie' K`x'=`nie_se' L`x'=`nie_p' ///
				M`x'=`mte' N`x'=`mte_se' O`x'=`mte_p'
				} 
			}
		}
	}

timer off 1
timer list
