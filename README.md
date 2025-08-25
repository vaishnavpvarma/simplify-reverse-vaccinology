# Epitope Prediction Utility Scripts

This repository contains custom scripts developed during my **MSc Bioinformatics dissertation project**:  
**Multi-epitope Vaccine Design Against Hepatitis B Virus (HBV) Using Reverse Vaccinology Approach**.

The scripts help automate the processing and tabulation of epitope prediction outputs from various immunoinformatics tools.

---

## 📌 Current Script

### 1. `vaxijen_to_excel.pl`

**Problem Statement**  
[VaxiJen](http://www.ddg-pharmfac.net/vaxijen/) is a widely used tool for antigenicity prediction.  
However, **it does not provide an option to download results directly**. Researchers must manually copy outputs and tabulate them.  
For large datasets, this becomes impractical since each output contains:  
- A VaxiJen score (floating-point number)  
- Antigenicity classification (*Probable ANTIGEN* / *Probable NON-ANTIGEN*)  

Manually separating these values and creating a structured table is time-consuming and error-prone.

**Solution**  
This script automates the entire process:  
- Takes raw VaxiJen output (copied & saved as `.txt`) as input  
- Extracts:
  - Epitope ID  
  - Sequence  
  - VaxiJen score  
  - Antigenicity result  
- Saves results into a clean, well-formatted **Excel spreadsheet (.xlsx)**  

This enables efficient handling of **large-scale epitope datasets**.

---

## 🚀 Usage

```bash
perl vaxijen_to_excel.pl input_file.txt output_file.xlsx
