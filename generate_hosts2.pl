# Parse records text file

use warnings;
use strict;

my $datafile = 'data.txt';
my $recordsep = "-=-\n";
open my $DATAFILE, '<', "$datafile" or die "Unable to open datafile:$!\n";
{
local $/ =
$recordsep; # prepare to read in database file one record at a time print "#\n# host file - GENERATED BY $0\n# DO NOT EDIT BY HAND!\n#\n";
my %record;
while (<$DATAFILE>) {
chomp; # remove the record separator
%record = split /:\s*|\n/;
print "$record{address}\t$record{name} $record{aliases}\n";
}
close $DATAFILE; }
