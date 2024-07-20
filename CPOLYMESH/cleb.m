
function leb = cleb(deg,X,Z,zB,delta)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% Computes on a control set "Z" the maximum of the Lebesgue function of
% interpolation on a set "X" with "card(X)=n+1" or least-squares with
% "card(X)>n+1", as
%    ∥λ_n∥_Z = ||Wn(Z)Q_2^H||_inf=|| V_n(Z)/R_1)/R_2) Q_2^H \|_inf
% by a call to "cdop" on "X" and to "cdopeval" with "Y = Z". 
% Next, choosing "Z = Z_n^m" produced by a call to "cpom" one gets the 
% certified interval estimate for the Lebesgue constant of "X".
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


% Troubleshooting.
if nargin < 5, [zB,delta]=disk_enclosing_region(Z); end

% Main code.

[Q,R1,R2]=cdop(deg,X,zB,delta);
DOP = cdopeval(deg,R1,R2,Z,zB,delta);

leb=norm(Q*DOP',1);
