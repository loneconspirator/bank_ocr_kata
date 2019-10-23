# Bank OCR Kata

This is a programming exercise from [here](https://github.com/testdouble/contributing-tests/wiki/Bank-OCR-kata)

## Setup

Clone the repo, and set up your environment

This assumes you are using rbenv for ruby version management

```
git clone git@github.com:loneconspirator/bank_ocr_kata.git
cd bank_ocr_kata
rbenv install $(<.ruby_version)
bundle install
```

## Running
Pipe files into the run script and results will be written to stdout

```
cat test_file.txt | bin/run
```

To run the system as it is before User Story 4, where no attempt to correct the input is made, include `NO_CORRECT` in the environment.

```
cat test_file.txt | NO_CORRECT=1 bin/run
```

## Tests
Tests can be run with `guard`
