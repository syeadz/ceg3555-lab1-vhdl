#!/bin/bash
file=$1
set -x

file_tb="${file}_tb"  # Use curly braces for variable interpolation

ghdl -a "${file_tb}.vhdl"
ghdl -e "${file_tb}"  # Use curly braces for variable interpolation
ghdl -r "${file_tb}" --vcd="waveforms/waveform_${file}.vcd"  # Use curly braces for variable interpolation
