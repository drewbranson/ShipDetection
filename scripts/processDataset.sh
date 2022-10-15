#!/bin/bash
# enable next line for debugging purpose
# set -x 
#./processDataset.sh ShipDetection.xml SHP_DET.propterties "/media/drew/36464FC4464F8419/Data/Ukraine/BlackSea/toprocess" "/media/drew/36464FC4464F8419/Products/BlackSea_ShipDet" SHP

#./processDataset.sh ShipDetection.xml SHP_DET.propterties "/media/drew/36464FC4464F8419/Data/Ukraine/Azov/GRD" "/media/drew/36464FC4464F8419/Products/Azov_ShipDetection" SHP

#./processDataset.sh ShipDetection_van.xml SHP_DET.propterties "/media/drew/36464FC4464F8419/Data/Vancouver" "/media/drew/36464FC4464F8419/Products/Vancouver" SHP

############################################
# User Configuration
############################################

# adapt this path to your needs
# export PATH=~/progs/snap/bin:$PATH
gptPath="gpt"

# ############################################
# Command line handling
############################################

# first parameter is a path to the graph xml
graphXmlPath="$1"

# second parameter is a path to a parameter file
parameterFilePath="$2"

# use third parameter for path to source products
sourceDirectory="$3"

# use fourth parameter for path to target products
targetDirectory="$4"

# the fifth parameter is a file prefix for the target product name, typically indicating the type of processing
targetFilePrefix="$5"


# get path for  data to new directory
outputDirectory="$3/.."

   
############################################
# Helper functions
############################################
removeExtension() {
    file="$1"
    echo "$(echo "$file" | sed -r 's/\.[^\.]*$//')"
}


############################################
# Main processing
############################################

# Create the target directory
mkdir -p "${targetDirectory}"

# the d option limits the elements to loop over to directories. Remove it, if you want to use files.
for F in $(ls -1 "${sourceDirectory}"/S1*.zip); do
  sourceFile="$(realpath "$F")"
  targetFile="${targetDirectory}/${targetFilePrefix}_$(removeExtension "$(basename ${F})").dim"
  # echo  "sourceFile = "${sourceFile}", targetFile= "${targetFile}
  echo "Executing: "${gptPath} ${graphXmlPath} -q 4 -c 30G -x -Pfile=${sourceFile} -Ptarget=${targetFile} 
  ${gptPath} ${graphXmlPath} -q 4 -c 30G -x -Pfile=${sourceFile} -Ptarget=${targetFile} 
  # ${gptPath} ${graphXmlPath} -e -p ${parameterFilePath} -t ${targetFile} ${sourceFile}

  mv  -v ${sourceFile} ${outputDirectory}       # move source data to a new directory

done


