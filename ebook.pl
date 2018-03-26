
use warnings;
use strict;
use File::Basename qw(fileparse);
use File::Find::Rule;
use User::pwent;

opendir my $DIR, '.' or die("Can't open current directory. $!");
my @names = readdir $DIR or die("Unable to read current directory. $!");
closedir $DIR;

foreach my $name (@names) {
	next if ($name eq '.');
	next if ($name eq '..');
	if (-d $name) {
		print "Found a directory: $name\n";
		next;
	}
	if ($name eq 'core') {
		print "Found one Core!.\n";
	}
}

my @userdata = (getpwuid($<));
print "GETPWUID: @userdata\n";

my @files_dirs = File::Find::Rule->in('.');
# print "@files_dirs\n";

print "\n\n";


my $shells = '/etc/shells';
open my $shell, '<', $shells or die "Unable to open $shells:$!\n";

my %okshell;
while (<$shell>) {
	chomp;
	$okshell{$_}++; 
}
close $shell;

while ( my $pwent = getpwent() ) {
	warn $pwent->name . ' has a bad shell (' . $pwent->shell . ")!\n"
		unless ( exists $okshell{ $pwent->shell } ); 
}
endpwent();