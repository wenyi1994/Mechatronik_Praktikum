function init(x, y, z, phi)
    %% infos for server
    user=['G21'];
    pwd=['21'];

    %% set initial values
    disp('---- set values ----');
    % x,y,z in milimeter and phi in radian
        % range of x,y,z values
        % z = [0,1400]
        % y = [-1090, 0]
        % x = [0, 1050]
    % x = 600;
    % y = -800;
    % z = 400;
    % x = 415.8119;
    % y = -960;
    % z = 1556.2138;
    % phi = 0;
    % x = 552.5707;
    % y = -955;
    % z = 1455.0601;
    % phi = 2.5512;
    % x = 746.0383;
    % y = -960;
    % z = 1333.4751;
    % phi = 1.2612;
    setname=['ObjectDetection'];
    saveVals(user,pwd,setname,{'x_image', 'y_image', 'z_image', 'phi_image'}, ... 
                            {'DOUBLE',   'DOUBLE',  'DOUBLE',  'DOUBLE'}, ...
                                [x,         y,         z,        phi]);
    disp(['     x = ' num2str(x)]);
    disp(['     y = ' num2str(y)]);
    disp(['     z = ' num2str(z)]);
    disp(['   phi = ' num2str(phi)]);

    % q1 in meter and q2-q6 in radian
    q1=1.289;            
    q2=-1.0434;          
    q3=0.89447;          
    q4=-0.11496;         
    q5=-0.79129;         
    q6=1.052;
    setname=['InvKin'];
    saveVals(user,pwd,setname,{'status_kin', 'q1_kin', 'q2_kin', 'q3_kin', 'q4_kin', 'q5_kin', 'q6_kin'}, ... 
                            {'DOUBLE',     'DOUBLE', 'DOUBLE', 'DOUBLE', 'DOUBLE', 'DOUBLE', 'DOUBLE'}, ...
                                [1,            q1,       q2,       q3,       q4,       q5,       q6]);
    disp(['    q1 = ' num2str(q1)]);
    disp(['    q2 = ' num2str(q2)]);
    disp(['    q3 = ' num2str(q3)]);
    disp(['    q4 = ' num2str(q4)]);
    disp(['    q5 = ' num2str(q5)]);
    disp(['    q6 = ' num2str(q6)]);
    disp('------- done -------');
end