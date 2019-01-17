# Mechatronik Praktikum
## Kinematic part
#### 1. protocol of txt file
* Using `'start'` as a flag to mark the start reading position of a txt file. The [read_txt.m](https://github.com/wenyi1994/Mechatronik_Praktikum/blob/master/read_txt.m) function also supports other flags.
```
% Add a new key word to change start position of reading, the default flag is 'start':
%                         dsoll = read_txt(path, file, 'pos', 'begin')
```
> For further usage see [read_txt.m](https://github.com/wenyi1994/Mechatronik_Praktikum/blob/master/read_txt.m).
* Using an equal sign to specify the value. A line ends with a semicolon, one line per variable.
```MATLAB
x=500;  
y=-500;  
z=500;    
phi=30; 
```
* The value of flag specifies following content. 1 for pose of target position of TCP and 2 for joint parameters of initial status. That indicates that it will read next 4 lines after `'flag=1'` and next 6 lines after `'flag=2'`.
```MATLAB
start=2;             
q1=1.289;            
q2=-1.0434;          
q3=0.89447;          
q4=-0.11496;         
q5=-0.79129;         
q6=1.052; 
```
* The unit of pose are millimeter and degree. For joint parameters they are meter and radian.
> The unit can also be converted easily, I just keep the unit of [Var_Vorlage.txt](https://github.com/wenyi1994/Mechatronik_Praktikum/blob/master/Var_Vorlage.txt) from tutor.
```MATLAB
varargout{1} = [x/1000,y/1000,z/1000]';
varargout{2} = phi/180*pi;
varargout{3} = [q1, q2, q3, q4, q5, q6];
```
#### 2. About the coordinate system
