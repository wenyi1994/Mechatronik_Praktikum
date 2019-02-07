function out=JacobiMat_2(T, mu)
% T=4x4xn 3D-Matrix aus den Transformtionsmatrizen T12 T13 T14... 
% die mit fkin.m berechnet wurden.
% mu= Information, ob Schub oder Drehgelenk. Hinterlegt in model_6dof.m 
%
% Anzahl der Gelenke. Ist gleich der Anzahl von Spalten der 3. Dimension
% der uebergebenen 4x4xn Matrix mit den Transformtionsmatrizen T12 T13 T14...

[np, np, nq]=size(T);

u1=[0;0;1];
r11=[0;0;0];

c(:,1)=mu(1)* cross(u1,(T(1:3,4,end)-r11))+(1-mu(1))*u1;
omega(:,1)=mu(1)*u1;


for i=2:nq
    c(:,i)=mu(i)* cross(T(1:3,3,i-1),(T(1:3,4,end)-T(1:3,4,i-1)))+(1-mu(i))*T(1:3,3,i-1);
    omega(:,i)=mu(i)*T(1:3,3,i-1);
end

J1E=[c;omega];
out=J1E;
