#!/bin/bash

#$(/opt/lampp/bin/mysql -u root -e "create database tester1; use tester1")
$(/opt/lampp/bin/mysql -u root -e "USE tester1; CREATE TABLE user (id int, name varchar(50))")
#$(/opt/lampp/bin/mysql -u root -e "use tester1; insert into test (name) values ('name1')")
