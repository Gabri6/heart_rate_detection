%%%%%%%%%%%%%%%%
%
%Author: Gabriel LUCAS
%
%Creation: 06/02/23 11:03
%
%Last Modified: 06/02/23 12:02
%
%%%%%%%%%%%%%%%%



ROI = [315 360;560 580] %720
myheight = uint32(ROI(1,2)-ROI(1,1))
mylength = uint32(ROI(2,2)-ROI(2,1))
resolution = myheight*mylength

myred=[];
mygreen=[];
myblue=[];

for i=[0001:1:1860]
  red = uint32(0);
  green = uint32(0);
  blue = uint32(0);
  imgNum = int2str(i);
  numbDigits= abs(floor(log10(abs(i-1)+1))+1);
  if (numbDigits == 1)
    imgNum = ['0' '0' '0' imgNum];
  elseif(numbDigits == 2)
    imgNum = ['0' '0' imgNum];
  else
    imgNum = [int2str(zeros(1,abs(numbDigits-4))) int2str(i)];
  endif
    %changes the image number into the format given by ffmpeg

  if (length(imgNum) == 4)
    %disp("Image number has the good number of digits");
  else
    disp("/!\ TEST FAILED:Image number has not the good number of digits")
    disp(imgNum)
  endif


  myImage=imread(['video_robot/' imgNum '.png']);

  for h=ROI(1,1):ROI(1,2) %height of the ROI
    for l=ROI(2,1):ROI(2,2) %length of the ROI
      [myImage(h,l,1) myImage(h,l,2) myImage(h,l,3)];
      red = red + uint32(myImage(h,l,1));
      green = green + uint32(myImage(h,l,2));
      blue = blue + uint32(myImage(h,l,3));
    endfor
  endfor
  myred(i) = red/(myheight*mylength);
  mygreen(i) = green/(myheight*mylength);
  myblue(i) = blue/(myheight*mylength);

  fprintf('%i / 1860\n', i)
endfor

fftred = fft(myred);
fftgreen = fft(mygreen);
fftblue = fft(myblue);


figure;
subplot(3,1,1);
plot(myred);
title('red');

subplot(3,1,2);
plot(mygreen);
title('green');

subplot(3,1,3);
plot(myblue);
title('blue');