function h=RobotGeometry(n)
% Hilfsfuntion von dhplot.m zum Visualisieren des Roboters

switch n
    case 1 
        % Querbalken
        h=hgtransform;
        Properties={'FaceColor', 'r','LineStyle','-','FaceLighting','flat'};
        [Vertices, Faces]=Box3D([0,0,-0.01], 0.950,0.050,0.020);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        % Motor
        [Vertices, Faces]=Box3D([0,0,-0.065], 0.09,0.090,0.090);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
    case 2 
        % Motor
        h=hgtransform;
        Properties={'FaceColor', 'g','LineStyle','-','FaceLighting','flat'};
        [Vertices, Faces]=Box3D([0,-0.1350,0], 0.09,0.090,0.090);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        % Motor
        [Vertices, Faces]=Box3D([0,0,0], 0.09,0.090,0.090);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        % Arm 1
        [Vertices, Faces]=Box3D([0,-0.0475,0], 0.09,0.005,0.090);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        [Vertices, Faces]=Box3D([0,-0.0875,0], 0.09,0.005,0.090);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        [Vertices, Faces]=Box3D([0,-0.045-0.045/2,0], 0.03,0.035,0.03);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
    case 3 
        % Motor
        h=hgtransform;
        Properties={'FaceColor', 'b','LineStyle','-','FaceLighting','flat'};
        [Vertices, Faces]=Box3D([-0.5,0.0,-0.09], 0.09,0.090,0.090);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        %Motor
        [Vertices, Faces]=Box3D([0,0,-0.09], 0.07,0.070,0.070);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        % Arm 1
        [Vertices, Faces]=Box3D([-0.4525,0.0,-0.09], 0.005,0.09,0.090);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        [Vertices, Faces]=Box3D([-0.0375,0.0,-0.09], 0.005,0.07,0.070);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        [Vertices, Faces]=Box3D([-0.245,0.0,-0.09], 0.41,0.034,0.0340);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
    case 4
        %Motor
        h=hgtransform;
        Properties={'FaceColor', 'c','LineStyle','-','FaceLighting','flat'};
        [Vertices, Faces]=Box3D([-0.387,0,+0.02], 0.07,0.07,0.07);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        [Vertices, Faces]=Box3D([-0.3495,0.0,+0.02], 0.005,0.07,0.070);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});        
        [Vertices, Faces]=Box3D([-0.2645,0.0,+0.02], 0.165,0.034,0.0340);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        [Vertices, Faces]=Box3D([-0.007-0.160/2,0.0,+0.02], 0.190,0.075,0.0750);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
    case 5
        h=hgtransform;
        Properties={'FaceColor', 'y','LineStyle','-','FaceLighting','flat'};
        [X,Y,Z, Handles]=Cyl3D([0;-0.0350;0],[0;1;0],0.07,0.03,'k',1);
        set(Handles, 'Parent', h ,Properties{:});
        [X,Y,Z, Handles]=Cyl3D([0;0;0],[0;0;1],0.036,0.02,'k',1);
        set(Handles, 'Parent', h ,Properties{:});
    case 6
        h=hgtransform;
        Properties={'FaceColor', 'm','LineStyle','-','FaceLighting','flat'};
        [Vertices, Faces]=Box3D([-0.0150,0.0,-0.0605-0.081], 0.02,0.092,0.045);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});        
        [X,Y,Z, Handles]=Cyl3D([-0.09;0;-0.0605-0.081],[1;0;0],0.065,0.012,'k',1);
        set(Handles, 'Parent', h ,Properties{:});
        
        [Vertices, Faces]=Box3D([0,-0.0380,-0.076/2-0.081], 0.01,0.016,0.076);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:}); 
        [Vertices, Faces]=Box3D([0,0.0380,-0.076/2-0.081], 0.01,0.016,0.076);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
        [Vertices, Faces]=Box3D([0,-0.0380+0.008,-0.119/2], 0.05,0.005,0.119);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:}); 
        [Vertices, Faces]=Box3D([0,0.0380-0.008,-0.119/2], 0.05,0.005,0.119);
        Handles=patch('Vertices', Vertices, 'Faces', Faces, 'Parent', h ,Properties{:});
    otherwise
        h=[];
end

function [Vertices, Faces]=Box3D(r, a,b,c)

Vertices=[0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1];
Vertices=[a/2-a*Vertices(:,1),-b/2+b*Vertices(:,2),-c/2+c*Vertices(:,3)];
Vertices=Vertices+repmat(r, size(Vertices,1),1);

Faces=[1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8; 1 2 3 4; 5 6 7 8];  

function [X,Y,Z, hSurf]=Cyl3D(u,v,l,Rscale,Farbe,Disp);
u=[u(1);u(2);u(3)];
v=[v(1);v(2);v(3)];
w=u+v; ev=v/norm(v);
nphi=20; phi=linspace(0,2*pi,nphi);
dx=[0, 0, l, l]; 
scale=[0, 1, 1, 0];
CylStartPkt=cross(u,v);
if norm(CylStartPkt,2)==0
    if ev==[1;0;0]
        CylStartPkt=cross([0;1;0],v);
    else
        CylStartPkt=cross([1;0;0],v);
    end
end
CylStartPkt=Rscale*CylStartPkt/norm(CylStartPkt,2);
for j=1:length(dx)
    for i=1:length(phi)
        P(:,i,j)=Schraubung(u+CylStartPkt*scale(j), u, ev, phi(i), dx(j));
        X(i,j)=P(1,i,j); Y(i,j)=P(2,i,j); Z(i,j)=P(3,i,j);
    end
end
if Disp==1
    hSurf=surface(X,Y,Z); set(hSurf,'FaceColor',Farbe);
else
    hSurf=0;
end

function [q2, D]=Schraubung(q1, p1, s, phi, d0)
D=cos(phi)*eye(3,3)+(1-cos(phi))*s*s'+sin(phi)*skew(s);
q2=D*(q1-p1)+p1+d0*s;

