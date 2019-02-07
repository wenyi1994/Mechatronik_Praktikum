function qi=iKin(q0, dsoll, Asoll, jointInWork)
% Numerische Loesung der inversen Kinematik mit dem Newton-Verfahren

% Toleranz- und Abbruchkriterien
ilimit = 2e3; tol = 1e-6;

% Initialisierung
nm = 1; count = 0;

% Letzte Position des EE
q=q0';

nq=length(q0);

% **** restrictions ****
% set restrictions
q1Range = [-10, 10];
flag_q = zeros(nq);
% **** end of restriction ****

% Beginn der Iteration
while nm > tol   
    % % ---------- Vorwaerts Kinematik----------
    DH=feval(@model_6dof,q, jointInWork);
    T=fKin(DH);
    Jac=JacobiMat(T, DH.mu);
    % ---------- Inverse Kinematik ----------
    % Funktion zum Berechnen von K (=J) und b (=f) [Folie 30] aufrufen
    [F,J]=BerechneFJ(T,dsoll,Asoll,Jac);
    % Berechne x (=q_{i+1}-q_i=dq) nach Folie 32

    % considering the broken joint(s)
    % inv_J = pinv(J);
    countBroken = find(jointInWork == 0);
    if sum(countBroken) > 0
        for i = 1:length(countBroken)
            J(:,countBroken(i)) = 0;
        end
    end

    % % **** restrictions ****
    % if flag_q(1) == 1
    %     inv_J(1,:) = 0;
    % end
    % % **** end of restriction ****
    % flag_q(1) = 0;

    dq=-pinv(J)*F; % J ist quadratisch, aber fast singulaer deswegen pinv besser
    % %
    % tempDH=feval(@model_6dof,q);
    % T_temp = fKin(tempDH);
    % y_temp = T_temp(1:3,4,end)
    % %
    q = q + dq; % Loesung zu letzter Position addieren

    % % **** restrictions ****
    % if q(1) >= q1Range(2) || q(1) <= q1Range(1)
    %     q = q - dq;
    %     flag_q(1) = 1;
    %     continue;
    % end
    % % **** end of restriction ****

    % Wenn nm klein, dann Zielposition erreicht
    dq_new = [];
    for i = 1:length(jointInWork)
        if jointInWork(i) == 1
            dq_new = [dq_new dq(i)];
        end
    end
	nm = norm(dq_new); % nm=max(F); % auch moeglich
	count = count+1;
	if count > ilimit
        disp('********** Solution does not converge!!! **********');
        qi=q;
        return;
    end
end
qi=q';
end