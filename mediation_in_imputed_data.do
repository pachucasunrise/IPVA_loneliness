*Loneliness and IPVA - mixed methods paper 
*Annie Herbert November 2021
*Mediation within imputed datasets

timer clear
timer on 1

cd "Annie\Loneliness\Mediation"

ssc install paramed
set more off

*Setting global macros 
global exposure emotional_ab physical_abu sexual_abuse maltreatment bullying_0_1 mentl_hlth_p ace

global outcome vic_1821

global medbin lonely_sc14 friends_13 lonely_13 lonely_any

global medcont mfqtot_ccs 

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

			foreach med in $medcont {
				bootstrap, reps(1000) seed(91857785):   ///  
				 paramed `out', avar(`exp') mvar(`med') ///
				 cvars(`covar') ///
				 a0(0) a1(1) m(0) yreg(logistic) mreg(linear) 
			
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

*For some exposures, paramed would only work with a subset of the outcomes, given sparse data

*Emotional neglect & violence between parents & substance_household_0_12yrs & parental_conviction with lonely_sc14 and lonely_13 only (too sparse for outcome friends_13)
global exposure2 emotional_ne violence_bet substance_ho parent_convi
global medbin2 lonely_sc14 lonely_13
local filelist: dir . files "*_female.dta"

foreach exp in $exposure2 {
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
	
			foreach med in $medbin2 {
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

			foreach med in $medcont {
				bootstrap, reps(1000) seed(91857785):   ///  
				 paramed `out', avar(`exp') mvar(`med') ///
				 cvars(`covar') ///
				 a0(0) a1(1) m(0) yreg(logistic) mreg(linear) 
			
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

global outcome vic_1821
global medbin lonely_sc14 friends_13 lonely_13 lonely_any
global medcont mfqtot_ccs 
global covar2 mz028b b032 i.mated
local filelist: dir . files "*_female.dta"

*Parental separation without single parent as a covariate
foreach out in $outcome {
	
	local y=0
	
	foreach file of local filelist {
		use `file', clear

		local x = 1	
		local y = `y'+1
	
		putexcel  set "female_ind_parentalsep_`out'", sheet("`y'_parentalsep_`out'") modify
		putexcel A1="Exposure" B1="Outcome" C1="Mediator" ///
		D1="CDE Est" E1="CDE SE" F1="CDE P Value" ///
		G1="NDE Est" H1="NDE SE" I1="NDE P Value" ///
		J1="NIE Est" K1="NIE SE" L1="NIE P Value" ///
		M1="MTE Est" N1="MTE SE" O1="MTE P Value"

		foreach med in $medbin {
			bootstrap, reps(1000) seed(91857785):   ///  
			 paramed `out', avar(parental_sep) mvar(`med') ///
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
			
			putexcel A`x'="parental_sep" B`x'="`out'" C`x'="`med'" ///
			D`x'=`cde' E`x'=`cde_se' F`x'=`cde_p' ///
			G`x'=`nde' H`x'=`nde_se' I`x'=`nde_p' ///
			J`x'=`nie' K`x'=`nie_se' L`x'=`nie_p' ///
			M`x'=`mte' N`x'=`mte_se' O`x'=`mte_p'
			} 

		foreach med in $medcont {
			bootstrap, reps(1000) seed(91857785):   ///  
			 paramed `out', avar(parental_sep) mvar(`med') ///
			 cvars(`covar2') ///
			 a0(0) a1(1) m(0) yreg(logistic) mreg(linear) 
		
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
			
			putexcel A`x'="parental_sep" B`x'="`out'" C`x'="`med'" ///
			D`x'=`cde' E`x'=`cde_se' F`x'=`cde_p' ///
			G`x'=`nde' H`x'=`nde_se' I`x'=`nde_p' ///
			J`x'=`nie' K`x'=`nie_se' L`x'=`nie_p' ///
			M`x'=`mte' N`x'=`mte_se' O`x'=`mte_p'
			}
		}
	}

*Repeat for MEN	
global exposure2 maltreatment mentl_hlth_p ace
global outcome vic_1821
global medbin lonely_sc14 friends_13 lonely_13 lonely_any
global medcont mfqtot_ccs 
global covar2 mz028b b032 i.mated

local filelist: dir . files "*_male.dta"

foreach exp in $exposure2 {
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

			foreach med in $medcont {
				bootstrap, reps(1000) seed(91857785):   ///  
				 paramed `out', avar(`exp') mvar(`med') ///
				 cvars(`covar2') ///
				 a0(0) a1(1) m(0) yreg(logistic) mreg(linear) 
			
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
	
*Physical abuse, violence_bet (lonely_sc14 and friends_13 only, data too sparse for outcome lonely_13)
global exposure3 violence_bet
global outcome vic_1821
global medbin2 lonely_sc14 friends_13
global medcont mfqtot_ccs 
global covar2 mz028b b032 i.mated

local filelist: dir . files "*_male.dta"
foreach exp in $exposure3 {
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

			foreach med in $medbin2 {
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

			foreach med in $medcont {
				bootstrap, reps(1000) seed(91857785):   ///  
				 paramed `out', avar(`exp') mvar(`med') ///
				 cvars(`covar2') ///
				 a0(0) a1(1) m(0) yreg(logistic) mreg(linear) 
			
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

*Physical abuse (lonely_sc14 only, data too sparse for the two other outcomes)
global exposure3 physical_abu 
global outcome vic_1821
global medbin3 lonely_sc14
global medcont mfqtot_ccs 
global covar2 mz028b b032 i.mated

local filelist: dir . files "*_male.dta"
foreach exp in $exposure3 {
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

			foreach med in $medbin3 {
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

			foreach med in $medcont {
				bootstrap, reps(1000) seed(91857785):   ///  
				 paramed `out', avar(`exp') mvar(`med') ///
				 cvars(`covar2') ///
				 a0(0) a1(1) m(0) yreg(logistic) mreg(linear) 
			
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

*Bullying and substance misuse (lonely_13 only)
global exposure4 bullying_0_1 substance_ho
global outcome vic_1821
global medbin4 lonely_13
global medcont mfqtot_ccs 
global covar2 sex mz028b b032 mated

local filelist: dir . files "*_male.dta"
foreach exp in $exposure4 {
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

			foreach med in $medbin4 {
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

			foreach med in $medcont {
				bootstrap, reps(1000) seed(91857785):   ///  
				 paramed `out', avar(`exp') mvar(`med') ///
				 cvars(`covar2') ///
				 a0(0) a1(1) m(0) yreg(logistic) mreg(linear) 
			
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
	
*Data too sparse in all cases when sexual abuse and parent_convi  considered as exposures

timer off 1
timer list