
function [zC,delta]=disk_enclosing_region(zAM)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% It computes the center "zC" and the radius "zR" of a disk B(zC,delta)
% approximatively containing the domain.
%
% This routine is useful for defining a generalised Vandermonde matrix, 
% suitable for the domain in analysis.
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% zAM: admissible mesh (AM), sufficiently dense. The denser the AM the 
% better the enclosing.
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% zC,delta: center and radius of a disk approximatively containing the
% domain.
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


zC=mean(zAM);
delta=max(abs(zAM-zC));


