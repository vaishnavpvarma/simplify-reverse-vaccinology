#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;

# First check if Excel::Writer::XLSX is installed
eval {
    require Excel::Writer::XLSX;
    Excel::Writer::XLSX->import();
};
if ($@) {
    die "Error: Excel::Writer::XLSX module is not installed.\n" .
        "Please install it using: cpan Excel::Writer::XLSX\n";
}

# Input file path - CHANGE THIS TO YOUR FILE PATH
my $input_file = "E:/msc_dissertation/t_cell_prediction/iedb_mhcII_results/htl_16mer/vaxijen_antigenicity_results_16mer_unique.txt";
my $output_file = "vaxijen_results_htl_pred_16mer_unique.xlsx";

# Check if input file exists
if (!-f $input_file) {
    die "Input file not found: $input_file\n";
}

# Create a new Excel workbook with error handling
my $workbook;
eval {
    $workbook = Excel::Writer::XLSX->new($output_file);
};
if ($@ || !defined $workbook) {
    die "Error creating Excel workbook: $@\n" .
        "Check if the output file is open in another program or if you have write permissions.\n";
}

# Create a format for headers
my $header_format = $workbook->add_format();
$header_format->set_bold();
$header_format->set_bg_color('#D9D9D9');

# Get filename for worksheet name
my $basename = basename($input_file, ".txt");
print "Processing $basename...\n";

# Create a worksheet - limit name to 31 chars (Excel limit)
# Also replace invalid characters in sheet name
my $sheet_name = substr($basename, 0, 31);
$sheet_name =~ s/[\[\]:*?\/\\]/_/g; # Replace invalid Excel sheet name chars

my $worksheet = $workbook->add_worksheet($sheet_name);

# Write headers
$worksheet->write(0, 0, "ID", $header_format);
$worksheet->write(0, 1, "Sequence", $header_format);
$worksheet->write(0, 2, "VaxiJen Score", $header_format);
$worksheet->write(0, 3, "Antigenicity", $header_format);

# Read the file line by line
open my $input_fh, "<:encoding(utf8)", $input_file or die "Could not open '$input_file': $!";
my @file_content = <$input_fh>;
close $input_fh;

# Initialize variables
my $id = "";
my $sequence = "";
my $vaxijen_score = "";
my $antigenicity = "";
my $row = 1; # Start from row 1 (after header)

# Print first few lines for debugging
print "First 10 lines of file:\n";
for (my $i = 0; $i < 10 && $i < scalar @file_content; $i++) {
    print "$i: " . $file_content[$i];
}
print "\n";

# Process file line by line
for (my $i = 0; $i < scalar @file_content; $i++) {
    my $line = $file_content[$i];
    chomp $line;
    
    # Extract ID
    if ($line =~ /^>(.+)/) {
        # If we already have data from a previous entry, save it
        if ($id ne "") {
            $worksheet->write($row, 0, $id);
            $worksheet->write($row, 1, $sequence);
            $worksheet->write($row, 2, $vaxijen_score);
            $worksheet->write($row, 3, $antigenicity);
            $row++;
        }
        
        # Reset variables for new entry
        $id = $1;
        $sequence = "";
        $vaxijen_score = "";
        $antigenicity = "";
        
        # Look for the sequence in the next several lines
        my $j = $i + 1;
        while ($j < scalar @file_content && $sequence eq "") {
            my $next_line = $file_content[$j];
            chomp $next_line;
            
            # Check for 16-letter sequence specifically, but also allow other lengths
            # that consist of only capital letters
            if ($next_line =~ /^[A-Z]{16}$/) {
                $sequence = $next_line;
                print "Found 16-letter sequence: $sequence for ID: $id\n";
                last;
            }
            # Also check for any sequence of only capital letters as a fallback
            elsif ($next_line =~ /^[A-Z]+$/) {
                $sequence = $next_line;
                print "Found sequence (length " . length($sequence) . "): $sequence for ID: $id\n";
                last;
            }
            
            $j++;
            
            # Don't search too far (limit to 10 lines after ID)
            if ($j > $i + 10) {
                last;
            }
        }
    }
    
    # Extract VaxiJen score (including negative scores)
    if ($line =~ /Overall Prediction for the Protective Antigen = (-?[0-9.]+)/) {
        $vaxijen_score = $1;
    }
    
    # Extract antigenicity
    if ($line =~ /\(\s*(Probable ANTIGEN|Probable NON-ANTIGEN)\s*\)/) {
        $antigenicity = $1;
    }
}

# Save the last entry if needed
if ($id ne "") {
    $worksheet->write($row, 0, $id);
    $worksheet->write($row, 1, $sequence);
    $worksheet->write($row, 2, $vaxijen_score);
    $worksheet->write($row, 3, $antigenicity);
}

# Set reasonable column widths
$worksheet->set_column(0, 0, 30); # ID column
$worksheet->set_column(1, 1, 20); # Sequence column - wider for 16-letter sequences
$worksheet->set_column(2, 2, 15); # VaxiJen Score column
$worksheet->set_column(3, 3, 20); # Antigenicity column

$workbook->close();
print "Extraction complete. Results saved to $output_file\n";