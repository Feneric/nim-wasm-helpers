EMCC = emcc
EMCCFLAGS = -s WASM=1 --emrun -O2
NIM = nim
NIMFLAGS =

%.html: %.c
	$(EMCC) $< $(EMCCFLAGS) -o $@

%: %.nim
	$(NIM) c --out:$@ $(NIMFLAGS) $<

%.bc: %.nim
	$(NIM) c -d:emscripten -o:$@ $(NIMFLAGS) $<

%.html: %.nim
	$(NIM) c -d:emscripten -o:$@ $(NIMFLAGS) $<

