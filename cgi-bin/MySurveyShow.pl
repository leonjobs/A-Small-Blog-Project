#!/usr/bin/perl -w
# conelec2.pl - display the survey results

use CGI ":standard";

# error - a function to produce an error message for the client
#         and exit in case of open errors

sub error {
    print "Error - file could not be opened in conelec2.pl <br/>";
    print end_html();
    exit(1);
}

# Begin main program
# Initialize file locking/unlocking parameter

$LOCK = 2;
$UNLOCK = 8;

print header();
# Open, lock, read, and unlock the survey data file

open(SURVDAT, "<survdat.dat") or error();
flock(SURVDAT, $LOCK);
@data = <SURVDAT>;
flock(SURVDAT, $UNLOCK);
close(SURVDAT);

# Create the beginning of the result Web page

print start_html("Survey Results");
print "<h2> Results of the Consumer Survey",
      "</h2><br/> \n";

# Split the input lines for females into age arrays

#@age1 = split(/ /, $vote_data[0]);
#@age2 = split(/ /, $vote_data[1]);
#@age3 = split(/ /, $vote_data[2]);
#@age4 = split(/ /, $vote_data[3]);

# Add the row titles to the age arrays

#unshift(@age1, "10-25");
#unshift(@age2, "26-40");
#unshift(@age3, "41-60");
#unshift(@age4, "Over 60");

# Make the column titles array

print "<form action='./MySurveyF5.pl' method='post'>";
@col_titles = ("NumberID", "Name", "Email Address", "Age Group", "Gender","Operate");

# Create the column titles in HTML by giving their address to the th
#  function and storing the return value in the @rows array

@rows = th(\@col_titles);

# Now create the data rows with the td function
#  and add them to the row addresses array
 $count = 0;
$len = @data;
    while ($count < $len) {
    @item = split(/ /, $data[$count]);
	if ($item[0] ne 'N')
	{	
    		push(@item, "<input type=\"checkbox\" name='nul$item[0]' value='nul$item[0]'>");
    		push(@rows, td(\@item));
	}
    		$count++;
    }

# Create the table for the female survey results
#  The address of the array of row addresses is passed to Tr

print table({-border => "border"},
            caption("<h3>The Survey Result Data</h3>"),
            Tr(\@rows)
           );
print submit(-value=>"Delete");
print "</form>";

print end_html();

