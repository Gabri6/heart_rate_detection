%%%%%%%%%%%%%%%%%
%for i=[0001:1:1860]
%  imgNum = int2str(i);
%  numbDigits= abs(floor(log10(abs(i-1)+1))+1);
%  if (numbDigits == 1)
%    imgNum = ['0' '0' '0' imgNum];
%  elseif(numbDigits == 2)
%    imgNum = ['0' '0' imgNum];
%  else
%    imgNum = [int2str(zeros(1,abs(numbDigits-4))) int2str(i)];
%  endif
%  
%  if (abs(floor(log10(abs(imgNum-1)+1))+1) == 4)
%    disp("Image number has the good number of digits")
%  else
%    disp("/!\ TEST FAILED:Image number has not the good number of digits")
%  endif
%
%
%  myImage=imread(['video_robot/' imgNum '.png']);
%  imshow(uint8(myImage));
%  disp(myImage(10,10))
%endfor

myImage=imread(['video_robot/0001.png']);

imshow(uint8(myImage));
disp("test1")