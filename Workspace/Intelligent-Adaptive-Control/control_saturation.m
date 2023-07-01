function [u_saturated, delta_u] = control_saturation(u, lower_bound, upper_bound)
   if u < lower_bound
       u_saturated = lower_bound;
   else 
       if u > upper_bound
           u_saturated = upper_bound;
       else
           u_saturated = u;
       end
   end
   
   delta_u = u - u_saturated;
end

