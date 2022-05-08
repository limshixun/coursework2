#!/bin/bash
website=https://covidnow.moh.gov.my/
#curl $website
output="output.txt"
dbName="coursework2"
daily="daily"
total="total"

function createDB(){
	
	$(/opt/lampp/bin/mysql -u root -e "create database $dbName; use $dbName");
	## daily is kind of pointless
	$(/opt/lampp/bin/mysql -u root -e "use $dbName; CREATE TABLE $daily (id int AUTO_INCREMENT, dAdministered int(10), d1stDose int(10), d2ndDose int(10), dBooster int(10), dLocalCases int(10), dimportedCases int(10), dRecovored int(10), dDeath_including_BID int(3), dBrought_in_Dead int(3), PRIMARY KEY (id));")
	$(/opt/lampp/bin/mysql -u root -e "use $dbName; CREATE TABLE $total (id int AUTO_INCREMENT, tAdministered int (10), tAt_Least1Dose int(10), t2Doses int (10), tBoosters int(10),tLocalCases int(10), tImportedCases int(10), tActiveCases int(10), recovered int, deathIncludingBID int, BroughtInDead int, date DATE,  PRIMARY KEY (id));")
	} 
      
function getSource(){
	curl -o $output $website
	}

#sed -n '/Daily - Administered/,/Total - Administered/p' testing.txt | sed -n '/+/,/</p' | cut -d '<' -f1 | sed ':a; N; s/[[:space:]]//g; ta'#

function getTAdministered(){
	sed -n '/Total - Administered/,/Daily - 1st Dose/p' $output | sed -n '/,/,/</p' | cut -d '<' -f1 | sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
}

function getTAt_Least1Dose(){
	sed -n '/Total - At Least 1 Dose/,/Daily - 2nd Dose/p' $output | sed -n '/,/,/</p' | cut -d 'N' -f1 | cut -d '<' -f1 | sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
}

function getT2Doses(){
	sed -n '/Total - 2 Doses/,/Daily - Booster/p' $output | sed -n '/,/,/</p' | cut -d 'N' -f1 | cut -d '<' -f1 | sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
}

function getTBoosters(){
	sed -n '/Total - Booster/,/Total Population/p' $output | sed -n '/,/,/</p' | cut -d '<' -f1  | cut -d 'T' -f1 |  sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
}

function getTLocalCases(){
	sed -n '/Local Cases/,/Imported Cases/p' $output | sed -n '/><span>/,/,/p' | cut -d '<' -f1 | sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
}

function getTImportedCases(){
	sed -n '/Imported Cases/,/Active Cases/p' $output | sed -n '/><span>/,/,/p' | cut -d '<' -f1 | sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
	}

function getTActiveCases(){
	sed -n '/ICUs/,/Local Cases/p' $output | sed -n '/Active Cases/,/,/p' | cut -d '<' -f1 | cut -d 'A' -f1 | sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
	}

function getDate(){
	date +"%Y-%m-%d"
}

function getRecovered(){
	sed -n '/Recovered/,/Deaths/p' $output | cut -d '<' -f1 | cut -d 'R' -f1 | cut -d '+' -f1 | sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
	}

function getDeathIncludingBID(){
	sed -n '/Deaths (including BID)/,/Brought in Dead/p' $output | cut -d '<' -f1 | cut -d 'D' -f1 | cut -d 'B' -f1 | cut -d '+' -f1 | sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
	}

function getBroughtInDead(){
	sed -n '/Brought in Dead/,/COVID-19 patients/p' $output | cut -d 'B' -f1 | cut -d '<' -f1 | cut -d 'C' -f1 | sed ':a; N; s/[[:space:]]//g; ta' | sed 's/,//g'
	}
getSource

tAdministered="$(getTAdministered)"
tAt_Least1Dose="$(getTAt_Least1Dose)"
t2Doses="$(getT2Doses)"
tBoosters="$(getTBoosters)"
tLocalCases="$(getTLocalCases)"
tImportedCases="$(getTImportedCases)"
tActiveCases="$(getTActiveCases)"
date="$(getDate)"
recovered="$(getRecovered)"
deathIncludingBID="$(getDeathIncludingBID)"
BroughtInDead="$(getBroughtInDead)"

echo "$tAdministered"
echo "$tAt_Least1Dose"
echo "$t2Doses"
echo "$tBoosters"
echo "$tLocalCases"
echo "$tImportedCases"
echo "$tActiveCases"
echo "$date"
echo "$recovered"
echo "$deathIncludingBID"
echo "$BroughtInDead"

##Main
#createDB
#getSource
#getData
