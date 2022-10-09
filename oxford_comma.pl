#  Annie/Ngoc Tran

#  Determine if there is exactly 1 command line argument; if there 
#  is, decide whether its value is the string "true"
if (@ARGV == 1) {
  if ($ARGV[0] eq "true") {
    $include_oxford_comma = 1;
  }
  else {
    $include_oxford_comma = 0;
  }  
}
else {
	#  No command line argument means that we will not use the oxford 
	#  comma
	$include_oxford_comma = 0;
}

if ($include_oxford_comma) {
  print "The Oxford comma IS being used\n";  
}
else {
  print "The Oxford comma IS NOT being used\n";
}

#  Get the input from the user
print "What is your first name? ";
chomp ($first_name = <STDIN>);

print "What is your last name? ";
chomp ($last_name = <STDIN>);

print "Please enter your three favorite foods, one per line\n";
chomp ($foods[0] = <STDIN>);
chomp ($foods[1] = <STDIN>);
chomp ($foods[2] = <STDIN>);

#  Insert the word "and" into the list of foods, so the user doesn't have 
#  to type it
($foods[2], $foods[3]) = ("and", $foods[2]);


#  Using the oxford comma means that we should have a comma after each word in the list
if ($include_oxford_comma) {
	$foods = join (", ", ($foods[0], $foods[1], $foods[2]));
	$foods .= " $foods[3]";
}
else {
	$foods = join (", ", ($foods[0], $foods[1]));
	$foods .= " $foods[2] $foods[3]";
}



print "You are $first_name $last_name, and you like to eat $foods!\n";