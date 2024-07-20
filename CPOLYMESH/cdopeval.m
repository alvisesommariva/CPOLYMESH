
function W_n = cdopeval(deg,R1,R2,Y,zB,delta)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% Keeping in mind routine "cdop" computes a discrete orthogonal polynomial 
% basis on a  finite complex set X  with "card(X)<=n+1" where 
% orthogonalization is performed by applying twice a QR factorization with 
% unitary "Q" and square triangular factor R namely "V_n(X)=Q_1R_1", 
% "V_n(X)/R_1=Q_2R_2" following  the well-known ``twice is enough'' 
% orthogonalization rule in finite precision arithmetic, the routine 
% "cdopeval" evaluates the orthogonal basis on a target complex set "Y".
%
% The target matrix is "W_n(Y)=(V_n(Y)/R1)/R2" where the matrix operator 
% "/" is preferred to "inv" in order to automatically cope with possible 
% ill-conditioning of the triangular factors.
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% deg: interpolation degree;
% R1, R2: matrices of change of basis, w.r.t a certain shifted monomial 
%    basis (depending on zB, delta);
% Y: interpolation/least square points;
% zB, delta: center and radius of a disk approximatively containing the
%    domain.
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% W_n: a generalized Vandermonde matrix w.r.t. discrete orthogonal 
%      polynomials of degree "deg" evaluated at "Y".
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

W=cvand(Y,deg,zB,delta);
W_n=(W/R1)/R2;


