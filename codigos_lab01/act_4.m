clc;
clear;
close all;

% Parámetros generales
fm = 1000;    % Frecuencia de la señal moduladora (Hz)
fs_pam = 5000; % Frecuencia de muestreo para PAM (Hz)
fs_inst = 20000; % Frecuencia de muestreo para PAM instantáneo (Hz)
d = 0.3;      % Ciclo de trabajo (tau / T) para muestreo natural

% Definición de la señal original
Tm = 1/fm;  
t = 0:Tm/500:2*Tm;  % Mayor resolución en el tiempo
x = sin(2*pi*fm*t); % Señal sinusoidal

% Muestreo de la señal PAM Natural
Ts_pam = 1/fs_pam;    % Periodo de muestreo para PAM Natural
t_pam = 0:Ts_pam:max(t); % Instantes de muestreo
x_pam = sin(2*pi*fm*t_pam); % Valores muestreados

% Construcción de la señal PAM Natural con ancho de pulso
pam_natural = zeros(size(t));
for i = 1:length(t_pam)
    idx = find(t >= t_pam(i), 1); % Encuentra el índice más cercano
    if idx + round(d * Ts_pam / (Tm/500)) - 1 <= length(t)
        pam_natural(idx:idx + round(d * Ts_pam / (Tm/500)) - 1) = x_pam(i);
    end
end

% Muestreo de la señal PAM Instantáneo
Ts_inst = 1/fs_inst;    % Periodo de muestreo para PAM Instantáneo
t_inst = 0:Ts_inst:max(t); % Instantes de muestreo
x_inst = sin(2*pi*fm*t_inst); % Valores muestreados

% Gráfica de las tres señales
figure;
hold on;
plot(t, x, 'b', 'LineWidth', 1.5); % Señal original en azul
stairs(t, pam_natural, 'r', 'LineWidth', 1.5); % PAM natural en rojo
stem(t_inst, x_inst, 'g', 'LineWidth', 1.2); % PAM instantáneo en verde

xlabel('Tiempo (s)');
ylabel('Amplitud');
title('Señal Original, PAM Natural y PAM Instantáneo');
legend('Señal Original', 'PAM Natural', 'PAM Instantáneo');
grid on;
hold off;
