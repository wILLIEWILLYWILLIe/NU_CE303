#!/bin/bash
xrun -64bit -gui -access +r \
    -xmelab_args "-warnmax 0 -delay_mode zero -maxdelays" \
    ./Synthesis/alu_conv_syn.v \
    alu_conv_test.v \
    /vol/ece303/genus_tutorial/NangateOpenCellLibrary.v