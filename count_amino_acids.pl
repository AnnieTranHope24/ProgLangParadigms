use strict;
if (@ARGV < 1) {
	die "You must specifiy the name of the file to open.";
}
elsif(@ARGV > 1){
	die "Please enter only one file name."
}
open (AMINOACIDS, $ARGV[0] ) 
	or die "File name is invalid.";
# Read a line from the file by using the angle brackets on the file handle
#Skip the header line
my $reader = <AMINOACIDS>;
my $aminoAcids= "";
while($reader = <AMINOACIDS>){
	chomp $reader;
	$aminoAcids .= $reader;
}
# Turn a string into an array of single characters
my @aAcids = split("", $aminoAcids);
#print @aAcids;
#  Declare an initially empty hash named wordcounts
my %aAcids;
foreach(@aAcids){
	$aAcids{$_}++;
}
#print $aAcids{"A"};
print "Adequate: Print the amino acids in alphabetical order. \n";
foreach(sort keys %aAcids){
	print $_ . " ". $aAcids{$_} . "\n";
}
print "Good: Print how many different amino acids appeared in the protein sequence, and which ones (if any) did not appear. \n";
print "Number of different amino acids: ". scalar keys %aAcids;
print "\n";
##https://www.tutorialspoint.com/perl/perl_qw.htm
my @allaAcids = qw (A C D E F G H I K L M N P Q R S T V Y W);
foreach(@allaAcids){
#https://stackoverflow.com/questions/1003632/how-can-i-see-if-a-perl-hash-already-has-a-certain-key	
	if(!exists $aAcids{$_}){
		print "No occurrences of ". $_ . "\n";
	}
}
#https://stackoverflow.com/questions/10901084/how-can-i-sort-a-perl-hash-on-values-and-order-the-keys-correspondingly-in-two
my @keys = sort { $aAcids{$b} <=> $aAcids{$a} } keys(%aAcids);
#my @vals = @h{@keys};
print "Superior: Print the amino acids in order from most to least of how many times each one appeared in the protein sequence. \n";
foreach(@keys){
	print $_ . " " . $aAcids{$_} . "\n";
}

