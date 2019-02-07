function DH=model_6dof(q, jointInWork)
% Berechnung der DH-Parametersaetze aus den 6 Gelenkkoordinaten q
% (1 Schub-, 5 Drehgelenke) des Praktikumsroboters
% q(1)=Verfahrweg, q(2:6) Winkel der Drehgelenke


%% DH-Koordinaten
% Zeile = Gelenkindex (i. Gelenk)
% Spalte 1 = alpha, (Winkel zwischen z_i und z_{i+1}-Achse)
% Spalte 2 = a, Abstand zwischen z_i und z_{i+1}-Achse in Richtung x_{i+1}
% Spalte 3 = beta, Winkel zwischen x_i und x_{i+1}-Achse
% Spalte 4 = b, Abstand zwischen x_i und x_{i+1}-Achse in Richtung der
% z_i-Achse
% (Siehe Folien 16 - 18 Vertiefungsphase)


DH.p = [-pi/2,  575*1e-3,  0,          jointInWork(1)*q(1)+400e-3;
        -pi/2,	0,         jointInWork(2)*q(2),      -290*1e-3;
                0,     500*1e-3,  jointInWork(3)*q(3)+pi/2,  0;
                pi,    387*1e-3,  jointInWork(4)*q(4)-pi/2,  0;
        -pi/2,  0,         jointInWork(5)*q(5)-pi/2,  20*1e-3;
                0,     0,         jointInWork(6)*q(6),       200*1e-3];

DH.mu=[0,1,1,1,1,1];

% 5 DoF (4. joint is broken)
% DH.p = [-pi/2,  575*1e-3,            0,                  400e-3+q(1);
%         -pi/2,  0,                   q(2),               -290*1e-3;
%          pi,    sqrt(0.5^2+0.387^2), atan(500/387)+q(3), 0;
%         -pi/2,  0,                  -atan(387/500)+q(4), 0;
%          0,     0,                   q(5),               200];

% DH.mu=[0,1,1,1,1];
end




%% Gelenkart
% 0 = Schubgelenk
% 1 = Drehgelenk
% Wird z.B. in JacobiMat.m gebraucht