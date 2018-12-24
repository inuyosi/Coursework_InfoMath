function Theta_est = rls_single_func(Yn ,Zn)
%% forgetting factor (Time varying)
persistent Rn ;
if isempty(Rn)
   Rn = 0.95;
end
Rn = (1 - 0.01)*Rn + 0.01;

%% Covariance Mat and Estimated val
persistent Pn;
persistent Cta;
if isempty(Pn)
   Pn = 1000;
end
if isempty(Cta)
   Cta = 0;
end

%% function
Num = Rn+Zn'*Pn*Zn;
Ln = Pn*Zn /Num;
En = Yn - Zn.' * Cta;
%% Update covariance Mat
Pn = 1/Rn*( Pn - (Pn * Zn * Zn' * Pn/Num) );
%% Output
Cta = Cta + Ln * En;
Theta_est = Cta;
end
