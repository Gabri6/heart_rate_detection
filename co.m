function Z = co(X,Y)
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
X_bar = mean(X);
Y_bar = mean(Y);

Z = sum((X-X_bar).*(Y-Y_bar))/length(X);
end