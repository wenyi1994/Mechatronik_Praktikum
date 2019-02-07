function [Tout]=fKin(DHin)
% Funktion berechnet Transformationsmatrizen der i-Gelenke aus den 
% DH-Parametern
% Aufruf mit vorher aus model_6dof.m gelesener Datenstruktur

DH=DHin.p;

% Anzahl der Gelenke (6) und DH-Parameter (4)
[nq,np]=size(DH);

% Initialisierung der Ausgabematrix (4x4xAnzahl der Gelenke)
Tout=zeros(4,4,nq);
% Transformationsmatrizen von i -> i+1 (i=0:5), T01, T12,..T56
for i=1:nq
	Tij(:,:,i)=DHTrans(DH(i,1),DH(i,2),DH(i,3),DH(i,4));
end

% Multiplikation der Transformationsmatrizen um Transformationsmatrix vom
% raumfesten KS zu den einzelnen Gelenken zu erhalten. Also
% T01 T02 T03...
T=eye(4,4);
% Transformationsmatrizen 0 -> i
for i=1:nq
    T=T*Tij(:,:,i);
    Tout(:,:,i)=T;
end

function out=DHTrans(alpha,a,beta,b)
% Homogene Transformationsmatrix der DH-Parameter (Folie 19)
Rz=[[cos(beta);sin(beta);0;0],[-sin(beta);cos(beta);0;0],[0;0;1;0],[0;0;b;1]];
Rx=[[1;0;0;0],[0;cos(alpha);sin(alpha);0],[0;-sin(alpha);cos(alpha);0],[a;0;0;1]];
out=Rz*Rx;

