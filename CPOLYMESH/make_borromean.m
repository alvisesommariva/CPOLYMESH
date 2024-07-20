
function domain=make_borromean(ndisks)


%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% In this routine, given "n", we define a Matlab variable "domain" of
% "struct" type that contains the information useful to compute an
% Admissible Mesh on a borromean ring.
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% ndisks: number of disks making the borromean curve.
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% domain: variable of "struct" type that contains the information useful to
%         compute an Admissible Mesh.
%--------------------------------------------------------------------------
% REFERENCE:
%--------------------------------------------------------------------------
% https://en.wikipedia.org/wiki/Borromean_rings
%--------------------------------------------------------------------------
% AUTHORS:
%--------------------------------------------------------------------------
% Authors: D.J. Kenne, A. Sommariva, M. Vianello;
% Written: October 2023;
% Modified: June 1, 2024.
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
% Date: June 26, 2024
%--------------------------------------------------------------------------

% Troubleshooting

if nargin < 1, ndisks=3; end

% Main code

domain.intervals={};
domain.functions={};
domain.curve_types={};
domain.degrees={};

th=2*pi/ndisks;
th0=(pi-th)/2;

for k=1:ndisks
    domain.intervals{end+1}=[0 2*pi];
    thL=th0+(k-1)*th;
    domain.functions{end+1}=@(t) sqrt(3)*exp(1i*t)+(cos(thL)+1i*sin(thL));
    domain.curve_types{end+1}='trig';
    domain.degrees{end+1}=1;
end



domain.name='BorromeanCurve';
