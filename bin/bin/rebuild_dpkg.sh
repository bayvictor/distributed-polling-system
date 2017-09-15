 script to build a new dpkg status file.  Relies on an assumption
# that /usr/share/doc is intact, and that each subdir of that
# indicates an installed package.
#
# This script can be run as a non-root user and creates output files,
# in an unsecure fashion, in /tmp.
#
# Thanks to capink on ubuntuforums.org, and Karsten M. Self.
#

use strict;
use warnings;


my @installed_packages;
my %package_control_info;  # By package, then by file.
my $new_status_file = "/tmp/new-status";
my $new_dpkg_selections_file = "/tmp/new-dpkg-selections";


##
##  Here we populate @installed_packages by examining /usr/share/doc,
##  as suggested by Karsten M. Self.
##
opendir DOC, "/usr/share/doc" or die "failed opening doc dir";
foreach ( grep { -d "/usr/share/doc/$_" } readdir( DOC )) {
    next if ( m/^\./ );
    next if ( m/[A-Z]/ );
    next if ( $_ eq 'texmf' );
    next if ( $_ eq 'debian' );
    push @installed_packages, $_;
}
closedir DOC;


##
##  Now we hash the contents of the control files.
##
my ($package, $control_file);
opendir LISTS, "/var/lib/apt/lists" or die "failed opening lists dir";
while (my $control_file = readdir( LISTS )) {
    next unless ( -f "/var/lib/apt/lists/$control_file" );
    next unless ( "/var/lib/apt/lists/$control_file" =~ m/_Packages$/ );

    open CONTROL_FILE, "/var/lib/apt/lists/$control_file"  or die "failed opening control file '$_'";
    while (my $line = <CONTROL_FILE>) {
        if ( $line =~ m/^(Package:\s)(.*$)/ ) {
            my $package_name = $2;
            push @{ $package_control_info{$package_name}->{$control_file} }, $line;
            $line = <CONTROL_FILE>;
            while ($line !~ m/^\s*$/ ) {
                push @{ $package_control_info{$package_name}->{$control_file} }, $line;
                $line = <CONTROL_FILE>;
            }
        }
    }
    close CONTROL_FILE;
}
closedir LISTS;


##
## Here we create the new status file by printing all the control info
## we have for all the installed packages, as suggested by 'capink' on
## ubuntuforums.org.
##
open NEW_STATUS_FILE, ">", $new_status_file   or die "this sucks";
foreach my $package ( @installed_packages ) {
    while (my ($control_file, $control_info_ref) = each( %{ $package_control_info{$package} } ) ) {
        my @status_info;
        foreach my $line ( @{ $control_info_ref } ) {
            next if ( $line =~ m/^Filename:/ );
            next if ( $line =~ m/^MD5sum:/ );
            next if ( $line =~ m/^Size:/ );
            next if ( $line =~ m/^SHA1:/ );
            next if ( $line =~ m/^SHA256:/ );
            push @status_info, $line;
            if ( $line =~ m/^Package:/ ) {
                push @status_info, "Status: install ok installed\n";
            }
        }
        push @status_info, "\n";
        print NEW_STATUS_FILE @status_info;
    }
}
close NEW_STATUS_FILE;


##
## Here we create a dpkg selections file containing a list of the
## packages we think are installed.
##
open NEW_SELECTIONS_FILE, ">", $new_dpkg_selections_file   or die "this also sucks";
foreach my $line ( @installed_packages ) {
    print NEW_SELECTIONS_FILE "$line install\n";
}
close NEW_SELECTIONS_FILE;


print "\n";
print "New status file created: '$new_status_file'.\n";
print "If it looks right, then:  mv  '$new_status_file'  '/var/lib/dpkg/status'\n";
print "\n";
print "New dpkg selections file created: '$new_dpkg_selections_file'.\n";
print qq|run 'dpkg --get-selections < "$new_dpkg_selections_file"'  to re-create deselect's selections.\n|;
print "\n";

