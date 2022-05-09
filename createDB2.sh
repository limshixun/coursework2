#!/bin/bash

website=https://covidnow.moh.gov.my/
#curl $website

dbName="coursework2"
daily="daily"
total="total"


function createDB(){
        
        $(/opt/lampp/bin/mysql -u root -e "create database $dbName; use $dbName");
        $(/opt/lampp/bin/mysql -u root -e "use $dbName; CREATE TABLE $total (id int AUTO_INCREMENT, tAdministered int (10), tAtLeast1Dose int(10), t2Doses int (10), tBoosters int(10),tLocalCases int(10), tImportedCases int(10), tActiveCases int(10), recovered int, deathIncludingBID int, BroughtInDead int, date DATE, PRIMARY KEY (id));")
        } 

createDB
