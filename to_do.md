# Tasks to do
- [ ] Get all the plots into github 
	**AA:** Missing files for reproducibility (if we want to host them here, discussion is open - so far the Martin files, for example, are hosted in google drive and incorporated into the scripts with a custom command):

			- [ ] Enhancers
			- [ ] New/old BAZ1B lists
			- [ ] GTEx files
	
- [X] Plot both introgression files (Vernot vs Sankararaman)
	+ **AA:** If you have any other suggestions re that let me know
	+ [X] check introgression captions for errors
	+ [ ] Add Sankararaman as well
	+ [X] Reduced window for the 2 introgression files plot
- [X] Divide between Denisovan and Neanderthals in the Martin files (and plot)
	+ **AA:** Done using NNall and columns 7, 10 and 13 for the filter specifically. Looks like it should. I'd say stats should be robust on the earlier peak with Neanderthals vs Denisovan.
	- [X] KS tests for Denisovan, if we want to mention this
- [X] Martin filter plots
	+ [X] **CB** perhaps here too differences within archaics may matter?
	+ [X] **A** They don't really, as shown by the archaic_and_populations plot. The curves are very similar (almost identical, differences in some hundred of variants overall) between archaics, despite filters. It's true this is done through HF right now, so of course a lot of variants are shared. There is a difference re Denisova in the second plot from Naall though 
- [X] Run Phewas through the variants with highest expression values to get list of GWAS top hits 
- [ ] GO gene categories
	- [X] Select GO categories of interest
	- [~] Run them through Expecto
		- **AA:** (with caveat)
		- [X] Plots
		- [X] QQ plot - regular ExPecto
	- [ ] Run stats test GO EXP (vs normal as well)
	- [ ] Exclusive GO terms code
	- [ ] Venn diagram
- [X] Reorganize BAZ1B 
	- [X] create "BAZ1B_0", 
	- [X] *bona fide* lists & plots
	- [ ] Statistics for BAZ1B_1
- [X] Statistics for:
	- [X] Deserts of introgression, Akey and Peyregné 
		+ **AA:** all <0.01 except hf vs deserts, which gives a p-value of ~ 0.011
	- [ ] also for length/excess
	- [ ] Also, add lenght/excess to 5 (7?) files plot
- [ ] Reproduce "<" ExPecto plots
	- [ ] Use the same kind of plot for GO genes
- [ ] Check out Hallmark GProfiler2 genes
- [ ] Come up with a way to redo graphs a la Reich
- [ ] Add all the current observations 

Note: when a task is complete just add an upper-case X to the box, like this:

```md
- [X] Completed task 
+ **AA:** Here's an example comment on this task 
```

This looks like this:
- [X] Completed task 
+ **AA:** Here's an example comment on this task 
