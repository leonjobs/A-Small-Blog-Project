#!/usr/bin/perl -w
# conelec1.pl
# This CGI program processes the consumer electronics survey
#  form and updates the file that stores the survey

use CGI ":standard";

# error Ð a function to produce an error message for the client
#         and exit in case of open errors

sub error {
    print "Error file could not be opened in conelec1.pl <br/>";
    print end_html();
    exit(1);
}

# Begin main program
# Get the form values

my($thename, $email, $age, $gender) = (param("thename"), param("email"), param("age"), param("gender")); 

$thename =~ s/\s//g;
$email =~ s/\s//g;
	#根据表单的填写 得到关键信息

# Produce the header for the reply page - do it here so
#  error messages appear on the page

print header();

# Set names for file locking and unlocking

$LOCK = 2;
$UNLOCK = 8;

# Set $index to the line index of the current vote

#$index = 0;
#if ($gender eq "male") {
    #$index = 4;
#}
#if ($age eq "b2640") { $index += 1 }
#elsif ($age eq "b4160") { $index += 2 }
#elsif ($age eq "o60") { $index += 3 }

# Open and lock the survey data file

open(NUMDAT, "<numdat.dat") or error();
flock(NUMDAT, $LOCK);

# Read the survey data file, unlock it, and close it

chomp($file_lines_num= <NUMDAT>);

flock(NUMDAT, $UNLOCK);
close(NUMDAT);
$file_lines_num++;

# Split the line into its parts, increment the chosen
# device, and put it back together again

#@file_votes = split / /, $file_lines[$index];
#$file_votes[$vote]++;
#$file_lines[$index] = join(" ", @file_votes);

# Reopen the survey data file for writing and lock it

open(SURVDAT, ">>survdat.dat") or error();
flock(SURVDAT, $LOCK);

# Write out the file data, unlock the file, and close it

print SURVDAT "$file_lines_num $thename $email $age $gender\n";

flock(SURVDAT, $UNLOCK);
close(SURVDAT);

open(NUMDAT, ">numdat.dat") or error();
flock(NUMDAT, $LOCK);

print NUMDAT "$file_lines_num\n";

flock(NUMDAT, $UNLOCK);
close(NUMDAT);

# Build the Web page to thank the survey participant
print start_html("Thank You");
print "Thanks for doing this survey <br/>\n";
print end_html();

