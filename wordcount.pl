#!/usr/bin/perl -w
use strict;

#  Check to make sure that the number of command line arguments
#  in the ARGV array is at least 1; if not, print out an error message
#  and die
if (@ARGV < 1) {
	die "You must specifiy the name of the file to open.";
}
#  Open the file specified by the file in the first element of the ARGV
#  array; if this fails, print out an error message and die
#  First argument to open is a filehandle to be used later; second is 
#  the name of the file to be opened
# my $filename = $ARGV[0];
open (DECLFILE, $ARGV[0] ) 
	or die "Cannot find the file.";
#  Read all of the lines in the document into an array named @lines
chomp (my @lines = <DECLFILE> );
# print @lines;

#  Declare an initially empty hash named wordcounts
my %wordcounts;
#  Iterate over the lines in the file
foreach (@lines) {
	#  Convert any upper case letters to lower case
	tr/A-Z/a-z/;

	#  Convert any non letters into spaces; the c at the end of the 
	#  tr operator causes the search list (the first blank) to be 
	#  complemented
	tr/a-z/ /c;

	#  Use split to break the line up by spaces and put 
	#  the result into an array named @words
	my @words = split(" ", $_);

	#  Iterate over the words in @words, and increment the number of times
	#  that each have been seen
	foreach (@words) {
			$wordcounts{$_} += 1;
	}
}
#print $wordcounts{"would"};
#  Sort the stored counts in descending order, storing the result
#  in an array
#  The first blank is an anonymous function that sort will use to compare 
#  two elements from the list being sorted.  The values being compared can 
#  be referenced within this function as the scalars $a and $b.
my @descending_values = sort {$b <=> $a} values %wordcounts;

#  Figure out the boundary number of occurrences that should be skipped,
#  if any, by looking for a second command line argument
# my $boundary = 0;
# if((@ARGV == 2) & ($ARGV[1] != 0)){	
		# $boundary = $descending_values[$ARGV[1] - 1];	
# }
#  Iterate over the words in the hash (sorted alphabetically), and print
#  them out (possibly skipping words that occur too frequently)
foreach (sort keys %wordcounts) {
	if((@ARGV == 2)){	
		if(($ARGV[1] != 0)){
			my $boundary = $descending_values[$ARGV[1] - 1];
			if($wordcounts{$_} < $boundary){		
				print $_ . ": ". $wordcounts{$_} . "\n"; 
			}
		}
		else{
			print $_ . ": ". $wordcounts{$_} . "\n";
		}
		
	}
	else{
		print $_ . ": ". $wordcounts{$_} . "\n"; 
	} 	

}

#  Print the total number of unique words that were seen in the document
print "Total unique words in decl.txt: ". scalar keys %wordcounts;

