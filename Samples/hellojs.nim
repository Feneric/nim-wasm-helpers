proc emscripten_run_script(scriptstr: cstring) {.header: "<emscripten.h>",
importc: "emscripten_run_script".}

emscripten_run_script(
    "document.getElementById('output').value='Hello world from Nim via JavaScript!';"
)

