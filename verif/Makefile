#Makefile

#defaults

SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../src/transform.v $(PWD)/../src/MAC.v

TOPLEVEL = transform

MODULE = testbench

include $(shell cocotb-config --makefile)/Makefile.sim