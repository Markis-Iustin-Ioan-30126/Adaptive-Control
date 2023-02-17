function [spab, t] = SPAB_GEN(N, i, j, Te, alpha, numberOfPeriods)
    % SPAB signal generator
    % INPUTS: 
    % N = shift register size
    % i, j = xor bits
    % Te = sampling time
    % alpha = coefiecient to enlarge the shift register output
    % numberOfPeriods = how many sequences of the shift register to output
    % OUTPUTS:
    % spab = generated spab signal
    % t = simulation time
    
    register = ones(1, N*numberOfPeriods);
    spab = zeros(1, (2^N - 1)*alpha*numberOfPeriods);
    t = 0:Te:((2^N - 1)*alpha*Te)*numberOfPeriods - Te;
    m = 1;
    
    for k = 1:(2^N - 1)*numberOfPeriods
        spab(m:m + alpha - 1) = register(end)*ones(1, alpha);
        m = m + alpha;
        aux = xor(register(i), register(j));
        register = [aux register(1:N - 1)];
    end
end