%%% main file
%% ---------- global variables ----------
clc; clear all; close all; warning off;
tol = 0.05; % meter, tolerance of hitting platform, can be saved on server
countRun = 0; % times of running
countReady = 0; % times of checking flag
AnimNumPoints = 30; % precision of animation
timePause = 4; % paused seconds in every loop, can be saved on server
jointInWork = [1,1,1,0,1,1]; % specify joints in normal work (not broken)
startPunc = ' ● '; % punctuation used in log file

%% ---------- save logs ----------
% running time
timeRun = datestr(now, 'ddmmyy_HHMMSS');
% save current path
pathCurrent = cd;
% get target path
pathFile = mfilename('fullpath');
i = strfind(pathFile, filesep);
pathFile = pathFile(1:i(end));
cd(pathFile);
if ~exist('logs')
    mkdir logs
end
% return to previous path
cd(pathCurrent);
pathFile = [pathFile 'logs' filesep timeRun];
% open file to write
fid=fopen(pathFile, 'w');
fprintf(fid, '%s%s\n', datestr(now), ' Start running ...');

%% ---------- infos for server ----------
fprintf(fid, '%s%s\n', datestr(now), ' Connecting to the server ...');
user = ['G21'];
pwd = ['21'];

%% ---------- Anfangswerte ----------
if ~exist('q0')
    q0 = [0, 0, 0, 0, 0, 0];
end

