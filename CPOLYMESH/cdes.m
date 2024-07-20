
function [pts,zAM]=cdes(zAM,leja,deg,zB,delta)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% This routine gives one of three interpolation pointsets corresponding to
% a greedy maximization of the Vandermonde determinant modulus on the
% polynomial mesh "zAM".
%
% 1. AFP Approximate Fekete Points:
% After a call to "cdop" with "X=zAM" to get a better conditioned matrix,
% AFP are obtained by a "QR" factorization with column pivoting of the
% adjoint "Q_2^H", taking the points in "zAM" corresponding to the first
% "n+1" elements of the column permutation vector.
% They do not form a sequence, but typically have the lowest Lebesgue
% constant among the three sets.
%
% 2. DLP Discrete Leja Points:
% Again after a call to "cdop" with "X=zAM", DLP are obtained by a "LU"
% factorization with row pivoting of "Q_2", taking the points in "zAM"
% corresponding to the first "n+1" elements of the row  permutation vector.
% They form a sequence and in the present univariate complex instance are
% substantially equivalent to the iteration
%    "xi(j)=argmax_{z\in zAM}{\prod_{k=1}^{j-1}{|z-\xi_k|}}",
%    "j=2,\dots,n+1",
% after choosing "\xi_1" as the point that maximizes the element modulus in
% the first column of "Q_2".
%
% 2. PLP Pseudo Leja Points: these are a sequence obtained by the iteration
%   "xi(j)=argmax_{z\in Z(j-1)^m}{\prod_{k=1}^{j-1}{|z-\xi_k|}}",
%    "j=2,\dots,n+1",
% after choosing the first point "xi_{1}" arbitrarily, e.g. "\xi_{1}" is
% one of the points in "Z_1^m" with larger imaginary component.
%--------------------------------------------------------------------------
% INPUT:
%--------------------------------------------------------------------------
% zAM: if 'leja' is '0' or '1', i.e. it is required to extract AFEK or DLP
%       then it is an admissible mesh at degree "deg", while if 'leja' is
%       '2', i.e. it is required to extract PLP, then it is a cell of AM in
%       which zAM{k} is an AM for degree "k".
%      more generally, respecting the cases, it must be a vector or cell
%      of points unisolvent at degree "deg" (or up to degree "deg" for PLP)
%      from which one intends to extract points.
%
% leja: 0: AFEK, 1: DLP, 2: PLP;
%
% deg: interpolation degree;
%
% zB,delta: center and radius of a disk approximatively "well" enclosing
%      the domain (not mandatory but useful).
%--------------------------------------------------------------------------
% OUTPUT:
%--------------------------------------------------------------------------
% pts: interpolation pointset for this domain at degree "deg";
% zAM: admissible mesh for this domain at degree "deg";
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


% 1. Define defaults.
if iscell(zAM) == 0, zAM={zAM}; end
if nargin < 2, leja=0; end
if nargin < 3, deg=5; end
if nargin < 5, [zB,delta]=disk_enclosing_region(zAM{end}); end

% 2. Compute pointset.

switch leja

    case {0,1}

        % 0: approximate Fekete points, 1: discrete Leja points
        % Determine disk "B(zB,zR)" including the domain.
        % If degree is low, than we have only a rough approximation of
        % the disk "B(zB,zR)".

        zAM=zAM{1};
        V=cvand(zAM,deg,zB,delta);
        [~,R1]=qr(V,0);[Q,~]=qr(V/R1,0);

        dim=deg+1;

        if leja == 0 % Approximate Fekete Points

            w=Q'\ones(dim,1);
            ind=abs(w)>0;
            pts=zAM(ind,:);

        else % Discrete Leja points

            [~,~,perm]=lu(Q,'vector');
            pts=zAM(perm(1:dim),:);

        end

    case {2}

        pts_trial=zAM{1};
        [~,index]=max(imag(pts_trial));
        pts=zeros(deg+1,1);
        pts(1)=pts_trial(index);
        for degL=1:deg

            pts_trial=zAM{degL};
            pts_L=choose_next_point(pts,pts_trial);
            pts(degL+1,1)=pts_L;

        end

end




function pt=choose_next_point(pts,pts_trial)

%--------------------------------------------------------------------------
% OBJECT:
%--------------------------------------------------------------------------
% Computing next Pseudo Leja Point "pt" from a previous set "pts" using
% points in "pts_trial".
%--------------------------------------------------------------------------

prods=ones(size(pts_trial));
for k=1:length(pts)
    z_minus_zk=pts_trial-pts(k);
    prods=prods.*z_minus_zk;
end

[~,ind]=max(abs(prods));
pt=pts_trial(ind);








