## Copyright (C) 2023 lucas
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} normal (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: lucas
## Created: 2023-02-10

function x = normal (data)
  for i = 1:3
    for j = 1:size(data,1)
      data(j,i) = (data(j,i)-mean(data(:,i)))/std(data(:,i));
    endfor
  endfor
  x=data;
endfunction