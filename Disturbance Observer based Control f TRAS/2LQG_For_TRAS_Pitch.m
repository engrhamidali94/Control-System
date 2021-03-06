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
D11=1;
D12=0;
D21=((-0.4492*s^6-3.143*s^5-7.083*s^4-17.06*s^3-22.28*s^2-9.60*s+5.51*10^(-14))/(s^6+6.906*s^5+15.22*s^4+37.09*s^3+47.03*s^2+19.44*s+4.749*10^(-14)));
numG1=numGm;
denG1=denGm;
numG2=numGm;
denG2=[ denGm];
G2=tf(numG2, denG2);
%%
[am, bm, cm, dm ]=tf2ss(numGm, denGm)
p = size(cm,1);
n=3; m=1
Onm=zeros(n,m); 
Omm=zeros(m,m);
Onn=zeros(n,n); 
Omn=zeros(m,n);
A = [am [0 ;  0;  0 ]; -cm 0 ]; 
B = [bm; 0  ];
Q=[0.1 0 0 0 ; 0 20 0  0 ; 0 0 040 0 ; 0 0 0 0.8];
R=eye(m)
Krm=lqr(A,B,Q,R)
Krp=Krm(1:m,1:n);
Kri=Krm(1:m,n+1:n+m)
Bnoise = eye(n);
W = 0.1*eye(n);
V = eye(m);
Estss=ss(am,[bm Bnoise],cm,[0 0 0 0  ]);
[Kess,Kem]=kalman(Estss,W,V);
%%Ke = lqe(a,Bnoise,c,W,V);
Acm=[Omm Omn;-bm*Kri am-bm*Krp-Kem*cm];
Bcr=[eye(m);Onm]; 
Bcym=[-eye(m);Kem];
%%Bc = [eye(m) -eye(m);Onm +Ke];
Ccm = [-Kri -Krp];
Dcr=[Omm];
Dcym=Omm;
%%Dc = [Omm Omm];
%Klqg2=ss(Ac,[Bcr Bcy],Cc,[Dcr Dcy]); %final 2-dof controller
Klqgm=ss(Acm,-Bcym,Ccm,-Dcym);  %feedback part of controller
%%Klqg = ss(Ac,Bc,Cc,Dc)
%sys1 = feedback(G*Klqg,1)
%step(sys1,50)
%sys=feedback(G*Klqg2,1,2,1,+
sys1 = feedback(Gm*Klqgm,1)
step(sys1,50)
%sys=feedback(Gm*Klqg,1,2,1,+1)
% sys2=sys1*[1;0]%hold
% step(sys2,50)