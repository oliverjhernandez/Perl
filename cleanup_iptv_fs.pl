#!/usr/bin/perl

use warnings;
use strict;

my @ign_channels = qw(bloomberghd ocwhd outdoorsp pethd mydestinationhd carshd comedytvhd estvhd receipehd outdoorhd colors wealthhd ginxtv clubbing bbcworldhd fevatv flowtvjm);
my $directory = "/mnt/videostorenpvr/wwwroot/npvr/content/";
my $channels;

open my $fh, '>', 'log.out';

opendir $channels, $directory or die("Can't open target directory $directory. $!");
my @content = readdir $channels or die("Unable to read target directory. $!");
closedir $channels;

for (my $l = 0; $l <= $#content; $l++) {
	if (not -d $directory.$content[$l]) {
		splice @content, $l, 1;
	}

}

my $lchannels = @content; 
print "Channels: $lchannels\n";
my $lign_channels = @ign_channels;
print "IGN Channels: $lign_channels\n";

for (my $i = 0; $i <= $#ign_channels; $i++) {
	for (my $x = 0; $x <= $#content; $x++) {
		if ( $content[$x] eq $ign_channels[$i] ) {
			# print $content[$x] . " $i.\n";
			splice @content, $x, 1;
		}
	}
}

$lchannels = @content;
print "Channels: $lchannels\n";

for (my $j = 0; $j <= $#content; $j++) {
	if ($content[$j] eq '.' or $content[$j] eq '..') {
		splice @content, $j, 1;
		next;
	}
	$content[$j] = $directory.$content[$j];
	# print $content[$j] . "\n";
	
	my $identifier;
	opendir $identifier, $content[$j] or dir("Unable to open id_dir directory $content[$j]. $!");
	my @id_dir = readdir $identifier or die("Unable to read id_dir directory. $!");
	closedir $identifier;

	for (my $n = 0; $n <= $#id_dir; $n++) {
		if ($id_dir[$n] eq '.' or $id_dir[$n] eq '..') {
			splice @id_dir, $j, 1;
			next;
		}
		$id_dir[$n] = $content[$j]."/".$id_dir[$n];
		
		my $recordings;
		opendir $recordings, $id_dir[$n] or die("Unable to open recording directory $id_dir[$n]. $!");
		my @recording = readdir $recordings or die("Unable to read recording directory $recordings. $!");
		closedir $recordings;

		my @ismvs;
		foreach my $x (@recording) {
			if ($x =~ /\.ismv$/) {
				push @ismvs, $id_dir[$n]."/".$x;
			}
		}
		print $fh "#############\n";
		my $biggestf;
		my $fsize = 0;
		foreach (sort @ismvs) {
			if (-s $_ > $fsize ) {
				$biggestf = $_;
			}
			$fsize = -s $_;
			print $fh "$fsize\t$_\r\n";
		}
		print $fh "The biggest file is: $biggestf\n";
		# for (my $o = 0; $o <= $#ismvs; $o++) {
		# 	if ($ismvs[$o] eq $biggestf) {
		# 		splice @ismvs, $o, 1;
		# 	}
		foreach (@ismvs) {
			if ($_ ne $biggestf){
				unlink $_;
				print $fh "Deleted: $_\n";
			}
		}
	}
}

$lchannels = @content;
print "Channels: $lchannels\n";

close $fh;