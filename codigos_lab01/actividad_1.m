% Actividad 1: Generar una señal sinusoidal
A = 1;               % Amplitud de la señal
fc = 1000;           % Frecuencia de la señal (Hz)
ts = 1/100000;      % Intervalo de muestreo (10 µs)
t = 0:ts:0.01;      % Tiempo de simulación (10 ms)

% Generar señal sinusoidal
m_t = A * sin(2 * pi * fc * t);

% Gráfico de la señal original
figure;
plot(t, m_t, 'b', 'LineWidth', 1.5);
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Señal sinusoidal original');
grid on;


% Actividad 2: Muestreo natural (PAM con tren de pulsos)
fs = 8000;          % Frecuencia de muestreo (Hz)
Ts = 1/fs;          % Período de muestreo
d = 0.5;            % Ciclo de trabajo (50%)

% Generar tren de pulsos para muestreo natural
pulsos = (mod(t, Ts) < (d * Ts));
muestra_natural = m_t .* pulsos;

% Gráfico de la señal con muestreo natural
figure;
plot(t, m_t, 'b', 'LineWidth', 1.5); hold on;
stem(t, muestra_natural, 'r', 'Marker', 'none');
hold off;
legend('Señal original', 'PAM muestreo natural');
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Modulación PAM con muestreo natural');
grid on;


% Actividad 3: Muestreo instantáneo
% Generar instantes de muestreo
t_muestreo = 0:Ts:0.01;
muestra_instantanea = A * sin(2 * pi * fc * t_muestreo);

% Gráfico de la señal con muestreo instantáneo
figure;
stem(t_muestreo, muestra_instantanea, 'g', 'Marker', 'o');
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Modulación PAM con muestreo instantáneo');
grid on;


% Actividad 4: Comparación de señales originales y muestreadas
figure;
plot(t, m_t, 'b', 'LineWidth', 1.5); hold on;
stem(t, muestra_natural, 'r', 'Marker', 'none');
stem(t_muestreo, muestra_instantanea, 'g', 'Marker', 'o');
hold off;
legend('Señal original', 'PAM muestreo natural', 'PAM muestreo instantáneo');
xlabel('Tiempo (s)'); ylabel('Amplitud');
title('Comparación de señales: Original, PAM Natural e Instantáneo');
grid on;


% Actividad 5: Transformada de Fourier de las señales
NFFT = 2^nextpow2(length(t)); % Tamaño de FFT
f = linspace(0, fs/2, NFFT/2); % Escala de frecuencias positivas

% FFT de la señal original
M_f = abs(fft(m_t, NFFT)/length(t));

% FFT de la señal PAM con muestreo natural
M_nat_f = abs(fft(muestra_natural, NFFT)/length(t));

% FFT de la señal PAM con muestreo instantáneo
t_muestreo_padded = [t_muestreo, zeros(1, length(t) - length(t_muestreo))];
muestra_instantanea_padded = [muestra_instantanea, zeros(1, length(t) - length(t_muestreo))];
M_inst_f = abs(fft(muestra_instantanea_padded, NFFT)/length(t));

% Graficar transformadas
figure;
plot(f, M_f(1:NFFT/2), 'b', 'LineWidth', 1.5); hold on;
plot(f, M_nat_f(1:NFFT/2), 'r', 'LineWidth', 1.5);
plot(f, M_inst_f(1:NFFT/2), 'g', 'LineWidth', 1.5);
hold off;
legend('FFT Señal original', 'FFT PAM muestreo natural', 'FFT PAM muestreo instantáneo');
xlabel('Frecuencia (Hz)'); ylabel('Magnitud');
title('Espectros de frecuencia de las señales');
grid on;
