
                            Free Pascal Compiler

                               Version 2.6.4

****************************************************************************
* Introduction
****************************************************************************

Please also read the platform specific README file, if it exists.


This package contains an advanced freeware 32-bit/64-bit pascal compiler for
several platforms. The language and the runtime library are almost
compatible with Turbo Pascal 7.0 and recent Delphi releases. There is also
partial support for the Macintosh pascal dialect.

News and changes related to this release are described in whatsnew.txt.

Free Pascal 2.6.4 is currently available for the following platforms:
- Linux-i386
- Linux-x86_64 (amd64)
- Linux-powerpc
- Linux-sparc
- Linux-arm
- Win32-i386 (Win95/98/Me/XP/2000/2003/Vista and WinNT)
- Win64-x86_64 (XP/Vista/2003)
- Wince-arm (cross compiled from win32-i386)
- FreeBSD-i386
- FreeBSD-x86_64
- Mac OS X/Darwin for PowerPC
- Mac OS X/Darwin for Intel (i386)
- OS/2-i386 (OS/2 Warp v3.0, 4.0, WarpServer for e-Business and eComStation)
- GO32v2-i386

There are other platforms (like other BSD variants) which are more or less
working, but there is currently no maintainer for them and thus we cannot
provide adequate support. If you want to change this and create and
maintain versions for other platforms and targets, feel free to contact us,
e-mail addresses are listed below.


****************************************************************************
* Features
****************************************************************************

- high speed compiler
- fully 32 or 64-bit code
  - 32 bit compiler can be on x86_64 Linux distributions to compile 32 bit
    applications
- language features:
  - almost fully compatible with Borland Pascal and Borland Delphi
  - ansi strings
  - wide strings
  - exception support
  - RTTI support
  - procedure overloading
  - generics (experimental)
  - operator overloading
  - COM, CORBA and raw interfaces support
  - dynamic array support
  - variant support
  - inlining
- code optimizer:
  - peephole optimizer (80x86 only)
  - jump optimizer
  - loading of variables into registers
  - assembler level dataflow analyzer (80x86 only)
  - stack frame eliminations
  - sophisticated register allocator
- integrated BASM (built-in assembler) parser
  - supports ATT syntax used by GNU C
  - supports Intel syntax used by Turbo Pascal (80x86-only)
- can compile code into assembler source code for these assemblers:
  - GNU Assembler (GAS)
  - Netwide assembler (Nasm)
  - Microsoft Assembler/Turbo Assembler (Masm/Tasm)
  - Watcom assembler (wasm)
- internal assembler for ultra fast object file generation
- can call external C code
  - h2pas utility to convert .h files to Pascal units
- smartlinking (not yet supported under Mac OS X)
- support for the GNU debugger
- integrated development environment (disabled by default on Mac OS X)
  - powerful user friendly Wordstar compatible multi file editor
  - context sensitive help supports help files in HTML, Windows HLP and
    Borland TPH format.
  - debugger on most platforms
- can create binaries running natively under both DOS and OS/2 (EMX version)
- no need for Linux distribution specific binaries, programs you write run
  on all distributions
- high quality documentation


****************************************************************************
* Minimum requirements
****************************************************************************

i386, x86_64, PowerPC or Sparc processor
Win32:
 - Win95/98/Me/2000/2003/XP/Vista or WinNT
 - 16 MB RAM
OS/2:
 - OS/2 Warp v3.0 with one of late fixpaks - FP 35 should be fine,
   OS/2 Warp v4.0 with FP 5 and above, WSeB, MCP or any eComStation version
   (OS/2 2.0/2.1 currently not supported, not even for compiled programs)
Linux:
 - system running a 2.4.x kernel
FreeBSD:
- There are separate releases for FreeBSD 7.x system or 8.x system. The code
    works on 6.x too. Older versions might need specific adaptations.
Mac OS X:
 - Mac OS X 10.2 and higher
Mac OS (classic)
 - Mac OS 9.2 has been tested, should probably also work from 7.5.3 and up.


****************************************************************************
* Quick start - Win32
****************************************************************************

Download the distribution package (fpc-2.6.2.i386-win32.exe) and run it
- it is a self-extracting installer, so just follow the instructions
to install it. Don't forget to set the PATH environment variable if you
install FPC under Win95/98/ME (the installer should do it automatically
under WinNT/2k/XP).

To test the compiler, change to the demo\texts directory of the FPC tree
and type
        fpc hello
        hello


