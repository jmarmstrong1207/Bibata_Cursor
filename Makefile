# Usage:
# make  NAME=CURSOR_NAME     # build cursor
# make link NAME=CURSOR_NAME #for generating cursor X11 and Window both
# make clean  # remove ALL cursors and objects

.DEFAULT_GOAL := requir

.PHONY := requir
requir:
	@echo "installing Requirements..."
	pip3 install -r requirements.txt 
	@echo "installing zip"
	apt-get install zip unzip
	
.PHONY := build
build:	
	@echo "Building $(NAME)..."
	python3 render-cursors.py ./src/$(NAME)/source-cursors.svg -o -a --name $(NAME)
	./tweak.sh $(NAME)		
.PHONY := link
link:
	./x11-make.sh $(NAME)
	cp src/$(NAME)/*.theme $(NAME)/out/X11/$(NAME)
	./w32-make.sh $(NAME)

.PHONY := clean	
clean:
	@echo "Cleaning Up..."
	rm -rf ./Bibata_*

.PHONY := package	
package:
	@echo "Packaging Bibata..."
	zip -r Bibata_build.zip Bibata_*