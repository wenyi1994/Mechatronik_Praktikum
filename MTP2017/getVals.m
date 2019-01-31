function result=getVals(username, password, setname, varslist)

%/*
%*
%*		Author:			Dr. Maik Lorch
%*		Email:			maik.lorch@kit.edu; maik.lorch@lorch-group.de
%*		Version:		MTP2017
%*
%*		Keine Verwendung / Änderung ohne Rücksprache
%*		No usage / edit without permission
%*/

TRENNER = '?/?TRENN?/?';

vars = varslist;
allvars ='';
[m,n]=size(vars);
for k=1:n
    allvars=strcat(allvars, vars(k), TRENNER);
end

result=getValItems(username, password, setname, allvars);

k=strfind(result, '[');

[a,b]=size(result);
json=result(k(1):b);
result2json=loadjson(json);

result=[];

for k=1:n
    i=1;
    while i<=n
        if strcmp(vars(k), result2json{i}.varname)
            result=[result; str2double(result2json{i}.value)];
            break;
        else
            i=i+1;
        end
    end
end
end
