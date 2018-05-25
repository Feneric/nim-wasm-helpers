include Makefile
CURL = curl
SED = sed
RM = rm

template.html:
	$(CURL) -s https://raw.githubusercontent.com/kripken/emscripten/master/src/shell_minimal.html > /tmp/template.html
	$(SED) 's/<script/<script src="https:\/\/ajax.googleapis.com\/ajax\/libs\/dojo\/1.13.0\/dojo\/dojo.js"><\/script>\n    <script/' /tmp/template.html > template.html

hellodojo.html: hellodojo.nim template.html
	$(NIM) c -d:emscripten -l:"--shell-file template.html" -o:$@ $(NIMFLAGS) $<

clean:
	$(RM) template.html hellodojo.js hellodojo.html hellodojo.wasm

