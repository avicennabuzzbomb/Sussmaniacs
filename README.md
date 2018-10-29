# Sussmaniacs
Scripts for general use in Sussman proteomics

* Includes a working draft for pulling GEE labeled peptides and finding 
their abundance in samples versus control samples (efficiency)

* Also a general use version that receives string arguments (example 
"GEE", "MetOx", etc. to run the script for several different 
peptide modifications of interest) 

* note to self (10/28/2018): calculating GEE labeling efficiency does not depend on the identity of unlabeled peptides, only their number
calulate number of unlabeled by doing ` # total peptides - # GEE peptides `. These numbers of peptides can be done by `wc -n` of the inpute file(s),
or by `sed p/"GEE"// | WC -n` printing from a specific starting point (line counts should stay the same as long as input files come from PD and are not
manipulated by the user first.
