MODULES=camltypes opening test ai attack stages
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES := .ml)
MLIS=$(MODULES :=.mli)
BYTES=$(MODULES:=.byte)
TEST=test.byte 
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

clean:
	ocamlbuild -clean
	rm -rf _coverage 
