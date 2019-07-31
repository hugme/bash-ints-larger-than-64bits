#!/bin/bash

between() {
 #Set your variables
 L=$1;LL=${#1};LO=0;LZ=0
 H=$2;HL=${#2};HO=0;HZ=0
 C=$3;CL=${#3};CO=0;CZ=0
 # Create offsets if needed
 [[ $LL != $HL && $LL != $CL ]]&&{
  [[ $LL -lt $HL ]] && BIG=$HL || BIG=$LL
  [[ $BIG -lt $CL ]]&& BIG=$CL
  [[ $BIG != $LL ]]&& LO=$(($BIG-$LL))
  [[ $BIG != $HL ]]&& HO=$(($BIG-$HL))
  [[ $BIG != $CL ]]&& CO=$(($BIG-$CL))
 } || BIG=$LL
 SS=18
 ST=$(($BIG/$SS+1))
 SC=0
 while (( $SC < $ST )) ; do
  SB=$(($SC*$SS))
  # set offsets
  LZ=$(($SS-$LO)) ; [[ $LZ -lt 0 ]] && LZ=0 ; LO=$(($LO-($SS-$LZ))) 
  CZ=$(($SS-$CO)) ; [[ $CZ -lt 0 ]] && CZ=0 ; CO=$(($CO-($SS-$CZ))) 
  HZ=$(($SS-$HO)) ; [[ $HZ -lt 0 ]] && HZ=0 ; LO=$(($HO-($SS-$HZ))) 
  # Just in case offset is smaller than the number
  [[ -e ${L:$SB:$LZ} ]] && LT=${L:$SB:$LZ} || LT=0
  [[ -e ${C:$SB:$CZ} ]] && CT=${C:$SB:$CZ} || CT=0
  [[ -e ${H:$SB:$HZ} ]] && HT=${H:$SB:$HZ} || HT=0
  # The work is one line
  (( $CT >= $LT && $CT <= $HT )) || return 1
  SC=$(($SC+1))
 done 
}

