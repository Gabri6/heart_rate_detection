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

iter = 10000;
tolerance=1e-10;
% Center the data
X = center(X);
component_nbr = size(X,1);
% Whiten the data
X_whiten = whitening(X);




W = zeros(component_nbr,size(X,2));

% Main loop of the FastICA algorithm
for i = 1:size(X,2)
  %rdm matrix gen
  w = rand(component_nbr,1);
  for j = 1:iter
    w_new = calc_new_w(w, X_whiten);
    if i >= 1
      w_new -= (w_new * W(:,i)') * W(:,i);
    endif
    dist = abs(sum(abs(w .* w_new))-1);
    w = w_new;
    if dist < tolerance
      break;
    endif
  endfor
  W(:,i)=w
endfor    
icasig = W' * X_whiten;
end

