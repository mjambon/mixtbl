.PHONY: default all opt install uninstall reinstall clean
default: all opt
all:
	ocamlc -c -g mixtbl.mli
	ocamlc -c -g mixtbl.ml
opt:
	ocamlopt -c -g mixtbl.mli
	ocamlopt -c -g mixtbl.ml
clean:
	rm -f *~ *.cm[iox] *.o
install:
	ocamlfind install mixtbl META *.mli *.ml *.cm[iox] *.o
uninstall:
	ocamlfind remove mixtbl
reinstall:
	-$(MAKE) uninstall
	$(MAKE) install
