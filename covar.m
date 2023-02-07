function Z = covar(X)
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
x=X(:,1);
y=X(:,2);
z=X(:,3);
Z1 = co(x,x);
Z2 = co(x,y);
Z3 = co(x,z);
Z4 = co(y,x);
Z5 = co(y,y);
Z6 = co(y,z);
Z7 = co(z,x);
Z8 = co(z,y);
Z9 = co(z,z);

Z = [Z1 Z2 Z3;Z4 Z5 Z6;Z7 Z8 Z9]
end