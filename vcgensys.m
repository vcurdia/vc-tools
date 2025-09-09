function REE=vcgensys(eq,varargin)

% vcgensys
%
% Allows use of alternative versions of gensys. Uses structures for input and output.
%
% mapping to original gensys input notation:
%   eq.Gamma0   = Gamma0
%   eq.Gamma1   = Gamma1
%   eq.GammaBar = Const
%   eq.Gamma2   = Psi
%   eq.Gamma3   = Pi
%
% mapping to original output notation
%   REE.G1   = G1
%   REE.GBar = C
%   REE.G2   = impact
%   REE.fmat = fmat
%   REE.fwt  = fwt
%   REE.ywt  = ywt
%   REE.gev  = gev
%   REE.eu   = eu
%
% Option: Author (string)
% If set to 'CS' (default) it uses the original verion. If set to 'JW' it uses
% the fast gensys from Jae Won and if it does not yield a normal solution it
% runs the original gensys.
%
% ..............................................................................
% 
% Created: February 14, 2011 by Vasco Curdia
% Copyright 2011-2025 by Vasco Curdia


% Default options
op.FID = 1;
op.Verbose = 0;
op.FastGensys = 0;
op.Div = [];
op.NumPrecision = [];
op.UsePinv = 0;
op = updateoptions(op,varargin{:});

%% set fid
fid = op.FID;


%% Run Gensys
REE.GBar = [];
REE.G1 = [];
REE.G2 = [];
REE.eu = [0;0];
if op.FastGensys
    [REE.G1,REE.GBar,REE.G2,REE.fmat,REE.fwt,REE.ywt,REE.gev,REE.eu] = ...
        fastgensysJaeWonvb(eq.Gamma0,eq.Gamma1,eq.GammaBar,eq.Gamma2,eq.Gamma3,...
                           op.FID,op.Verbose,op.Div,op.NumPrecision,op.UsePinv);
end
if ~op.FastGensys || ~all(REE.eu(:)==1)
    [REE.G1,REE.GBar,REE.G2,REE.fmat,REE.fwt,REE.ywt,REE.gev,REE.eu] = ...
        gensysvb(eq.Gamma0,eq.Gamma1,eq.GammaBar,eq.Gamma2,eq.Gamma3,...
                 op.FID,op.Verbose,op.Div,op.NumPrecision,op.UsePinv);
end
if ~all(REE.eu==1) && op.Verbose
    fprintf(fid,'Warning: REE solution not normal.\n');
end
