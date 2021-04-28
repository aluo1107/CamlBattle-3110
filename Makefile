MODULES=camltypes test ai attack author main_func state command main sprite draw actors

OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES := .ml)
MLIS=$(MODULES :=.mli)
BYTES=$(MODULES:=.byte)
TEST=test.byte 
MAIN=main.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind 

FINISHED_TEST=sort_test_finished.byte
PKGS=ounit2, js_of_ocaml, js_of_ocaml-ppx

default: build
	OCAMLRUNPARAM=b utop

utop: build
	OCAMLRUNPARAM=b utop

build:
	$(OCAMLBUILD) $(OBJECTS)
play: 
	$(OCAMLBUILD) -tag 'debug' $(MAIN) && OCAMLRUNPARAM=B ./$(MAIN)
test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST) -runner sequential

zip:
	zip camlbattle.zip *.ml* *.mli* * _tags .merlin .ocamlformat .ocamlinit Makefile install.md*

clean:
	ocamlbuild -clean
	rm -rf _coverage 
