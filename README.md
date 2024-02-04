# Antimicrobial Peptides Screening from Microbial Genomes in Sludge Based on Deep Learning 
## Abstract
As the issue of traditional antibiotic resistance continues to worsen, exploring new antimicrobial substances has become crucial to addressing this challenge. Antimicrobial peptides (AMPs), recognized for their low resistance levels and minimal bacterial mutation frequencies, have garnered significant attention from researchers. However, traditional screening methods for AMPs are inefficient and costly. This study proposes a combined AMP screening model based on Long Short-Term Memory (LSTM) neural networks with an attention mechanism. By analyzing the characteristics of peptide segments, which are simulated enzymatic hydrolysis products of proteins expressed in sludge microbial genomes, the model accurately identifies peptide segments with potential antimicrobial activity. Molecular docking and dynamic simulation results validate three potential antimicrobial peptide candidates: LLPRLLARRY, GVREIHGLNPGGCLHTVRLVCR, and FRTTLAPHVLTRLLAPCW. These candidates exhibit high binding stability and affinity with target proteins, confirming the efficiency of the proposed AMP screening model.
## original data
The raw data file for this study is named `sludge.fastq`.<br>
## The program and instructions are provided below
* Prediction small ORF from genome sequences → `small.pl`<br>
* remove redundant sORF and known AMPs → `remove.pl`<br>
* Prepare input data format for LSTM and Attention models → `prepare_data.pl`<br>
* AMPs prediction → `FocusMechanism.py`;`prediction_lstm.py` updated_attention_model.py updated_lstm_model.py<br>
* result → `Result_integration.pl``ROC.py`<br>
