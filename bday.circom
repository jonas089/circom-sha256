pragma circom 2.0.0;
include "./circomlib/circuits/sha256/sha256.circom";
template Birthday(){
  component SHA = Sha256(6);
  signal input date[6];
  SHA.in <== date;

  signal output date_out[256];
  date_out <== SHA.out;
}

component main = Birthday();
