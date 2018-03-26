
use warnings;
use strict;
use diagnostics;
use 5.010;

my @numbers = ( 
	[3, 1, 4, 9, 32], 	# total 49
	[5, 200],		# total 205
	[22, 75, 100, -3],	# total 194
	[35, 43, 855, -1284],
	[-97]
);

foreach my $group (@numbers) {
	my ($total, $running_total) = _running_total($group);
	print "Total is $total and running total is $running_total\n";
}

sub _running_total {
	state $running_total = 0;
	my $numbers = shift;
	my $total = 0;
	$total += $_ for @$numbers;
	$running_total += $total;
	return $total, $running_total;
}
