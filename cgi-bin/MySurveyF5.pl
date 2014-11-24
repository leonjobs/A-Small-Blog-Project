#!/usr/bin/perl -w
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

# Produce the header for the reply page - do it here so
#  error messages appear on the page

print header();

# Set names for file locking and unlocking

$LOCK = 2;
$UNLOCK = 8;

# Set $index to the line index of the current vote


# Open and lock the survey data file

open(SURVDAT, "<survdat.dat") or error();
flock(SURVDAT, $LOCK);

# Read the survey data file, unlock it, and close it

@data = <SURVDAT>;

flock(SURVDAT, $UNLOCK);
close(SURVDAT);

# Split the line into its parts, increment the chosen
# device, and put it back together again

# Reopen the survey data file for writing and lock it

 $count = 0;
    while ($count < @data) {
	chomp($data[$count]);
	$jk = $data[$count];
   	@item = split(/ /, $jk);
	$temp = $count +1;
	if(param("nul$temp"))
	{
		$item[0] =  'N';
		$data[$count] = join(" ",@item);
	}	
    $count++;
    }

open(SURVDAT, ">survdat.dat") or error();
flock(SURVDAT, $LOCK);

# Write out the file data, unlock the file, and close it
 $count = 0;
    while ($count < @data) {
	$NewTemp = $data[$count];
	print SURVDAT "$NewTemp\n";
    $count++;
    }

flock(SURVDAT, $UNLOCK);
close(SURVDAT);

# Build the Web page to thank the survey participant
print start_html("Yes, you have change the table");
print "<form action='./MySurveyShow.pl'>";
print submit(-value=>"Return Back");
print "</form>";
print "You can see the result of survey <br/>\n";
print end_html();

#