while(1)
    %% ---------- get initial joint parameters and target position ----------
    setname = ['InvKin'];
    countReady = countReady + 1;
    % ---- validate flag of starting ----
    disp(['-------- check if the parameters are ready -------- (' num2str(countReady) ')']);
    fprintf(fid, '%s%s%s%s', datestr(now), ' Checking if the parameters are ready ... (', num2str(countReady), ')');
    getJointReady = getVal(user, pwd, setname, 'status_kin', 'DOUBLE');
    if getJointReady ~= 1
        fprintf(fid, '%s\n', ' FAIL! Parameters are not ready!');
        pause(timePause);
        continue;
    elseif getJointReady == 1
        countRun = countRun + 1;
        disp(['**** parameters are new, receiving **** (' num2str(countRun) ')']);
        fprintf(fid, '%s%s%s\n', ' SUCCESS! Receiving ... (', num2str(countRun), ')');
        setname = ['ObjectDetection'];
        valuePos = getVals(user, pwd, setname, {'x_image', 'y_image', 'z_image', 'phi_image'});
        fprintf(fid, '%s%s%s%s%s%s%s%s%s%s%s\n', datestr(now), startPunc, 'x = ', num2str(valuePos(1)), ' mm; y = ', ...
            num2str(valuePos(2)), ' mm; z = ', num2str(valuePos(3)), ' mm; phi = ', num2str(valuePos(4)), ' rad');
        disp(['       x = ' num2str(valuePos(1)) ' mm']);
        disp(['       y = ' num2str(valuePos(2)) ' mm']);
        disp(['       z = ' num2str(valuePos(3)) ' mm']);
        disp(['     phi = ' num2str(valuePos(4)) ' rad']);
        setname = ['InvKin'];
        valueJoint = getVals(user, pwd, setname, {'q1_kin', 'q2_kin', 'q3_kin', 'q4_kin', 'q5_kin', 'q6_kin'});
        % **** edit here to continue from last position **** %
            % flag = true
            %   ... ...
            % (during getting parameters)
            % if flag
            %   valueJoint = [0 ... 0]';
            % end
            %   ... ...
            % (after first calculation)
            % flag = false
        valueJoint = [0,0,0,0,0,0]';
        % **** edit here to continue from last position **** %
        fprintf(fid, '%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n', datestr(now), startPunc, ... 
                    'q1 = ', num2str(valueJoint(1)), '; q2 = ', num2str(valueJoint(2)), ...
                    '; q3 = ', num2str(valueJoint(3)), '; q4 = ', num2str(valueJoint(4)), ...
                    '; q5 = ', num2str(valueJoint(5)), '; q6 = ', num2str(valueJoint(6)));
        disp(['      q1 = ' num2str(valueJoint(1))]);
        disp(['      q2 = ' num2str(valueJoint(2))]);
        disp(['      q3 = ' num2str(valueJoint(3))]);
        disp(['      q4 = ' num2str(valueJoint(4))]);
        disp(['      q5 = ' num2str(valueJoint(5))]);
        disp(['      q6 = ' num2str(valueJoint(6))]);

        %% ---------- set target position and angle ----------
        % transform the unit from milimeter to meter
        dsoll = [valuePos(1)/1000, valuePos(2)/1000, valuePos(3)/1000]';
        alphaMRT = valuePos(4);

        %% ---------- Zielposition vorgeben ----------
        % erst ins MRT-System, dann Orientierung in diesem KS (aus Kamera)
        fprintf(fid, '%s%s%s\n', datestr(now), startPunc, 'Calculating Kardan-angle ...');
        Asoll = Kardanwinkel([pi/2, 0, -pi/2]) * Kardanwinkel([0, 0, alphaMRT]); 

        %% ---------- Plot Ausgangsstellung ----------
        DH0 = feval(@model_6dof, q0, jointInWork);
        dhplot(DH0, dsoll, Asoll);
        
        %% ---------- Vorwaerts Kinematik ----------
        fprintf(fid, '%s%s%s\n', datestr(now), startPunc, 'Forward kinematic calculating ...');
        DH = feval(@model_6dof, q0, jointInWork);
        T = fKin(DH);
        Jac_q0 = JacobiMat(T, DH.mu);
        check_q0 = T(1:3, 4, end);
        dhplot(DH0, check_q0, Asoll);

        %% ---------- Vorwaerts Kinematik test---------
        %  q1=[0.5 pi/3 pi/3 pi/3 pi/3 pi/3]
        %  DH=feval(@model_6dof,q1);
        %  T=fKin(DH);
        %  Jac=JacobiMat(T, DH.mu)
        %  check1_q1=T(1:3,4,end)
        % dhplot(DH0,check1,Asoll);
        %% ---------- Inverse Kinematik ----------
        fprintf(fid, '%s%s%s\n', datestr(now), startPunc, 'Inverse kinematic calculating ...');
        qi = iKin(q0, dsoll, Asoll, jointInWork);
        fprintf(fid, '%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n', datestr(now), startPunc, ... 
                    'q1 = ', num2str(qi(1)), '; q2 = ', num2str(qi(2)), ...
                    '; q3 = ', num2str(qi(3)), '; q4 = ', num2str(qi(4)), ...
                    '; q5 = ', num2str(qi(5)), '; q6 = ', num2str(qi(6)));
        % Wenn Inverse Kinematik fertig ist ab hier einkommentieren. Endposition
        % der Gelenkwinkel muss den Namen "qi" haben.
        %% ---------- Winkelbereich [-pi ... pi] ----------
        fprintf(fid, '%s%s%s\n', datestr(now), startPunc, 'Optimizing joint parameters ...');
        for i = 1:length(q0)
            qi_red(i) = qi(i);
            if DH0.mu(i) == 1
                qi_temp = mod(qi(i), 2 * pi);
                if qi_temp > pi
                    qi_red(i) = qi_temp - 2 * pi;
                else
                    qi_red(i) = qi_temp;
                end
            end
        end
        countBroken = find(jointInWork == 0);
        if sum(countBroken) > 0
            for i = 1:length(countBroken)
                qi_red(countBroken(i)) = 0;
            end
        end
        % dq = qi-q0;
        fprintf(fid, '%s%s%s%s%s%s%s%s%s%s%s%s%s%s\n', datestr(now), startPunc, ... 
                    'q1 = ', num2str(qi_red(1)), '; q2 = ', num2str(qi_red(2)), ...
                    '; q3 = ', num2str(qi_red(3)), '; q4 = ', num2str(qi_red(4)), ...
                    '; q5 = ', num2str(qi_red(5)), '; q6 = ', num2str(qi_red(6)));
        disp('**** target position (parameter) of joint ****');
        disp(['      q1 = ' num2str(qi_red(1))]);
        disp(['      q2 = ' num2str(qi_red(2))]);
        disp(['      q3 = ' num2str(qi_red(3))]);
        disp(['      q4 = ' num2str(qi_red(4))]);
        disp(['      q5 = ' num2str(qi_red(5))]);
        disp(['      q6 = ' num2str(qi_red(6))]);
        
        %% ---------- Winkelverlaeufe ----------
        for i = 1:length(qi)
            Q(:, i) = linspace(q0(i), qi_red(i), AnimNumPoints)'; % Lineare Interpolation
        end

        %% ---------- Trajektorie ----------
        Traj = [];
        fprintf(fid, '%s%s%s\n', datestr(now), startPunc, 'Validating joint parameters ...');
        statusKin = 2; % flag for status of kinematic
        for i = 1:AnimNumPoints
            DH = feval(@model_6dof,Q(i,:), jointInWork);
            T = fKin(DH); % Vorwaertskinematik aller Gelenkstellungen
            Traj = [Traj, T(1:3, 4, end)]; % Neue Trajektorie ist alte plus neue Position des Endeffektors
            if sum(Traj(2,:) < -1.09-tol) > 0
                statusKin = 3;
            end
        end

        %% ---------- calculate difference between parameters and target ----------
        posDiff = (Traj(:,end) - dsoll) * 1000; % transform to milimeter
        posDistance = norm(posDiff);
        disp('**** difference between calculated and target position ****');
        disp(['      x: ' num2str(posDiff(1)) ' mm; y: ' num2str(posDiff(2)) ' mm; z: ' num2str(posDiff(3)) 'mm; distance: ' num2str(posDistance) 'mm']);
        fprintf(fid, '%s%s%s\n', datestr(now), startPunc, 'Calculating difference to target position ...');
        fprintf(fid, '%s%s%s%s%s%s%s%s%s%s%s\n', datestr(now), startPunc, 'x: ', num2str(posDiff(1)), ' mm; y: ', num2str(posDiff(2)), ...
                     ' mm; z: ', num2str(posDiff(3)), 'mm; distance: ', num2str(posDistance), 'mm');

        %% ---------- save joint parameters to the server ----------
        setname = ['InvKin'];
        if statusKin == 3
            fprintf(fid, '%s%s%s\n', datestr(now), startPunc, 'FAIL! Joint parameters are not executable!');
            saveValItem(user, pwd, setname, 'status_kin', num2str(statusKin), 'DOUBLE', 0, 0); % not executable
            disp('    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
            disp('    !!! The joint parameters are NOT executable !!!');
            disp('    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
            lineColor = 'r';
        elseif statusKin == 2
            fprintf(fid, '%s%s%s\n', datestr(now), startPunc, 'SUCCESS! Saving parameters on the server ...');
            saveVals(user,pwd,setname,{'status_kin', 'q1_kin', 'q2_kin', 'q3_kin', 'q4_kin', 'q5_kin', 'q6_kin'}, ... 
                                        {'DOUBLE',   'DOUBLE', 'DOUBLE', 'DOUBLE', 'DOUBLE', 'DOUBLE', 'DOUBLE'}, ...
                                        [statusKin, qi_red(1),qi_red(2),qi_red(3),qi_red(4),qi_red(5),qi_red(6)]);
            disp('**** values have been saved on the server ****');
            lineColor = 'b';
        end
        fprintf(fid, '%s%s%s%s%s\n', datestr(now), startPunc, 'Finished! (', num2str(countRun), ')');

        %% ---------- Animation ----------
        flag = 1;
        for i = 1:AnimNumPoints
            DH = feval(@model_6dof, Q(i,:), jointInWork);
            dhplot(DH, dsoll, Asoll, Traj, lineColor); % Plotten aller Stellungen mit Trajektorie
        end

        continue;
    end
    % close log file
    fclose(fid);
end