.PHONY: paper clean wordcount sim figures validation

PAPER = main

paper: $(PAPER).pdf

$(PAPER).pdf: $(PAPER).tex sections/*.tex refs.bib
	pdflatex $(PAPER).tex
	bibtex $(PAPER)
	pdflatex $(PAPER).tex
	pdflatex $(PAPER).tex

sim: results.rds

results.rds: scripts/sim.R scripts/run.R
	Rscript scripts/run.R

figures: figures/glass_ceiling.pdf figures/informative_coding.pdf

figures/glass_ceiling.pdf figures/informative_coding.pdf: scripts/figures.R results.rds
	Rscript scripts/figures.R

validation: results.rds figures

clean:
	rm -f $(PAPER).aux $(PAPER).bbl $(PAPER).blg $(PAPER).log \
	      $(PAPER).out $(PAPER).pdf $(PAPER).fdb_latexmk \
	      $(PAPER).fls $(PAPER).synctex.gz $(PAPER).toc \
	      sections/*.aux

wordcount:
	@texcount -inc -sum -1 $(PAPER).tex 2>/dev/null || \
	  echo "(install texcount for word count)"

oracle_check: results_oracle_check.rds

results_oracle_check.rds: scripts/oracle_check.R scripts/sim.R
	Rscript scripts/oracle_check.R

table4a: results_table4a_deployable.rds

results_table4a_deployable.rds: scripts/regen_table4a.R scripts/sim.R
	Rscript scripts/table4a.R
