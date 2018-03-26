# TRY IT OUT 2

use strict;
use warnings;
use diagnostics;

my @name = ('Andrew', '"Andy"', 'Kaufman');
my $x = 1;


#print 3 / $x;
print "@name\n";

my %fruits = (
	'bananas' => 'yellow',
	'oranges' => 'orange',
	'strawberries' => 'red',
	'grapes' => 'purple',
);

for (keys %fruits) {
	print "$_ are $fruits{$_}\n";
}

