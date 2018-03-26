
use strict;
use warnings;
use diagnostics;
use Scalar::Util 'looks_like_number';
use Carp qw(croak carp);
use Data::Dumper;

my @strings = qw(
	abba
	abacus
	abbba
	babble
	Barbarella
	123-456-7890
	555554444-332-6576487
	Yello
);

my @regexes = (
	qr/\Aab/,
	qr/(\b\d{3}-\d{3}-\d{4}\b)/,
	qr/(\d{3}-\d{3}-\d{4})/,
#	qr/\Aab/,
#	qr/ab*/,
#	qr/ba./,
);

foreach my $string (@strings) {
	foreach my $regex (@regexes) {
		if ( $string =~ $regex ) {
		print "'$regex' matches '$string'\n";
		}
	}
}

if ($strings[5] =~ $regexes[1]) {
	print "Matches $1\n";
}

my $text = <<'END';
Name: Alice Allison   Age: 23 Occupation: Spy Color: Blue
Name:      Bob Barkely         Age: 45 Occupation: Fry Cook Color: Yellow
Name: Carol Carson Age: 44 Occupation: Manager Color: Black
Name: Prince Age: 53 Occupation: World Class Musician Color: Gray
END
my %ocuppation_for;

foreach my $line (split /\n/, $text) {
	if ( $line =~ /Name:\s+(.*?)\s+Age:\s+(\d+)\s+Occupation:\s+(\w+\s+)/ ) {
$ocuppation_for{$1} = $3;
}
}
print Dumper(\%ocuppation_for);

my $string3 = '';
while ("a1b2c3dddd444eee66" =~ /(\D+)/g) {
	$string3 .= $1;
}
print $string3,"\n";

 my $prisoner = << "END";
I will not be pushed, filed, stamped, indexed, briefed, debriefed or numbered.
My life is my own.
END
print $prisoner =~ /^I/		 ? "Yes\n" : "No\n";
print $prisoner =~ /^My/m	 ? "Yes\n" : "No\n";
print $prisoner =~ /numbered\.$/m ? "Yes\n" : "No\n";
print $prisoner =~ /own\.$/	 ? "Yes\n" : "No\n";


my $string4 = '42 85 abcd 8 4ever foobar 666 43';
my @odd1;
push @odd1 => $1 while $string4 =~ /\b(\d*[^02468])\b/g;
print "@odd1\n";

my $string2 = '42 85 abcd 8 4ever foobar 666 43';
my @odd;
push @odd => $1 while $string2 =~ /([[:alpha:]])/g;
print "@odd\n";


my $text1 = <<"END";
Name: Alice Allison 	Position: VOLUNTEER
Name: Bob Barkely 	Position: Manager
Name: Carol Carson	Position: Volunteer
Name: David Dark	Position: Geek
Name: e.e. cummings	Position: Volunteer
name: Fran Francis	Position: Volunteer
END

my @volunteers;
foreach my $line (split /\n/, $text1) {
	if ($line =~ m<Name:\s+(.*?)\s+Position:\s+(?i-xsm:volunteer)\b>) {
		push @volunteers => $1;
	}
}
print Dumper(\@volunteers);
