# Mechatronik Praktikum
## Kinematic part
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
    > Considering saving some global variables also on the server, such as tolerance of impact checking, cycle time of checking.
#### 3. Running of the system
* After clicking 'Run' button, the program is in continuous operation. It will check a starting flag on the server periodically, once a 'ready' situation is detected, it will then read the values of target position and initial joint parameters. These values will be saved locally until next period.
* The program will create a folder named 'logs' in current path (if not existing), running log with timestamp will be saved there for debugging and checking.
* After calculating, it will validate the values of target joint parameters. Through linear interpolation it create the trajectory of the path and check if the manipulator will hit the platform. If the result is valid, it will be saved then on the server, otherwise the program will set a 'not executable' mark on the server.
* Finally the program gives a simulation of the process, premised with all the joints move simutaneously.
* When everything is done, it will wait for the set time and next period starts.
