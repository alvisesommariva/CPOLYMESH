
function demo_cdes_2(domain_type)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% In this demo we show how to
%
% A. define the complex domain (several ways);
% B. varying the degrees:
%    a. compute an admissible mesh (AM) of a fixed degree;
%    b. extract extremal sets:
%    AFP: Approximate Fekete Points;
%    DLP : Discrete Leja Points;
%    PLP : Pseudo Leja Points;
%    c. compute a certified Lebesgue constant.
% C. plot Lebesgue contants and domain.
%
% The purpose of this routine is to show how to extract extremal pointsets,
% good for interpolation, and compute their Lebesgue constant. Differently
% from "demo_cdes_1", this demo illustrates easily batteries of tests to
% show on each domain the performance of several extremal points, varying
% the degree.
%--------------------------------------------------------------------------
% NOTE FOR OCTAVE USERS:
%--------------------------------------------------------------------------
% This code runs also in Octave.
%
% Examples 9 and 10 require the "spline toolbox" installed since the code
% makes use of the routine "csape".
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% The variable domain can range from 1 to 22 and defines a specific domain
% as follows:
%
% * case 1: cardioid
% * case 2: laporte heart
% * case 3: deltoid
% * case 4: sun
% * case 5: butterfly of Sautereau
% * case 6: multidomain
% * case 7: borromean
% * case 8: simplex
% * case 9: spikes
% case 10: polygon
% case 11: hypocycloid
% case 12: epicycloid
% case 13: epitrochoid
% case 14: limacon
% case 15: rhodonea
% case 16: egg
% case 17: bifolium
% case 18: talbot curve
% case 19: tricuspoid
% case 20: torpedo
% case 21: ellipse
% case 22: heart
%
% default: example 1 (cardioid).
%
% note: the cases with "*" are used as illustration in the paper:
% "CPOLYMESH: Matlab and Python codes for complex polynomial approximation
% by Chebyshev admissible meshes".
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
% Date: June 26, 2024
%--------------------------------------------------------------------------

% ............................. SETTINGS ..................................

% Select your example to define a domain.
if nargin < 1, domain_type=1; end
warning off;

degV=1:20; % Degrees for which the Lebesgue constant is asked
lejaV=0:3; % Extremal sets: 0: AFP, 1: DLP, 2: PLP 3: LS at AM
m_ep=2;    % AM parameter extremal points.
m_leb=4;   % AM parameter Lebesgue points.



switch domain_type

    case 1
        a=1; domain=make_cardioid(a);
    case 2
        domain=make_laporte;
    case 3
        a=5; domain=make_deltoid(a);
    case 4
        n_rays=4; length_rays=0.5; domain=make_sun(n_rays,length_rays);
    case 5
        domain=make_butterflysautereau;
    case 6
        verticesV={
            [0.2111+1i*0.1246; 1.3923+1i*0.1246;...
            1.3923+1i*1.4454; 0.2111+1i*1.4454];

            [-0.8524-1i*0.1512; 0.8502-1i*0.1512;...
            0.8502+1i*0.5306; -0.8524+1i*0.5306];

            [0.2150+1i*0.3562; 0.7781+1i*0.3562; ...
            0.7781+1i*1.9183; 0.2150+1i*1.9183]
            };
        centerV =[ 0.1378 + 0.4882i; 0.8367 + 0.3662i; 0.1386 + 0.8068i];
        radiusV =[0.9638; 0.8896; 1.0770];
        domain=make_multidomain(verticesV,centerV,radiusV);
    case 7
        domain=make_borromean(3);
    case 8
        n_rays=4; length_rays=1; disk_radius=0;
        domain=make_sun(n_rays,length_rays,disk_radius);
    case 9
        th=[pi/2; pi/2+2*pi/3; pi/2+4*pi/3];
        vertices=cos(th)+1i*sin(th);
        degree=1;
        domain=make_polygon(vertices,degree);
    case 10
        vertices=(1/4)*[1 0; 3 2; 3 0; 4 2; 3 3; 3 0.85*4; 2 4; ...
            0 3; 1 2];
        domain=make_polygon(vertices,3);
    case 11
        a=5; b=1; domain=make_hypocycloid(a,b);
    case 12
        R=4; r=1; domain=make_epicycloid(r,R);
    case 13
        R=3; r=1; d=1/2; domain=make_epitrochoid(r,R,d);
    case 14
        a=7; b=5; domain=make_limacon(a,b);
    case 15
        a=5; k=2; domain=make_rhodonea(a,k);
    case 16
        a=1; n=2; domain=make_egg(a,n);
    case 17
        a=2; domain=make_bifolium(a);
    case 18
        a=2; b=3; f=8; domain=make_talbot(a,b,f);
    case 19
        a=2; domain=make_tricuspoid(a);
    case 20
        a=1; domain=make_torpedo(a);
    case 21
        a=2; b=10; domain=make_ellipse(a,b);
    case 22
        domain=make_heart;

