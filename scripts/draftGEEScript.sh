###########################--GEE Labeling Script: takes input from .txt and .csv files and retrieves GEE-labeled peptides--###########################################

#for testing, removes files output by this script
rm output.csv
rm error.csv

DATE=$(date)
echo "$DATE"

if [ ! -e output.csv ]
then
	echo "RESULTS FROM GEE LABELING EXPERIMENT. Generated on $DATE." > output.csv
	for filename in sampleData/*
	do
        	analysis=$(basename -s ".txt" "sampleData/$filename")
		filetype=$(echo "$filename" | cut -d '.' -f 2)
		echo "Filetype is .$filetype"
		if [ $filetype = "xlsx" ]
		then
                	echo "Incompatible filetype!"
                	echo "Incompatible file: $filename cannot be input because it is a .$filetype file." >> error.csv
                	echo "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		else
			echo "Gathering data from file: $analysis"
			echo "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
			echo "GEE data from $analysis" >> output.csv
			echo "Sequence,Modifications,Count,Positions in Proteins,Abundance,Found in Sample" >> output.csv
                	if [ $filetype = "txt" ]
			then
				analysis=$(basename -s ".txt" "$filename")
				importantData=$(grep "xGEE" "$filename" | cut -d '	' -f 3,4,10,12,15,18 | sed s/"	"/","/g)
				echo "$importantData" >> output.csv
                                #######LEAVE SPACE FOR ADDITIONAL CODE. THIS SPACE IS FOR CALCULATIONS AND OTHER MANIPULATIONS TO THE EXTRACTED DATA#########

			else [ $filetype = "csv" ]
                        	analysis=$(basename -s ".csv" "$filename" | sed s/".csv"//g)
                        	importantData=$(grep "xGEE" "$filename" | cut -d ',' -f 3,4,10,12,15,18)
                        	echo "$importantData" >> output.csv
				#######LEAVE SPACE FOR ADDITIONAL CODE. THIS SPACE IS FOR CALCULATIONS AND OTHER MANIPULATIONS TO THE EXTRACTED DATA#########
			fi
		fi
	done

	if [ -e output.csv ]
	then
                echo "Results file successfully created. File preview displayed below:"
		echo ""
		#Preview the first 10 lines of output.
                head output.csv
                echo "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
	else
		echo "FATAL: results file could not be created. Please check your input files and try again."
	fi

	if [ -e error.csv ]
		then
                        echo "Error file successfully created. Unrecognized files displayed below:"
			echo ""
			#tell user which files failed analysis and preview the error file
			head error.csv
                	echo "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
		else
			echo "All good - no errors detected."
	fi
else
	echo "WARNING: This will overwrite your previous results summary."
	echo "Make sure you have moved your results summary to a new folder if you want to save it, then run this script."
fi
