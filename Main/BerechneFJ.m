function [F,J]=BerechneFJ(T,dsoll,Asoll,Jac)
% Diese Funktion berechnet K und b (Folie 29)
% K (=J) und b (=f) [Folie 30]

F=[];
J=[];

% Berechne 1. Zeile von b. 
% d_{1E} steht in der Transformationsmatrix (raumfestes KS -> EE-KS)
% (Translation); dsoll = d_z
F=[F; T(1:3,4,end)-dsoll;];

% Berechne 1. Zeile von K (= translatorischer Anteil von Jocobimatrix)
J=[J; Jac(1:3,:);];
% Berechne A nach Folie 28. Asoll=A_Z. A_{1E} ist rotatorischer Anteil der
% Transformationsmatrix
A=Asoll'*T(1:3,1:3,end);
% Berechne S (schiefsym.Matrix zum Rodriguezvektor) aus A mit Funktion
S=A2S(A);
% Berechne Rodriguezvektor s zur schiefsymmetrischen Matrix und
% Transformation ins raumfeste System
s=Asoll*skew(S);
% Berechne U gemaess Folie 30, weil Linearisierung J ungleich J_1E
U=(eye(3,3)+skew(s))/(1+s'*s);
% K und b zusammensetzen
F=[F; s;];
J=[J; 1/2*inv(U)*Jac(4:6,:);];