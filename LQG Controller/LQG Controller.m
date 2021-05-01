clc
clear all
nx=4;nu=2;ny=2;
 a=[0.9801  0.0003 -0.0980  0.0038;
   -0.3868  0.9071  0.0471 -0.0008;
    0.1591 -0.0015  0.9691  0.0003;
   -0.0198  0.0958  0.0021  1      ]

b=[-0.0001  0.0058; 0.0296  0.0153; 0.0012 -0.0908; 0.0015  0.0008]

c=[1 0 0 0;0 0 0 1]

d=[0 0; 0 0]

 H=ss(a,b,c,d);
 
 G=tf(H);
p = size(c,1);
[n,m] = size(b);

Q=[100 0 0 0 ; 0 1 0 0 ; 0 0 0 0  ; 0 0 0 10];
R=eye(m);
Kr=lqr(a,b,Q,R);   %LQ regulator design
Bnoise = eye(n);
W = eye(n);
V = 0.01*eye(m);
Estss=ss(a,[b Bnoise],c,[0 0 0 0 0 0 ; 0 0  0 0 0 0]);
[Kess,Ke]=kalman(Estss,W,V);   %kalman filter design
