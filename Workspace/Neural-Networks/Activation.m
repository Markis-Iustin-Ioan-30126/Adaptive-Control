classdef Activation < Layer
    properties
        input
        activation
        activation_derivative
    end
    
    methods
        function obj = Activation(activation, activation_derivative)
            obj.activation = activation;
            obj.activation_derivative = activation_derivative;
        end
        
        function [output, obj] = forward(obj, input)
            obj.input = input;
            output = obj.activation(input);
        end
        
        function [output_gradient, obj] = backward(obj, gradient)
            output_gradient = gradient.*obj.activation_derivative(obj.input)';
        end
    end
end