
use strict;
use warnings;
use diagnostics;
use Scalar::Util 'looks_like_number';
use Carp qw(croak carp);


my %length_for = (
	SCALAR => sub { return length ${ $_[0] } },
	ARRAY  => sub { return scalar @{ $_[0] } },
	HASH   => \&_hash_length,
);

sub _hash_length { return scalar keys %{ $_[0] } }

sub mylength {
	my $reference = shift;
	my $length = $length_for{ ref $reference }
	     || croak "Don't know how to handle $reference";
	return $length -> ($reference);
}

my $name = 'John Q. Public';
my @things = qw(this that and the other);

my %cheeses = (
	good => 'Havarti',
	bad => 'Momilette',
);

print mylength( \$name ), "\n";
print mylength( \@things ), "\n";

print mylength( \%cheeses ), "\n";
#print mylength( $name ), "\n";

########
#
#

sub random_die_rolls($@) {
	my ( $number_of_rolls, @number_of_sides ) = @_;
	my @results;
	foreach my $num_sides (@number_of_sides) {
		my $total = 0;
		$total += int( 1 + rand($num_sides) ) for 1 .. $number_of_rolls;
		push @results, $total;
	}
	return @results;
}

my @rolls = random_die_rolls 3;
print join "\n", @rolls;
