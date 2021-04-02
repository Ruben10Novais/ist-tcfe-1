close all
clear all

%%EXAMPLE NUMERIC COMPUTATIONS

%% MESH AND NODE ANALYSIS 
R1 = 1.02183054686e3 %% Ohm
R2 = 2.00519295062e3
R3 = 3.01735849578e3
R4 = 4.15136004156e3
R5 = 3.04417402199e3
R6 = 2.02196984898e3
R7 = 1.00784334281e3
V = 5.11339870586 %% V
I = 1.0050415923e-3 %% A
Kb = 7.18106630963e-3 %% S
Kd = 8.1227111635e3 %% Ohm

%% Matriz-resultado com valores numéricos das correntes nas malhas
A = [0,-R5,Kd,R5; R1+R3+R4, -R3, -R4, 0; -R4, 0, R6+R7+R4-Kd, 0; -R3*Kb, R3*Kb - 1, 0, 0]
B = [1; 0; 0; 0]
C = A\B

%% Atribuir às variáveis os seus valores
Ia = C(1,1)
Ib = C(2,1)
Ic = C(3,1)
Id = C(4,1)

