close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

%% MESH AND NODE ANALYSIS
syms R1 
syms R2 
syms R3 
syms R4 
syms R5 
syms R6 
syms R7 
syms G1
syms G2
syms G3
syms G4
syms G5
syms G6
syms G7
syms V 
syms I 
syms Kb 
syms Kc 
Z = vpa(0.0)
O = vpa(1.0)

%% Matriz-resultado com valores simbólicos das correntes nas malhas (MESH)
A = [Z, Z, Z, O; R1+R3+R4, -R3, -R4, Z; -R4, Z, R6+R7+R4-Kc, Z; -R3*Kb, R3*Kb - O, Z, Z]
B = [I; -V; Z; Z]
A\B

%% Matriz-resultado com valores simbólicos da tensão nos nós do circuito (NODE)
E = [G7, Z, Z, Z, Z, Z, G6, Z; O, -O, Z, Z, Z, Z, Z, Z; Z, Z, Z, Z, Z, O, -O, Z; Z, Z, Z, -G2, G1+G2+G3, -G1, Z, -G3; Z, Z, G5, Z, G3, Z, G4+G6, -G3-G4-G5; O, Z, Z, Z, Z, Z, Kc*G6, -O; Z, Z, Z, Z, G1, -G1, -G4-G6, G4; Z, Z, Z, -G2, Kb+G2, Z, Z, -Kb]
F = [Z; Z; V; Z; I; Z; Z; Z]
E\F

R1 = vpa(1021.83054686)
R2 = vpa(2005.19295062)
R3 = vpa(3017.35849578)
R4 = vpa(4151.36004156)
R5 = vpa(3044.17402199)
R6 = vpa(2021.96984898)
R7 = vpa(1007.84334281)
G1 = 1/R1
G2 = 1/R2
G3 = 1/R3
G4 = 1/R4
G5 = 1/R5
G6 = 1/R6
G7 = 1/R7
V = vpa(5.11339870586)
I = vpa(0.0010050415923)
Kb = vpa(7.18106630963)
Kc = vpa(8.1227111635)

%% Matriz-resultado com valores numéricos das correntes nas malhas
C = [Z, Z, Z, O; R1+R3+R4, -R3, -R4, Z; -R4, Z, R6+R7+R4-Kc, Z; -R3*Kb, R3*Kb - O, Z, Z]
D = [I; -V; Z; Z]
C\D

%% Matriz-resultado com valores numéricos da tensão nos nós do circuito (NODE)
G = [G7, Z, Z, Z, Z, Z, G6, Z; O, -O, Z, Z, Z, Z, Z, Z; Z, Z, Z, Z, Z, O, -O, Z; Z, Z, Z, -G2, G1+G2+G3, -G1, Z, -G3; Z, Z, G5, Z, G3, Z, G4+G6, -G3-G4-G5; O, Z, Z, Z, Z, Z, Kc*G6, -O; Z, Z, Z, Z, G1, -G1, -G4-G6, G4; Z, Z, Z, -G2, Kb+G2, Z, Z, -Kb]
H = [Z; Z; V; Z; I; Z; Z; Z]
G\H



