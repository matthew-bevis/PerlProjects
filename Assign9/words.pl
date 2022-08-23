#!/usr/bin/perl -w
#Matt Bevis
use strict;

my $numLine = 0;

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
my @words;
my @lines;
my $numWord = 0;
my $line;
my @array;
my %lineNums;
my $longestWord = 0;
my $temp = 0;
my $temp2 = 0;
while (<>)
{	
	$line = $_;
	@array = split /\W/, $line;
	$temp = $temp + scalar(@array);
	push(@lines, @array);
	$numLine++;
	while($temp2 < $temp-1)
	{
		$lineNums{$lines[$temp2]} = $numLine;
		$temp2++;
	}	
}
foreach my $lines(@lines)
{
	if ($lines =~ /\w\D/)
	{
		$lines =~ tr/A-Z/a-z/;
		if(length $lines > $longestWord)
		{
			$longestWord = length $lines;
		}
		push(@words, $lines);
	}
} 
my %hashes;
my %lineNum;
my @k = keys %lineNums;
foreach my $k(@k)
{
	foreach my $word(@words)
	{
		if($k =~ /$word/i)
		{
			$lineNum{$word} = $lineNums{$k};
		}
	}
}
foreach my $word(@words)
{
	$hashes{$word}++;
}
foreach my $word(sort keys %hashes)
{
	printf "%*s: %4d times, lines: ", $longestWord, $word, $hashes{$word};
	print $lineNum{$word}, "\n";
}
exit 0;
