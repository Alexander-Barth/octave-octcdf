## Copyright (C) 2009 Alexander Barth <a.barth@ulg.ac.be>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Loadable Function} {@var{fillvalue} = } ncfillvalue(@var{ncvar})
## @deftypefnx {Loadable Function} ncfillvalue(@var{ncvar},@var{fillvalue})
## returns or sets the fillvalue of the NetCDF variable ncvar
## 
## @seealso{netcdf}

## Author: Alexander Barth <a.barth@ulg.ac.be>

function varargout = ncfillvalue(varargin);

varargout = {};

if nargin == 1
  ncvar = varargin{1};
  varargout{1} = ncvar.FillValue_;
elseif nargin == 1
  ncvar = varargin{1};
  fv = varargin{2};
  
  ncvar.FillValue_ = fv;  
else
  error('ncfillvalue: wrong number of arguments');
end

