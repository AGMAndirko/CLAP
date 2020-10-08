# CLAP project: structured observations 

## Main messages


## Core files
As predicted by Kuhlwilm and Boeckx, the curve of excess follows that of positive selection more closely than length does; introgression deserts from Akey also follows pos selection closely -- these 3 curves are different ways of giving sense to "most distinctive" variants
	+ **AA:** did we roll stats on it at some point? I don't remember doing it, and that's the short of statment that we should be very careful to back strongly

All the curves tend to look like a Brontosaurus profile, except for missense where the right bump and left bump have equal height, and the introgression plots, which nicely lack the posterior bump.
## Statistical results
LIST all statistically significant results here

**KS test**: are certain distributions from the core files statistically significant when compared?
- Recent distribution (0-300k years)
    - HF vs HF strict
    ```D = 0.039051, p-value = 4.328e-11 ```
    - ALL vs HF
     ```D = 0.037489, p-value < 2.2e-16 ```
    - ALL vs HF strict
     ```D = 0.043893, p-value < 2.2e-16 ```
- Older distribution (300k years to end of the tail):
    - HF vs HF strict
     ```D = 0.087302, p-value < 2.2e-16 ```
    - ALL vs HF
     ```D = 0.19197, p-value < 2.2e-16 ```
    - ALL vs HF strict
     ```D = 0.2469, p-value < 2.2e-16 ```

**Linear regression model**
A linear regression analysis shows that expression values as predicted by ExPecto are significantly different in the 0-60k, 200-300k and 300-500k blocks of time (p-values <0.05).The R2 is very low though - expertise in stats needed here.


**Back-to-back plot statistics - random sampling**
Approximative Kruskal-Wallis Test with random sampling (n = 1000)


## Expecto
After runing the dated variants through the ExPecto tool we find an overall tissue skewedness over extreme positive and negative values. The same kind of analysis reveals that brain tissues have a different profile, with Astrocyte, Neural Progenitor Cell and Adrenal Gland carrying overall more negative values than the rest of the tissues.

**AA:** "indicate what this more negative values mean functionally for EXPECTO" -  Depends on other things. The values could mean that there is a tissue sample size bias in the training data of the DL tool (ie the original datasets). Once we discard that we could say those are tissues that have changed overall expression by HF mutations, but in that case we also should prove that that's specific of HF mutations. That's something that can't be done until we do NNaall in ExPecto (for which we have a computational limtiation).


## BAZ1B
BAZ1B targets: INV vs DIR contrast but mostly for most robust targets -- useful to bring up H. antcessor, but also Gokhman

Domestication vs Globularization timing vindicated; Tom vindicated

## Technical details
- Mention of 4th genome?
- Not sure what to do with chromosome data (ask Martin?)

## Enhancers / promoters 
Not sure what to do with cortical enh/prom changes from Juan's paper, maybe in SI?

## GO Terms - gprofiler2

For the 0-300k period, terms related to post-synapse ('regulation of postsynapse organization', GO:0099175; 'postsynaptic neurotransmitter receptor activity', GO:0098960), channel activity ('transmitter-gated channel activity', GO:0022835; 'ligand-gated channel activity', GO:0022834) stand out, while in the 300-500k period it exclusively appears heart/cardiac-related terms ('regulation of heart rate by cardiac conduction', GO:0086091; 'cardiac muscle cell action potential', GO:0086001). It is indeed in the late period (300 to 1my) where we find terms related to cardiomyopathy (KEGG:05412; KEGG:05410;KEGG:05414) or 'calcium regulation in the cardiac cell' (WP:WP536). Interestingly, the comparison early (0-300k) versus late (300k-1m) periods further shows differences in bone and cartilage related terms (skeletal system development, GO:0001501; chondrocyte differentiation, GO:0002062; collagen biosynthesis and formation, REAC:R-HSA-1650814 and REAC:R-HSA-1474290) or in the visual system (eye and visual system development, GO:0001654 and GO:0150063), exclusively found in the later periods (300 to 1my). 

Regarding signaling pathways, only in the first period we find 'cGMP-PKG signaling pathway' (KEGG:04022), while later 'oxytocin signaling pathway'(KEGG:04921) (300-500k period), 'cAMP signaling pathway' (KEGG:04024) or 'Pathways Regulating Hippo Signaling' (WP:WP4540) (500-1my period). Specific to the most recent period is the term related to the disorder 'Fragile X Syndrome' (WP:WP4549). Across all time blocks we recurrently find GO terms related to development and differentiation (including terms such as 'head development', GO:0060322; 'brain development', GO:0007420; or 'anatomical structure development', GO:0048856) and synapse (e.g. GABAergic/cholinergic/glutamatergic synapses, KEGG:04727, KEGG:04725, GO:0098978; or postsynapse, GO:0098794). Some specific terms for each period are shown in Figure X (see Suppl. Tables X1...Xn for the complete set of GO terms).

We further noticed differences between GO terms across periods when thresholding for a adj p-value < .05. Exclusively in the middle period (300-500k) we find terms related to behavior (startle response, GO:0001964), facial shape (narrow mouth, 'HP:0000160') and hormone system (steroid hormone, GO:0043401, GO:0048545, and GO:0003707; or parathyroid hormone, KEGG:04928). For the 500-1m period, we find cognition (GO:0050890), learning or memory (GO:0007611) or cerebellum (granular layer, HPA:007020_22; also present at adj p value < .01) and spinocerebellar ataxia (KEGG:05017). Only in the most recent period the term 'cerebral cortex: neuropil' appears (HPA:008050_22) (Suppl. Tables X1...Xn).

We ran the variants associated with GO-enriched genes through ExPecto in order to predict expression levels. A series of statistical tests show that varians coming from GO-enriched genes have significantly differences in their average expression levels in the middle (300-500k) and late (500-800k) periods. The early period (0-300k) didn't show this difference (p = 0.1887).