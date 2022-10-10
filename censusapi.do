local out D:\Data\ACS\income

foreach year of numlist 2014/2018 {
	censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(B19013)") predicate("for=zip%20code%20tabulation%20area:*") destination("`out'\\B19013_`year'_zcta.txt")
}

* Clean SDH variables
* Extract ZCTA-level 2016 and 2017 Variables from Census

/*
median_household_income  B19013
p_uninsured 			 S2701 B27001
p_unemploy 				 S2301
p_no_highschool          B15003
food_index 
p_noncitizen 			 B05001
p_nonwhite               B02001  
p_association 
p_severehousing          
p_exercise_access 
p_rural_pop
*/

local out D:\Data\ACS\2017_ZCTA

global detail  B19013 B15003 B05001 B02001
global detail2 B19013 B15002 B05001 B02001
global subject1 S2701_C05_001E S2301_C04_001E
global detail3 B27001
global subject2 S2301_C04_001E

foreach year of numlist 2016 2017 {
	foreach x1 in $detail {
	censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=zip%20code%20tabulation%20area:*") destination("`out'\\`x1'_`year'_zcta.txt")
	clear
	}
}

foreach year of numlist 2009 {
	foreach x2 in $detail2 {
	censusapi, url("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x2')&for=county:*")  destination("`out'\\`x2'_`year'_fips.txt")
	clear
	}
}


********************************
foreach year of numlist 2016 2017 {
	foreach x3 in $subject1 {
	censusapi, url("https://api.census.gov/data/`year'/acs/acs5/subject?get=NAME,`x3'&for=zip%20code%20tabulation%20area:*") destination("`out'\\`x3'_`year'_zcta.txt")
	clear
	}
}

* Insurance, number
foreach year of numlist 2016 2017 {
	censusapi, url("https://api.census.gov/data/`year'/acs/acs5/subject?get=NAME,S2701_C01_001E&for=zip%20code%20tabulation%20area:*") destination("`out'\\S2701_C01_001E_`year'_zcta.txt")
		censusapi, url("https://api.census.gov/data/`year'/acs/acs5/subject?get=NAME,S2701_C04_001E&for=zip%20code%20tabulation%20area:*") destination("`out'\\S2701_C04_001E_`year'_zcta.txt")

	clear
}

* Employment demo
foreach year of numlist 2016 2017 {
	censusapi, url("https://api.census.gov/data/`year'/acs/acs5/subject?get=NAME,S2301_C01_001E&for=zip%20code%20tabulation%20area:*") destination("`out'\\S2301_C01_001E`year'_zcta.txt")
	clear
}

* Insurance
foreach year of numlist 2010 {
	foreach x4 in $detail3 {
	censusapi, url("https://api.census.gov/data/`year'/acs/acs1?get=NAME,group(`x4')&for=county:*")  destination("`out'\\`x4'_`year'_fips.txt")
	clear
	}
}

* Employment
foreach year of numlist 2010 {
	foreach x5 in $subject2 {
	censusapi, url("https://api.census.gov/data/`year'/acs/acs5/subject?get=NAME,`x5'&for=county:*")  destination("`out'\\`x5'_`year'_fips.txt")
	clear
	}
}

* Employment denominator
censusapi, url("https://api.census.gov/data/2010/acs/acs5/subject?get=NAME,S2301_C01_001E&for=county:*")  destination("`out'\\S2301_C01_001E_2010_fips.txt")
clear

* Use 2012 insurance 5-year estimate for 2007
foreach year of numlist 2012 {
	censusapi, url("https://api.census.gov/data/`year'/acs/acs5/subject?get=NAME,S2701_C03_001E&for=zip%20code%20tabulation%20area:*") destination("`out'\\S2701_C03_001E_`year'_zcta.txt")
	censusapi, url("https://api.census.gov/data/`year'/acs/acs5/subject?get=NAME,S2701_C02_001E&for=zip%20code%20tabulation%20area:*") destination("`out'\\S2701_C02_001E_`year'_zcta.txt")
	censusapi, url("https://api.census.gov/data/`year'/acs/acs5/subject?get=NAME,S2701_C01_001E&for=zip%20code%20tabulation%20area:*") destination("`out'\\S2701_C01_001E_`year'_zcta.txt")
	clear
}
***************
* Data extract for medication adherence project, census block group level
local out D:\Data\ACS

global detail  B15003 B23025 B17021

global CT  "000" "001"	"003"	"005"	"007"	"009"	"011"	"013"	"015"
foreach state of numlist 9  {
	foreach county in $CT {
		foreach year of numlist 2013/2016 {
			foreach x1 in $detail {
			capture censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=block%20group:*&in=state:0`state'%20county:`county'") destination("`out'\\`x1'_`year'_`state'_`county'.txt")
			clear
			}
		}
	}

}

local out D:\Data\ACS

global detail  B19013 B15003 B23025 B17021
global NJ "000"	"001" "003" "005" "007"	"009" "011"	"013" "015"	"017" "019"	"021" "023"	"025" "027"	"029" "031"	"033" "035"	"037" "039"	"041"

foreach state of numlist 34 {
	foreach county in $NJ  {
		foreach year of numlist 2013/2016 {
			foreach x1 in $detail {
			capture censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=block%20group:*&in=state:`state'%20county:`county'") destination("`out'\\`x1'_`year'_`state'_`county'.txt")
			clear
			}
		}
	}
}



