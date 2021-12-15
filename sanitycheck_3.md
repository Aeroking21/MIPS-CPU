Generic Notes
=============

Included are the results of running a set of sanity tests on your team's CPU. 

The files included here are:
- cpu/sub : The submission tested
- cpu/test_{bus,harvard}.txt : overall results, in the standard testbench output format
- cpu/test_{bus,harvard}.log : Verbose log for testing the CPU or Harvard version
- cpu/{bus,harvard}/* : directories contain detailed results for each test-bench
    - cpu/{bus,harvard}/TEST/*.s : input assembly used
    - cpu/{bus,harvard}/TEST/*.instr.vh : instructions loaded at the reset vector
    - cpu/{bus,harvard}/TEST/*.data.vh : data loaded at address 32'h00001000
    - cpu/{bus,harvard}/TEST/*.exp.txt : output lines expected in the test log for test-case
- test_mpu_cpu_{bus,harvard}.{stdout,stderr} : The stdout and stderr of running your test-bench on a different CPU.

The submissions were collected around 12:00 on Saturday morning, so updates
after than will not be present here.

Notes on common problems
========================

On looking over the outputs, there are a few common problems to
be aware of.

## Assuming test-bench is being run from the "test" directory.

The spec says that the test will always be invoked as:

    test/test_mips_cpu_bus.sh [path-to-rtl-folder]

So it is always executed from the directory that contains the "rtl" and "test" folders,
and you can use paths relative to that base directory.

Some tests are assuming that it will be executed as:

    ./test_mips_cpu_bus.sh [path-to-rtl-folder]

This then fails if there are any relative paths.

## Assuming the test-bench will always be given the folder "rtl"

Some test-benches assumes that the test-bench will always be
invoked as:

    test/test_mips_cpu_bus.sh rtl

But the folder containing the rtl could be anywhere, and in the
general case is some other folder. For example, here is is
invoked as:

    test/test_mips_cpu_bus.sh ../../cpus/formative1/rtl

as that is where the formative CPU is relative to your test-bench.

## Verilog modules not matching patterns

The only files that will get compiled into your CPU be a test-bench
will be of the form "mips_cpu_*.v" and "mips_cpu/*.v". Anything
else will not be compile in, and results in a missing module.

## Incorrect test-bench output format

A few test-benches are operating correctly, but are printing the
output incorrectly. The output is going to be read by another
program, so it needs to follow the format. Three problems I saw are:

1.  Uses commas instead of white-space to seperate the fields.
2.  Allowing other extraneous information (e.g. messages from sub-scripts
    and test-benches) to get mixed in with the output.
3.  Using ANSI colour codes. These are great for human output, but will
    confuse programs that want to consume the output.

If you want to print extra information that is fine (and often
very useful), but send it to stderr rather than stdout.



Notes on the test files
=======================

(Unchanged since first sanity check)

The vh files are in the format for loading into a 32-bit array 
defined as:

    reg [31:0] memory_instr [0:RAM_LEN_WORDS-1];

using readmemh, so you should interpret:

    @0
    00000825

as
"Starting at address 0, load the 32-bit vector 32'00000825".
Note that endianness doesn't apply here, as we are dealing with
32-bit vectors. So due to the definition of the Avalon bus, which
states the 4 bytes are passed from highest address to lowest address,
we have:
  byte[0]=25
  byte[1]=08
  byte[2]=00
  byte[3]=00

_Then_ if you interpet it as big-endian you will get the
32-bit integer 0x25080000 (addiu t0,t0,0).

Notes on your team's submission (if any)
========================================

(Any notes here were written by a machine)

File extraction
---------------
  User ln220 at time 2021-12-10T22:29:43
    file=submissions/blackboard/Coursework submission_ln220_attempt_2021-12-10-22-29-43_alu.v
  User ln220 at time 2021-12-10T22:29:43
    file=submissions/blackboard/Coursework submission_ln220_attempt_2021-12-10-22-29-43_mips_cpu_harvard.v

There appear to be multiple files in the submission, which is not allowed. There
should be exactly one archive. For final submission this would cause a loss of marks,
as it is out of spec.


Selecting submission file [('submissions/blackboard/Coursework submission_ln220_attempt_2021-12-10-22-29-43_alu.v', 'alu.v'), ('submissions/blackboard/Coursework submission_ln220_attempt_2021-12-10-22-29-43_mips_cpu_harvard.v', 'mips_cpu_harvard.v')]
Multiple files received. Trying to guess what should
be done with them.

One file 'submissions/blackboard/Coursework submission_ln220_attempt_2021-12-10-22-29-43_alu.v' seems to be verilog. Trying to copy everything into
a new directory called 'rtl' and seeing what happens. Who knows...

Guessing that the original name of file submissions/blackboard/Coursework submission_ln220_attempt_2021-12-10-22-29-43_alu.v was alu.v, but who knows...
Guessing that the original name of file submissions/blackboard/Coursework submission_ln220_attempt_2021-12-10-22-29-43_mips_cpu_harvard.v was mips_cpu_harvard.v, but who knows...
