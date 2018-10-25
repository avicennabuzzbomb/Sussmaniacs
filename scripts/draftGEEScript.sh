 #takes input from .txt and .csv files

#

for filename in sampleData/*.txt
do
        analysis=$(basename -s ".txt" "sampleData/$filename")
	filetype=$(echo "$filename" | cut -d '.' -f 2)
	echo "Filetype is .$filetype"
	if [ $filetype != "xlsx" ]
	then


		echo "Gathering data from file: $analysis"
		echo "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo "GEE data from $analysis" > output.csv
		echo "Sequence,Modifications,Count,Positions in Proteins,Abundance,Found in Sample" >> output.csv
	
		analysis=$(basename -s ".txt" "$filename")

		importantData=$(grep "xGEE" "$filename" | cut -d '	' -f 3,4,10,12,15,18 | sed s/"	"/","/g)
	
		echo "$importantData" >> output.csv
	else
		echo "$filename is an incompatible filetype"
                echo "$filename is an incompatible filetype" >> output.csv
	fi
done

#rm output.csv

if [ -e output.csv ]
	then
		#Preview the first 10 lines.
                head output.csv
                echo "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		echo "Results file successfully created. File preview displayed above."
	else
		echo "FATAL: results file could not be created. Please check your input files and try again."
fi
