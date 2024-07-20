
function domain=make_butterflysautereau

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% In this routine, given "a", we define a Matlab variable "domain" of
% "struct" type that contains the information useful to compute an
% Admissible Mesh on the butterfly of Sautereau
%
%                    (sin(5*t)+3*cos(t))*exp(it)
%
% with "t" in "[0,2*pi]".
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% no input
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% domain: variable of "struct" type that contains the information useful to
%         compute an Admissible Mesh.
%--------------------------------------------------------------------------
% REFERENCE:
%--------------------------------------------------------------------------
% https://mathcurve.com/courbes2d/ornementales/ornementales.shtml
% https://it.wiktionary.org/wiki/...
% Appendice:Glossario_sulle_curve_matematiche#Cuore_(curve_a_forma_di)
%--------------------------------------------------------------------------
% AUTHORS:
%--------------------------------------------------------------------------
% Authors: D.J. Kenne, A. Sommariva, M. Vianello.
% Written: October 2023
% Modified: June 10, 2024
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
% Date: June 10, 2024
%--------------------------------------------------------------------------

% Troubleshooting.

% Main code

domain.intervals=[0 2*pi];
domain.functions=@(t) (-3*cos(2*t)+sin(7*t)-1).*exp(1i*t);
domain.curve_types='trig';
domain.degrees=8;
domain.name='butterfly';
