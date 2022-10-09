use strict;
if (@ARGV < 1) {
	die "You must specifiy the name of the file to open.";
}
elsif(@ARGV > 1){
	die "Please enter only one file name."
}
open (FILE, $ARGV[0] ) 
	or die "File name is invalid.";
chomp (my @lines = <FILE> );
##Part1
#parsing(@lines);
sub parsing{
foreach(@_){
	$_ =~ tr/ //ds;
	if (/(R\d{5})\D/){
		print "reaction is $1\n";	
	}
	if(/(\W\d{5})/){
		print "map is $1\n";
	}
	my @twoParts = split(/<*=>*/, $_);
	if($_ =~/\w(=>)/){
		print "direction is $1\n";
		while($twoParts[0] =~ /(C\d{5})/g){
			print "substrate is $1\n";
		}
		while($twoParts[1] =~ /(C\d{5})/g){
			print "product is $1\n";
		}
	}
	if($_ =~/(<=)\w/){
		print "direction is $1\n";
		while($twoParts[1] =~ /(C\d{5})/g){
			print "substrate is $1\n";
		}
		while($twoParts[0] =~ /(C\d{5})/g){
			print "product is $1\n";
		}
	
	}
	if($_ =~/\w(<=>)\w/){
		print "direction is $1\n";
		while($twoParts[0] =~ /(C\d{5})/g){
			print "substrate is $1\n";
		}
		while($twoParts[1] =~ /(C\d{5})/g){
			print "product is $1\n";
		}
		while($twoParts[1] =~ /(C\d{5})/g){
			print "substrate is $1\n";
		}
		while($twoParts[0] =~ /(C\d{5})/g){
			print "product is $1\n";
		}		
	}
	print "$_\n";
	

}	
}

##Part2
my %substrates2rxns;
my %rxns2products;
my @reactions;
my $reactionsRef = \@reactions;
my @products;
my $productsRef = \@products;
my $substrate;	
my $reaction;
foreach(@lines){
	if(/\W(00010)/){
		#print "$_ \n";
		my @twoParts = split(/<*=>*/, $_);
		$_ =~ tr/ //ds;
		if (/(R\d{5})\D/){
			$reaction = $1;
		}	
		if($_ =~/\w(=>)/){
			while($twoParts[0] =~ /(C\d{5})/g){
				$substrate = $1;
				push(@{$substrates2rxns{$substrate}}, $reaction);
			}
			while($twoParts[1] =~ /(C\d{5})/g){
				push(@{$rxns2products{$reaction}}, $1);
			}
		}
		
		if($_ =~/(<=)\w/){

			while($twoParts[1] =~ /(C\d{5})/g){
				$substrate = $1;
				push(@{$substrates2rxns{$substrate}}, $reaction);
			}
			while($twoParts[0] =~ /(C\d{5})/g){
				push(@{$rxns2products{$reaction}}, $1);

			}
		
		}
		if($_ =~/\w(<=>)\w/){
			while($twoParts[0] =~ /(C\d{5})/g){
				$substrate = $1;
				push(@{$substrates2rxns{$substrate}}, $reaction);
			}
			while($twoParts[1] =~ /(C\d{5})/g){
				push(@{$rxns2products{$reaction}}, $1);

			}
			while($twoParts[1] =~ /(C\d{5})/g){
				$substrate = $1;
				push(@{$substrates2rxns{$substrate}}, $reaction);
			}
			while($twoParts[0] =~ /(C\d{5})/g){
				push(@{$rxns2products{$reaction}}, $1);

			}		
	}

		 

	}
 }

my %compoundsToNumb;
my %rctsToNumb;
print "Starting with compound C00031 \n";
recursive('C00031', 'C00022');
my $steps;
my $compoundNumb;
sub recursive{
	
	my $compound = $_[0];
	my $goal = $_[1];
	$compoundsToNumb{$compound} = 1;
	if($compound eq $goal){
		print "After $steps steps\n";
		print "I've seen ". scalar %compoundsToNumb . " compounds. \n";
		exit;
	}
	else{
		$steps++;
	my @rcts = @{$substrates2rxns{$compound}};
	
	foreach(@rcts){
		 if(!(exists($rctsToNumb{$_}))){
			$rctsToNumb{$_} = 1;
			print "Following reaction $_ \n";
			my @prdts = @{$rxns2products{$_}};
			
			foreach(@prdts){
				if(!(exists($compoundsToNumb{$_}))){
					print "Reached compound $_ \n";
					$compoundsToNumb{$_} = 1;
					$compound = $_;
					recursive($compound, $goal);
									
				 }

			}

		}

	}

}

}
