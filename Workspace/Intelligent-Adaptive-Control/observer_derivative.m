function dxi_hat = observer_derivative(xi_hat, A, B, C, G, y, H_hat)
    dxi_hat = A*xi_hat + B*H_hat + G*(y - C'*xi_hat);
end
