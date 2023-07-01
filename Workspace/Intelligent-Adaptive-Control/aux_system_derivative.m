function dzeta = aux_system_derivative(zeta, delta_u, K, h)
    dzeta = K*zeta + h*delta_u;
end
