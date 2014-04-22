%% Copyright (C) 2014 Colin B. Macdonald
%%
%% This file is part of Octave-Symbolic-SymPy
%%
%% Octave-Symbolic-SymPy is free software; you can redistribute
%% it and/or modify it under the terms of the GNU General Public
%% License as published by the Free Software Foundation;
%% either version 3 of the License, or (at your option) any
%% later version.
%%
%% This software is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty
%% of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
%% the GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public
%% License along with this software; see the file COPYING.
%% If not, see <http://www.gnu.org/licenses/>.

%% -*- texinfo -*-
%% @deftypefn {Function File} {@var{sol} =} solve (@var{eqn, var})
%% Symbolic solutions of equations and systems
%%
%% Examples
%% @example
%% solve(x==2*x+6, x)
%% solve(eq1, eq2, var1, var2)
%% solve(eq1,...,eqn, var1,...,varm)   % FIXME for now need m==n
%% @end example
%%
%% Output will be a cell array.  Each entry of the cell array is a
%% dictionary (well, a struct).  String representation of the things
%% you wanted to solve for (typically variables) are the keys of the
%% dict.
%%
%% Examples
%% @example
%% syms x y
%% e = 10*x == 20*y
%% d = solve(e, x)
%% d@{1@}.x          % gives 2*y
%% d = solve(e, y)
%% d@{1@}.y          % gives x/2
%%
%% d = solve(e, 2*x)
%% d@{1@}.('2*x')   % gives 4*y (and won't work on Matlab)
%% @end example
%%
%% FIXME: make it work if omitting the vars
%% @example
%% solve(eq1,...,eqm)
%% @end example
%%
%% FIXME: when there is just one variable to be solved for, the
%% output doesn't match Matlab SMT (should not be inside a cell
%% array).  Many other forms of output to consider.
%%
%% @seealso{dsolve}
%% @end deftypefn

function out = solve(varargin)

  n = nargin;
  varargin = sym(varargin);
  % FIXME: this is not right in all cases!
  eqn = varargin(1:n/2);
  vars = varargin(n/2+1:n);

  cmd = [ 'dbout(_ins)\n'  ...
          'd = sp.solve(*_ins, dict=True)\n'  ...
          'dbout(d)\n'  ...
          'return (d,)' ];
  out = python_cmd (cmd, eqn, vars);
end


%!shared x,y,e
%! syms x y
%! e = 10*x == 20*y;
%!test
%! d = solve(e, x);
%! assert (isequal (d{1}.x, 2*y))
%!test
%! d = solve(e, y);
%! assert (isequal (d{1}.y, x/2))
%!test
%! d = solve(e, 2*x);
%! s = d{1}.('2*x');
%! assert (isequal (s, 4*y))  % won't work on Matlab