# RobustGaSP-in-Matlab

 This package is a RobustGaSP Package available in MATLAB. The R version of the RobustGaSP Package is available at CRAN: https://cran.r-project.org/web/packages/RobustGaSP/index.html

Description:

This package is mainly for emulating computationally expensive computer model/simulators with scalar or vector output in MATLAB. It implements the robust Gaussian stochastic process and parallel partial Gaussian stochastic process. It allows for robust parameter estimation and prediction using Gaussian stochastic process emulator. It also implements the parallel partial Gaussian stochastic process emulator for computer model with massive outputs See the reference: Mengyang Gu and Jim Berger, 2016, Annals of Applied Statistics; Mengyang Gu, Xiaojing Wang and Jim Berger, 2018, Annals of Statistics; Mengyang Gu, 2019, Bayesian Analysis.

References:                                                
    1. M. Gu. and J.O. Berger (2016). Parallel partial Gaussian process emulation for computer models with massive output. Annals of Applied Statistics, 10(3), 1317-1347.                             
    2. M. Gu, X. Wang and J.O. Berger (2018), Robust Gaussian stochastic process emulation, Annals of Statistics, 46(6A), 3038-3066.                                              
    3. M. Gu (2019), Jointly robust prior for Gaussian stochastic process in emulation, calibration and variable selection, 14(3), Bayesian Analysis.                                        

Installation:

To use this package, first please download RobustGaSP_Matlab.zip. The examples.m contains some examples. You need to compile the C++ files by compile_cpp() in MATLAB and you only need to do it once. To do so, change the directory to the folder of "RobustGaSP_Matlab' and run the following lines: 

addpath('functions');                             
compile_cpp();

For mac user, you may not need to compile the package. You need a C++ builder to compile. For windows users, you may need visual studio. For Linux users, you may have a build-in C++ builder. For mac users, you may need Xcode. 

You also need the optimization toolbox in MATLAB to use this package. 


Updates:

v0.5.2 (current version)

Two main functions are ppgasp() and prediction_predict_ppgasp(). Use help ppgasp() and help prediction_predict_ppgasp() to see how to use these functions. 
