#!/Users/olhernandez/perl5/perlbrew/perls/perl-5.16.3/bin/perl

use strict;
use warnings;

my @strings = (
         'the quick brown fox jumped over the lazy dog',
         'The Sea! The Sea!',
         '(.+)\s*\1',
         '9780471975632',
         'C:\DOS\PATH\NAME',
     );

my @regex = (
         '/[a-z]/',
         '/(\W+)/',
         '/\W*/',
         '/^\w+$/',
         '/[^\w+$]/',
         '/\d/',
         '/(.+)\s*\1/',
         '/((.+)\s*\1)/',
         '/(.+)\s*((\1))/',
         '/\DOS/',
         '/\\DOS/',
         '/\\\DOS/',
     );





print "\n\n\nEXERCISE 3.1\n\n";
my $s1 = '100';
my $s2 = '$100';

print "$s1\n";
print "$s2\n";
print "\$s1\n";
print "\Q$s2\E\n";
print "\Q\Q$s2\E\E\n";

print "\n\n\nEXERCISE 3.2\n\n";
my @text = qw(Many programmers use variable names made up of several words. One convention is to write names entirely in lower-case letters with underline characters separating words as in a_long_variable_name. An alternative which appears to be growing in popularity uses mixed case with each word beginning with an upper-case letter except that the whole variable name always begins with a lower-case one (usually to distinguish variables from type names) as in aLongVariableName. Write a Perl script to convert variable names from the first form to the second. (Or if you prefer vice versa.) );

my $big = "a";
foreach my $word (@text) {
    if ( length($word) > length($big) ) {
        $big = $word;
    }
}
print "$big\n";


print "\n\n\nEXERCISE 3.3\n\n";















