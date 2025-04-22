function [B] = veilingLight(b, E, beta)
%veilingLight The backscattered signal as z approches infinity
%   D. Akkaynak and T. Treibitz. A revised underwater image
% formation model. In Proc. IEEE CVPR, 2018
%
%   Outputs:
%   B: Backscatter
%   
%   Inputs:
%   b: Beam scattering coefficient
%   E: Irradiance
%   beta: Beam attenuation coefficient

B = b*E/beta;
end
