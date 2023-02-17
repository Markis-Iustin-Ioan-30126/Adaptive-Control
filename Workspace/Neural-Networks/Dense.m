classdef Dense < Layer
    properties
        input
        weights
        previous_weights
        biases
        previous_biases
        allow_bias
        learning_rate
        momentum
    end
    methods 
        function obj = Dense(number_of_inputs, number_of_outputs, varargin)
            p = inputParser;
            addParameter(p, 'AllowBias', true)
            addParameter(p, "LearningRate", 0.01)
            addParameter(p, "Momentum", 0)
            parse(p, varargin{:})
            
            obj.learning_rate = p.Results.LearningRate;
            obj.momentum = p.Results.Momentum;
            obj.allow_bias = p.Results.AllowBias;
            obj.weights = rands(number_of_outputs, number_of_inputs);
            obj.previous_weights = zeros(number_of_outputs, number_of_inputs);
            obj.biases = rands(number_of_outputs, 1);  
            obj.previous_biases = zeros(number_of_outputs, 1);
        end
  
        function [output, obj] = forward(obj, input)
            obj.input = input;
            output = obj.weights*input + obj.biases*obj.allow_bias;
        end
        
        function [output_gradient, obj] = backward(obj, gradient)
            current_weights = obj.weights;
            obj.weights = obj.weights - obj.learning_rate*(gradient'*obj.input') + obj.momentum*(obj.weights - obj.previous_weights);
            obj.previous_weights = current_weights;
            
            if obj.allow_bias == true
                current_biases = obj.biases;
                obj.biases = obj.biases - obj.learning_rate*gradient' + obj.momentum*(obj.biases - obj.previous_biases);
                obj.previous_biases = current_biases;
            end
            
            output_gradient = gradient*obj.weights;
        end
    end
end