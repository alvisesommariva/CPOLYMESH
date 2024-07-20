# CPOLYMESH
Matlab/Octave version of CPOLYMESH (computation of certified Lebesgue constants on complex sets).

The Matlab package includes two demos, that we briefly comment.

demo_cdes_1: by this routine we show
• how to define the complex domain (several ways),

• compute an admissible mesh (AM) of a fixed degree,

• extract extremal sets,

• compute a certified Lebesgue constant.

demo_cdes_2: by this routine we perform all batteries of numerical tests that are described above.
In particular, varying the degrees, we

• compute an admissible mesh (AM) of a fixed degree;

• extract the AFP, DLP, PLP extremal sets;

• for each of them we compute a certified Lebesgue constant;

• plot Lebesgue contants, domain and extremal points.

Changing the value of the variable domain_type, from 1 to 22, one can test our routines also on other complex geometries, as hypocycloids, epicycloids, epitrochoids, limacons, rhodoneas, eggs, bifoliums, Talbot curves, tricuspoids, torpedos, ellipses and heart-shaped domain.

For a full description of the software, see the paper:

Dimitri J. Kenne, Alvise Sommariva and Marco Vianello, CPOLYMESH: Matlab and Python codes for complex polynomial approximation by Chebyshev admissible meshes

All the codes work also in Octave. The only note is that to analyse curvilinear domains it is
necessary to have installed the spline toolbox (see https://gnu-octave.github.io/packages).

Observe that there is also a Python version whose author is Dimitri J. Kenne, available at https://github.com/DimitriKenne/CPOLYMESH.

(current update: July 20, 2024)
