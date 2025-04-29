function [Ic] = imgForm(b, E, beta, z, e, Jc)
%IMGFORM Revised underwater image formation model from:
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
%   Jc: RGB image with unattenuated signal
%   
%   For simplicity of testing, we assume that wideband attenuation 
%   coefficient derived from the direct transmission (D) equals to the
%   one derived from backscatter (Bc)

wbBackscatter = -widebandBackscatter(b, E, beta, z, e);
Ic = Jc .* e .^(-wbBackscatter .* z) + ...
    backscatter(b, E, beta, -wbBackscatter .* z , e);

end

