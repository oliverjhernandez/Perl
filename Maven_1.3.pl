#!/bin/perl

use strict;
use warnings;
use diagnostics;

# This is a "Hello World!" script. 
# It doesn't do much, actually.

my $name = "Foo";

print "Hello ", $name, " World!\n";
print "Enter your name, please: ";
#$name = <STDIN>;
chomp $name;
print "Hello $name World!\n";
print 42, "\n";

=pod

=head1 Hello World!

This is a simple tutorial for a simple script

=cut

if (2 == 2) {
	print "Fuck you!\n";
	print "$name\n"
} elsif($name eq 666) {
	print "Beat it!\n";
} else {
	print "All right.\n";
}

if (2 == 3) {
	print "What??\n";
} elsif($name and 3 == 3) {
	print "Oh yeah!\n";
} else {
	print index "Heeeyy!", "y";
}

print q("Whatever \n 'motherfucker!'\n");
print "\n";
my $var = int(rand(100));

print "$var\n";

print int(rand(150)), "\n";

my $nine = 9;
my @stuff = ( 7, 'of', $nine);

print @stuff, "\n";
print "@stuff\n";

print $stuff[0], "\n";

my %people = (
	"Alice" => 1,
	"Bob" => 2,
	"Ovid" => "idiot",
);

for my $name ( keys %people ) {
	print "$name is $people{$name}\n";
};

my @array = ( 1, 2, 3, 4, 5, 144, 2435, 65, 875, 97);

my @things_in_common = ( 'liars', 'Whatever', "for" );
my %new_hash = ( useless_things => scalar @things_in_common );
print $new_hash{useless_things}, "\n";