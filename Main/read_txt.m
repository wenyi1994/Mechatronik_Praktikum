function varargout = read_txt(path, file, varargin)
    % read_txt - Try to read the content of a txt-file.
    %
    % ----------------------------Syntax------------------------------------
    %                         dsoll = read_txt(path, file, 'pos')
    %                           phi = read_txt(path, file, 'phi')
    %               joint_parameter = read_txt(path, file, 'joint')
    %                  [dsoll, phi] = read_txt(path, file, 'pose')
    % [dsoll, phi, joint_parameter] = read_txt(path, file, 'all')
    % [dsoll, phi, joint_parameter] = read_txt(path, file)
    % Add a new key word to change start position of reading, the default flag is 'start':
    %                         dsoll = read_txt(path, file, 'pos', 'begin')
    % ----------------------------------------------------------------------
    % Yi Wen
    % yi.wen@student.kit.edu
    % 17/01/2019

    % path='/Users/edwardsue/Documents/MATLAB/Mechatronik_Praktikum/Gruppenphase/';
    % file='Var_Vorlage.txt';
    % [dsoll, alphaMRT, q0] = read_txt(path, file, 'all');

    % get content of file
    fid=fopen([path,file]);
    fileContTemp = textscan(fid, '%s');
    fileContCl=fileContTemp{1};
    lgthData=size(fileContCl);
    for ct = 1:lgthData(1)
        dataCl{ct} = textscan(fileContCl{ct},'%s %f', 'Delimiter', {'=',';'});
    end
    fclose(fid);

    % set reading flag
    if nargin == 4
        flag = varargin{2};
    else
        flag = 'start';
    end

    % find data
    for ct_st = 1:lgthData(1)
        start_flag = dataCl{ct_st}{1}{1};
        if strcmp(start_flag, flag)
            start_value = dataCl{ct_st}{2};
            if start_value == 1
                x = dataCl{ct_st+1}{2};
                y = dataCl{ct_st+2}{2};
                z = dataCl{ct_st+3}{2};
                phi = dataCl{ct_st+4}{2};
            elseif start_value == 2
                q1 = dataCl{ct_st+1}{2};
                q2 = dataCl{ct_st+2}{2};
                q3 = dataCl{ct_st+3}{2};
                q4 = dataCl{ct_st+4}{2};
                q5 = dataCl{ct_st+5}{2};
                q6 = dataCl{ct_st+6}{2};
            end
        end
    end

    % set output
    if nargin == 2
        varargout{1} = [x/1000,y/1000,z/1000]';
        varargout{2} = phi/180*pi;
        varargout{3} = [q1, q2, q3, q4, q5, q6];
    else
        switch varargin{1}
            case 'pos'
                varargout{1} = [x/1000,y/1000,z/1000]';
            case 'phi'
                varargout{1} = phi/180*pi;
            case 'joint'
                varargout{1} = [q1, q2, q3, q4, q5, q6];
            case 'pose'
                varargout{1} = [x/1000,y/1000,z/1000]';
                varargout{2} = phi/180*pi;
            case 'all'
                varargout{1} = [x/1000,y/1000,z/1000]';
                varargout{2} = phi/180*pi;
                varargout{3} = [q1, q2, q3, q4, q5, q6];
        end
    end
    
end