****************************************************************************
* Quick start - DOS
****************************************************************************

Download distribution archive (dos262.zip for GO32v2) and unzip it into
a temporary directory.

Start the install program INSTALL.EXE and follow the instructions.

Don't forget to set PATH as mentioned by the install program. If running
under plain DOS, this can be done by opening file named AUTOEXEC.BAT located
in the root directory of your boot drive (usually C:\) with a plain text
editor (like EDIT.COM), extending the line starting with "set PATH=" (case
insensitive) with path to newly installed binaries (installation root as
selected in the installation program appended with "\BIN\GO32v2") and save
it.

To test the compiler, change to the demo\texts directory of the FPC tree
and type
        fpc hello
        hello


****************************************************************************
* Quick start - OS/2 / eComStation
****************************************************************************

Download distribution archive (os2262.zip for OS/2 or eComStation) and unzip
it into a temporary directory.

Start the install program INSTALL.EXE and follow the instructions.

Don't forget to set PATH and LIBPATH as mentioned by the install program.
This can be done by opening file named CONFIG.SYS located in the root
directory of your boot drive (e.g. C:\) with a plain text editor (e.g.
E.EXE), extending the lines starting with "set PATH=" and "LIBPATH=" (both
are case insensitive) with path to newly installed binaries (installation
root as selected in the installation program appended with "\BIN\OS2" for
PATH and "\DLL" for LIBPATH) and save it again as a plain text file.
Note that changes to LIBPATH require restart of your machine in order to come
into effect.

To test the compiler, change to the demo\texts directory of the FPC tree
and type
        fpc hello
        hello


****************************************************************************
* Quick start - Linux/FreeBSD
****************************************************************************

Download fpc-2.6.2.<cpu>-<os>.tar and untar into a temporary directory.

Start the install script with ./install.sh and follow the instructions.

To test the compiler, change to the demo/texts directory of the FPC tree
and type
        fpc hello
        hello


****************************************************************************
* Quick start - Mac OS X/Darwin
****************************************************************************

There are two methods to install Free Pascal for Mac OS X.

1) Download and install the Mac OS X package (fpc-2.6.2.powerpc-macosx.dmg)

This gives you the Free Pascal Compiler and the Xcode integration kit.

2) Install fpc using fink

This gives you the Free Pascal Compiler, including all libraries, packages
and units from its sources, including Free Vision and the IDE, which partly
works using X11 xterm.


With method 1 follow the instructions to install the XCode integration kit
at:

http://www.freepascal.org/xcode.html

Method 2 is mainly meant for using the compiler through the command
line. Fink takes care of setting the PATH variable. You can (under
Mac OS X 10.2.x or earlier you actually have to) also use the command line
with Free Pascal installed using method 1. The main point is to change your
PATH as described below:

