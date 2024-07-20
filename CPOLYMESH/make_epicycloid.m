
function domain=make_epicycloid(r,R)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% In this routine, given "r" and "R", we define 
% a Matlab variable "domain" of "struct" type that contains the 
% information useful to compute an Admissible Mesh on the epicycloid:
%
%    (R+r)*cos(t)-r*cos((R+r)*t/r)+i*((R+r)*sin(t)-r*sin((R+r)*t/r))
%
% with "t" in "[0,2*pi]".
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% r,R: parameters defining the epicycloid, with r < R, R multiple of r, 
%     (R+r)*cos(t)-r*cos((R+r)*t/r)+i*((R+r)*sin(t)-r*sin((R+r)*t/r))
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% domain: variable of "struct" type that contains the information useful to 
%         compute an Admissible Mesh.
%--------------------------------------------------------------------------
% REFERENCE:
%--------------------------------------------------------------------------
% https://en.wikipedia.org/wiki/Epicycloid
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
% Date: June 1, 2024
%--------------------------------------------------------------------------

% Troubleshooting.

if ceil(R/r) > R/r
    error('In defining the domain R must be a multiple of r'); 
end
if R < r, error('In defining the domain, choose R >= r'); end

% Main code

domain.intervals=[0 2*pi];
domain.functions=@(t) (R+r)*cos(t)-r*cos((R+r)*t/r)+...
    1i*((R+r)*sin(t)-r*sin((R+r)*t/r));
domain.curve_types='trig';
domain.degrees=max(1,(R+r)/r);
domain.name='epicycloid';
