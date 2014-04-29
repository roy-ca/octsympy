%% Copyright (C) 2014 Colin B. Macdonald
%%
%% This file is part of OctSymPy
%%
%% OctSymPy is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published
%% by the Free Software Foundation; either version 3 of the License,
%% or (at your option) any later version.
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
%% @deftypefn  {Function File} {@var{y} =} all (@var{x})
%% @deftypefnx {Function File} {@var{y} =} all (@var{x}, @var{dim})
%% Return true if all entries of a symbolic vector are nonzero.
%%
%% Similar behaviour to the built-in @code{all} with regard to
%% matrices and the second argument.
%%
%% Throws an error if any entries are non-numeric.
%%
%% @seealso{any}
%% @end deftypefn

%% Author: Colin B. Macdonald
%% Keywords: symbolic

function z = all(x, varargin)

  z = double (x, false);
  if (isempty (z))
    error ('indeterminable')
  else
    z = all (z, varargin{:});
  end

end


%% Tests
%!shared a, s
%! a = [0 3; 1 2];
%! s = sym (a);
%!assert (isequal (all (s), all (a)))
%!assert (isequal (all (s,1), all (a,1)))
%!assert (isequal (all (s,2), all (a,2)))
%
%!shared a, s
%! a = [1 2 3];
%! s = sym (a);
%!assert (isequal (all (s), all (a)))
%!assert (isequal (all (s,1), all (a,1)))
%!assert (isequal (all (s,2), all (a,2)))
%
%!shared s, x
%! syms x
%! s = sym ([1 2 x]);
%!test
%! try
%!   all (s)
%!   error ('should fail with symbols')
%! catch
%! end

