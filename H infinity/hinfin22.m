clc
clear all
nx=4;nu=2;ny=2;
A=[0.9801 0.0003 -0.0980 0.0038; -0.3868 0.9071 0.0471 -0.0008;
     0.1591 -0.0015 0.9691 0.0003; -0.0198 0.0958 0.0021 1];
 B=[-0.0001 0.0058; 0.0296 0.0153; 0.0012 -0.0908; 0.0015 0.0008];
 C=[1 0 0 0;0 0 0 1];D=[0 0; 0 0];
 H=ss(A,B,C,D)
 sigmaplot(H)
 figure
 G=tf(H)
M=1.5; wb=10; A=100; 
s=tf('s');

ws1 = (s/M+wb)/(s+wb*A);
ws2 = (s/M+wb)/(s+wb*A);
Ws=[ws1,  0
    0   ws2];
Wu = eye(2); % Weights.

[A1, B1, C1, D1]=linmod('hinfinity');
P=ss(A1, B1, C1, D1)
[K,CL,GAM] = hinfsyn(P,2,2);
sigmaplot(K)
figure
%P=augw(G,Ws,Wu)
%[K,CL,GAM]=hinfsyn(P);
step(feedback(G*K, eye(2)))