print "Enter your DNA sequence in FASTA format: ";
#Get input from user
$fileName = <STDIN>;
# Get a handle on the file we want to read
open(PROTEINFILE, $fileName);

# Read a line from the file by using the angle brackets on the file handle
#Skip the header line
$reader = <PROTEINFILE>;
$dna = "";
while($reader = <PROTEINFILE>){
	chomp $reader;
	$dna .= $reader;
}
# Turn a string into an array of single characters
@DNA = split("", $dna);
 $length = scalar @DNA;
#Keep count of G and C
$count = 0;
foreach $base(@DNA){
	if(($base eq "G") or ($base eq "C")){
		$count++;
	}
	
}
$result = ($count/$length)*100;
print "The Percent GC is $count out of $length\: $result";