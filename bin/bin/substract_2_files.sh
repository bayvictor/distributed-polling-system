# printing out the lines in fileA that don't contain the same data as any line in fileB.
#grep -F -x -v -f fileB fileA
echo "usage: $0 <basefile> <cutout_slice_fn>"

grep -F -x -v -f $2 $1 >$1--$3.txt 


