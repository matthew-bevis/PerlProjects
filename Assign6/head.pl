#!/usr/bin/perl -w
#Matt Bevis
use strict;

my $numLine = 0;
my $lines;
if(eof(STDIN) && $numLine == 0) 
{
	print "No input detected\n";
	exit 1;
}
while (<stdin>)
{	
	if ($numLine == 0)
	{
		$lines = $_;
	}
	elsif($numLine < 10)
	{
		$lines = $lines . $_;
	}
	$numLine++;
}
print STDOUT $lines;
exit 0;
