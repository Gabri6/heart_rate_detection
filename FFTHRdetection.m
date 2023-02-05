data = dlmread('results.txt')



x = data(:,1);
y = data(:,2);
z = data(:,3);

X = fft(x);
Y = fft(y);
Z = fft(z);

N = length(x);

fs = 14;
f = (0:N-1)*fs/N;


f_min = 0.5;
f_max = 4;
idx_min = find(f >= f_min, 1);
idx_max = find(f <= f_max, 1, 'last');
f_filtered = f(idx_min:idx_max);
X_filtered = X(idx_min:idx_max);
Y_filtered = Y(idx_min:idx_max);
Z_filtered = Z(idx_min:idx_max);


[X_max, X_idx] = max(abs(X_filtered));
X_freq = f_filtered(X_idx);

[Y_max, Y_idx] = max(abs(Y_filtered));
Y_freq = f_filtered(Y_idx);

[Z_max, Z_idx] = max(abs(Z_filtered));
Z_freq = f_filtered(Z_idx);


figure;
subplot(3,1,1);
plot(f_filtered, abs(X_filtered));
xlabel('Fréquence (Hz)');
ylabel('Amplitude X');
title('Spectre de fréquence filtré X');

subplot(3,1,2);
plot(f_filtered, abs(Y_filtered));
xlabel('Fréquence (Hz)');
ylabel('Amplitude Y');
title('Spectre de fréquence filtré Y');

subplot(3,1,3);
plot(f_filtered, abs(Z_filtered));
xlabel('Fréquence (Hz)');
ylabel('Amplitude Z');
title('Spectre de fréquence filtré Z');



##fprintf("X: Valeur max = %f, Fréquence associée = %f Hz\n", X_max, X_freq);
##fprintf("Y: Valeur max = %f, Fréquence associée = %f Hz\n", Y_max, Y_freq);
##fprintf("Z: Valeur max = %f, Fréquence associée = %f Hz\n", Z_max, Z_freq);

val_freq = [X_max X_freq; Y_max Y_freq; Z_max Z_freq];

[val_max, idx] = max(val_freq(:,1));
freq_max = val_freq(idx,2);
fprintf("BPM : %f\n", freq_max*60);