#!/usr/bin/perl -w

# A simple script to check all md5sums from downloaded ncbi db files
# requires a directory to have only the db files, this script,
# and requires the files and file.md5 to be in the same directory
# It is recommended to download the db files to a new directory
# then copy this script to that directory and run it


my @a = `ls`;
my $f = "/home/adminuser/Documents/ftpFromNCBI/";
my @testmd5;
my @gzipArr;
my $ict = 0;
foreach (@a) {
        my $s = $_;
        $s =~ s/\n//;
        if ($s =~ m/md5$/) {
                # array entry is md5 sum
                my $openFile = $f.$s;
                open (my $fh, "<", $openFile) or die "cannot open file $!\n";
                while (<$fh>) {
                chomp;
                push @testmd5, $_;
                # the next line will split entries
                # use for MacOSX or other distros               
                # @testmd5 = split(/\s+/,$_);
                # close $fh;
                }
        }
        elsif ($s =~ m/gz$/) {
        # array entry is gzip file
                push @gzipArr, $s;
        }
        else {
        # print $s;     
        }

}



for my $i (0..$#testmd5) {
        my $t = $gzipArr[$i];
        my $fileToCheck = $t;
        my $md5result = `md5sum $fileToCheck`;
        my $c = $testmd5[$i];
        $md5result =~ s/\n//;
        unless ($c eq $md5result) {
                print "WARNING!  $md5result did not match\n$c\n";
        }
}

print "Job done!\n";
