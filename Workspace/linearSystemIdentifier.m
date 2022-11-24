function Hid = linearSystemIdentifier(u, y, t, orders)
    na = orders(1);
    nb = orders(2);
    nd = orders(3);
    Ts = t(2) - t(1);
    evalGradient = @(theta, phi, y)(-2*sum((y - theta'*phi).*phi, 2));
    evalHessian = @(phi)(2*phi*phi');
    evalCost = @(theta, phi, y)(sum((y - theta'*phi).^2));
    alpha = 1;
    alphaUpperThreshold = 100000;
    alphaBottomTreshold = 0.0000001;
    beta = 1.1;
    
    theta = 2*rand([na + 1 + nb, 1]) - 1;
    theta = [theta zeros(na + 1 + nb, 1)];

    phi = zeros(na + nb + 1, length(y));
    for i = 1:nb+1
        phi(i, (nd + i):end) = u(1:end-nd-i+1);
    end
    k = nb + 2;
    for i = 1:na
        phi(k, i + 1:end) = -y(1:end - i);
        k = k + 1;
    end

    for i = na + nb + 2:length(t)
        gradient = evalGradient(theta(:, 1), phi(:, 1:i), y(1:i)');
        gradient = gradient/norm(gradient);
        hessian = evalHessian(phi(:, 1:i));
        hessian = hessian/norm(hessian);

        theta(:, 2) = theta(:, 1) - hessian\gradient*alpha;
        cost = evalCost(theta(:, 2), phi(:, 1:i), y(1:i)');
        newAlpha = beta*alpha;
        theta(:, 2) = theta(:, 1) - hessian\gradient*newAlpha;
        newCost = evalCost(theta(:, 2), phi(:, 1:i), y(1:i)');

        if newCost < cost
            while newCost < cost && newAlpha < alphaUpperThreshold
                cost = newCost;
                newAlpha = beta*newAlpha;
                theta(:, 2) = theta(:, 1) - hessian\gradient*newAlpha;
                newCost = evalCost(theta(:, 2), phi(:, 1:i), y(1:i)');
            end
            newAlpha = newAlpha/beta;
            theta(:, 2) = theta(:, 1) - hessian\gradient*newAlpha;
        else
            newAlpha = alpha/beta;
            theta(:, 2) = theta(:, 1) - hessian\gradient*newAlpha;
            newCost = evalCost(theta(:, 2), phi(:, 1:i), y(1:i)');

            if newCost < cost 
                while newCost < cost && newAlpha > alphaBottomTreshold
                    cost = newCost;
                    newAlpha = newAlpha/beta;
                    theta(:, 2) = theta(:, 1) - hessian\gradient*newAlpha;
                    newCost = evalCost(theta(:, 2), phi(:, 1:i), y(1:i)');
                end
                newAlpha = newAlpha*beta;
                theta(:, 2) = theta(:, 1) - hessian\gradient*newAlpha;
            else
                theta(:, 2) = theta(:, 1) - hessian\gradient*alpha;
            end
        end
        theta(:, 1) = theta(:, 2);
    end

    Hid = tf(theta(1:nb+1, 1)', [1 theta(nb+2:nb+1+na, 1)'], Ts);
end