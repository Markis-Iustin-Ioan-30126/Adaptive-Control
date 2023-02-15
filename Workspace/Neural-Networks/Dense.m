classdef Dense < Layer
    properties
        input
        weights
        biases
    end
    methods 
        function obj = Dense(number_of_inputs, number_of_outputs)
            obj.weights = normrnd(0, 1, number_of_outputs, number_of_inputs);
            obj.biases = normrnd(0, 1, number_of_outputs, 1);         
        end
  
        function [output, obj] = forward(obj, input)
            obj.input = input;
            output = obj.weights*input + obj.biases;
        end
        
        function [output_gradient, obj] = backward(obj, gradient, learning_rate)
            obj.weights = obj.weights - learning_rate*(gradient'*obj.input');
            obj.biases = obj.biases - learning_rate*gradient';
            output_gradient = gradient*obj.weights;
        end
    end
end