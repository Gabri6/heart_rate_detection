function X_whiten = whitening(X)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Creator : Lucas Marais
% Date : 07/02/23
% Time : 11:06:00
% FastICA function tentative
%
%
% Last update : Lucas
% D-T : 06/02/2023-14:16:00
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
co = covar(X);
[E, D] = eig(co);
D_inv = sqrt(inv(D));
X_whiten = E * (D_inv * (E' * X));
end