%/*
%*
%*		Author:			Dr. Maik Lorch
%*		Email:			maik.lorch@kit.edu; maik.lorch@lorch-group.de
%*		Version:		MTP2017
%*
%*		Keine Verwendung / �nderung ohne R�cksprache
%*		No usage / edit without permission
%*/


user=['G21'];
pwd=['21'];
setname=['Gruppe'];


% saveValItem(user, pwd, setname, 'n', '2', 'INT32', 0, 0)
% saveValItem(user, pwd, setname, 'x', '2.2', 'DOUBLE', 0, 0)

getVal(user, pwd, setname, 'n', 'INT32')
  
% saveVals(user,pwd,setname,{'x', 'n'},{'DOUBLE','INT32'}, [1.23, 333])

% getVals(user,pwd,setname,{'q1_kin','q2_kin','q3_kin','q4_kin','q5_kin','q6_kin'})
