TEXMK := latexmk
TEXOPTS := -xelatex

SRCS = $(wildcard *.tex)
OUTS = $(SRCS:.tex=.pdf)
DEPS = $(SRCS:.tex=.d)

all: $(OUTS)

%.pdf: %.tex
	TEXINPUTS="./styles:" $(TEXMK) -M -MF $*.d $(TEXOPTS) $<

.PHONY: clean
clean:
	$(TEXMK) --quiet -C
	rm -f $(DEPS)

-include $(DEPS)