end

% .......................... BATTERY OF TESTS .............................

lebV=zeros(length(degV),length(lejaV));
CV=zeros(length(degV),length(lejaV));

% pointsetV is a cell of cells, whose k-th cell contains a cell of all
% the pointsets of extremal points determined by "lejaV(k)".
pointsetV=cell(1,length(lejaV));

for lejak=1:length(lejaV)
    leja=lejaV(lejak);
    pointsetL=cell(1,length(degV));
    for degk=1:length(degV)

        deg=degV(degk);

        switch leja
            case {0,1}
                zAM=cpom(deg,m_ep,domain); % AM
                pointset=cdes(zAM,leja,deg); % Extremal points
            case 2
                zAM=cell(1,deg);
                for k=1:deg
                    zAM{k}=cpom(k,m_ep,domain); % AM;
                end
                pointset=cdes(zAM,leja,deg); % Extremal points
            case 3
                zAM=cpom(deg,m_ep,domain); % AM
                pointset=zAM;
        end

        [zAMleb,C]=cpom(deg,m_leb,domain); % AM

        lebV(degk,lejak) = cleb(deg,pointset,zAMleb); % Lebesgue constant.
        CV(degk,lejak)=C;
        pointsetL{degk}=pointset;

    end
    pointsetV{lejak}=pointsetL;
end


% .............................. MAKE TABLES ..............................


A=[degV' lebV];


% Making table. We do not use "table" since it is not an Octave command.

str='Deg ';
for k=1:length(lejaV)
    lejaL=lejaV(k);
    switch lejaL
        case 0
            str_add='AFP ';
        case 1
            str_add='DLP ';
        case 2
            str_add='PLP ';
        case 3
            str_add='LSAM';
    end
    str=[str,'     ',str_add,'   ',];
end

fprintf('\n \t'); disp(str);
for ii=1:size(A,1)
    fprintf('\n \t %2d  %1.4e  %1.4e  %1.4e  %1.4e',...
        A(ii,1),A(ii,2),A(ii,3),A(ii,4),A(ii,5))
end
fprintf('\n \n');










% .............................. PLOT RESULTS .............................

% ..... A. Lebesgue constants plot


clear_figure(1); figure(1);

grid on;

hold on;

legend_str=cell(1,length(lejaV));

for lejak=1:length(lejaV)

    ylim([0 20]); % in case you want to set limits to plot.

    semilogy(degV',lebV(:,lejak),'LineWidth',2);

    leja=lejaV(lejak);
    switch leja
        case 0
            legend_str{lejak}='AFP';
        case 1
            legend_str{lejak}='DLP';
        case 2
            legend_str{lejak}='PLP';
        case 3
            legend_str{lejak}='LS';
    end
end

legend(legend_str, 'Interpreter', 'none','Location','northwest');



% ..... B. Last AM computed of the domain in analysis.

for k=1:length(lejaV)

    clear_figure(k+1); figure(k+1);
    axis equal;
    axis off;
    pbaspect([2 2 2])

    hold on

    plot_domain(domain);

    plot(real(zAMleb),imag(zAMleb),'g.','LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','k',...
        'MarkerSize',2)

    ext_pts=pointsetV{k}; ext_pts=ext_pts{end};
    plot(real(ext_pts),imag(ext_pts),'mo',...
        'MarkerEdgeColor','m',...
        'MarkerFaceColor','m',...
        'MarkerSize',5)


end





function clear_figure(nfig)

h=figure(nfig);
f_nfig=ishandle(h)&&strcmp(get(h,'type'),'figure');
if f_nfig
    clf(nfig);
end



