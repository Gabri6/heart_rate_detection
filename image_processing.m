%%%%%%%%%%%%%%%%
%
%Author: Gabriel LUCAS
%
%Creation: 06/02/23 11:03
%
%Last Modified: 06/02/23 12:02
%
%%%%%%%%%%%%%%%%


framerate=30;

ROI = [315 360;560 580] %720
myheight = uint32(ROI(1,2)-ROI(1,1))
mylength = uint32(ROI(2,2)-ROI(2,1))
resolution = myheight*mylength;

mycolors=[];

for i=[0001:1:900] %until 1860
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
  mycolors(i,1) = red/(myheight*mylength);
  mycolors(i,2) = green/(myheight*mylength);
  mycolors(i,3) = blue/(myheight*mylength);

  fprintf('%i / 1860\n', i)
endfor

for i=1:3
  y=0;
  z=0;
  for j=1:length(mycolors)
    y+=mycolors(j,i);
    z+=1;
  endfor
  
  mymean=y/z
  m=0;
  
  for j=1:length(mycolors)
    m+=abs(mycolors(j,i)-avg);
  endfor
    mystd=sqrt(m/z)
    %mymean = mean(mycolors(:,i));
    %mystd = std(mycolors(:,i));
  for j=1:length(mycolors)
    mycolors(j,i) = (mycolors(j,i)-mymean)/mystd;
  endfor
endfor
%normalisation of the values


fftred = fft(mycolors(:,1));
fftgreen = fft(mycolors(:,2));
fftblue = fft(mycolors(:,3));
%normal fast fourier transform

N=size(mycolors)(1);
freq=(0:N-1)*framerate/N;
%frequency from frame rate


minfreq=0.5;
maxfreq=4;
idx_min = find(freq >= minfreq, 1);
idx_max = find(freq <= maxfreq, 1, 'last');
filtered_freq = freq(idx_min:idx_max);

fftred_filtered = fftred(idx_min:idx_max);
fftgreen_filtered = fftgreen(idx_min:idx_max);
fftblue_filtered = fftblue(idx_min:idx_max);
%filtered fastfourier transform



figure;
subplot(3,1,1);
%plot(mycolors(:,1));
plot(filtered_freq, abs(fftred_filtered));
title('red');

subplot(3,1,2);
%plot(mycolors(:,2));
plot(filtered_freq, abs(fftgreen_filtered));
title('green');

subplot(3,1,3);
%plot(mycolors(:,3));
plot(filtered_freq, abs(fftblue_filtered));
title('blue');