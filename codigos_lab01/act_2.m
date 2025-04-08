clc;
clear;
close all;

% Parámetros
fm = 100000;    % Frecuencia de muestreo de la señal original (Hz)
tm = 1/fm;      % Periodo de muestreo
ls = 200;       % Número de muestras
f_c = 1000;     % Frecuencia de la señal moduladora (Hz)

% Vector de tiempo
t = (0:ls-1) * tm;

% Señal moduladora (sinusoidal)
m_t = sin(2 * pi * f_c * t);

% Parámetros de muestreo PAM
fs = 5000;      % Frecuencia de muestreo PAM (Hz)
ts = 1/fs;      % Periodo de muestreo PAM
tau = 0.5 * ts; % Duración del pulso (mitad del periodo)
duty_cycle = tau / ts; % Ciclo de trabajo

% Muestreo PAM (natural)
samples_idx = 1:round(ts/tm):length(t); % Índices de muestreo
pam_signal = zeros(size(m_t));

for i = 1:length(samples_idx)
    idx = samples_idx(i);
    if idx + round(duty_cycle * ts / tm) - 1 <= length(m_t)
        pam_signal(idx:idx + round(duty_cycle * ts / tm) - 1) = m_t(idx);
    end
end

% Gráfica (solo la línea roja de PAM)
figure;
stairs(t, pam_signal, 'r', 'LineWidth', 1.5); % PAM en rojo
xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Modulación PAM con Muestreo Natural');
grid on;
