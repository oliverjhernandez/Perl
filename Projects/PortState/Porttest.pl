#!/Users/olhernandez/perl5/perlbrew/perls/perl-5.16.3/bin/perl

use strict;
use warnings;
use IO::Socket::INET;
use Data::Dumper;

require Exporter;
our @ISA = qw(Exporter);

our @EXPORT_OK = qw(check_ports);

our $VERSION = '0.03';

sub check_ports {
   my ($ip,$to,$pmhr,$proc) = @_;
   my $hr = defined wantarray ? {} : $pmhr;
   for my $prot (keys %{ $pmhr }) {
      for(keys %{ $pmhr->{$prot} }) {
         $hr->{$prot}->{$_}->{name} = $pmhr->{$prot}->{$_}->{name};
         if(ref $proc eq 'CODE') {
            $proc->($hr->{$prot}->{$_},$ip,$_,$prot,$to);
         } else {
            my $sock = IO::Socket::INET->new(
               PeerAddr => $ip,
               PeerPort => $_,
               Proto => $prot,
               Timeout => $to
            );
            $hr->{$prot}->{$_}->{open} = !defined $sock ? 0 : 1;
            $hr->{$prot}->{$_}->{note} = 'builtin()';
         }
      }
   }
   return $hr;
}


my $hostfile = 'hosts.txt';

open HOSTS, '<', $hostfile or die "Cannot open $hostfile:$!\n";

my %hosts;

while ( my $line = <HOSTS> ) {
  chomp($line);
  my @array = split / /, $line;
  print Dumper \@array;
  my %hash = @array;
  print Dumper \%hash;
  while ((my $key, my $value) = each (%hash)) {
    print $key $value;
  }
}

close HOSTS;



# my %port_hash = (
#         tcp => {
#             22      => {},
#             443     => {},
#             80      => {},
#             53      => {},
#             30032   => {},
#             13720   => {},
#             13782   => {},
#             }
#         );

# my $timeout = 5;

# open HOSTS, '<', $hostfile or die "Cannot open $hostfile:$!\n";

# while (my $host = <HOSTS>) {
#   chomp($host);
#   my $host_hr = check_ports($host,$timeout,\%port_hash);
#   print "Host - $host\n";
#   for my $port (sort {$a <=> $b} keys %{$host_hr->{tcp}}) {
#     my $yesno = $host_hr->{tcp}{$port}{open} ? "yes" : "no";
#     print "$port - $yesno\n";
#   }
#   print "\n";
# }

# close HOSTS;











