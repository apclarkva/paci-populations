## Introduction

The objective of this code is to develop a monolayer of coupled iPSC-derive CM models to simulate the conductance through cardiac tissue. This project is a work-in progress, but the README below explains how to generate a population of models using an LHS method.

### How to access population of models

There are two `.mat` files in the `data/` folder:
- `lhs_parameters_40000.mat` &mdash; has parameter values for 40,000 potential parameter sets. The variable's size is 8 x 40,000.
- `passing_features.mat` &mdash; has a reference to the parameter set, a flag for whether the parameter set passed, and a flag for whether the parameter set passed each feature. The variable's size is 3,204 x 10.

#### lhs_parameters_40000 Explained (See `generate_parameters` directory)

I realize, I should have made the `lhs_parameters_40000.mat` file 40,000 x 8, but don't want to mess with that now. I'll circle back and clean things up later. 

Anyway, the rows of this array contain values for the following parameters:
1. `g_CaL`
2. `g_K1`
3. `g_Kr`
4. `g_Ks`
5. `g_Na`
6. `g_PCa`
7. `g_b_Ca`
8. `g_b_Na`

#### passing_features Explained (See `ap_features` directory)

This contains information about how each parameter set in the 40,000 performed, relative to the Ma features &mdash; I can share that stuff with you when I have more time. If you're up to it, you can poke around in the `ap_features` directory.

Of the 40,000 parameters, only ~3,204 resulted in spontaneous, and AP-like waveforms. The columns of this variable are:
1. parameter index &mdash; integer
2. passing AP or not &mdash; `1` or `0` (I can't remember if I set the threshold to passing all 7 of the following features, or just 6 &mdash; it doesn't matter, because I used column ten to filter for APs that passed 7 vs 6 vs 5...)
3. cycle_length &mdash; `1` or `0`
4. spontaneous_heart_rate &mdash; `1` or `0`
5. maximum_diastolic_potential &mdash; `1` or `0`
6. peak_voltage &mdash; `1` or `0`
7. action_potential_amplitude &mdash; `1` or `0`
8. maximum_upstroke_velocity &mdash; `1` or `0`
9. apd90 &mdash; `1` or `0`
10. Sum of columns 3 through 9. A passing AP has a value equal to 7.







