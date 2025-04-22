function [L] = rte(L0, Lstar, beta, Kd, z, theta, e)
%RTE The Radiance Transfer Equation
%   D. Akkaynak and T. Treibitz. A revised underwater image
% formation model. In Proc. IEEE CVPR, 2018
%   
%   The RTE for a homogeneous, source free water body

%   Outputs: 
%   L: total radiance reaching the diver
% 
%   Inputs:
%   L0: Total radiance leaving the object
%   Lstar: The path function describing radiance gained
%   beta: Beam attenuation coefficient
%   Kd: Diffuse downwelling attenuation coefficient
%   z: Range along LOS
%   theta: Angle measured from nadir direction
%   e: Constant e

L = L0 * e^(-beta*z) + (Lstar*e^(-Kd*z*cos(theta))/(beta-Kd*cos(theta)))...
    * (1 - e^(-(beta-Kd*cos(theta)*z)));
end
