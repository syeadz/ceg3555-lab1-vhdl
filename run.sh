#!/bin/bash
file=$1

mkdir -p ./waveforms
sh ./build.sh mux2to1 && sh ./test.sh mux2to1
sh ./build.sh mux4to1 && sh ./test.sh mux4to1
sh ./build.sh mux16to8
sh ./build.sh mux32to8
sh ./build.sh enardFF_2
sh ./build.sh register8bit && sh ./test.sh register8bit
sh ./build.sh shftleftreg8bit && sh ./test.sh shftleftreg8bit
sh ./build.sh shftrightreg8bit && sh ./test.sh shftrightreg8bit
sh ./build.sh datapath && sh ./test.sh datapath
sh ./build.sh controlpath && sh ./test.sh controlpath
sh ./build.sh lab1 && sh ./test.sh lab1
