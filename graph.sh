 #!/bin/bash

table1=$(/opt/lampp/bin/mysql -u root -e "USE coursework2; SELECT tActiveCases, date FROM total")
echo "# $table1" > graphData.txt

gnuplot << EOF
	set title "Total Active covid cases in malaysia"
	set xLabel "Date"
	set yLabel "Total Active case"
	set xdata time
	set timefmt '%Y-%m-%d'
	set terminal png size 1980,1080
	set output "$HOME/graph.png"
	plot "graphData.txt" using 2:1 with lines notitle
EOF
rm graphData.txt
