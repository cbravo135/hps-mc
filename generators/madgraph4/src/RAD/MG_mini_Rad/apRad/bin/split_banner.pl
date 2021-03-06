#!/usr/bin/perl -w

#############################################################################
#                                                                          ##
#                    MadGraph/MadEvent                                     ##
#                                                                          ##
# FILE : split_banner.pl                                                   ##
# VERSION : 1.0                                                            ##
# DATE : 6 April 2007                                                      ##
# AUTHOR : Michel Herquet (UCL-CP3)                                        ##
#                                                                          ##
# DESCRIPTION : script to recover cards from a banner                      ##
# USAGE : split_banner.pl banner.txt                                       ##
# OUTPUT : all found cards                                                 ##
#############################################################################


# Parse the command line arguments

if ( $#ARGV != 0 ) {
     die "This script must be called with one banner filename as argument!\n";
}

my $banner=$ARGV[0];


print "Reading input file ... \n";
open(BANNER,"$banner") || die "Cannot open banner file called $banner, stopping\n";

# Define tags and extract cards

my $begin_proc='# Begin proc_card.dat'."\n".'#'."\n";
my $end_proc="\n".'#'."\n".'# End proc_card.dat';

my $begin_param='# Begin param_card.dat'."\n".'#'."\n";
my $end_param="\n".'#'."\n".'# End param_card.dat';

my $begin_run='# Begin run_card.dat'."\n".'#'."\n";
my $end_run="\n".'#'."\n".'# End run_card.dat';

my $begin_pythia='# Begin pythia_card.dat'."\n".'#'."\n";
my $end_pythia="\n".'#'."\n".'# End pythia_card.dat';

my $begin_pgs='# Begin pgs_card.dat'."\n".'#'."\n";
my $end_pgs="\n".'# End pgs_card.dat';

while(<BANNER>)
{
    $fullbanner .= $_;
} 

close(BANNER);

if ( $fullbanner=~ /<MGProcCard>/ ) {
# New version of banner
    $begin_proc='<MGProcCard>'."\n";
    $end_proc="\n".'<\/MGProcCard>';
    
    $begin_param='<slha>'."\n";
    $end_param="\n".'<\/slha>';
    
    $begin_run='<MGRunCard>'."\n";
    $end_run="\n".'<\/MGRunCard>';
    
    $begin_pythia='<MGPythiaCard>'."\n";
    $end_pythia="\n".'<\/MGPythiaCard>';
    
    $begin_pgs='<MGPGSCard>'."\n";
    $end_pgs="\n".'<\/MGPGSCard>';
}

if ( $fullbanner=~ m/$begin_proc/ ) {
	print "proc_card found ... ";
	($proc_card)= $fullbanner=~ m/$begin_proc(.*?)$end_proc/s;
        open(PROC,">proc_card.dat") || die "Cannot open proc_card.dat for writing, stopping\n";
	print PROC $proc_card."\n";
        close(PROC);
	print "Extracted\n";
} else { print "proc_card not found!\n"; }

if ( $fullbanner=~ m/$begin_param/ ) {
	print "param_card found ... ";
	($param_card)= $fullbanner=~ m/$begin_param(.*?)$end_param/s;
        open(PARAM,">param_card.dat") || die "Cannot open param_card.dat for writing, stopping\n";
	print PARAM $param_card."\n";
        close(PARAM);
	print "Extracted\n";
} else { print "param_card not found!\n"; }

if ( $fullbanner=~ m/$begin_run/ ) {
	print "run_card found ... ";
	($run_card)= $fullbanner=~ m/$begin_run(.*?)$end_run/s;
        open(RUN,">run_card.dat") || die "Cannot open run_card.dat for writing, stopping\n";
	print RUN $run_card."\n";
        close(RUN);
	print "Extracted\n";
} else { print "run_card not found!\n"; }

if ( $fullbanner=~ m/$begin_pythia/ ) {
	print "pythia_card found ... ";
	($pythia_card)= $fullbanner=~ m/$begin_pythia(.*?)$end_pythia/s;
	#remove LHA path tags that are locally defined
        $pythia_card =~ s/\n\s*LHAPATH=.*/\n/g;
        open(PYTHIA,">pythia_card.dat") || die "Cannot open pythia_card.dat for writing, stopping\n";
	print PYTHIA $pythia_card."\n";
        close(PYTHIA);
	print "Extracted\n";
} else { print "pythia_card not found!\n"; }

if ( $fullbanner=~ m/$begin_pgs/ ) {
	print "pgs_card found ... ";
	($pgs_card)= $fullbanner=~ m/$begin_pgs(.*?)$end_pgs/s;
        open(PGS,">pgs_card.dat") || die "Cannot open pgs_card.dat for writing, stopping\n";
	print PGS $pgs_card."\n";
        close(PGS);
	print "Extracted\n";
} else { print "pgs_card not found!\n"; }

