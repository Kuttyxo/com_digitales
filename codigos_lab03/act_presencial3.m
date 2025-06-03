% Parámetros de la señal FSK
f1 = 100e3;  % Frecuencia asignada al bit '0' en Hz [cite: 1]
f2 = 300e3;  % Frecuencia asignada al bit '1' en Hz [cite: 1]
Rb = 10e3;   % Tasa de bits en Hz [cite: 1]
Ac = 1;      % Amplitud de la señal portadora (asumida de GRC Signal Source Amplitude)

% Cálculo de parámetros derivados
Delta_f = abs(f2 - f1) / 2; % Desviación de frecuencia [cite: 1]
Fc = (f1 + f2) / 2;         % Frecuencia central

% Parámetros de simulación
Fs = 800e3;  % Frecuencia de muestreo (Sample Rate de GRC)
Tb = 1 / Rb; % Duración de un bit [cite: 1]

% Definir una secuencia de datos binarios representativa m(t)
% m(t) tomará valores de +1 o -1. [cite: 1]
% Simularemos para 8 períodos de bit para tener una señal representativa.
num_bits = 8;
total_time = num_bits * Tb;
num_samples = floor(Fs * total_time); % Usar floor para asegurar un número entero de muestras

% Vector de tiempo
t = 0:1/Fs:(total_time - 1/Fs);

% Crear una secuencia m(t) de ejemplo (alternando +1 y -1)
m_values = [1, -1, 1, -1, 1, -1, 1, -1]; % Un patrón simple repetitivo
m_t = zeros(size(t));

for i = 1:num_bits
    start_sample = floor((i - 1) * Tb * Fs) + 1;
    end_sample = floor(i * Tb * Fs);
    m_t(start_sample:end_sample) = m_values(i);
end

% Calcular la envolvente compleja g(t) [cite: 1]
% g(t) = Ac * exp(j * 2 * pi * m(t) * Delta_f * t) [cite: 1]
g_t = Ac * exp(1j * 2 * pi * m_t .* Delta_f .* t);

% Calcular la Transformada Rápida de Fourier (FFT) de g(t)
G_f = fft(g_t);
frequencies = Fs * (0:(num_samples/2))/num_samples; % Frecuencias positivas

% Para centrar el espectro alrededor de 0 Hz y visualizar las frecuencias negativas
G_f_shifted = fftshift(G_f);
frequencies_shifted = (-num_samples/2 : num_samples/2 - 1) * (Fs / num_samples);

% Graficar el espectro de magnitud de la envolvente compleja G(f)
figure;
plot(frequencies_shifted / 1e3, 20 * log10(abs(G_f_shifted) + 1e-10)); % Se agrega 1e-10 para evitar log(0)
title('Transformada de Fourier de la Envolvente Compleja g(t) (Espectro de Magnitud)');
xlabel('Frecuencia (kHz)');
ylabel('Magnitud (dB)');
grid on;
xlim([-2 * Delta_f / 1e3, 2 * Delta_f / 1e3]); % Enfocar en las frecuencias relevantes

% Mostrar algunos parámetros calculados
fprintf('Frecuencia f1: %.1f kHz\n', f1 / 1e3);
fprintf('Frecuencia f2: %.1f kHz\n', f2 / 1e3);
fprintf('Tasa de bits Rb: %.1f kHz\n', Rb / 1e3);
fprintf('Desviación de frecuencia Delta_f: %.1f kHz\n', Delta_f / 1e3);
fprintf('Frecuencia central Fc: %.1f kHz\n', Fc / 1e3);
fprintf('Duración de bit Tb: %.1f ms\n', Tb * 1e3);