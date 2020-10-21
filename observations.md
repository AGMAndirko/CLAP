# CLAP project: structured observations 

## Main messages

# Dating Homo sapiens-specific variants

## Methods
We used the Genealogical Estimation of Variant Age [GEVA](https://github.com/pkalbers/geva) database to assign estimated dates of emergence to various sets of variants related to human evolution. We settled on **29** years per generation, though [other timings shouldn't affect the overall distribution](https://github.com/AGMAndirko/CLAP/blob/master/plots/KB19_distributions/alt_gen_values.pdf). We used the "Combined" estimated age, as opposed to the measures derived uniquely from the Simons Diversity project or the 1000 genomes project. 

Though the GEVA dataset has a wide set of variants, we do miss some of the rarest variants in the process of assigning a date. 
- Out of a total of  4437804 for out total set of variants, 3163747 can be rsID'ed (71%) ([)from 2 sources, 1000G and Simons projects), and out of that 2294023 can be mapped (72%; which means 51% of the  4437804 original total). 
- Out of the high-frequency subset, 128706 (94%) can be rsID'ed, and out of that, 101417 can be mapped (78%; i.e., 74% of original total). 
- For the stricter HF filtering data, out of 78085 variants, 70027 (89%) can be rsID'ed, and 48424 of that mapped (69%; i.e., 62% of the original total).
- We looked into fixed positions, but out of 12028 variants, only 32% could be rsID'ed, and out of that only 4% could be mapped, i.e. about only 1% of the original total.


## Kulhwilm and Boeckx files 
We first crossed the Kuhlwilm & Boeckx (2019) database of changes between modern humans and archaics with the GEVA database. See the resulting distribution [here](https://github.com/AGMAndirko/CLAP/blob/master/plots/KB19_distributions/3dist_sqrd.pdf), where "All" is all the variants from [the Kuhlwilm and Boeckx article](https://figshare.com/articles/Variants_and_annotations_of_Neandertals/8184038), 90% is a subset of the data that includes only high frequency variants and 90% (strict) is a further subset with more stringent filters.

These distributions are characterized by a bimodal distribution. We tried to stablish a k-cluster of ages that resulted in two possibilities for downstream analysis: a [k = 3](https://github.com/AGMAndirko/CLAP/blob/master/plots/KB19_distributions/kmean3_HFstr.pdf) cluster or a [k = 4](https://github.com/AGMAndirko/CLAP/blob/master/plots/KB19_distributions/kmeans4_HFstr.pdf) one. We finally settled on hand-picked values based on major tipping points in the Homo sapiens history (see [here](https://github.com/AGMAndirko/CLAP/blob/master/plots/KB19_distributions/timing_windows.pdf) for the final distribution). 

## Statistical significance
We checked with a KS statistical test whether the all, 90 (non strict) and 90 (strict) distributions are significantly different, performing different tests for the 0-300k and the 300k-end bits. The KS tests show that the different curves are different in a significant way (p-val < 0.01) despite two of them being a subset of the "all" distribution.
 
## Other subsets of evolutionary relevance
In order to see if specific subsets of variants had strickingly different distributions over time, we plotted them [here](https://github.com/AGMAndirko/CLAP/blob/master/plots/five_files_plots/seven_files_plot.pdf). The subsets of interest include:
 1. *Akey* signals 
 2. *Deserts:* Deserts of introgression
 3. *Excess* and *lenght*: in-house lists including genes with an excess of mutations, and a gene lenght-controlled version
 4. *Peyregné:* regions under putative positive selection

We also plotted [variants of interest](https://github.com/AGMAndirko/CLAP/blob/master/plots/McCoyetal_snps/mcCoyetal_snps.pdf) comming from McCoy et al.'s study on Neanderthal-introgressed variants (see [here](https://github.com/AGMAndirko/CLAP/blob/master/plots/introgression/all_neand_intro2.pdf)). 

Regarding introgression, we used data from [Vernot et al.](https://pubmed.ncbi.nlm.nih.gov/26989198/) and [Sankararaman et al.](https://pubmed.ncbi.nlm.nih.gov/27032491/). Both distributions follow each other closely, and lack the second peak *circa* 1,2mya characteristic of the [main distribution plots.](https://github.com/AGMAndirko/CLAP/blob/master/plots/KB19_distributions/3dist_sqrd.pdf), as expected.

[TBC]
- Enhancers, GTEX

# Expecto
We tried to predict the effect of variants in specific time windows in brain tissues using [ExPecto](https://humanbase.readthedocs.io/en/latest/expecto.html), a machine learning framework for expression prediction in silico. 

First, the authors of this tool trained tissue-specific convolutional neural networks (CNN) that takes histone marks, transcription factors and DNA accessibility experimental data from ENCODE and Roadmap. This information is organized in each CNN in windows of 1000 bp before and after the TSS of each protein coding gene. You can, in theory, train any expression data to generate a CNN. This generates various layers of predictions, each accounting for a series of features (roughly speaking), that are then transformed into 'weights' spatially located around the TSS. These weights are compounds of features that determine future expression predictions in a specific locus. When fed a new variant file (vcf), these weights are used to predict gene expression with a linear regression model. The predicted result correlates highly with experimental evidence, according to the authors.

In our case we are using a curated list of the training models they generated for the study (GTEx, Roadmap and ENCODE expression data). The main criteria for this list was that the tissue or cell had to be brain-related. 

## Methods
We only used the list of dated high-frequency varaints, as the process consumes a huge ammount of computational resources and couldn't be run for all the variants. You can see a list of plots generated per time windows in [here](https://github.com/AGMAndirko/CLAP/tree/master/plots/ExPecto), codenames `date-date_1or2.pdf`. The 1 plots show down and upregulation for each period. The 2 plots show the combined measure of downregulation and upregulation. 

Variation potential score plots were created as described in [here](https://humanbase.readthedocs.io/en/latest/expecto.html#variation-potential-directionality-scores).


## Results
We obtained [lists of genes per age](https://github.com/AGMAndirko/CLAP/blob/master/plots/ExPecto/all_timingwindows_cone.pdf) that accumulate what the ExPecto authors call a [high variation potential score](https://humanbase.readthedocs.io/en/latest/expecto.html#variation-potential-directionality-scores), a predictive measure of tissue/condition-specificity of a gene. A window-specific version of the variation potential scores can be seen [here](https://github.com/AGMAndirko/CLAP/blob/master/plots/ExPecto/timing_cone.pdf).

A [hierarchical cluster analysis](https://github.com/AGMAndirko/CLAP/blob/master/plots/ExPecto/tissues_dendrogram.pdf) showed that predicted tissue values are grouped in three main groups. This is well reflected in a [similarity distance heatmap](https://github.com/AGMAndirko/CLAP/blob/master/plots/ExPecto/expecto_similarity_value.pdf) plot. In terms of value skewedness, we show that the model reflects a high-skewedness towards negative expression values in [brain tissues](https://github.com/AGMAndirko/CLAP/blob/master/plots/ExPecto/alltissuesQQ.pdf) but not in [all the tissues included](https://github.com/AGMAndirko/CLAP/blob/master/plots/ExPecto/alltissuesQQ.pdf), where there's an overall skewedness in both positive and negative extreme values.

## Stats
A linear regression analysis shows that expression values as predicted by ExPecto are significantly different in the 0-60k, 200-300k and 300-500k blocks of time (p-values <0.05). However, the R2 is very low.

We performed another analysis to check whether there was a significant correlation between dates predicted by the GEVA tool and expression - correlation is significant (p-value = 0.003259) but only when not taking into account tissue-specifity. Tissue expression value is significantly different in some of the tissues regardless of GEVA timing (such as Neural Progenitor Cell, astrocyte or Adrenal Gland). Note that this are also grouped together in a cluster, as shown by a hierarchical cluster dendrogram plot. 


# GO analysis

## Gprofiler2

For the 0-300k period, terms related to post-synapse ('regulation of postsynapse organization', GO:0099175; 'postsynaptic neurotransmitter receptor activity', GO:0098960), channel activity ('transmitter-gated channel activity', GO:0022835; 'ligand-gated channel activity', GO:0022834) stand out, while in the 300-500k period it exclusively appears heart/cardiac-related terms ('regulation of heart rate by cardiac conduction', GO:0086091; 'cardiac muscle cell action potential', GO:0086001). It is indeed in the late period (300 to 1my) where we find terms related to cardiomyopathy (KEGG:05412; KEGG:05410;KEGG:05414) or 'calcium regulation in the cardiac cell' (WP:WP536). Interestingly, the comparison early (0-300k) versus late (300k-1m) periods further shows differences in bone and cartilage related terms (skeletal system development, GO:0001501; chondrocyte differentiation, GO:0002062; collagen biosynthesis and formation, REAC:R-HSA-1650814 and REAC:R-HSA-1474290) or in the visual system (eye and visual system development, GO:0001654 and GO:0150063), exclusively found in the later periods (300 to 1my). 

Regarding signaling pathways, only in the first period we find 'cGMP-PKG signaling pathway' (KEGG:04022), while later 'oxytocin signaling pathway'(KEGG:04921) (300-500k period), 'cAMP signaling pathway' (KEGG:04024) or 'Pathways Regulating Hippo Signaling' (WP:WP4540) (500-1my period). Specific to the most recent period is the term related to the disorder 'Fragile X Syndrome' (WP:WP4549). Across all time blocks we recurrently find GO terms related to development and differentiation (including terms such as 'head development', GO:0060322; 'brain development', GO:0007420; or 'anatomical structure development', GO:0048856) and synapse (e.g. GABAergic/cholinergic/glutamatergic synapses, KEGG:04727, KEGG:04725, GO:0098978; or postsynapse, GO:0098794). Some specific terms for each period are shown in Figure X (see Suppl. Tables X1...Xn for the complete set of GO terms).

We further noticed differences between GO terms across periods when thresholding for a adj p-value < .05. Exclusively in the middle period (300-500k) we find terms related to behavior (startle response, GO:0001964), facial shape (narrow mouth, 'HP:0000160') and hormone system (steroid hormone, GO:0043401, GO:0048545, and GO:0003707; or parathyroid hormone, KEGG:04928). For the 500-1m period, we find cognition (GO:0050890), learning or memory (GO:0007611) or cerebellum (granular layer, HPA:007020_22; also present at adj p value < .01) and spinocerebellar ataxia (KEGG:05017). Only in the most recent period the term 'cerebral cortex: neuropil' appears (HPA:008050_22) (Suppl. Tables X1...Xn).

A venn diagran showing the number of shared categories accross timing windows can be seen [here](https://github.com/AGMAndirko/CLAP/blob/master/plots/GO_terms/GOTerms_Venn_001.pdf) (with a significance threshold of p-val < 0.01)


## Gene expression in GO-enriched genes
We ran the variants associated with GO-enriched genes through ExPecto in order to predict expression levels. A series of statistical tests show that varians coming from GO-enriched genes have significantly differences in their average expression levels in the middle (300-500k) and late (500-800k) periods. The early period (0-300k) didn't show this difference (p = 0.1887).

## Hallmark gene sets
A Hallmark gene set enrichment set showed no significance in any of the curated pathway categories.

# BAZ1B 
## Methods

## Results 

## Stats

Anova tests to understand whether there's significant variation among lists or categories (dir/inv) didn't give a significant p-value (p ~ 0.08). This means these BAZ1B affecting variants don't have significantly different age values compared to other variants within different lists or groups (inv vs dir).

---
**THINGS I STILL HAVEN'T STRUCTURED:**
---



As predicted by Kuhlwilm and Boeckx, the curve of excess follows that of positive selection more closely than length does; introgression deserts from Akey also follows pos selection closely -- these 3 curves are different ways of giving sense to "most distinctive" variants
	+ **AA:** did we roll stats on it at some point? I don't remember doing it, and that's the short of statment that we should be very careful to back strongly


## Statistical results

**Back-to-back plot statistics - random sampling**
Approximative Kruskal-Wallis Test with random sampling (n = 1000)


## BAZ1B
BAZ1B targets: INV vs DIR contrast but mostly for most robust targets -- useful to bring up H. antcessor, but also Gokhman

Domestication vs Globularization timing vindicated; Tom vindicated



## Technical details
- Mention of 4th genome?
- Not sure what to do with chromosome data (ask Martin?)

## Enhancers / promoters 
Not sure what to do with cortical enh/prom changes from Juan's paper, maybe in SI?

## GO Terms - gprofiler2
## Others (not sure where to put this)

A cross-check of the ExPecto/GEVA high frequency data against the [Big40](https://open.win.ox.ac.uk/ukbiobank/big40/) UKBiobank GWAS meta-analysis showed that there are top hits in GWAS related to the following:

| chrom | pos       | rsids      | nearest_genes | tag                                          | Age (GEVA)|
|-------|-----------|------------|---------------|----------------------------------------------|-----------|
| 14    | 59669037  | rs75255901 | DAAM1         | rfMRI connectivity ICA-features 4            | 39543.24  |
| 22    | 27195261  | rs72617274 | CRYBA4        | rfMRI connectivity ICA100 edge 1386          | 445477.7  |
| 1     | 22498451  | rs2807369  | WNT4          | IDP T1 FAST ROIs L cerebellum V              | 50060.96  |
| 2     | 63144695  | rs17432559 | EHBP1         | aseg global volume CC-Posterior              | 52290.48  |
| 12    | 2231744   | rs75557252 | CACNA1C       | rfMRI connectivity ICA100 edge 643           | 93924.62  |
| 10    | 92873811  | rs17105731 | PCGF5         | aparc-DKTatlas rh thickness inferiortemporal | 255792.5  |
| 17    | 59312894  | rs73326893 | BCAS3         | rfMRI connectivity ICA100 edge 53            | 418742.6  |
| 2     | 230367803 | rs56049535 | DNER          | rfMRI connectivity ICA100 edge 966           | 523629.8  |
| 16    | 3687973   | rs78315731 | DNASE1        | aparc-Desikan lh thickness parstriangularis  | 698856.5  |
| 20    | 49070644  | rs75994450 | PTPN1         | IDP dMRI TBSS MO Splenium of corpus callosum | 36735.46  |

You can see the details of the tags [here](https://open.win.ox.ac.uk/ukbiobank/big40/BIG40-IDPs_v2/IDPs.html). 
    + **AA:** Note that these variants don't have a particularly high expression profile in ExPecto predictions, so I think it's a nice snippet of information but I don't know if it should really be reported -- I'm including this here just in case you want to use this information, feel free to discuss whether that should be the case.
