MODULES=camltypes opening test ai attack stages
BYTES=$(MODULES:=.byte)
OCAMLBUILD=ocamlbuild -use-ocamlfind -plugin-tag 'package(bisect_ppx-ocamlbuild)'
TEST=sort_test.byte 
FINISHED_TEST=sort_test_finished.byte
PKGS=ounit2

default: build

utop: build
	OCAMLRUNPARAM=b utop

build:
	$(OCAMLBUILD) $(BYTES)

test:
	BISECT_COVERAGE=YES $(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST) -runner sequential

finished-test:
	BISECT_COVERAGE=YES $(OCAMLBUILD) -tag 'debug' $(FINISHED_TEST) && ./$(FINISHED_TEST) -runner sequential

bisect: clean test
	bisect-ppx-report html

clean:
	ocamlbuild -clean
	rm -rf _coverage bisect*.coverage
