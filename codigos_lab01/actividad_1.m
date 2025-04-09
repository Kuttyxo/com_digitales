% Transformada de Fourier
L = length(t);  
L_pam = length(t_pam);
L_inst = length(t_inst);

X_f = fft(x)/L;
X_pam_f = fft(pam_natural)/L_pam;
X_inst_f = fft(x_inst)/L_inst;

% Eje de frecuencias
f = (0:L/2-1)*(fs_pam/L);  
f_pam = (0:L_pam/2-1)*(fs_pam/L_pam);
f_inst = (0:L_inst/2-1)*(fs_inst/L_inst);

% Magnitud del espectro
X_f = abs(X_f(1:L/2));
X_pam_f = abs(X_pam_f(1:L_pam/2));
X_inst_f = abs(X_inst_f(1:L_inst/2));

% Subgráfico de espectros
nexttile;
hold on;
plot(f, X_f, 'b', 'LineWidth', 1.5);
plot(f_pam, X_pam_f, 'r', 'LineWidth', 1.5);
plot(f_inst, X_inst_f, 'g', 'LineWidth', 1.5);
title('Espectros de Fourier');
xlabel('Frecuencia (Hz)'); ylabel('Magnitud');
legend('Señal Original', 'PAM Natural', 'PAM Instantáneo');
grid on;
hold off;
