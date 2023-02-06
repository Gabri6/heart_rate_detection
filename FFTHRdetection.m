#extract the data under the form of a matrix
data = dlmread('results.txt')


#separate the 3 sets of data (colonnes)
r = data(:,1);
g = data(:,2);
b = data(:,3);
#do the fast fourrier transform on each set
fftR = fft(r);
fftG = fft(g);
fftB = fft(b);
#find frequency from frame rate
N = length(r);

fr = 14;
f = (0:N-1)*fr/N;

#cut the desired range of values
f_min = 0.5;
f_max = 4;
idx_min = find(f >= f_min, 1);
idx_max = find(f <= f_max, 1, 'last');
f_filtered = f(idx_min:idx_max);
fftR_filtered = fftR(idx_min:idx_max);
fftG_filtered = fftG(idx_min:idx_max);
fftB_filtered = fftB(idx_min:idx_max);

#extract the max values for each sets and their corresponding frequency
[R_max, R_idx] = max(abs(fftR_filtered));
R_freq = f_filtered(R_idx);

[G_max, G_idx] = max(abs(fftG_filtered));
G_freq = f_filtered(G_idx);

[B_max, B_idx] = max(abs(fftB_filtered));
B_freq = f_filtered(B_idx);

#Plot just to visualize
figure;
subplot(3,1,1);
plot(f_filtered, abs(fftR_filtered));
xlabel('Frequency (Hz)');
ylabel('POWER');
title('frequency spectrum for component 1');

subplot(3,1,2);
plot(f_filtered, abs(fftG_filtered));
xlabel('Frequency (Hz)');
ylabel('POWER');
title('frequency spectrum for component 2');

subplot(3,1,3);
plot(f_filtered, abs(fftB_filtered));
xlabel('Frequency (Hz)');
ylabel('POWER');
title('frequency spectrum for component 3');


#Take the max value from the max of the 3 fft sets and process the heart rate
val_freq = [R_max R_freq; G_max G_freq; B_max B_freq];

[val_max, idx] = max(val_freq(:,1));
freq_max = val_freq(idx,2);
fprintf("BPM : %f\n", freq_max*60);