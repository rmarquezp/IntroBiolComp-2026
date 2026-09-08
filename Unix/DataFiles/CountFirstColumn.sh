# This script takes the first column of a file and counts the 
# Number of unique elements in it after removing the header

#Get the first columns
cut -f $2 $1 > tmp1

#Remove the header
tail -n +2  tmp1 > tmp2
 
#Count unique elements
number=`sort tmp2 | uniq | wc -l`

# Clean up temp files
rm tmp*

# Output result
echo "The number of unique elements is $number"

