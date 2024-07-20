
function V=cvand(pts,deg,zB,delta)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% Computation of a generalised Vandermonde matrix (fighting ill condition),
% i.e. monomial basis of degree "deg", centered in zB and with radius 
% "delta", that is the (k+1) column is given by "(pts-zB)^k/delta".
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% pts: pointset of complex numbers;
% zB, delta: center and radius of a small disk containing the domain.
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% V: generalised Vandermonde matrix.
%--------------------------------------------------------------------------
% AUTHORS:
%--------------------------------------------------------------------------
% Authors: D.J. Kenne, A. Sommariva, M. Vianello.
% Written: October 2023
% Modified: May 30, 2024
%--------------------------------------------------------------------------
% THANKS TO:
%--------------------------------------------------------------------------
% Leokadia Biales-Ciez for her help in developing this work.
%--------------------------------------------------------------------------
% LICENSE
%--------------------------------------------------------------------------
% Copyright (C) 2023- D.-J.Kenne, A.Sommariva, M. Vianello.
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
% Date: May 30, 2024
%--------------------------------------------------------------------------

if nargin < 3, zB=0; end
if nargin < 4, delta=1; end

% Shifted monomial basis (w.r.t. the complex disk with center zB and radius
% delta).

pts_sh=(pts-zB)/delta;

% Vandermonde matrix at "pts_sh" (dims: points x polynomial dim)
V=zeros(size(pts_sh,1),deg+1);
for k=1:deg+1
    V(:,k)=pts_sh.^(k-1); 
end

