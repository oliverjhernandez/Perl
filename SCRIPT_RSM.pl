#!/usr/local/bin/perl -w
use strict;
use warnings;
use feature qw(say);
use autodie;

use File::stat;
use Net::SFTP::Foreign;

use constant {
    HOST            => "172.31.0.9",
    REMOTE_DIR      => "/var/cdr",
    LOCAL_DIR       => "/opt/cdr/USA/RSM/", # the local directory must finish with '/'
    USER_NAME       => "root",
    PASSWORD        => "xM-SkD2d@",
    DEBUG           => "0",
        SERVER_NAME     => "RSM"
};

my $days = 15;
my $now = time();
my $seconds_per_day = 60 * 60 * 24;
my $AGE = $now - $seconds_per_day * $days;

my $sftp;
$sftp = Net::SFTP::Foreign->new (
    HOST,
    timeout         => 300,
    user            => USER_NAME,
    password        => PASSWORD,
);

if($sftp->error){

        $sftp->die_on_error (system("echo 'Unable to connect to  ".SERVER_NAME." ".HOST.". Please check for connectivity or authentication issues.' | mail -s 'Error transfering files from RSM ".HOST." to server 172.31.1.153' -r 'MEDIATION SERVER<vqa\@columbus.co>' vqa\@columbus.co"));
        }
else{


#
# Fetch Files from remote server
#
$sftp->setcwd(REMOTE_DIR);
my @remote_files = @{$sftp->ls(wanted => sub { $_[1]->{a}->mtime > $AGE }) };

#
# Fetch Files from local directory ignoring files starting with '.'
#
opendir (DIR, LOCAL_DIR) or die $!;

my @local_files;

while (my $file = readdir(DIR)) {
        next if ($file =~ m/^\./);
        push(@local_files,$file);
}
closedir DIR;

#
#Reading local directory again just to know which was the last file transferred
#

my $dirname = LOCAL_DIR;
my $timediff=0;
my $newest = "";

opendir DIR, "$dirname";

while (defined (my $file = readdir(DIR)))
{
        if($file ne "." && $file ne "..")
        {
                my $diff = time()-stat("$dirname/$file")->mtime;
                if($timediff == 0)
        {
            $timediff=$diff;
            $newest=$file;
        }
        if($diff<$timediff)
                {
            $timediff=$diff;
            $newest=$file;
        }
    }
}

#The name of the most recent file is $newest

#
#Ignore remote files starting with '.' and save each file name in a new array
#
my @rem_files;

for my $file (@remote_files) {
        if(substr($file->{filename},0,1) ne "." && substr($file->{filename},-4,4) eq ".txt"){
                push(@rem_files,$file->{filename});
        }
}

#
#Get only new files in array result
#
my %in_local = map{$_ => 1}@local_files;
my @result = grep{not $in_local{$_}}@rem_files;

#
#If there are new files copy them to the server, otherwise send an email
#
my $arrSize = @result;

my $datestring = localtime();

my $message = "";

if($arrSize != 0){
        for my $file (@result) {

                if($sftp->get( $file, LOCAL_DIR.$file )){
                        print "File - $file transferred.\n";
                }else{
                        $message = $message. "An error occurred transfering $file!\n";
                }
        }
}else{

        $message = "There were no new files on server ".SERVER_NAME." ".HOST.". Local time: $datestring.\nLast file transferred: $newest.\n";

}

if ($message ne ""){
        system("echo '$message' | mail -s 'Error transfering files from RSM to server 172.31.1.153' -r 'MEDIATION SERVER<vqa\@columbus.co>' vqa\@columbus.co");
}
}
