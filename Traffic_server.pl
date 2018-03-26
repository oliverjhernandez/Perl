#!/usr/bin/perl

use warnings;
use strict;
use Cwd;
use File::Copy qw(copy);


# Files !!!!
# 02.05.00.0016-spectrum-sdc-cms-sw-install.tgz
# 02.05.00.0016-spectrum-sdc-sw-install.tgz
# CentOS-6-5-reqPackages-Sep21-2015.tgz
# Columbus Centos 6.5 SDC 2.5 Intstallation Notes - Oct 30-2015.docx
# tmp
# trafficserver-5.3.1-1.ar.el6.x86_64.rpm
# trafficserverNewConfig-Oct19-2015.tgz

# VARIABLES

my $dir = getcwd;
my $traffic_file = "trafficserver-5.3.1-1.ar.el6.x86_64.rpm";
my $traffic_pkg = "trafficserver-5.3.1-1.ar.el6.x86_64";
my $traffic_rpm = join "/", $dir, $traffic_file;
my $ramdir = "/mnt/ramdisk";
my $fstab = "/etc/fstab";
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time); 
my @abbr = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
my $fstab_line = "tmpfs 	/mnt/ramdisk 	tmpfs 	defaults,mode=1777,noatime,size=100g 	0 0";
my $trafficconf_dir = "/etc/trafficserver";
my $traffic_tar = "trafficserverNewConfig-Oct19-2015.tgz";

#
# Installing Traffic Server
#

if ( -f "$traffic_rpm" ) {
	print "File $traffic_file exists.\n";
	my $yum = `yum localinstall -y $traffic_rpm`;
	my $yum_check = `rpm -q trafficserver`;
	chomp $yum_check;
	if ( $yum_check eq $traffic_pkg ) {
		print "Traffic Server package installed.\n";
		print "Enabling service.\n";
		my $chkconfig = `chkconfig trafficserver on`;
		my $chkconfig_chk = `chkconfig --list trafficserver`;
		if ( $chkconfig_chk =~ /\s.*["3:on"]\s.*/ ) {
			print "Service enabled.\n";
		}
	} else {
		print "Something prevented Traffic Server from being installed. Quitting.\n";
	}
}

#
# RAM Disk
#

mkdir $ramdir;
print "Mounting RAMDisk.\n";
my $mount = `mount -t tmpfs -o size=100G tmpfs $ramdir`;
my $mount_check = `df -h $ramdir`;
if ( $mount_check =~ /.*tmpfs.*/ ) {
	print "Ram disk mounted.\n";
}

# copy $fstab, "$fstab-$abbr[$mon]$mday$hour$min";
# open my $fs, ">>", $fstab or die "Could not open file '$fstab'. $!";
# print $fs $fstab_line;
# close $fs;

#
# Traffic Server Configuration
#

print "Backing up Traffic Server configuration directory.\n";
rename $trafficconf_dir "$trafficconf_dir-$abbr[$mon]$mday$hour$min";
if ( -f $traffic_tar ) {
	print "Extracting New Config tar.\n";
	my $tar_xzvf = "tar -xzf $traffic_tar -C /";
}















