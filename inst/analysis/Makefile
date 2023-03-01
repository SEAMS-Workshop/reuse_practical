
# collaborators can use a `local.mk` file to override default variables
-include local.mk

# you can set variables for paths, etc
DATADIR ?= ./data
FIGDIR ?= ./fig
RAWDIR := $(DATADIR)/raw
PROCDIR := $(DATADIR)/processed
SRCURL := https://covid.ourworldindata.org/data/owid-covid-data.csv
TARISO ?= ZAF

# the first target in a makefile is the default target, so it good practice to highlight
# skip this for now and come back to it after reading the rest of the file
# this is also a pattern based target, but uses the patsubst function to generate the list of targets
# this target doesn't have any rules, so it just triggers making its dependencies
default: $(patsubst %,$(FIGDIR)/owid-epi-%.png,$(TARISO)) $(patsubst %,$(FIGDIR)/owid-cfr-%.png,$(TARISO))

# this is a target - targets start with what will be made, followed by a colon, then what it depends on (nothing in this case)
# then the steps to make the target
$(DATADIR):
	mkdir -p $@

# you can also specify multiple targets that are made in the same way. The $@ variable is the actual target being requested
$(RAWDIR) $(PROCDIR) $(FIGDIR):
	mkdir -p $@

# make has functions (in this case, `notdir`, which will pickout the filename from a path or url)
$(RAWDIR)/$(notdir $(SRCURL)): | $(RAWDIR)
	@echo 'Fetching data from Our World in Data ...' # @ suppresses echoing the command
	wget --no-clobber $(SRCURL) -O $@

# make also supports pattern matching. by making this a pattern match, we actually setup a rule for every country (code) in the data
# the % is a wildcard that will match any string. the $* is the string that matched the wildcard
$(PROCDIR)/owid-%_all.csv: $(RAWDIR)/$(notdir $(SRCURL)) | $(PROCDIR)
	@echo 'Extracting data for $* ...'
	head -1 $< > $@
	awk -F, '$$1=="$*" { print $$0 }' $< >> $@ # note: have to escape the $$ to get make to pass it through

$(PROCDIR)/owid-%.csv: $(PROCDIR)/owid-%_all.csv
	@echo -n 'Extracting date, case, and death data ...'
	cut -d',' -f1,4,12,13,15,16 $< > $@ # grab columns with date, smoothed cases per million, smoothed deaths per million

# you can write your own function definitions ...
R = $(strip Rscript $^ $(1) $@)

# which then make for concise rules - this invokes Rscript epicurve.R $(PROCDIR)/owid-%.csv $(FIGDIR)/owid-%.png
# if you write your targets as "output: script input1 input 2 ...,"
# then $(call R) will run Rscript on the inputs (the first of which is the script itself) and the output
# this is very convenient if you have a lot of targets. you can use a similar pattern for python, julia, etc - even bash utilities
$(PROCDIR)/owid-%.rds: clean.R $(PROCDIR)/owid-%.csv
	$(call R)

$(FIGDIR)/owid-epi-%.png: epicurve.R $(PROCDIR)/owid-%.rds | $(FIGDIR)
	$(call R)

$(FIGDIR)/owid-cfr-%.png: cfrcurve.R $(PROCDIR)/owid-%.rds | $(FIGDIR)
	$(call R)
