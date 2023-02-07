function w_new = calc_new_w(w)
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
w_new = (X * g(w' * X)) / size(X, 1) - gder(w' * X) / size(X, 1) * w;
w_new = w_new / sqrt(sum(w_new .^ 2));
end