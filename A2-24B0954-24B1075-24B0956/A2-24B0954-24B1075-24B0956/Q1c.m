n = 1000;
p_values = [1e-4, 5e-4, 0.001, 0.005, 0.01, 0.02, 0.05, 0.08, 0.1, 0.2];

T_a = zeros(size(p_values));
T_b = zeros(size(p_values));

for i = 1:length(p_values)
    p = p_values(i);
    
    
    s_cont = 1/sqrt(p);
    T_a(i) = n/s_cont + n*(1-(1-p)^round(s_cont));
    
   
    T_b(i) = exp(1)*n*p*log(n*(1-p)/(exp(1)*n*p)) + n*p + exp(1)*n*p;
end

figure;
plot(p_values, T_a, '-o', 'LineWidth', 1.5, 'Color',[0 0.4470 0.7410]);
hold on;
plot(p_values, T_b, '-s', 'LineWidth', 1.5, 'Color',[0.8500 0.3250 0.0980]);
xlabel('Disease prevalence p');
ylabel('Expected number of tests');
legend('Method (a): Non-overlapping', 'Method (b): Overlapping');
title('Expected Tests vs Disease Prevalence (n=1000)');
grid on;
