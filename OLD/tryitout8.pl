use strict;
use warnings;
use diagnostics;



my @first = qw(me quiero ir pal cono);
my $aref = \@first;

for my $i ( 0 .. $#$aref ) {
	print "$aref->[$i] ";
} 
print "\n";
#print "$aref->[0]\n";


my $sales = {
	monday => { jim => [ 2 ], mary => [ 1, 3, 7 ] },
	tuesday => { jim => [ 3, 8 ], mary => [ 5, 5 ] },
	wednesday => { jim => [ 7, 0 ], mary => [ 3 ] },
	thursday => { jim => [ 4 ], mary => [ 5, 7, 2, 5, 2 ] },
	friday => { jim => [ 1, 1, 6 ], mary => [ 2 ] },
};


my @test = qw( me quiero ir pal cono );
my $sh = shift @test;
print "$sh\n";
print "@test\n";
