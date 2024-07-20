
function domain=make_polygon(vertices,degree)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% In this routine, given "a" and "b", we define
% a Matlab variable "domain" of "struct" type that contains the
% information useful to compute an Admissible Mesh on Hypocycloid.
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% vertices: column vector of at least N > 3 complex numbers or
%           alternatively a matrix N x 2, where the k-th vertex P is
%           represented as
%
%                      P=vertices(k,1)+i*vertices(k,2)
%
% degree  : if "degree=1" then we define a "linear" polygon otherwise a
%           curvilinear one of that degree (parametric splines with
%           "periodic" conditions).
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% domain: variable of "struct" type that contains the information useful to
%         compute an Admissible Mesh.
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


% ------------------------- Troubleshooting -------------------------------

if nargin < 2, degree=1; end

% Trouble shooting, so that vertices will be a N x 2 matrix.
dims=size(vertices);
if dims(1) < dims(2), vertices=vertices'; dims=dims([2 1]); end
if dims(2) == 1
    x=real(vertices); y=imag(vertices);
    vertices=[x y];
end
if norm(vertices(1,:)-vertices(end,1)) > 0
    vertices(end+1,:)=vertices(1,:);
end


% ------------------------- Main code -------------------------------

% At this stage the vector "vertices" is an N x 2 matrix where the first
% and last row are equal (first and last row cohincide).
s=1:size(vertices,1);
x=vertices(:,1); y=vertices(:,2);
spline_order=degree+1;
spline_type='periodic';

[ppx,ppy]=compute_parametric_spline(s,x,y,spline_order,...
    spline_type);

domain.intervals=s;
domain.functions=[ppx,ppy];
domain.curve_types='spline';
domain.degrees=degree;
if degree == 1
    if size(vertices,1) > 4
        domain.name='polygon';
    else
        domain.name='simplex';
    end
else
    domain.name='CurvilinearPolygon';
end













% .............................. SPLINE ...................................

function [ppx,ppy]=compute_parametric_spline(s,x,y,spline_order,...
    spline_type)

%..........................................................................
% Object:
%
% Compute parametric spline relavant parameters "ppx", "ppy" so that a
% point at the boundary of the  domain has coordinates (x(s),y(s))
%
% Input:
% s: parameter data.
% x: determine spline x(s) interpolating (s,x)
% y: determine spline y(s) interpolating (s,y)
% spline_order: spline order (i.e. degree + 1)
% spline_type: string with the spline type i.e.
%             'complete'   : match endslopes (as given in VALCONDS, with
%                     default as under *default*).
%             'not-a-knot' : make spline C^3 across first and last interior
%                     break (ignoring VALCONDS if given).
%             'periodic'   : match first and second derivatives at first
%                     data point with those at last data point (ignoring
%                     VALCONDS if given).
%             'second'     : match end second derivatives (as given in
%                    VALCONDS, with default [0 0], i.e., as in variational).
%             'variational': set end second derivatives equal to zero
%                     (ignoring VALCONDS if given).
%     If "spline_type" is not declared or equal to "[]", we use 'periodic'.
%
% Output:
% ppx: spline x(t) data
% ppy: spline y(t) data
%..........................................................................

% ................ troubleshooting ................

% Detting default as periodic cubic spline in case "spline_parms" is not
% declared.
if nargin < 5
    spline_type = 'periodic';
end

if isempty(spline_type)
    spline_type = 'periodic';
end


% ................ splines definition ................

% fprintf('\n \t order %3.0f: ',spline_order);
% tic;
switch spline_order
    case 4

        % Cubic splines: using "csape".
        ppx=csape(s,x,spline_type); ppy=csape(s,y,spline_type);

    otherwise

        % Non cubic splines: using "spapi".
        ppx=spapi(spline_order,s,x); ppy=spapi(spline_order,s,y);

end
% toc;

%..........................................................................
% Note:
%..........................................................................
% The routine "spapi" gives splines in "B-"form while "csape" in "pp"form.
% We brutally normalise them so to be in "pp" form, to simplify further
% code.
%
% The two forms are not equal, but provide "close" function (relative error
%  close to machine precision).
%
% This normalisation is requested to save all splines components as vector.
%..........................................................................

% fprintf('\n \t Changing form: ');
% tic;
if strcmp(ppx.form,'B-')
    ppx=fn2fm(ppx,'pp'); ppy=fn2fm(ppy,'pp');
end



