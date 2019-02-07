function out=skew(in)
% s <-> S
% Funktion rechnet schiefsymmetrische Matrix in den entsprechenden 
% Vektor des Kreuzproduktes um (Folie 28) 
[m,n]=size(in);

if (m==1) && (n==3) 
    out=[0, -in(3), in(2); in(3), 0, -in(1); -in(2), in(1), 0];
elseif (m==3) && (n==1)
    out=[0, -in(3), in(2); in(3), 0, -in(1); -in(2), in(1), 0];
elseif (m==3) && (n==3)
    out=[in(3,2); in(1,3); in(2,1)];
else
    disp('error: invalid size');
end

