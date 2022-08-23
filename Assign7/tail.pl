#!/usr/bin/perl -w
#Matt Bevis
use strict;
my $output = 10;
if (@ARGV == 1)
{
	if($ARGV[0] =~ /\D/)
	{
		print "$ARGV[0] is not a valid argument.\n";
		exit 1;
	}
	$output = $ARGV[0];
}
elsif(@ARGV > 1)
{
	print "Too many arguments provided.\n";
	exit 2;
}
my $numLine = 0;
my @lines;
if(eof(STDIN) && $numLine == 0) 
{
	print "No input detected.\n";
	exit 3;
}
while (<stdin>)
{	
	$lines[$numLine] = $_;
	$numLine++;
}
if ($numLine >= 10 && $output < $numLine)
{
	$output = $numLine - $output;
	while ($output != $numLine)
	{
		print $lines[$output];
		$output++;
	}
}
elsif($output > $numLine)
{
	$output = 0;
	while($output != $numLine)
	{
		print $lines[$output];
		$output++;
	}
}
exit 0;
