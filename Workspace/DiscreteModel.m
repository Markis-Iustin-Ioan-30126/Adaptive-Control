classdef DiscreteModel
    properties
        u
        y
        num
        den
    end
    
    methods
        function obj = DiscreteModel(num, den)
            obj.num = num;
            obj.den = den;
            obj.u = zeros(length(num), 1);
            obj.y = zeros(length(den), 1);
        end
        
        function [obj, res] = forward(obj, u)
            if length(obj.u) > 1
                for j = length(obj.u):-1:2
                    obj.u(j) = obj.u(j - 1);
                end
                obj.u(1) = u;
            else
                obj.u = u;
            end
            
            res = (obj.num)*(obj.u) - (obj.den)*(obj.y);
                
            if length(obj.y) > 1
                for j = length(obj.y):2
                    obj.y(j) = obj.y(j - 1);
                end
                obj.y(1) = res;
            else
                obj.y = res;
            end
        end
    end
end