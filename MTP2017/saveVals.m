function mess=saveVals(username, password, setname, vars, datatypes, values)

%/*
%*
%*		Author:			Dr. Maik Lorch
%*		Email:			maik.lorch@kit.edu; maik.lorch@lorch-group.de
%*		Version:		MTP2017
%*
%*		Keine Verwendung / �nderung ohne R�cksprache
%*		No usage / edit without permission
%*/

TRENNER = '?/?TRENN?/?';
allvars ='';
alltypes='';
allvalues='';
allrows='';
allcols='';
[m,n]=size(vars);
for k=1:n
    allvars=strcat(allvars, vars(k), TRENNER);
    alltypes=strcat(alltypes, datatypes(k), TRENNER);
    allvalues=strcat(allvalues, num2str(values(k)), TRENNER);
    allrows=strcat(allrows, '0', TRENNER);
    allcols=strcat(allcols, '0', TRENNER);
end

result=saveValItems(username, password, setname, allvars,allvalues,alltypes,allrows,allcols);

k=strfind(result, '[');
k(1);
[a,b]=size(result);
json=result(k(1):b);
result2json=loadjson(json);
mess=result2json{1}.messages;


