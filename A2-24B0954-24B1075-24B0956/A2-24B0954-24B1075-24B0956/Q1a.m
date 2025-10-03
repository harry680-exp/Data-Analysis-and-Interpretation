
s_max = 100;
p_max = zeros(s_max,1);

for s = 1:s_max
    p_max(s) = 1- (1/s)^(1/s); 
end

[max_p_value,idx] = max(p_max);

disp(max_p_value);
disp(idx);

