function h = vertcat(varargin)

  cmd = [ '_proc = []\n'  ...
          'for i in _ins:\n'  ...
          '    if i.is_Matrix:\n'  ...
          '        _proc.append(i)\n'  ...
          '    else:\n'  ...
          '        _proc.append(sp.Matrix([[i]]))\n'  ...
          'M = sp.Matrix.vstack(*_proc)\n'  ...
          'return (M,)' ];

  varargin = sym(varargin);
  h = python_cmd (cmd, varargin{:});
