#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;

# Playing with scalars
# Print Hello friends!
#
print "Scalars******\n";
print "Hello friends!\n";
print "Hello ";
print "friends!\n";
my $x = 16;
print "$x\n";

my $nine = 9;

# Arrays
print "Arrays******\n";
my @stuff = ( 7, 'of', $nine );
print @stuff, "\n";
print "@stuff\n";
print "$stuff[1]\n";

my @things_in_common = ('liars','fools','certain politicians');
my $number_of_things = scalar @things_in_common;
print "$number_of_things\n";

my $p = 1;
my $n = 2;
( $p, $n)=( $n, $p);
print "$p\n";
print "$n\n";

@things_in_common = ('liars','fools','certain politicians');
print "@things_in_common\n";

# Hashes
print "Hashes******\n";
my %people = (
	"Alice",  1,
	"Bob",    2,
	"Ovid", "idiot",
);
print "$people{'Alice'}\n";


