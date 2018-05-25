nim-wasm-helpers
================

*Help quickly set up a VM configured to build WebAssembly code using Nim.*

Intent
------

Here are a few collected aids to generating WebAssembly_ (WASM) from Nim_
using Emscripten_. The `Vagrantfile` can be used with Vagrant_ and
VirtualBox_ to create a virtual machine (VM) that's already equipped
with a properly configured build environment. We won't reproduce all of
the Vagrant documentation here, but in general after installing both
Vagrant_ and VirtualBox_ you should be able to type:

.. code-block:: shell

    git clone https://github.com/Feneric/nim-wasm-helpers.git
    cd nim-wasm-helpers
    vagrant up

and after waiting for awhile for everything to download and configure
you should have your environment to play in. The `vagrant` command
will produce a _lot_ of output in a variety of colors (mostly green
with some gray, white, yellow, and cyan, and maybe two lines of red
related to `dpkg-preconfigure` and building a symlink). This should
work on Linux, macOS, MS-Windows, Solaris, BSD, etc. but has only
been tested extensively on Linux. This build environment makes use
of the "Bodhi Vagrant Box"_ which runs "Bodhi Linux"_.

Samples
-------

There are also a few traditional "hello world" samples included,
and a `Makefile` to make building them via make_ easy. They are
all in the `Samples` folder.

*   `hello.nim` is a one-line "hello world" program. Compiling it
    to WASM can be achieved by typing:

    .. code-block:: shell

        make hello.html

*   `hellojs.nim` outwardly appears to do much the same thing, but
    internally does so via DOM access via JavaScript, providing
    a simple example of how it's done. It can be compiled to WASM
    by typing:

    .. code-block:: shell

        make hellojs.html

*   `hellodojo.nim` again outwardly appears to do much the same
    thing, but complicates the example still further by accessing
    an external CDL to pull in a JavaScript framework, providing
    an example of how to modify the HTML template and make less
    trivial applications. It needs to have a template (here built
    on the fly, but in a real project you'd craft your own) and
    it uses its own special `Makefile` (in order to keep the basic
    sample one more generic) and can be compiled to WASM by typing:

    .. code-block:: shell

        make -f specific.mk hellodojo.html

*   `Makefile` is a generic `Makefile` to provide basic support
    for building both Nim and WASM programs.

*   `specific.mk` is a project-specific `Makefile` built on top
    of the generic one but with extra information for making
    `hellodojo`. Probably for your own project you'd just
    incorporate this extra information into your regular `Makefile`
    so you wouldn't need to use the extra `-f` flag and argument.



.. _Nim: https://nim-lang.org/
.. _WebAssembly: https://webassembly.org/
.. _Emscripten: http://emscripten.org/
.. _Vagrant: https://www.vagrantup.com/
.. _VirtualBox: https://www.virtualbox.org/
.. _"Bodhi Linux": https://www.bodhilinux.com/
.. _"Bodhi Vagrant Box": https://app.vagrantup.com/Feneric/boxes/bodhi
.. _"make": https://www.gnu.org/software/make/manual/html_node/

