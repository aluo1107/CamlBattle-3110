MODULES=camltypes test ai attack stages author state command main
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES := .ml)
MLIS=$(MODULES :=.mli)
BYTES=$(MODULES:=.byte)
TEST=test.byte 
MAIN=main.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind 

FINISHED_TEST=sort_test_finished.byte
PKGS=ounit2

default: build
	OCAMLRUNPARAM=b utop

utop: build
	OCAMLRUNPARAM=b utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST) -runner sequential

play:
	$(OCAMLBUILD) -tag 'debug' $(MAIN) && OCAMLRUNPARAM=b ./$(MAIN)


clean:
	ocamlbuild -clean
	rm -rf _coverage 
