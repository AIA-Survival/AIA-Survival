TARGET=AIA-Survival.pdf
SRC_TEX=$(shell find . -name "*.tex")

all: $(TARGET)

$(TARGET): $(SRC_TEX)
	python3 ./helper.py --autogen autoGen --src src
	latexmk main.tex -outdir=out -interaction=nonstopmode -jobname=AIA-Survival
	cp out/AIA-Survival.pdf ./AIA-Survival.pdf

dry:
	python3 ./helper.py --dry --src src

clean:
	$(RM) -rf autoGen out $(TARGET)

.PHONY:
	dry clean
