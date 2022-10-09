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

print "Please enter your favorite foods, one per line\n";
chomp(@foods = <STDIN>);

if(@foods == 0){#if there is no food
	$foods = "nothing";
}
elsif(@foods == 1){#if there is one food
	$foods = $foods[0];
}
else {
	

 # Insert the word "and" into the list of foods, so the user doesn't have 
 # to type it
($foods[$#foods], $foods[ $#foods + 1]) = ("and", $foods[$#foods]);
if(@foods == 3){#if there are 2 foods
	$foods = join (" ", @foods);
}

else{
$index = 0;
while($index<$#foods-1){
	$foodsCopy[$index] = $foods[$index];
	$index++;
}
# print @foodsCopy;
# print @foods;
 #Using the oxford comma means that we should have a comma after each word in the list
if ($include_oxford_comma) {
	$foods = join (", ", @foodsCopy, $foods[-2]);
	$foods .= " $foods[-1]";
}
else {
	$foods = join (", ", @foodsCopy);
	$foods .= " $foods[-2] $foods[-1]";
}
}

}
 print "You are $first_name $last_name, and you like to eat $foods!\n";