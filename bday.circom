pragma circom 2.0.0;
include "./circomlib/circuits/sha256/sha256.circom";
template Birthday(){
  component SHA = Sha256(16);
  signal input d[16];
  SHA.in <== d;

  signal output d_out[256];
  d_out <== SHA.out;
}

component main = Birthday();
