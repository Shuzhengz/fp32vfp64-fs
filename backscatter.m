function [B] = backscatter(b, E, beta, z, e)
%backscatter The backscattered signal
%   D. Akkaynak and T. Treibitz. A revised underwater image
% formation model. In Proc. IEEE CVPR, 2018
%
%   Outputs:
%   B: The backscatter Signal
%   
%   Inputs:
%   b: Beam scattering coefficient
%   E: Irradiance
%   beta: Beam attenuation coefficient
%   z: Range along LOS
%   e: Constant e

B = (b*E/beta) * (1 - e^(-beta*z));
end
