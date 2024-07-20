
function [zAM,C]=cpom(deg,m,dom_intv,dom_funct,dom_ftypes,dom_deg)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% Building AM(deg) using a mesh of degree "deg", on a complex domain.
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% deg: interpolation degree.
%
% m: AM factor.
%
% dom_intv: cells that describe the intervals of the functions defining
%     the boundary of the domain; it is a cell of 1 x 2 vectors as "[a b]"
%     but it can be just a vector (in case of just one interval).
%
% dom_funct: cells that describe the functions defining
%     the boundary of the domain; it is a cell of functions but it can be
%     just a function  (in case of just one interval of definition).
%
% dom_ftypes: cells that describe as string the type functions defining
%     the boundary of the domain; it is a cell of functions but it can be
%     just a function;
%     these strings can be
%     1. "alg" if the function is a polynomial described as vector (see how
%        "polyval" describes polynomials);
%     2. "trig" if the function is a trigonometric polynomial;
%     3. "spline" if the domain is a defined by splines. 
%
% dom_deg : cells that describe the degree of each polynomial in
%     "dom_funct", but it can be just a scalar (in case of just one
%     interval of definition).
%
% Note: in the case there is just one interval in dom_intv, one can use the
% basic structure.
%--------------------------------------------------------------------------
% EXAMPLES:
%--------------------------------------------------------------------------
% 1. cardioid
%        z(t)=cos(t)*(1-cos(t))+i*(sin(t)*(1-cos(t))),  t in [0,2*pi]
%     set
%     * dom_intv=[0 2*pi];
%     * dom_funct=@(t) cos(t)*(1-cos(t))+i*(sin(t)*(1-cos(t)));
%     * dom_ftypes='trig'.
%     * dom_deg=2;
%
% 2. polygon with 6 sides:
%        vertices=[0.1 0; 0.7 0.2; 1 0.5; 0.75 0.85; 0.5 1; 0 0.25; 0.1 0];

%     * dom_intv=[0 6]; % 6 is the number of sides
%     * dom_funct=[0.1 0; 0.7 0.2; 1 0.5; 0.75 0.85; 0.5 1; 0 0.25; 0.1 0];
%     * dom_ftypes='spline';
%     * dom_deg=[1 1 1 1 1 1]; % linear splines to define sides
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% zAM: column vector of complex numbers (elements of the AM);
% C  : AM constant over the domain.
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




% ------------------------- Troubleshooting -------------------------------

% A. case in which the whole boundary is described by a struct.
if nargin == 3
    domain=dom_intv;
    dom_intv=domain.intervals;
    dom_funct=domain.functions;
    dom_ftypes=domain.curve_types;
    dom_deg=domain.degrees;
end

% B. If inputs are not cells we convert them in cells for uniformity.
if iscell(dom_intv) == 0, dom_intv={dom_intv}; end
if iscell(dom_funct) == 0, dom_funct={dom_funct}; end
if iscell(dom_ftypes) == 0, dom_ftypes={dom_ftypes}; end
if iscell(dom_deg) == 0, dom_deg={dom_deg}; end




% ------------------- Computing AM and AM constant ------------------------

C=1/(cos(pi/(2*m)));

zAM=[];

for k=1:length(dom_intv)
    dom_intvL=dom_intv{k};
    dom_functL=dom_funct{k};
    dom_ftypesL=dom_ftypes{k};
    dom_degL=dom_deg{k};
    
    switch dom_ftypesL

        case 'alg'
            a=dom_intvL(1); b=dom_intvL(2);
            dj=dom_degL; n=deg; v=dj*n;
            z0=alg_pts(m,v,a,b);
            % A. defined as vector w.r.t. alg. basis (as polyfit coeffs)
            if isvector(dom_functL) && not(isa(dom_functL,'function_handle'))
                if size(dom_functL,1) < size(dom_functL,2)
                    dom_functL=dom_functL';
                end
                zAML=polyval(dom_functL,z0);
            else
                % B. defined as function
                zAML=feval(dom_functL,z0);
            end


        case 'trig'
            a=dom_intvL(1); b=dom_intvL(2);
            dj=dom_degL; n=deg; v=dj*n;
            z0=trig_pts(m,v,a,b);
            % A. defined as vector w.r.t. trig. basis (exp(k*t))
            if isvector(dom_functL) && not(isa(dom_functL,'function_handle'))
                if size(dom_functL,1) < size(dom_functL,2)
                    dom_functL=dom_functL';
                end
                
                V=vander_trig(dom_degL,z0);
                zAML=V*dom_functL;
            else
                % B. defined as function
                zAML=feval(dom_functL,z0);
            end

        case 'spline'
            Sx=dom_functL(1); Sy=dom_functL(2);
            [zAML,C]=complex_curvpolygon_AM(Sx,Sy,deg,m);

    end

    zAM=[zAM; zAML];

end






% ............................... ALG. PTS ................................

function z0=alg_pts(m,v,a,b)

N=m*v;

j=1:N; j=j';
u=cos((2*j-1)*pi/(2*N));
z0=(b-a)*u/2+(b+a)/2;



% .............................. TRIG. PTS ................................

function z0=trig_pts(m,v,a,b)

N=2*m*v;

j=1:N; j=j';
u=cos((2*j-1)*pi/(2*N));
z0=2*asin(u*sin((b-a)/4))+(b+a)/2;


% .............................. VANDER.TRIG ..............................

function V=vander_trig(deg,z0)

% z0: column vector (troubleshooting)
if size(z0,1) < size(z0,2), z0=z0'; end

V=exp(1i*z0*(-deg:deg));






% ........................... CURV POLYGON ................................

function [zAM,C]=complex_curvpolygon_AM(Sx,Sy,deg,m)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% Building AM(deg) using a mesh of degree "deg", on a complex curvilinear
% polygon.
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% Sx,Sy: parametric spline representation as Sx(t)+i*Sy(t).
% deg: AM degree
% m: AM factor (deg*m+1 points for each side)
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% zAM: Admissible mesh points
% C  : Norming set factor.
%--------------------------------------------------------------------------
% DATES:
%--------------------------------------------------------------------------
% Written on October 18, 2023.
% Author: Alvise Sommariva
%--------------------------------------------------------------------------

if nargin < 2, m=2; end

% ....................... AM over parametric splines ......................

L=length(Sx);
C=[]; % AM constant
zAM=[]; % AM over spline curvilinear domain

for ii=1:L

    SxL=Sx(ii);
    SyL=Sy(ii);

    SxL_breaks=SxL.breaks;

    Nbreaks=length(SxL_breaks);

    for kk=1:Nbreaks-1

        t0=SxL_breaks(kk); t1=SxL_breaks(kk+1);

        % reference points on segment
        deg_poly=max([SxL.order SxL.order])-1;
        mAM=ceil(m*deg*deg_poly);
        k=1:mAM; ptsR=0.5*(1+cos((2*k-1)*pi/(2*mAM)));

        % build AM over arc
        tt=t0+(t1-t0)*ptsR';
        xx=ppval(SxL,tt); yy=ppval(SyL,tt);
        zz=xx+1i*yy;
        zAM=[zAM; zz];

        % AM constant arc.
        C(end+1)=1/cos(deg*pi/(2*mAM));

    end

end

C=max(C);

