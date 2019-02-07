function varargout = write_txt(path, file, varargin)
    % path='/Users/edwardsue/Documents/MATLAB/Mechatronik_Praktikum/Gruppenphase/';
    % file='test_write.txt';
    fid=fopen([path,file], 'w');
    fprintf(fid, '%s%s%d%s\n', 'start', '=', 2, ';');
    fclose(fid);
end