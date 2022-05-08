#!/bin/bash

website=https://covidnow.moh.gov.my/
#curl $website

dbName="coursework2"
daily="daily"
total="total"

function createDB(){
        
        $(/opt/lampp/bin/mysql -u root -e "create database $dbName; use $dbName");
        $(/opt/lampp/bin/mysql -u root -e "use $dbName; CREATE TABLE $daily (id int AUTO_INCREMENT, dAdministered int(10), d1stDose int(10),>
        $(/opt/lampp/bin/mysql -u root -e "use $dbName; CREATE TABLE $total (id int AUTO_INCREMENT, tAdministered int (10), tAt_Least1Dose i>
        } 

createDB
