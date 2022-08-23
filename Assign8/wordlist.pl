#!/usr/bin/perl -w
#Matt Bevis
use strict;


my $numLine = 0;
my @lines;
if(eof() && $numLine == 0) 
{
	print "No input detected.\n";
	exit 1;
}
my $i;
foreach $ARGV (@ARGV)
{
	$i++;
	if( -e $ARGV && $i != 0)
	{
		next;
	}
	else
	{
		print "One or more files does not exist\n";
		exit 2;
	}
}
my $longestWord = 0;
while (<>)
{	
	$lines[$numLine] = $_;
	chomp($lines[$numLine]);
	if (length $lines[$numLine] > $longestWord)
	{
		$longestWord = length $lines[$numLine];
	}
	$numLine++;
}
my %hashes;
foreach my $word(@lines)
{
	$hashes{$word}++;
}
foreach my $word(sort keys %hashes)
{
	printf "%*s: %4d\n", $longestWord, $word, $hashes{$word};
}
exit 0;
