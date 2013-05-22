.PHONY: default all opt install uninstall reinstall clean test
default: all opt
all:
	ocamlc -c -g mixtbl.mli
	ocamlc -c -g mixtbl.ml
opt:
	ocamlopt -c -g mixtbl.mli
	ocamlopt -c -g mixtbl.ml
test: all
	ocamlfind ocamlc -I src -I $$( ocamlfind query oUnit) \
		unix.cma oUnit.cma mixtbl.cmo tests.ml -o tests
clean:
	rm -f *~ *.cm[iox] *.o tests
install:
	ocamlfind install mixtbl META *.mli *.ml *.cm[iox] *.o
uninstall:
	ocamlfind remove mixtbl
reinstall:
	-$(MAKE) uninstall
	$(MAKE) install
