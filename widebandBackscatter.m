function [b] = widebandBackscatter(b, E, beta, z, e)
%widebandBackscatter Wideband backscatter coefficient
%   D. Akkaynak and T. Treibitz. A revised underwater image
% formation model. In Proc. IEEE CVPR, 2018
%
%   Outputs:
%   B: The wideband backscatter coefficient
%   
%   Inputs:
%   b: Beam scattering coefficient
%   E: Irradiance
%   beta: Beam attenuation coefficient
%   z: Range along LOS
%   e: Constant e

b = -log( 1 - (backscatter(b, E, beta, z, e) ./ veilingLight(b, E, beta))) ./ z;

end
