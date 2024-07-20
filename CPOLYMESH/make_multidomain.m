
function domain=make_multidomain(verticesV,centerV,radiusV)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% In this routine, given "verticesV", "centerV", "radiusV", we define a 
% Matlab variable "domain" of "struct" type that contains the information 
% useful to compute an Admissible Mesh on the union of 
% 
% a) polygons with vertices "verticesV{k}" ;
% b) disks with centers "centerV(k,:)" and radii "radiusV(k)";
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% verticesV: cell of vertices (each polygon is described by vertices that 
%           are complex numbers, e.g. 
%             verticesV=[0.2111+i*0.1246
%                        1.3923+i*0.1246
%                        1.3923+i*1.4454
%                        0.2111+i*1.4454]
%           for a square).
% centerV  : matrix of centers (k-th element represent the k-th center as 
%            complex number, e.g.
%                centerV =[ 0.1378 + 0.4882i
%                           0.8367 + 0.3662i
%                           0.1386 + 0.8068i];
%           for three disks).
% radiusV  : vector of radii (k-th element represent the k-th radius)
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% domain: variable of "struct" type that contains the information useful to 
%         compute an Admissible Mesh.
%--------------------------------------------------------------------------
% REFERENCE:
%--------------------------------------------------------------------------
% http://facstaff.bloomu.edu/skokoska/curves.pdf (p.44)
%--------------------------------------------------------------------------
% AUTHORS:
%--------------------------------------------------------------------------
% Authors: D.J. Kenne, A. Sommariva, M. Vianello.
% Written: October 2023
% Modified: June 21, 2024
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
% Date: June 21, 2024
%--------------------------------------------------------------------------

LV=length(verticesV);
LR=length(radiusV);

domainV=cell(1,LV+LR);
for k=1:LV
    domainV{k}=make_polygon(verticesV{k},1);
end

for k=1:LR
    domainV{LV+k}=make_disk(centerV(k),radiusV(k));
end

% Unroll domainV.
domain={};
for k=1:length(domainV)
    domainL=domainV{k};
    domain.intervals{k}=domainL.intervals;
    domain.functions{k}=domainL.functions;
    domain.curve_types{k}=domainL.curve_types;
    domain.degrees{k}=domainL.degrees;
end
domain.name='multidomain';


