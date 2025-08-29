# 🧬 Epitope  Tools

---

## 🌟 Highlights
- 🚀 Automates tedious manual parsing of **VaxiJen** and **AllerTOP** webserver outputs.  
- 📊 Converts raw text outputs into structured **Excel spreadsheets**.  
- 🧪 Handles **large datasets** where copy–pasting results is not humanly possible.  
- 🐪 Written in **Perl**, a classic bioinformatics scripting language, optimized for **text parsing**.  

---

## ℹ️ Overview
Many bioinformatics webservers (like **VaxiJen(all versions)** and **AllerTOP**) do not provide an option to **download results**.  
Instead, they display predictions on the webpage, forcing researchers to manually copy, paste, and tabulate the results.  

👉 This becomes impractical when working with **hundreds or thousands of peptides**, each output containing:  
- A **score** (e.g. VaxiJen score, floating point)  
- A **prediction** (e.g. *Probable ANTIGEN* / *NON-ANTIGEN* / *ALLERGEN*/ *NON-ALLERGEN*)  

These Perl scripts solve this problem by:  
1. Reading raw `.txt` files saved from the webserver output.  
2. Extracting IDs, peptide sequences, and prediction values using **Regular Expressions (RegEx)**.  
3. Writing them neatly into an Excel file (`.xls` or `.xlsx`) for downstream analysis.  

💡 In short:  
**Unstructured text in → Structured spreadsheet out.**  

---

## ✍️ Authors
👨‍🔬 **Vaishnav P. Varma**  
[GitHub Profile](https://github.com/vaishnavvarma) | Bioinformatician by Degree| Photographer by Passion| My creativity is from my Laziness 😉  

---

## ⬇️ Installation/Prerequisites
1) Install **Perl 5**  
   - Linux/macOS: usually preinstalled  
   - Windows: install via **Strawberry Perl** → https://strawberryperl.com/

2) Install Perl modules:
```bash
cpan Excel::Writer::XLSX          # for VaxiJen script (.xlsx)
cpan Spreadsheet::WriteExcel      # for AllerTOP script (.xls)

```
3) Clone the repo:

```bash
git clone https://github.com/vaishnavvarma/epitope-scripts.git
cd epitope-scripts
```
🚀 Usage (no command-line arguments)
1️⃣ VaxiJen → Excel (.xlsx)

Step A: Edit file paths inside the script
Open scripts/vaxijen_to_excel.pl in your preferred Text Editor and set:
```
# Change these to your files/paths
my $input_file  = "path/to/vaxijen_output.txt";
my $output_file = "vaxijen_results.xlsx";
```
Step B: Run in commandline/terminal
```
perl scripts/vaxijen_to_excel.pl
```


