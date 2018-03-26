
use strict;
use warnings;
use diagnostics;

my @upper = qw(PUBLIUS OVIDIUS NASO);
my @lower = qw(publius ovidius naso);

print join " ", map { ucfirst lc } @upper;
print "\n";

my $name = join ' ', map { ucfirst lc } @lower;
#my $name = join ' ', map ( ucfirst( lc($_) ), @lower);
$name .= "\n";
print $name;


my @fahrenheit = (0, 32, 65, 80, 212);
my @celcius = map { ($_ - 32) * 5/9  } @fahrenheit;

for ( 0 .. $#celcius) {
	print "$_ : $celcius[$_]\n";
	print "\n";
}


my $answer1 = 3 + 5 * 5;
print "$answer1\n";
my $answer2 = 9 -2 -1;
print "$answer2\n";
print "$answer2++\n";
my $answer3 = 10 - $answer2++ ;
print "$answer3\n";
