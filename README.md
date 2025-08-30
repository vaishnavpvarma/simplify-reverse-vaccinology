# 🧬 Vaxijen Antigenicity Parser

---

## 🌟 Highlights
- 🚀 Automates tedious manual parsing of **VaxiJen** webserver outputs.  
- 📊 Converts raw text outputs into structured **Excel spreadsheets**.  
- 🧪 Handles **large datasets** where copy–pasting results is not humanly possible.  
- 🐪 Written in **Perl**, a classic bioinformatics scripting language, optimized for **text parsing**.  

---

## ℹ️ Overview
Many bioinformatics webservers (like **VaxiJen [all version])**) do not provide an option to **download results**.  
Instead, they display predictions on the webpage, forcing researchers to manually copy, paste, and tabulate the results.  

👉 This becomes impractical when working with **hundreds or thousands of peptides**, each output containing:  
- A **score** (e.g. VaxiJen score, floating point)  
- A **prediction** (e.g. *Probable ANTIGEN* / *NON-ANTIGEN*)  

These Perl scripts solve this problem by:  
1. Reading raw `.txt` files saved from the webserver output.  
2. Extracting IDs, peptide sequences, and prediction values using **Regular Expressions (RegEx)**.  
3. Writing them neatly into an Excel file (`.xls` or `.xlsx`) for downstream analysis.  

💡 In short:  
**Unstructured text in → Structured spreadsheet out.**  

**Before:** You have a text file that looks something like this:
```
>protein_sequence_001
AKFPQRSTUVWXYZAB
Some technical text here...
Overall Prediction for the Protective Antigen = 0.7234
More text...
(Probable ANTIGEN)
>protein_sequence_002
MNPQRSTUVWXYZDEF
...
```

**After:** You get a clean Excel file with columns:
| ID | Sequence | VaxiJen Score | Antigenicity |
|----|----------|---------------|--------------|
| protein_sequence_001 | AKFPQRSTUVWXYZAB | 0.7234 | Probable ANTIGEN |
| protein_sequence_002 | MNPQRSTUVWXYZDEF | 0.5621 | Probable NON-ANTIGEN |
---

## Key Features

- 🔍 **Smart Search**: Automatically finds protein sequences and their prediction scores, even when they're scattered across multiple lines
- 📊 **Excel Output**: Creates professional-looking spreadsheets with proper formatting and column headers
- 🛡️ **Error Proof**: Checks if files exist and handles common errors gracefully
- 🔧 **Flexible**: Works with different sequence lengths (optimized for 16-letter sequences but adapts to others)
- ✅ **Data Validation**: Only captures valid protein sequences (sequences with only capital letters A-Z)

## How It Works (In Simple Terms)

Think of this script like a very patient assistant who:

1. **Reads every line** of your messy text file, one by one
2. **Looks for patterns** like sequence names (lines starting with ">") and protein sequences (lines with only capital letters)
3. **Connects the dots** between related information that might be several lines apart
4. **Organizes everything** into a neat table structure
5. **Creates a pretty Excel file** with proper formatting and headers

## Technical Approach

### Pattern Matching Strategy
The script uses **regular expressions** (pattern matching rules) to identify different types of data:
- `^>(.+)` finds sequence identifiers
- `^[A-Z]{16}$` finds 16-letter protein sequences
- `Overall Prediction.*= (-?[0-9.]+)` extracts numerical scores
- `Probable (ANTIGEN|NON-ANTIGEN)` captures classification results

### Search Algorithm
Uses a **forward-looking sequential search**:
- Processes the file line by line from top to bottom
- When it finds a sequence identifier, it searches the next 10 lines for the corresponding protein sequence
- Stops searching once it finds what it's looking for (efficient and prevents endless searching)

### Why Not Use Simpler Tools?

**Question**: "Why use Perl instead of AWK or other text processing tools?"

**Answer**: While AWK would be simpler for just extracting text, this script needs to create formatted Excel files with headers, column widths, and styling. AWK can't do that directly - you'd need multiple tools. Perl handles both text parsing and Excel creation in one go, with robust error handling for research workflows.

## ⬇️ Prerequisites
1) Install **Perl 5**  
   - Linux/macOS: usually preinstalled  
   - Windows: install via **Strawberry Perl** → https://strawberryperl.com/

2) Install Perl modules:
```bash
cpan Excel::Writer::XLSX          # for VaxiJen script (.xlsx)
cpan Spreadsheet::WriteExcel      # for AllerTOP script (.xls)


```
##**Installation**

3) Clone the repo:

```bash
git clone https://github.com/vaishnavvarma/epitope-scripts.git
cd epitope-scripts
```
##**🚀 Usage (no command-line arguments)**
1️⃣ VaxiJen → Excel (.xlsx)

Step A: Edit file paths inside the script
Open scripts/vaxijen_to_excel.pl in your preferred Text Editor and set:
```
my $input_file  = "path/to/vaxijen_output.txt";
my $output_file = "vaxijen_results.xlsx";
```
Step B: Run in commandline/terminal
```
perl scripts/vaxijen_to_excel.pl
```
💡 Tips for file paths (Windows):

> Prefer forward slashes: C:/Users/Name/Desktop/input.txt

Or escape backslashes: C:\\Users\\Name\\Desktop\\input.txt

> If a path has spaces, wrap in quotes inside the Perl string: "C:/My Data/results.txt"

## Perfect For

- 🧬 Bioinformatics researchers working with protein predictions (Immunoinformatics)
- 📊 Anyone who needs to convert scientific text output into spreadsheet format
- 🎓 Students learning about data parsing and file processing
- 🔬 Labs that need to process VaxiJen antigenicity predictions regularly

## ✍ Behind the Code
👨‍🔬 **Vaishnav P. Varma**  [GitHub Profile](https://github.com/vaishnavvarma)   
Bioinformatician by training | Photographer by heart | Turning coffee and curiosity into code ☕

----------
Crafted with ❤️, code, and curry in India 🇮🇳
