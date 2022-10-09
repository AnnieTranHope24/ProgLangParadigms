print "Enter a radius: ";
$radius = <STDIN>;
if($radius < 0 ){
	$c = 0;
}
else{
	$c = 2*3.141592654*$radius;
}

print "Your circumference: ";
print $c;