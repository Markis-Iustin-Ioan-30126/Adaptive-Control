classdef LinearDiscreteModel   
    properties (Access = private)
        theta 
        phi
        nd
        na
        buffer
    end
    
    methods 
        function obj = LinearDiscreteModel(num ,den, nd)
            obj.theta = [den(2:end) num]';
            if den(1) ~= 1
                obj.theta = obj.theta/den(1);
            end
            obj.phi = zeros(length(obj.theta), 1);
            obj.nd = nd;
            obj.na = length(den(2:end));
            obj.buffer = zeros(nd, 1);
        end
        
        function [obj, output] = forward(obj, input)
            if obj.nd ~= 0
                obj.phi(obj.na + 1:end) = [obj.buffer(end); obj.phi(obj.na + 1:end - 1)];
                obj.buffer = [input; obj.buffer(1:end - 1)];
            else
                obj.phi(obj.na + 1:end) = [input; obj.phi(obj.na + 1:end - 1)];
            end
            
            output = obj.theta'*obj.phi;
            
            obj.phi(1:obj.na) = [-output; obj.phi(1:obj.na - 1)];
        end
        
        function obj = changeParameters(obj, num, den)
            obj.theta = [den(2:end) num]';
            if den(1) ~= 1
                obj.theta = obj.theta/den(1);
            end
        end
        
        function [obj, parameters] = getParameters(obj)
            parameters = obj.theta;
        end
    end
end