global NY "000" "001" "003"	"005" "007"	"009" "011"	"013" "015"	"017" "019"	"021" "023"	"025" "027"	"029" "031"	"033" "035"	"037" "039"	"041" "043"	"045"	"047" "049"	"051" "053"	"055" "057"	"059" "061"	"063" "065"	"067" "069"	"071" "073"	"075" "077"	"079" "081"	"083" "085"	"087" "089"	"091" "093"	"095"	"097" "099"	"101"	"103"	"105"	"107"	"109"	"111"	"113"	"115"	"117"	"119"	"121"	"123"

foreach state of numlist 36 {
	foreach county in $NY {
		foreach year of numlist 2013/2016 {
			foreach x1 in $detail {
			capture censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=block%20group:*&in=state:`state'%20county:`county'") destination("`out'\\`x1'_`year'_`state'_`county'.txt")
			clear
			}
		}
	}
}

local out D:\Data\ACS
global detail  B19013 B15003 B23025 B17021

global PA "000" "001"	"003"	"005"	"007"	"009"	"011"	"013"	"015"	"017"	"019"	"021"	"023"	"025"	"027"	"029"	"031"	"033"	"035"	"037"	"039"	"041"	"043"	"045"	"047"	"049"	"051"	"053"	"055"	"057"	"059"	"061"	"063"	"065"	"067"	"069"	"071"	"073"	"075"	"077"	"079"	"081"	"083"	"085"	"087"	"089"	"091"	"093"	"095"	"097"	"099"	"101"	"103"	"105"	"107"	"109"	"111"	"113"	"115"	"117"	"119"	"121"	"123"	"125"	"127"	"129"	"131"	"133"

foreach state of numlist 42 {
	foreach county in $PA {
		foreach year of numlist 2013/2016 {
			foreach x1 in $detail {
			capture censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=block%20group:*&in=state:`state'%20county:`county'") destination("`out'\\`x1'_`year'_`state'_`county'.txt")
			clear
			}
		}
	}
}


global FL "000" "001"	"003"	"005"	"007"	"009"	"011"	"013"	"015"	"017"	"019"	"021"	      "023"	 "027"	"029"	"031"	"033"	"035"	"037"	"039"	"041"	"043"	"045"	"047"	      "049"	"051"	"053"	"055"	"057"	"059"	"061"	"063"	"065"	"067"	"069"	"071"	      "073"	"075"	"077"	"079"	"081"	"083"	"085"	"086"   "087"	"089"	"091"	"093"	     "095"	"097"	"099"	"101"	"103"	"105"	"107"	"109"	"111"	"113"	"115"	"117"	     "119"	 "121"	"123"	"125"	"127"	"129"	"131"	"133"

foreach state of numlist 12 {
	foreach county in $FL {
		foreach year of numlist 2013/2016 {
			foreach x1 in $detail {
			capture censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=block%20group:*&in=state:`state'%20county:`county'") destination("`out'\\`x1'_`year'_`state'_`county'.txt")
			clear
			}
		}
	}
}
*******************
* Revise
local out D:\Data\ACS

global detail  B19013 B15003 B23025 B17021

global PA "000" "001"	"003"	"005"	"007"	"009"	"011"	"013"	"015"	"017"	"019"	"021"	"023"	"025"	"027"	"029"	"031"	"033"	"035"	"037"	"039"	"041"	"043"	"045"	"047"	"049"	"051"	"053"	"055"	"057"	"059"	"061"	"063"	"065"	"067"	"069"	"071"	"073"	"075"	"077"	"079"	"081"	"083"	"085"	"087"	"089"	"091"	"093"	"095"	"097"	"099"	"101"	"103"	"105"	"107"	"109"	"111"	"113"	"115"	"117"	"119"	"121"	"123"	"125"	"127"	"129"	"131"	"133"

foreach state of numlist 42 {
	foreach county in $PA {
		foreach year of numlist 2013/2016 {
			foreach x1 in $detail {
			capture censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=block%20group:*&in=state:`state'%20county:`county'") destination("`out'\\`x1'_`year'_`state'_`county'.txt")
			clear
			}
		}
	}
}


global FL "000" "001"	"003"	"005"	"007"	"009"	"011"	"013"	"015"	"017"	"019"	"021"	      "023"	 "027"	"029"	"031"	"033"	"035"	"037"	"039"	"041"	"043"	"045"	"047"	      "049"	"051"	"053"	"055"	"057"	"059"	"061"	"063"	"065"	"067"	"069"	"071"	      "073"	"075"	"077"	"079"	"081"	"083"	"085"	"086"   "087"	"089"	"091"	"093"	     "095"	"097"	"099"	"101"	"103"	"105"	"107"	"109"	"111"	"113"	"115"	"117"	     "119"	 "121"	"123"	"125"	"127"	"129"	"131"	"133"

foreach state of numlist 12 {
	foreach county in $FL {
		foreach year of numlist 2013/2016 {
			foreach x1 in $detail {
			capture censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=block%20group:*&in=state:`state'%20county:`county'") destination("`out'\\`x1'_`year'_`state'_`county'.txt")
			clear
			}
		}
	}
}
*****************
local out D:\Data\ACS

global detail  B19013
global FL 	"077"

foreach state of numlist 12 {
	foreach county in $FL {
		foreach year of numlist 2013/2016 {
			foreach x1 in $detail {
			capture censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=block%20group:*&in=state:`state'%20county:`county'") destination("`out'\\`x1'_`year'_`state'_`county'.txt")
			clear
			}
		}
	}
}

************
local out D:\Data\ACS

global detail  B17021 B15003 B19013 B23025

foreach year of numlist 2013/2016 {
	foreach x1 in $detail {
	censusapi, dataset("https://api.census.gov/data/`year'/acs/acs5?get=NAME,group(`x1')") predicate("for=zip%20code%20tabulation%20area:*") destination("`out'\\`x1'_`year'_zcta.txt")
	clear
	}
}




