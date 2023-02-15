classdef (Abstract) Layer
    methods (Abstract)
        output = forward(input)
        output = backward(input, learning_rate)
    end
end