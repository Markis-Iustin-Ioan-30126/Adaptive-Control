function newTheta = AAP(theta, phi, y, alpha, beta, alphaUpperThreshold, alphaBottomTreshold)
    % optimizer utility functions
    evalGradient = @(theta, phi, y)(-sum((y - theta'*phi).*phi, 2));
    evalHessian = @(phi)(phi*phi');
    evalCost = @(theta, phi, y)((1/2)*sum((y - theta'*phi).^2));

    gradient = evalGradient(theta(:, 1), phi, y');
    if norm(gradient) ~= 0 
        gradient = gradient/norm(gradient);
        if rank(phi*phi') == length(phi*phi')
            hessian = evalHessian(phi);
            hessian = hessian/norm(hessian);
            optimizerDirection = hessian\gradient;
        else
            optimizerDirection = gradient;
        end
       
        theta(:, 2) = theta(:, 1) - optimizerDirection*alpha;
        cost = evalCost(theta(:, 2), phi, y');
        newAlpha = beta*alpha;
        theta(:, 2) = theta(:, 1) - optimizerDirection*newAlpha;
        newCost = evalCost(theta(:, 2), phi, y');
        
        if newCost < cost
            while newCost < cost && newAlpha < alphaUpperThreshold
                cost = newCost;
                newAlpha = beta*newAlpha;
                theta(:, 2) = theta(:, 1) - optimizerDirection*newAlpha;
                newCost = evalCost(theta(:, 2), phi, y');
            end
            newAlpha = newAlpha/beta;
            theta(:, 2) = theta(:, 1) - optimizerDirection*newAlpha;
        else
            newAlpha = alpha/beta;
            theta(:, 2) = theta(:, 1) - optimizerDirection*newAlpha;
            newCost = evalCost(theta(:, 2), phi, y');
            
            if newCost < cost 
                while newCost < cost && newAlpha > alphaBottomTreshold
                    cost = newCost;
                    newAlpha = newAlpha/beta;
                    theta(:, 2) = theta(:, 1) - optimizerDirection*newAlpha;
                    newCost = evalCost(theta(:, 2), phi, y');
                end
                newAlpha = newAlpha*beta;
                theta(:, 2) = theta(:, 1) - optimizerDirection*newAlpha;
            else
                theta(:, 2) = theta(:, 1) - optimizerDirection*alpha;
            end
        end
        theta(:, 1) = theta(:, 2);
    end
    newTheta = theta;
end

