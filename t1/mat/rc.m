close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

%% MESH ANALYSIS
R1 = vpa(1021.83054686)
R2 = vpa(2005.19295062)
R3 = vpa(3017.35849578)
R4 = vpa(4151.36004156)
R5 = vpa(3044.17402199)
R6 = vpa(2021.96984898)
R7 = vpa(1007.84334281)
V = vpa(5.11339870586)
I = vpa(0.0010050415923)
Kb = vpa(7.18106630963)
Kc = vpa(8.1227111635)
Z = vpa(0.0)
O = vpa(1.0)

A = [Z, Z, Z, O; R1+R3+R4, -R3, -R4, Z; -R4, Z, R6+R7+R4-Kc, Z; -R3*Kb, R3*Kb - O, Z, Z]
B = [I; -V; Z; Z]
A\B
