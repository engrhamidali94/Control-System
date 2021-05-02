s=tf('s');
Gm=tf(1.246, [1 0.9215 4.77 3.92]);
G11=Gm;
G12=0;
G21=tf([1.482 0.4234], [1 6.33 7.07 2.08 0]);
numG21=[1.482 0.4234];
denG21=[1 6.33 7.07 2.08 0];
G22=tf(3.6,[1 6 5 0]);
numGm=1.246;
denGm=[1 0.9215 4.77 3.92];
Gt=tf(3.6,[1 6 5 0]);
denGt=[1 6 5 0];
numGt=3.6;
[a,b,c,d]=tf2ss(numGt, denGt);
D11=1;
D12=0;
D21=((-0.4492*s^6-3.143*s^5-7.083*s^4-17.06*s^3-22.28*s^2-9.60*s+5.51*10^(-14))/(s^6+6.906*s^5+15.22*s^4+37.09*s^3+47.03*s^2+19.44*s+4.749*10^(-14)));
numG1=numGm;
denG1=denGm;
numG2=numGm;
denG2=[ denGm];
G2=tf(numG2, denG2);
%% Weights Selection

numWd=[0.20];
denWd=[1 0.20]
Wd=tf(numWd,denWd);
Wn=1/(s+62.83);
numWn=[1 0];
denWn=[1 800.8];
Wn=tf(numWn,denWn);
W3=5*((s+6283)/(s+31420));
numW3=5*[1];
denW3=[1 300];
nump21=[-109.2 327.7];
denp21=[1 6.504 42.27 0.1593];
nump23=[-144.9 434.6];
denp23=[1 69.33 450.6 2655]
%% H infinity controller 
[A1, B1, C1, D1]=linmod('OBserver_WithLQG_Control_Yaw');
P=ss(A1, B1, C1, D1)
[Ktail, CL, GAM] = hinfsyn(P, 2, 1);

[Aktail, Bktail, Cktail, Dktail]=ssdata(Ktail);
    GAM
    D=tf(Ktail);
sim('Nonlinear_with_DOB');
%  hold on
 plot( t5, P2, t5, Y1)
 legend('yaw angle', 'Pitch angle');
bodemag(D(1,1), D(1,2)/D(1,1), D(1,2), 1/Gt )
legend('-D_1_1','-D_1_1^-^1D_1_2','D_1_2', 'G_t^-^1')