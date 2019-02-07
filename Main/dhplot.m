function dhplot(DH,dsoll,Asoll,varargin)
% Plotten des Roboters fuer geg. DH-Parameter und der Zielposition als KS
% Optionale Parameter zum Zeichnen der Endeffektortrajektorie

%% Plot Einstellungen (Neue Fig. oder in alter weiterzeichnen)
    hFig=findobj(0, 'Tag', 'ModelFigure');
        if isempty(hFig)
            hFig=figure;
            set(0,'CurrentFigure',hFig);
            set(hFig,'color','w','doublebuffer','on','Renderer','OpenGL','Tag','ModelFigure');
            set(gca,'CameraPositionMode','auto');
            set(gca,'CameraTargetMode','auto');
            set(gca,'CameraUpVectorMode','auto');
            set(gca,'CameraViewAngleMode','auto'); 
            set(gca,'DataAspectRatio',[1,1,1],'Position',[0,0,1 1]); 
            cameratoolbar('Show');
            set(gca,'DrawMode','fast','Visible','off','Tag','ModelAxes');
        else
            set(0,'CurrentFigure',hFig);
            set(hFig,'color','w','doublebuffer','on','Renderer','OpenGL','Tag','ModelFigure');
            cameratoolbar('Show');
            hAxes=findobj(hFig, 'Tag', 'ModelAxes');
            if isempty(hAxes)
                hAxes=axes;
                set(hFig,'CurrentAxes',hAxes);
                set(hAxes,'CameraPositionMode','auto');
                set(hAxes,'CameraTargetMode','auto');
                set(hAxes,'CameraUpVectorMode','auto');
                set(hAxes,'CameraViewAngleMode','auto'); 
                set(hAxes,'DataAspectRatio',[1,1,1]); 
                set(hAxes,'DrawMode','fast','Visible','off','Tag','ModelAxes');
            else
                set(hFig,'CurrentAxes',hAxes);
             	cla;
                set(gca,'CameraPositionMode','manual');
                set(gca,'CameraTargetMode','manual');
                set(gca,'CameraUpVectorMode','manual');
                set(gca,'CameraViewAngleMode','manual'); 
                set(gca,'DrawMode','fast','Visible','off','Tag','ModelAxes');
            end
        end

plotopt.Achse.Laenge=200*1e-3;
plotopt.Achse.Dicke=10*1e-3;
plotopt.Achse.Farbe=[0.8,0.8,0.8];
plotopt.KoorSys.Laenge=100*1e-3;
zPlatte=1.100;

cla;
[nq,n]=size(DH.p);
% -------------------- Asoll --------------------

if ~isempty(Asoll) && ~isempty(dsoll)
    KoorSys(Asoll, dsoll, plotopt.KoorSys.Laenge)
    [x,y,z,h]=Vec3D(dsoll,Asoll(:,3),0.5*plotopt.Achse.Laenge,0.5*plotopt.Achse.Dicke,'w',1);
    set(h, 'FaceAlpha',0.5);
elseif ~isempty(Asoll)
    KoorSys(Asoll, [0;0;0], plotopt.KoorSys.Laenge);
    [x,y,z,h]=Vec3D([0;0;0],Asoll(:,3),plotopt.Achse.Laenge,plotopt.Achse.Dicke,'w',1);
    set(h, 'FaceAlpha',0.5);
elseif ~isempty(dsoll)
    h=line([dsoll(1) dsoll(1)],[dsoll(2) dsoll(2)],[dsoll(3) dsoll(3)]);
    set(h,'Marker','.','MarkerSize',15);
end

