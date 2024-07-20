
function domain=make_sun(n_rays,length_rays,disk_radius)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% In this routine, given "rays", we define a Matlab variable "domain"
% of "struct" type that contains the information useful to compute an
% Admissible Mesh on a "sun-like domain", given by the union of the
% unit-disk with "n_rays" equispaced rays of length "length_rays".
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% n_rays,length_rays,disk_radius: parameters defining the domain, given by 
% the union of the disk with radius "disk_radius" and "n_rays" equispaced 
% rays of length "length_rays".
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% domain: variable of "struct" type that contains the information useful to
%         compute an Admissible Mesh.
%--------------------------------------------------------------------------
% REFERENCE:
%--------------------------------------------------------------------------
% >> https://www.math.unipd.it/~marcov/pdf/cleb.pdf
%--------------------------------------------------------------------------
% AUTHORS:
%--------------------------------------------------------------------------
% Authors: D.J. Kenne, A. Sommariva, M. Vianello.
% Written: October 2023
% Modified: June 20, 2024
%--------------------------------------------------------------------------
% THANKS TO:
%--------------------------------------------------------------------------
% Leokadia Biales-Ciez for her help in developing this work.
%--------------------------------------------------------------------------
% LICENSE
%--------------------------------------------------------------------------
% Copyright (C) 2024- D.-J.Kenne, A.Sommariva, M. Vianello.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
%
% Authors:
% D.J. Kenne <dimitri.kenne@doctoral.uj.edu.pl>
% Alvise Sommariva <alvise@math.unipd.it>
% Marco Vianello   <marcov@math.unipd.it>
%
% Date: June 20, 2024
%--------------------------------------------------------------------------

if nargin < 1, n_rays=4; end
if nargin < 2, length_rays=1; end
if nargin < 3, disk_radius=1; end

% Main code
domain.intervals={[0 2*pi]};
domain.functions={@(t) disk_radius*exp(1i*t)};
domain.curve_types={'trig'};
domain.degrees={1};
for k=1:n_rays
    init_angle=k*(2*pi)/n_rays;
    domain.intervals{end+1}=length_rays*[0 1];
    domain.functions{end+1}=@(t) exp(1i*init_angle)*(disk_radius+t);
    domain.curve_types{end+1}='alg';
    domain.degrees{end+1}=1;
end

if disk_radius > 0
domain.name='sun';
else
    domain.name='spikes';
end
