close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

%% MESH AND NODE ANALYSIS 
Z = vpa(0.0)
O = vpa(1.0)

R1 = vpa(1021.83054686)
R2 = vpa(2005.19295062)
R3 = vpa(3017.35849578)
R4 = vpa(4151.36004156)
R5 = vpa(3044.17402199)
R6 = vpa(2021.96984898)
R7 = vpa(1007.84334281)
G1 = O/R1
G2 = O/R2
G3 = O/R3
G4 = O/R4
G5 = O/R5
G6 = O/R6
G7 = O/R7
V = vpa(5.11339870586)
I = vpa(0.0010050415923)
Kb = vpa(0.00718106630963)
Kc = vpa(8122.7111635)

%% Matriz-resultado com valores numéricos das correntes nas malhas
A = [Z, Z, Z, O; R1+R3+R4, -R3, -R4, Z; -R4, Z, R6+R7+R4-Kc, Z; -R3*Kb, R3*Kb - O, Z, Z]
B = [I; -V; Z; Z]
A\B

%% Matriz-resultado com valores numéricos da tensão nos nós do circuito (NODE)
C = [G7, Z, Z, Z, Z, Z, G6, Z; O, -O, Z, Z, Z, Z, Z, Z; Z, Z, Z, Z, Z, O, -O, Z; Z, Z, Z, -G2, G1+G2+G3, -G1, Z, -G3; Z, Z, G5, Z, G3, Z, G4+G6, -G3-G4-G5; O, Z, Z, Z, Z, Z, Kc*G6, -O; Z, Z, Z, Z, G1, -G1, -G4-G6, G4; Z, Z, Z, -G2, Kb+G2, Z, Z, -Kb]
D = [Z; Z; V; Z; I; Z; Z; Z]
C\D