% -------------------- Lage und Orientierung der KoorSys --------------------
[T]=fKin(DH);
%A=Kardanwinkel([-pi/2,0,pi/2]);
%KoorSys(A,[1.150,-zPlatte,2.090]',plotopt.KoorSys.Laenge);
%[x,y,z,h]=Vec3D([1.150,-zPlatte,2.090]',A(:,2),0.5*plotopt.Achse.Laenge,0.5*plotopt.Achse.Dicke,'w',1);
%set(h, 'FaceAlpha',0.5);
% -------------------- Inertialsystem [KoorSys 0] --------------------
KoorSys(eye(3,3),[0,0,0]',plotopt.KoorSys.Laenge);
Vec3D([0,0,0]',[0,0,1]',plotopt.Achse.Laenge,plotopt.Achse.Dicke,plotopt.Achse.Farbe,1); % selbstdef. Funktion
Oi_minus_1=[0;0;0];
% -------------------- [KoorSys i] --------------------
for i=1:nq
    Pi=T(:,:,i)*[-DH.p(i, 2);0;0;1];
    Ai=T(1:3,1:3,i);
    if i<nq
        Vec3D(T(1:3,4,i),T(1:3,3,i),plotopt.Achse.Laenge,plotopt.Achse.Dicke,plotopt.Achse.Farbe,1);
    end
    KoorSys(T(1:3,1:3,i),T(1:3,4,i),plotopt.KoorSys.Laenge);
    hLine=line([Pi(1) T(1,4,i)],[Pi(2) T(2,4,i)],[Pi(3) T(3,4,i)]);
    set(hLine,'Color','m','Linewidth',1,'LineStyle','-','Marker','.');
    hLine=line([Pi(1) Oi_minus_1(1)],[Pi(2) Oi_minus_1(2)],[Pi(3) Oi_minus_1(3)]);
    set(hLine,'Color','c','Linewidth',1,'LineStyle','-','Marker','.');
    Oi_minus_1=T(1:3,4,i);
    
    h=RobotGeometry(i); set(h, 'Matrix',T(:,:,i)); % Zeichnen der positionierten Segmente mittels Box3D und Cyl3D (selbstdef.)
end
% Bodenplatte zeichnen
[x,z] = meshgrid(linspace(0,1.150,5),linspace(0,2.090,9));
y = -zPlatte*ones(size(x)); 
hS=surface(x,y,z);
set(hS,'FaceColor',1*[0.5,1,0.5],'FaceAlpha',0.25,'LineStyle','-')
% Rahmen zeichnen
h=line([0 0],[0 -zPlatte],[0 0]); set(h, 'Color', 1*[0.5,0.5,0.5])
h=line([1.150 1.150],[0 -zPlatte],[0 0]); set(h, 'Color', 1*[0.5,0.5,0.5])
h=line([1.150 1.150],[0 -zPlatte],[2.090 2.090]); set(h, 'Color', 1*[0.5,0.5,0.5])
h=line([0 0],[0 -zPlatte],[2.090 2.090]); set(h, 'Color', 1*[0.5,0.5,0.5])
h=line([0 1.150 1.150 0 0],[0 0 0 0 0],[0 0 2.090 2.090 0]); set(h, 'Color', 1*[0.5,0.5,0.5])


% set(gcf,'doublebuffer','on','Renderer','OpenGL');
% set(gca,'DrawMode','fast');
% % light('Position',plotopt.LightPosition,'Style','infinite');
% 
% set(gca,'Visible','off','CameraPosition',plotopt.CameraPosition,'CameraUpVector',plotopt.CameraUpVector,'CameraTarget',plotopt.CameraTarget,'CameraViewAngle',plotopt.CameraViewAngle);
% axis(plotopt.axis); axis equal; 
if ~isempty(varargin)
    Traj=varargin{1};
    % -------- try to change the color of lines -------- %
    lineColor = varargin{2};
    h=line(Traj(1,:), Traj(2,:), Traj(3,:)); % X,Y,Z-Data der gesamten Trajektorie
    set(h,'Color', lineColor, 'LineStyle','-', 'LineWidth', 2)
    % ----------------------- end ---------------------- %
end
set(gca,'DrawMode','fast');
drawnow;

function KoorSys(A, d, l)
X=l*A(:,1)+d; Y=l*A(:,2)+d; Z=l*A(:,3)+d; 
hLine=line([d(1) X(1)],[d(2) X(2)],[d(3) X(3)]); set(hLine,'Color','r','Linewidth',2);
hLine=line([d(1) Y(1)],[d(2) Y(2)],[d(3) Y(3)]); set(hLine,'Color','g','Linewidth',2);
hLine=line([d(1) Z(1)],[d(2) Z(2)],[d(3) Z(3)]); set(hLine,'Color','b','Linewidth',2);

function [X,Y,Z, hSurf]=Vec3D(u,v,l,Rscale,Farbe,Disp);
u=[u(1);u(2);u(3)];
v=[v(1);v(2);v(3)];
w=u+v; ev=v/norm(v);
nphi=9; phi=linspace(0,2*pi,nphi);
dx=[0,l-8*Rscale,l-8*Rscale,l]; 
scale=[1, 1, 2, 0];
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
