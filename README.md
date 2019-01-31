# Mechatronik Praktikum
## Kinematic part
#### 1. protocol of txt file
* Using `'start'` as a flag to mark the start reading position of a txt file. The [read_txt.m](https://github.com/wenyi1994/Mechatronik_Praktikum/blob/master/read_txt.m) function also supports other flags.
```
% ----------------------------Syntax------------------------------------
%                         dsoll = read_txt(path, file, 'pos')
%                           phi = read_txt(path, file, 'phi')
%               joint_parameter = read_txt(path, file, 'joint')
%                  [dsoll, phi] = read_txt(path, file, 'pose')
% [dsoll, phi, joint_parameter] = read_txt(path, file, 'all')
% [dsoll, phi, joint_parameter] = read_txt(path, file)
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
* The value of flag specifies following content. '1' for pose of target position of TCP and '2' for joint parameters of initial status. That indicates that it will read next 4 lines after `'flag=1'` and next 6 lines after `'flag=2'`.
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
#### 1. About the coordinate system
* The manipulator system is modelled as below: 
![image](https://github.com/wenyi1994/Mechatronik_Praktikum/blob/master/model.jpg) 
* Based on the model and rules of Denavit-Hartenberg Parameter, the system can be simplified as below: 
![image](https://github.com/wenyi1994/Mechatronik_Praktikum/blob/master/coordinate.jpg)
* The origin is set on the remote top corner. The arrow starting from origin indicates the direction of z-axis. According to the right-hand rule, the short red line shows the direction of x-axis and the green line for y-axis. That is the basic coordinate system and also **the global coordinate system for target position**.
* There are some restrictions in the range of provided target position: 
    + X-value and z-value should be postive and y-value should be negative. 
    + Due to the range of linear motor, z-value cannot exceed 1400mm.
    + The platform is 1090 mm high and 1050 mm wide, so the range of x-value is [0, 1050] and for y-value [-1090, 0].
#### 2. Access to data
* The target position and initial joint parameters are saved on the server, theirs values will be called in the process of running.
* Using JSON as underlying implementation for the exchange of data, the interface is provided by tutor and here is a brief introduction of how to use it.
    + The structure of database is as below, there are some attributes of each variable: 
    ![image](https://github.com/wenyi1994/Mechatronik_Praktikum/blob/master/MTP2017/database.png) 
    + To save or get the value of a variable, we should first connect to the server. In a MATLAB script, the username and passwort can be set as: 
    ```MATLAB
    user = ['G21'];
    pwd = ['21'];
    ```
    + Before accessing the data, a correct setname is necessary:
    ```MATLAB
    setname = ['InvKin'];
    ```
    + Using provided functions to save or get the variables:
    ```MATLAB
    % save var 'status_kin' on the server, the value is '1' in 'double' type
    saveValItem(user, pwd, setname, 'status_kin', '1', 'DOUBLE', 0, 0);
    % get the value of var 'status_kin', the value is in 'double' type
    getVal(user, pwd, setname, 'status_kin', 'DOUBLE');
    ```
