function R=Kardanwinkel(kw)
% Transformationsmatrix R fuer eine allgemeine Drehung beschrieben durch drei
% Kardanwinkel kw(1:3)
R1=[1,0,0; 0,cos(kw(1)), -sin(kw(1)); 0,sin(kw(1)), cos(kw(1))];
R2=[cos(kw(2)), 0, sin(kw(2)); 0,1,0; -sin(kw(2)), 0, cos(kw(2))];
R3=[cos(kw(3)),-sin(kw(3)), 0; sin(kw(3)), cos(kw(3)),0;0,0,1];
R=R1*R2*R3;