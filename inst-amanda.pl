#!/usr/bin/perl

use strict;
use warnings;
#use diagnostics;
use Net::Ping;
use File::Copy;



# Perl Script to install amanda client
# 1.- Change /etc/resolv.conf
# 	.- Check nameservers already configured
# 	.- Check if there's a search parameter
# 	.- Skip comments
# 	.- Test DNS
# 2.- Install xinetd amanda amanda-client
# 	.- Look for the best way to install a package
# 	.- Check dependencies
# 	.- 
# 3.- Create /etc/xinetd.d/amanda file
# 	.- Check if it's already there
# 	.- If it is, change it accordingly.
# 	.-
# 4.- Edit /var/lib/amanda/.amandahosts
# 	.- Add parameters as required
# 5.- Adding "-y" to accept everything

# Variable Declaration
my $packages = "amanda amanda-client xinetd";
my $nmsrv01 = "172.28.8.181";
my $nmsrv02 = "172.28.8.182";
my $domain = "cwc.local";
my $resolv = "/etc/resolv.conf";
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time); 
my @abbr = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);

my $clear = qx(clear);

# Functions Declaration

sub trim {
    (my $s = $_[0]) =~ s/^\s+|\s+$//g;
    return $s;        
}

# Check if DNS servers are within reach
# 
my $p = Net::Ping->new();
if ($p->ping($nmsrv01, 3) and $p->ping($nmsrv02, 3)) {
	print "DNS Servers respond to ping. Continue...\n";
	my $resolvbk = "$resolv.orig-$abbr[$mon]$mday$hour$min";
	# Here we go
	print "Backing up...\n" and copy $resolv, $resolvbk or die ("Could not backup file. '$resolv'. $!");
	if (-e $resolvbk) {
		print "$resolvbk\n\n";
	}
	# Parsing /etc/resolv.conf
	#  
	open my $resf, '+>', $resolv or die "Could not open file '$resolv'. $!";
	print "Current DNS Configuration: \n";
	while (my $ln = <$resf>) {
		if ($ln =~ /^\s*(nameserver)/ or $ln =~ /^\s*(search)/ or $ln =~ /^\s*(domain)/ ) {
			print $ln;
		}
	}
	print "\nThe file '$resolv' will be replaced. Continue? [y/n]: ";
	my $ans = <STDIN>;
	chomp $ans;
	if ($ans eq "y") {
		print "Good, carry on.\n";
		# Writing new DNS servers
		print $resf "nameserver $nmsrv01\n";
		print $resf "nameserver $nmsrv02\n";
		print $resf "search cwc.local\n";
		close $resf;
	} else {
		print "OK. Quitting.\n";
		exit;
	}
		# Printing new configuration
		#
	print "New DNS configuration: \n";
	open my $nf, "<", $resolv or die "Could not open file '$resolv'. $!";
	while (my $ln = <$nf>) {
		if ($ln =~ /^(nameserver)/ or $ln =~ /^(search)/ or $ln =~ /^(domain)/ ) {
			print $ln;
		}
	}
	print "\n";
	close $resf;

	# Parsing network configuration files
	#
	my @files = glob("/etc/sysconfig/network-scripts/ifcfg-*");
	foreach my $path (@files) {
		open my $conf, '<', <"$path"> or die "Could not open file. $!";
		while (my $ln = <$conf>) {
			if ($ln =~ /^\s*(#)/){
				next;
			} elsif ($ln =~ /\s*DNS[0-9]?=/) {
				print "DNS found in file '$path'. You shoul remove it.\n"
			}
		}
	}
}
	
# Installing necessary packages	
#
print $clear;
my $yum = qx("yum install $packages | sed -n -e '/Installing:/,\$p'");
#print $yum;

print "\n" x 2;
print "Time to install necessary packages.\n";
print "$packages\n\n";
print "Please check dependencies to install and press [y/n]: \n\n";
print $yum;
if ($? == 1) {
	print "Something went wrong with Yum.\n";
	exit;
}

# Checking if packages are installed.
#
my $rpm = qx("rpm -qa amanda amanda-client xinetd");
print $rpm;
if ( $rpm =~ /^amanda.*/ and  $rpm =~ /^amanda-client.*/ and $rpm =~ /^xinetd.*/ ) {
	print "Packages installed apparently.\n";
} else {
	print "Something went wrong. Please check.\n";
}

# Configuring XINETD
#
print "Proceding with XINETD configuration for Amanda.\n\n";
my $xinetdconf = "/etc/xinetd.d/amanda";
my $xinetdconfbck = "$xinetdconf.orig-$abbr[$mon]$mday$hour$min";
if (-e $xinetdconf) {
	print "Amanda file found in Xinetd. Backing up...\n" and copy $xinetdconf, $xinetdconfbck or die ("Could not backup file. '$xinetdconf'. $!");
}

open my $conf, ">", $xinetdconf or die("Could not open Amanda conf file for Xinetd. $xinetdconf. $!");
my $var = system("which amandad");
my $aman = <<END;
# default: on
#
# description: Amanda services for Amanda server and client.
#
service amanda
{
        disable         = no
        socket_type     = stream
        protocol        = tcp
        wait            = no
        user            = amandabackup
        group           = disk
        groups          = yes
        server          = $var
        server_args     = -auth=bsdtcp amdump amindexd amidxtaped
}
END
print $conf, $aman;

my $amandahosts = "/var/lib/amanda/.amandahosts";
my $ahostsconf = <<'END';
cur-ecp-m06-sl01-amanda-1.cwc.local amandabackup amdump
localhost amandabackup amdump
localhost.localdomain amandabackup amdump
END

if (-e $amandahosts) {
	open my $ahosts, ">>", $amandahosts or die("Could not open Amanda hosts file. $amandahosts. $!");
	print $ahosts, $ahostsconf;
}
