The compiler is called "fpc" and will be installed in /usr/local/bin. This
directory may not be in your PATH yet (if you type "fpc" in a Terminal
window and you get something like "fpc: command not found", then it isn't).
If the installation directory is not yet in your PATH, you will have to add
it. To get an idea, how to do this, follow the instructions at:

"http://fink.sourceforge.net/doc/users-guide/install.php#setup"

to determine which file you have to edit, but instead of adding the line
suggested there, add the following at the end:

- if your shell is the Bourne shell (bash):

 	export PATH=/usr/local/bin:$PATH

When using Terminal.app add this to ".bash_profile",
when using the X11 xterm add this to ".bashrc".
If these files do not exist yet in your home directory, you have to create
them, for example with nano (or any other text editor):

	nano .bash_profile

- if your shell is the C Shell (csh or tcsh):

	setenv PATH /usr/local/bin:${PATH}

Next, close the Terminal window and open a new one. Now, the PATH should
be set correctly. After installing the package, you can write your
source code in your favorite editor (including Project Builder and XCode).
To compile something, go to the directory containing your source files in
Terminal and type:

        fpc name_of_your_source_file

The compiler only accepts one file name as argument, but will automatically
search for and compile any units used by the specified source file. Run
"fpc" without any arguments to get an overview of the possible command line
options.


****************************************************************************
* Documentation
****************************************************************************

The documentation is available as HTML pages, PDF, PS, and text although the
recommended format is pdf. These are all available on
ftp://ftp.freepascal.org/fpc/dist/docs-2.6.0

NB that there is at present no FPC specific documentation for the platform
specific API (like Win32 system functions, etc.). There is a note in the ftp
/doc explaining where MS help file documenting Win32 API can be obtained,
other platforms (especially Unix-based ones) often come with this
documentation included in system installation.


****************************************************************************
* Suggestions, Help, Bug reporting, snapshots,  ...
****************************************************************************

Suggestions, Help ...
---------------------
e-mail: fpc-devel@lists.freepascal.org (bugs, developer related questions)
e-mail: fpc-pascal@lists.freepascal.org (general pascal related questions)

Both these adresses are for mailing lists. If you're not subscribed,
be sure to mention this fact when sending questions to these lists,
so that people sending answers know about it and send you a copy.
Information about available lists and subscription can be found
on http://lists.freepascal.org/mailman/listinfo

Web forum: http://community.freepascal.org:10000 (all questions)

WWW: http://www.freepascal.org
FTP: ftp://ftp.freepascal.org/fpc
(several mirrors exist, see website for links)

Additional information about mailing lists, news, future plans etc.
can be found on the web site.

SNAPSHOTS & SOURCES
-------------------
One of the features of FPC is the snapshots. These are made daily or weekly
from the developers' latest versions of the source. Snapshots are available
for GO32v2, Win32, OS/2 and Linux versions. The latest snapshots are in:
ftp://ftp.freepascal.org/fpc/snapshot/ in appropriately named .zip/tar
files.

You will also normally find in the snapshot archive file a readme, with
a note about the latest included changes. It is quite common, though it
doesn't always happen, that when a bug is reported it is fixed and a fixed
version can be obtained the NEXT day in the appropriate snapshot.... yes
really!

Also on the ftp site you'll find a /dist directory, with the latest
distributed releases, a /docs directory, and a /source directory, in
which every night at about 0100 GMT the latest source generated by the
developers during the day & evening before is exported from SVN
into ZIP file fpc.zip.


Making your own snapshots
-------------------------
By downloading the /source files (makefiles are included) it is possible to
make your own version of the fpc compiler/rtl and to modify it. You are of
course free to do this so as long as you observe the licence conditions. In
order to make the compiler/rtl & IDE in a resonable time (eg <30 minutes)
you'll need at least 32 MB of physical memory (64 MB is better), at least
a 200 MHz processor and at least 100 MB of free disk space. You'll also
need some knowledge of makefiles & programming... it is not difficult but
it isn't easy either!

REPORTING BUGS
----------------
If you find a bug in the released version, you may want to try a snapshot
(see SNAPSHOTS above) to see if it has been fixed before reporting it to
the fpc-devel mailing list.

If you find a fault or 'feature' in a release, please report it either
using the bug reporting interface available on our WWW pages (see above),
or to the fpc-devel mailing list. PLEASE INCLUDE ALSO A COMPILABLE CODE
FRAGMENT which can be used to reproduce the problem (or a link to larger
archive if it cannot reproduced with small example), and state the version
eg Win32, GO32v2, and the date of the compiler etc on which you noticed the
problem & any other useful info so the developers can reproduce the
problem, otherwise they may not be willing/able to fix it.


****************************************************************************
* License
****************************************************************************

The compiler and most utilities and executables distributed in this package
fall under the GPL, for more information read the file COPYING.v2.

Some specific utilities and programs come under the license described in
COPYING.v3, COPYING.DJ, COPYING.EMX, COPYING.RSX and licensez.ip.

Some of the licenses of the third party tools require to make the source
available. If you cannot find the sources or information where to find
them for a certain tool under such a license included into the FPC
distribution, please contact us through the contact details given
at http://www.freepascal.org/moreinfo.var and we will provide you
the sources or information where to find them.

The documentation, unless otherwise noted, is distributed as free
text, and is distributed under the GNU Library General Public
License as found in file COPYING.

The runtime library, package libraries, free component library, and
other libraries which are used to create executables by the compiler
come under a modified GNU Library General Public license. Additional
information about the library license is found in COPYING.FPC.

License conditions for DPMI provider for GO32v2 version (CWSDPMI.EXE)
can be found in cwsdpmi.txt, sources and/or binary updates may be
downloaded from http://clio.rice.edu/cwsdpmi/.

The DOS version (go32v2) contains some binaries of DJGPP. You can obtain
the full DJGPP package at: http://www.delorie.com/djgpp/

NOTE: OS/2 version of the installer uses the library UNZIP32.DLL from
      Info-ZIP. Info-ZIP's software (Zip, UnZip and related utilities)
      is free and can be obtained as source code or executables from
      Internet/WWW sites, including http://www.info-zip.org.
