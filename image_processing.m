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
disp("START")
ROI = [315 360;560 720]; %region of interest determined by hand
myheight = uint32(ROI(1,2)-ROI(1,1)); %height of ROI
mylength = uint32(ROI(2,2)-ROI(2,1)); %length of ROI
resolution = myheight*mylength; %number of pixels in ROI

mycolors=[];

for i=[0001:1:1860] %go through each image
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

  mycolors(i,1) = mean(mean(myImage(ROI(1,1):ROI(1,2),ROI(2,1):ROI(2,2),1)));
  mycolors(i,2) = mean(mean(myImage(ROI(1,1):ROI(1,2),ROI(2,1):ROI(2,2),2)));
  mycolors(i,3) = mean(mean(myImage(ROI(1,1):ROI(1,2),ROI(2,1):ROI(2,2),3)));

  fprintf('%i / 1860\n', i)
endfor

for i=1:3
  y=0;
  z=0;
  for j=1:length(mycolors)
    y+=mycolors(j,i);
    z+=1;
  endfor
  
  mymean=y/z;
  m=0;
  
  for j=1:length(mycolors)
    m+=abs(mycolors(j,i)-avg);
  endfor
    mystd=sqrt(m/z);
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

%exctract the max values of the fast fourier transform for each color 
[red_max, red_idx] = max(abs(fftred_filtered));
red_freq = filtered_freq(red_idx);

[green_max, green_idx] = max(abs(fftgreen_filtered));
green_freq = filtered_freq(green_idx);

[blue_max, blue_idx] = max(abs(fftblue_filtered));
blue_freq = filtered_freq(blue_idx);


%plot the filtered fft against the filtered frequency
figure;
subplot(3,1,1);
plot(filtered_freq, abs(fftred_filtered));
title('red');

subplot(3,1,2);
plot(filtered_freq, abs(fftgreen_filtered));
title('green');

subplot(3,1,3);
plot(filtered_freq, abs(fftblue_filtered));
title('blue');

#Take the max value from the max of the 3 fft sets and process the heart rate
val_freq = [red_max red_freq; green_max green_freq; blue_max blue_freq];

[val_max, idx] = max(val_freq(:,1));
freq_max = val_freq(idx,2);
fprintf("BPM : %f\n", freq_max*60);