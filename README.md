# Prove a SHA256 Hash in Circom
Prove a SHA256 hash computation in circom zk [learn more](https://docs.circom.io/background/background/)
# Prerequisites
1. install [circom](https://docs.circom.io/getting-started/installation/)
2. study the [circom getting started](https://docs.circom.io/getting-started/writing-circuits/)
2. add [circom lib](https://github.com/iden3/circomlib) to the working dir

# Verify the proof
```bash
cd ./ptau
./verify.sh
```
# The circuit
```circom
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
```
# Recompile and reproduce
1. compile:
```
circom bday.circom --r1cs --wasm --sym --c
```
2. compute the witness:
```
cd ./bday_js
node generate_witness.js bday.wasm ../input.json witness.wtns
```
3. Powersoftau
```
cd ./ptau
snarkjs groth16 setup ../bday.r1cs powersOfTau28_hez_final_15.ptau bday_0000.zkey
```
### Contribute to the ceremony
```
snarkjs zkey contribute bday_0000.zkey bday_0001.zkey --name="1st Contributor Name" -v
snarkjs zkey export verificationkey bday_0001.zkey verification_key.json
```
4. Generate a proof
```
snarkjs groth16 prove bday_0001.zkey ../bday_js/witness.wtns proof.json public.json
```
5. Verify the proof
```
snarkjs groth16 verify verification_key.json public.json proof.json
```
