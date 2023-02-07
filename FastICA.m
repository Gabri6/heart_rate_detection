function [icasig] = FastICA(X)
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

iter = 1000;
tolerance=1e-5;
% Center the data
X = center(X);
component_nbr = size(X,2);
% Whiten the data
X_whiten = whitening(X);



%rdm matrix gen
W = zeros(component_nbr, component_nbr);

% Main loop of the FastICA algorithm
for i = 1:component_nbr
  w = rand(component_nbr);
  for j = 1:iter
    w_new = calc_new_w(w);
    if i >= 1
      w_new -= (w_new * W(:,i)) * W(:,i)
    endif
    dist = abs(sum(abs(w * w_new))-1)
    w = w_new
    if dist < tolerance
      break;
    endif
  endfor
  W(:,i)=w
endfor    
icasig = W * X_whiten
end

