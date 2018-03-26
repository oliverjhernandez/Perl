
use strict;
use warnings;
use diagnostics;
use Scalar::Util 'looks_like_number';
use Carp qw(croak carp);

sub is_palindrome {
	my $word = lc shift;
	return $word eq scalar reverse $word;
}

for my $word (qw/Abba abba notabba/) {
	my $maybe = is_palindrome($word) ? "" : "not";
	print "$word is $maybe a palindrome\n";
}

####### 
#
#
#
my $number = $ARGV[0];
if (not @ARGV or not looks_like_number($number) or $number < 0) {
	carp "Usage: \"$ARGV[0]\" not acceptable."
}

print "$_\n" for 1 .. $number;

#########
#
#


