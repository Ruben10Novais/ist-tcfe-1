# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all:
	echo 95782 | python t2_datagen.py > data.txt
	sed -i '1,9d;21,23d' data.txt
	cp data.txt ~/ist-tcfe-1/t2/doc
	make -C doc
	cp doc/report.pdf .

clean:
	@rm -f data.txt
	make -C doc clean

.PHONY: all clean


