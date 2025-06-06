% Código MATLAB para graficar la Transformada de Fourier de la Envolvente Compleja (Espectro de la Modulante OOK)

% --- Parámetros ---
R = 1000;       % Tasa de bits (Hz) - Frecuencia de la onda cuadrada
Fs = 100000;    % Frecuencia de muestreo (Hz). Debe ser mucho mayor que R.
Duration = 0.05; % Duración de la simulación en segundos.


% --- Generación de la Señal Modulante (Onda Cuadrada Unipolar 0 a 1) ---
t = 0:1/Fs:(Duration - 1/Fs); % Vector de tiempo
% Generar onda cuadrada bipolar (-1 a 1) con frecuencia R
square_wave_bipolar = square(2*pi*R*t);
% Convertir a unipolar (0 a 1): (señal + 1) / 2
m_t = (square_wave_bipolar + 1) / 2; % Esta es la señal modulante m(t), proporcional a g(t)

% --- Cálculo de la Transformada de Fourier ---
N_fft = length(m_t); % Número de puntos para el FFT.
M_f_unshifted = fft(m_t); % Calcula la FFT de la señal modulante

% --- Cálculo del Vector de Frecuencia ---
f_unshifted = (0:(N_fft-1))*(Fs/N_fft); % Vector de frecuencia de 0 a Fs

% --- Centrar el Espectro en 0 Hz ---
M_f = fftshift(M_f_unshifted); % Centra el componente DC en el medio
f = fftshift(f_unshifted);       % Centra el vector de frecuencia correspondiente

% --- Corregir el rango del vector de frecuencia ---
% fftshift reordena de [0, Fs/2, -Fs/2, 0), necesitamos que sea [-Fs/2, Fs/2)
f(f > Fs/2) = f(f > Fs/2) - Fs; % Ajusta la parte positiva

% --- Graficar la Magnitud del Espectro ---
figure;
plot(f, abs(M_f)); % Grafica la magnitud del espectro vs frecuencia
title('Magnitud del Espectro de la Envolvente Compleja |G(f)|');
xlabel('Frecuencia (Hz)');
ylabel('Magnitud');
grid on;
% Opcional: Limitar el eje x para ver mejor los lóbulos principales
xlim([-5*R, 5*R]); % Muestra desde -5*R hasta +5*R Hz

% Opcional: Si quieres graficar la señal en el tiempo para verificarla
% figure;
% plot(t, m_t);
% title('Señal Modulante (Onda Cuadrada 0 a 1) en el Tiempo');
% xlabel('Tiempo (s)');
% ylabel('Amplitud');
% grid on;
% ylim([-0.2, 1.2]); % Ajustar límites para ver 0 y 1 claramente