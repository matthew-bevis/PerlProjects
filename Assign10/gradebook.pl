#!/usr/bin/perl -w
#Matt Bevis
use strict;

if (!open stuIN, "students.txt") 
{
	die "Could not open students.txt";
}
if (!open itemIN, "items.txt") 
{
	die "Could not open file items.txt";
} 
if (!open scoreIN, "scores.txt") 
{
	die "Could not open file scores.txt";
}
open OUT, ">report.txt";

my %stuHash;
my @tempArray;
my @students;
my $temp;
my $count = 0;
my $longestName = 0;
while(<stuIN>)
{	
	if ($count == 0){$temp = $_;}
	else{$temp = $temp . $_;}
	$count++;
}
$count = 0;
@students = split /\n/, $temp;
foreach my $students(@students)
{
	@tempArray = split /:/, $students;
	push(@{ $stuHash{$tempArray[1]} }, $tempArray[0]);
}
@tempArray = %stuHash;
$count = 1;
while ($count < scalar(@tempArray))
{
	if(length($tempArray[$count]) > $longestName)
	{
		$longestName = length($tempArray[$count]);
	}
	$count = $count + 2;
}
my @itemArray;
while(<itemIN>)
{	
	chomp;
	@tempArray = split / /, $_;
	push @itemArray, $tempArray[0];
	push @itemArray, $tempArray[1];
}
my $pointTotal = 0;
$count = 1;
foreach my $itemArray(@itemArray)
{
	if($count < scalar(@itemArray))
	{
		$pointTotal = $pointTotal + $itemArray[$count];
		$count = $count + 2;
	}
	else{next;}
}
while(<scoreIN>)
{
	chomp;
	@tempArray = split / /, $_;
	if(exists $stuHash{$tempArray[0]})
	{
		push(@ { $stuHash{$tempArray[0]} }, $tempArray[1] . " " . $tempArray[2]);
	}	
}
printf OUT "%-*s%5s ", $longestName, "Name", " StuID";
$count = 0;
while($count < scalar(@itemArray))
{
	printf OUT "%5s ", $itemArray[$count];
	$count = $count + 2;
}
printf OUT "%7s\n", "average";
printf OUT "%-*s", $longestName, "-" x $longestName;
my $itLen = (scalar(@itemArray))/2 + 1;
printf OUT " %s", "----- "x $itLen;
printf OUT "%s", "-"x 7;
print OUT "\n";
foreach my $studs(sort keys %stuHash)
{
	printf OUT "%-*s", $longestName, @{$stuHash{$studs}};
	printf OUT " %5s", $studs;
	$count = 2;
	while ($count < $itLen)
	{
		printf OUT "%5s", (s/ /@{$stuHash{$studs}}[$count]/) x $itLen;
		$count = $count + 2;
	}
#give me 10 more hours and I would have figured how to format all of this...
}
close stuIN;
close itemIN;
close scoreIN;
close OUT;
exit 0;
