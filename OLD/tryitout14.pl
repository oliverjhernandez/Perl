
use strict;
use warnings;
use diagnostics;
use Scalar::Util 'looks_like_number';
use Carp qw(croak carp);
use Data::Dumper;
use Regexp::Common;

my $text = <<'END';
Name: Alice Allison Age: 23 Occupation: Spy
Name: Bob barkely Age: 45 Occupation: Fry Cook
Name: Carol Carson Age: 44 Occupation: Manager
Name: Prince Age: 53 Occupation: World Class Musician
END

my %age_for;

while ( $text =~ m<Name:\s+([[:alpha:] ]+?)\s+Age:\s+(\d+)>g ) {
	$age_for{$1} = $2;
}
print Dumper(\%age_for);

my $string = 'xxxyyyxxxbbbxxxyyy';
$string =~ s/(?<=bbb)xxx(?=yyy)/---/g;
print "$string\n";

my $provided_date = '28-9-2011';

# $provided_date =~ s{
# 	(\d\d?)
# 	[-/]
# 	(\d\d?)
# 	[-/]
# 	(\d\d\d\d)
# }
# {
# 	sprintf "$3-%02d-%02d",$2, $1	
# }

$provided_date =~ s{
	(?<day>\d\d?)
	[-/]
	(?<month>\d\d?)
	[-/]
	(?<year>\d\d\d\d)
}
{
	sprintf "$+{year}-%02d-%02d", $+{month}, $+{day}	
}ex;

print $provided_date,"\n";


my @dates = qw(
	01-23/1987
	1/30/2000
	02-9/1980
);

foreach (@dates) {
	s{\A(\d\d?)[-/](\d\d?)}
	{$2/$1};
}
print Dumper(\@dates);

my $text = 'Something awful or amusing';
$text =~ s/($RE{profanity})/'*' x length($1)/eg;
print "$text\n";



