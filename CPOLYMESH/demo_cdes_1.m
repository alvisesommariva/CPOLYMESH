
function demo_cdes_1(example)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% In this demo we show how to
%
% A. define the complex domain (several ways);
% B. compute an admissible mesh (AM) of a fixed degree;
% C. extract extremal set:
%    AFEK: Approximate Fekete Points;
%    DLP : Discrete Leja Points;
%    PLP : Pseudo Leja Points.
% D. compute a certified Lebesgue constant.
%
% The purpose of this routine is to show how to extract extremal pointsets,
% good for interpolation, and compute their Lebesgue constant.
%--------------------------------------------------------------------------
% NOTE FOR OCTAVE USERS:
%--------------------------------------------------------------------------
% This code runs also in Octave.
%
% Example 3 requires the "spline toolbox" installed since the code makes 
% use of the routine "csape".
%--------------------------------------------------------------------------
% AUTHORS:
%--------------------------------------------------------------------------
% Authors: D.J. Kenne, A. Sommariva, M. Vianello.
% Written: October 2023
% Modified: July 20, 2024
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


if nargin < 1, example=6; end
warning off;

deg=20;
m_ep=2;   % AM factor (from which points are extracted)
m_leb=4;  % AM factor (from determining Lebesgue constant)

switch example

    case 0

        %----------------------------------------------------
        % Least-squares over a disk and computation of its
        % Lebesgue constant.
        % The AM definition is obtained by struct.
        %----------------------------------------------------
        leja=1; % 0: AFEK, 1: DLP.

        domain=make_disk(0,1);

        % note; for PLP one has to compute AM of increasing degree,
        %       storing them in cells "zAM".

        zAM_ep=cpom(deg,m_ep,domain);
        pointset=zAM_ep;
        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb);



    case 1

        %----------------------------------------------------
        % AFEK or DLP over a complex polynomial arc.
        % The AM definition is obtained by "struct" variable
        % "domain".
        %----------------------------------------------------

        leja=1; % 0: AFEK, 1: DLP.

        domain.intervals=[0 3];
        domain.functions=@(z) (2*1i)*z.^2+(3+5*1i)*z+(1+2*1i);
        domain.curve_types='alg';
        domain.degrees=2;

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 2

        %----------------------------------------------------
        % Pseudo Leja Points (PLP) over a cardioid
        % The AM definition is obtained by scalar variables
        % "dom_intv", "dom_funct", "dom_ftypes", "dom_deg".
        %----------------------------------------------------
        leja=2; % 0: AFEK, 1: DLP. 2: PLP

        dom_intv=[0 2*pi];
        dom_funct=@(t) cos(t).*(1-cos(t))+1i*(sin(t).*(1-cos(t)));
        dom_ftypes='trig';
        dom_deg=2;

        % note; for PLP one has to compute AM of increasing degree,
        %       storing them in cells "zAM".
        zAM_ep=cell(1,deg);
        for degL=1:deg
            zAM_ep{degL}=cpom(degL,m_ep,dom_intv,dom_funct,dom_ftypes,dom_deg);
        end

        pointset=cdes(zAM_ep,leja,deg);

        % AM leb.const.
        [zAM_leb,C]=cpom(deg,m_leb,dom_intv,dom_funct,dom_ftypes,dom_deg); 
        leb = cleb(deg,pointset,zAM_leb);

    case 3

        %----------------------------------------------------
        % AFEK or DLP over a curvilinear polygon.
        % The AM definition is obtained by using "make_polygon".
        %----------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        vertices= [0 0; 1 0; 1 1; 0 0];
        deg_spline=3; % For linear polygon set "deg_spline=1".
        domain=make_polygon(vertices,deg_spline);


        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 4

        %----------------------------------------------------
        % AFEK or DLP over a deltoid.
        % The AM definition is obtained by struct.
        %----------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        domain.intervals=[0 2*pi];
        domain.functions=@(t) 2*cos(t)+cos(2*t)+1i*( 2*sin(t)-sin(2*t) );
        domain.curve_types='trig';
        domain.degrees=2;


        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 5

        %------------------------------------------------------------------
        % AFEK or DLP over a hypocycloid
        % z(t)=((a-b)*cos(t)+b*cos((a-b)*t/b)+i*((a-b)*sin(t)-
        %      b*sin((a-b)*t/b));
        % a,b: parameters defining the hypocycloid, with a/b natural number.
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        a=4; b=1;
        domain=make_hypocycloid(a,b);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 6


        %------------------------------------------------------------------
        % AFEK or DLP over a epicycloid
        % r,R: parameters defining the epicycloid, with r < R, R multiple
        %      of r.
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        R=4; r=1; domain=make_epicycloid(r,R);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 7

        %------------------------------------------------------------------
        % AFEK or DLP over a epitrochoid
        % r,R: parameters defining the epitrochoid, with r < R, R multiple
        %      of r.
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        R=3; r=1; d=1/2; domain=make_epitrochoid(r,R,d);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 8

        %------------------------------------------------------------------
        % AFEK or DLP over a limacon;
        % a, b: parameters defining the domain; for avoiding
        %      auto-intersections choose "b <= a";
        %      A. the domain is convex if "a >= 2*b",
        %      B: concave if "b <= a < 2*b";
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        a=7; b=5; domain=make_limacon(a,b);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 9

        %------------------------------------------------------------------
        % AFEK or DLP over a deltoid;
        % a: parameter defining the domain;
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        a=5; domain=make_deltoid(a);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.



    case 10

        %------------------------------------------------------------------
        % AFEK or DLP over a rhodonea;
        % a,k: parameters defining the domain;
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        a=5; k=2; domain=make_rhodonea(a,k);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.


    case 11

        %------------------------------------------------------------------
        % AFEK or DLP over an "egg";
        % a,n: parameters defining the domain;
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        a=1; n=2; domain=make_egg(a,n);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 12

        %------------------------------------------------------------------
        % AFEK or DLP over an "bifolium";
        % a: parameter defining the domain;
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        a=2; domain=make_bifolium(a);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 13

        %------------------------------------------------------------------
        % AFEK or DLP over an "Talbot curve";
        % a,b,f: parameters defining the domain;
        %------------------------------------------------------------------
        leja=1; % 0: AFP, 1. DLP.

        a=2; b=3; f=8; domain=make_talbot(a,b,f);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 14

        %------------------------------------------------------------------
        % AFEK or DLP over an "tricuspoid";
        % a,b,f: parameters defining the domain;
        %------------------------------------------------------------------
        leja=1; % 0: AFP, 1. DLP.

        a=2; domain=make_tricuspoid(a);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.


    case 15

        %------------------------------------------------------------------
        % AFEK or DLP over a "torpedo";
        % a,b,f: parameters defining the domain;
        %------------------------------------------------------------------
        leja=0; % 0: AFP, 1. DLP.

        a=1; domain=make_torpedo(a);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.

        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 16

        %------------------------------------------------------------------
        % AFEK or DLP over an "ellipse";
        % a,b: parameters defining the domain;
        %------------------------------------------------------------------

        leja=0; % 0: AFP, 1. DLP.

        a=1; b=10; domain=make_ellipse(a,b);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 17

        %------------------------------------------------------------------
        % AFEK or DLP over an "La Porte curve";
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        domain=make_laporte;

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    case 18

        %------------------------------------------------------------------
        % AFEK or DLP over an "butterfly of Sautereau";
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        domain=make_butterflysautereau;

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.

    otherwise

        %------------------------------------------------------------------
        % AFEK or DLP over a "nephroid";
        %------------------------------------------------------------------

        leja=1; % 0: AFP, 1. DLP.

        a=2; domain=make_nephroid(a);

        zAM_ep=cpom(deg,m_ep,domain); % AM ext. pts.
        pointset=cdes(zAM_ep,leja,deg); % Extremal points

        [zAM_leb,C]=cpom(deg,m_leb,domain); % AM leb.const.
        leb = cleb(deg,pointset,zAM_leb); % Lebesgue constant.


end


% Display results

fprintf('\n \t -----------------------------------------');
fprintf('\n \t -> Demo on extremal points');
fprintf('\n \t -----------------------------------------');
fprintf('\n \t * AM degree            : %-4.0f',deg);
fprintf('\n \t * AM factor ext.pts.   : %-4.0f',m_ep);
fprintf('\n \t * AM cardinality e.p.  : %-6.0f',length(zAM_ep));
fprintf('\n \t * Ext. points card.    : %-4.0f',length(pointset));
fprintf('\n \t * AM factor Leb.const. : %-4.0f',m_ep);
fprintf('\n \t * AM cardinality l.c.  : %-6.0f',length(zAM_leb));
fprintf('\n \t * AM coefficient       : %-5.5f ',max(C));
fprintf('\n \t * Leb. const. bounds   : [%-1.3f,%-1.3f] ',leb,C*leb);
fprintf('\n \t * Leb. const. approx   : %-1.3f',(1+C)*leb/2);
fprintf('\n \t -----------------------------------------');
fprintf('\n \t -> Figure ');
fprintf('\n \t -----------------------------------------');
fprintf('\n \t * Green dots  : Admissible mesh');

switch leja
    case 0
        fprintf('\n \t * Magenta dots: Approximate Fekete Points');
    case 1
        fprintf('\n \t * Magenta dots: Discrete Leja Points ');
    case 2
        fprintf('\n \t * Magenta dots: Pseudo Leja Points ');
end

fprintf('\n \t -----------------------------------------\n');


% Plotting domain

figure(1);
clear_figure(1);
axis equal;

plot(real(zAM_leb),imag(zAM_leb),'ko','LineWidth',1,...
    'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',2);

hold on;
plot(real(pointset),imag(pointset),'mo','LineWidth',1,...
    'MarkerEdgeColor','k','MarkerFaceColor','m','MarkerSize',8);
hold off;






function clear_figure(nfig)

h=figure(nfig);
f_nfig=ishandle(h)&&strcmp(get(h,'type'),'figure');
if f_nfig
    clf(nfig);
end


