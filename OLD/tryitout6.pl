
use strict;
use warnings;
use diagnostics;

my $number = 0; 

while ($number > 0) {
	print "You should never see this\n";
}
do {
	print "Unfortunately, you see this\n";
} while $number > 0;

for (1..10) {
print "$_\n";
}

my $temperature = 5;
( $temperature < 15 ) ? print "Too cold!\n"
: ( $temperature > 35 ) ? print "Too hot!\n"
: print "Regular temp!\n";


my @numbers = (1, 5, 4, 7, 8, 9, 8, 4, 3, 3, 8);
sub average {
my $total ;
for (@numbers) {
	$total += $_;
	
}
print $total/@numbers,"\n";
}
average(@numbers);

my @array = qw( fee fie foe fum );
my $num_elements = @array;

foreach (my $i = 0; $i <= $num_elements; $i++) {
	print "$array[$i]\n";
}
foreach (@array) {
	print "$_\n";
}

##### Game


my %stat_for = (
	strength	=> undef,
	intelligence	=> undef,
	dexterity	=> undef,
);
LINE: for ( keys %stat_for) {
	$stat_for{$_} = (1 + int(rand(6)))  + (1 + int(rand(6)));
	if ( $stat_for{$_} < 6 ) {
		redo LINE;
	}
#	print  $_ . " is " . $stat_for{$_} ,"\n";
}

print <<"END";
Strength:	$stat_for{strength}
Intelligence:	$stat_for{intelligence}
Dexterity:	$stat_for{dexterity}
END

