
use strict;
use warnings;
use diagnostics;

my @day_of_week = qw (
   monday
   tuesday
   wednesday
   thursday
   friday
);

my @sales = (
	{ jim	=> 2, john   => 7, mary => 1 },
	{ alice => 4, jim    => 3, mary => 5 },
	{ jim   => 7, mary   => 3, pablo => 10},
	{ jim   => 4, mary   => 5 },
	{ jim   => 1, katherine => 4, mary => 2 },
);

print "Top Sales per day report\n\n";
printf "%10s	%10s	%s\n", 'Weekday', 'Person', 'Num sales';

# get the name of the day and sales for that day
#
foreach my $i ( 0 .. $#day_of_week ) {
	my $day = ucfirst $day_of_week[$i];
	my $daily_sales = $sales[$i];

	#Find top salesperson for the current day
	my $top_sales = 0;
	my $top_person;
	while ( my ( $salesperson, $num_sales ) = each %$daily_sales ) {
		if ( $num_sales > $top_sales ) {
			$top_sales = $num_sales;
			$top_person = $salesperson;
		}
	}
	printf "%10s:	%10s	%-3d\n", $day, $top_person, $top_sales;
}
