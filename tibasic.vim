" File generated using script from commit hash dbde9fd39622f9d9bd4d7c44a979542031adf029
" File generated at 2023-11-04 00:37:51 UTC
"
" TI-BASIC syntax file using TI8X series tokens
"
" Source: https://github.com/Arian04/vim-tibasic-syntax

" quit if a syntax file was already loaded
if exists("b:current_syntax")
	finish
endif

" Numbers
syn match   tiNumber		"\<\d\+\>"
syn match   tiNumber		"\<\d\+\>\.\<\d\+\>"

" Comments
syn region  tiComment		start="#\s*" end="$"

" Strings TODO: understand this syntax
syn region  tiString		start=+"+ skip=+\\\\\|\\"+ end=+"+ 

" case sensitive matches
syn case match

syn keyword tiFinanceVars 	PMT FV PV N I%

syn keyword tiPicVars 	Pic5 Pic8 Pic6 Pic0 Pic3 Pic9 Pic1 Pic4 Pic2 Pic7
syn keyword tiColors 	GREEN NAVY BLUE LTBLUE BROWN BLACK WHITE MAGENTA YELLOW DARKGRAY RED LTGRAY
syn keyword tiColors 	ORANGE MEDGRAY
syn keyword tiConstants 	Sigma rho tau theta lambda sigma alpha Phi chi delta mu greek_pi Omega
syn keyword tiConstants 	pi Delta epsilon gamma phat
syn keyword tiSequentialVars 	v(n-2) v(n-1) u(n) u(n+1) u(n-2) v(n+1) u(n-1) w(n-1) v(n) w(n+1) w(n)
syn keyword tiStrings 	Str1 Str0 Str9 Str3 Str5 Str6 Str4 Str8 Str2 Str7
syn match tiPipeVars '|C/Y'
syn match tiPipeVars '\[|e\]'
syn match tiPipeVars '\[|d\]'
syn match tiPipeVars '|E'
syn match tiPipeVars '|u'
syn match tiPipeVars '|<'
syn match tiPipeVars '|F'
syn match tiPipeVars '|?'
syn match tiPipeVars '\[|a\]'
syn match tiPipeVars '|!'
syn match tiPipeVars '|P/Y'
syn match tiPipeVars '<|'
syn match tiPipeVars '|w'
syn match tiPipeVars '|>'
syn match tiPipeVars '\[|c\]'
syn match tiPipeVars '|\~'
syn match tiPipeVars '|N'
syn match tiPipeVars '\[|F\]'
syn match tiPipeVars '|\''
syn match tiPipeVars '|:'
syn match tiPipeVars '\[|b\]'
syn match tiPipeVars '|v'
syn match tiPipeVars '|'
syn keyword tiLetters 	Q Y S T G F K B I Z J P W L U O C A D R X H V M E
syn keyword tiLoop 	While For( Repeat
syn keyword tiGraphDatabases 	GDB7 GDB3 GDB5 GDB0 GDB1 GDB6 GDB2 GDB8 GDB9 GDB4
syn keyword tiDigits 	6 7 1 5 0 2 3 8 4 9
syn match tiParametricVars '{X3T}'
syn match tiParametricVars '{Y5T}'
syn match tiParametricVars '{X4T}'
syn match tiParametricVars '{Y3T}'
syn match tiParametricVars '{Y6T}'
syn match tiParametricVars '{Y1T}'
syn match tiParametricVars '{Y4T}'
syn match tiParametricVars '{X6T}'
syn match tiParametricVars '{X2T}'
syn match tiParametricVars '{Y2T}'
syn match tiParametricVars '{X5T}'
syn match tiParametricVars '{X1T}'
syn match tiPolarVars '{r5}'
syn match tiPolarVars '{r6}'
syn match tiPolarVars '{r1}'
syn match tiPolarVars '{r2}'
syn match tiPolarVars '{r4}'
syn match tiPolarVars '{r3}'
syn keyword tiTrigFunctions 	tan tanh sinh cosh^-1 cosh sin tan^-1 cos cos^-1 sin^-1 sinh^-1 tanh^-1
syn keyword tiVariables 	[Sigmax] [minY] [maxX] [Sigmaxy] [x3] [n2] [y1] [x1] [Sx2] [F] [DEC] [xhat2]
syn keyword tiVariables 	[R^2] [Sigmay^2] [y2] [upper] [p] [z] [r^2] [n1] [y3] [AUTO] [minX] [Sx]
syn keyword tiVariables 	[Un/d] [phat2] [Sxp] [Sigmay] [A] [J] [sigmax] [G] [H] [Sy] [xhat] [e]
syn keyword tiVariables 	[Sigmax^2] [Sx1] [phat] [C] [n] [errorMS] [factorMS] [sigmay] [D] [MATHPRINT]
syn keyword tiVariables 	[factorSS] [i] [x2] [xhat1] [I] [CLASSIC] [errorSS] [B] [df] [phat1] [factordf]
syn keyword tiVariables 	[Med] [yhat] [n/d] [maxY] [FRAC] [lower] [E] [s] [RegEQ] [recursiven]
syn keyword tiImageVars 	Image5 Image8 Image0 Image7 Image2 Image6 Image9 Image1 Image4 Image3

syn match tiYVars '{Y9}'
syn match tiYVars '{Y6}'
syn match tiYVars '{Y2}'
syn match tiYVars '{Y4}'
syn match tiYVars '{Y1}'
syn match tiYVars '{Y5}'
syn match tiYVars '{Y7}'
syn match tiYVars '{Y8}'
syn match tiYVars '{Y0}'
syn match tiYVars '{Y3}'
syn keyword tiSubscripts 	small6 small8 small7 smallT small10 small1 small4 small5 small9 small2
syn keyword tiSubscripts 	small0 smallL
syn keyword tiConditional 	IS>( Then If Else DS<(
syn keyword tiLabel 	Lbl
syn keyword tiListVars 	L5 L4 L1 L3 L2 L6
syn keyword tiUserInputCommand 	Prompt Input
syn keyword tiFunctions 	Plot2( cos( Plot1( randM( seq( mean( dayOfWk( abs( identity( tpdf( setDtFmt(
syn keyword tiFunctions 	binompdf( checkTmr( nDeriv( remainder( tanh^-1( TextColor( GraphStyle(
syn keyword tiFunctions 	solve( bal( invT( sin^-1( length( npv( 2-PropZTest( cosh^-1( Pxl-Off(
syn keyword tiFunctions 	median( Shadechi^2( GraphColor( log( sin( augment( sub( SigmaInt( pieceWise(
syn keyword tiFunctions 	round( lcm( 2-SampZInt( expr( List>matr( 10^^( rowSwap( tcdf( fMax( 1-PropZTest(
syn keyword tiFunctions 	Pxl-Change( sinh( OpenLib( sqrt( Circle( 2-SampZTest( Line( poissoncdf(
syn keyword tiFunctions 	e^^( tanh( SortA( P>Ry( randNorm( GetCalc( ShadeF( dbd( irr( Select( Text(
syn keyword tiFunctions 	R>Pr( Equ>String( AsmComp( Get( row+( String>Equ( binomcdf( SortD( Send(
syn keyword tiFunctions 	dim( Z-Test( real( fMin( DeltaList( normalcdf( ref( randInt( sinh^-1(
syn keyword tiFunctions 	piecewise( getTmStr( int( setDate( Pt-On( conj( Pt-Change( Shade( ln(
syn keyword tiFunctions 	iPart( setTmFmt( invNorm( Output( Tangent( R>Ptheta( geometcdf( >Nom(
syn keyword tiFunctions 	Pt-Off( toString( rref( prod( SigmaPrn( setTime( invBinom( timeCnv( normalpdf(
syn keyword tiFunctions 	Matr>list( poissonpdf( Pxl-On( tan( chi^2GOF-Test( Menu( chi^2-Test( Fpdf(
syn keyword tiFunctions 	tan^-1( cosh( chi^2pdf( >Eff( pxl-Test( randIntNoRep( randBin( fPart(
syn keyword tiFunctions 	logBASE( Fcdf( getDtStr( P>Rx( sum( Fill( chi^2cdf( variance( Sigma( 1-PropZInt(
syn keyword tiFunctions 	Shade_t( fnInt( Asm( cumSum( ANOVA(
syn match tiFunctions '*row+('
syn match tiFunctions '*row('
syn keyword tiOperators 	xor + > -> - / != < or = <= and ! >= not(
syn match tiOperators '*'
syn keyword tiMiscStatement 	End Goto
syn keyword tiOther 	ClrHome DetectAsymOn Xmin ZQuadrant1 Pmt_Bgn Tmax Seq SEQ(n+2) ^^2 ModBoxplot
syn keyword tiOther 	RecallPic ZSquare PlotsOn iPart 2-SampFTest GridOff ^^-1 squareplot G-T
syn keyword tiOther 	PlySmlt2 PwrReg ZTmax Logistic xroot Ymax Copy Line Horiz Asm84CPrgm uwAxes
syn keyword tiOther 	Tstep squareroot ZFrac1/8 UnStart Quit Editor SEQ(n+1) ZInteger ZnMax
syn keyword tiOther 	DetectAsymOff Xres DiagnosticOn GridLine ^^r Scatter Zw(nMin) Paste Line Below
syn keyword tiOther 	Func ZStandard tvm_FV e^^ ZXres GarbageCollect v(nMin) sharps log Histogram
syn keyword tiOther 	Full AxesOn StoreGDB Time ClrAllLists ^^x ZFrac1/4 Disp ^^o DeltaY DependAuto
syn keyword tiOther 	LEFT Degree 2-Var Stats ZTstep CubicReg Execute Program Quartiles Setting...
syn keyword tiOther 	SinReg ClrTable 10^^ dim Zv(nMin) NormProbPlot CENTER StorePic ZXmin ClrList
syn keyword tiOther 	Yscl Dot RectGC Xscl FnOff DeltaTbl Ans ZBox rand IndpntAsk Param SEQ(n)
syn keyword tiOther 	Zoom In bolddownarrow LinReg(a+bx) Un-1 ZPlotStep Radian tvm_I% prgm Boxplot
syn keyword tiOther 	Zthetamin DrawF PlotStart ZFrac1/2 bolduparrow getTime AxesOff PlotStep
syn keyword tiOther 	ZFrac1/5 >Polar Zoom Out ZFrac1/3 getTmFmt Return 1-Var Stats Horizontal
syn keyword tiOther 	nMax LabelOff cuberoot >Dec VnStart xmark Insert Comment Above Xmax Fix
syn keyword tiOther 	QuickPlot&Fit-EQ ExpReg Vertical DispTable Normal SetUpEditor dotplot
syn keyword tiOther 	DispGraph nMin ... Sequential AsmPrgm crossplot sum nCr Connected ZYscl
syn keyword tiOther 	>F<>D BackgroundOn Manual-Fit ZTrig fPart >Rect Sci isClockOn Undo Clear
syn keyword tiOther 	ZYmax DelVar FnOn Pause ClrDraw LnReg ZoomStat w(nMin) downarrow u(nMin)
syn keyword tiOther 	sqrt n/d Vn-1 DeltaX startTmr TblInput Web YFact Thick ExprOff Wait invertedequal
syn keyword tiOther 	ZoomFit Tmin TblStart Ymin Un/d vwAxes Eng LinReg(ax+b) tvm_PV CoordOn
syn keyword tiOther 	ZDecimal CoordOff Clear Entries Zthetamax ClockOn DrawInv getDate RIGHT
syn keyword tiOther 	RecallGDB QuadReg Archive IndpntAuto Med-Med Simul ZXmax thetastep ZYmin
syn keyword tiOther 	xyLine TraceStep Polar PlotsOff >DMS ExecLib >n/d<>Un/d re^thetai T-Test
syn keyword tiOther 	ZInterval LinRegTTest Thin ZPlotStart a+bi ZTmin ^^T mathprintbox ZXscl
syn keyword tiOther 	UnArchive Zu(nMin) getDtFmt >Frac getKey 2-SampTInt ExprOn ClockOff ln
syn keyword tiOther 	ZFrac1/10 PolarGC Zthetastep PrintScreen uparrow abs [FRAC-APPROX] Cut Line
syn keyword tiOther 	Stop nStart tvm_Pmt Insert Line Above GridDot 2-SampTTest Dot-Thin int
syn keyword tiOther 	identity LabelOn GridOn

hi def link tiFinanceVars Identifier
hi def link tiMiscCommand Statement
hi def link tiPicVars Identifier
hi def link tiColors Constant
hi def link tiConstants Constant
hi def link tiSequentialVars Identifier
hi def link tiStrings Identifier
hi def link tiPipeVars Identifier
hi def link tiLetters Identifier
hi def link tiLoop Repeat
hi def link tiGraphDatabases Identifier
hi def link tiDigits Number
hi def link tiParametricVars Identifier
hi def link tiPolarVars Identifier
hi def link tiTrigFunctions Function
hi def link tiVariables Identifier
hi def link tiImageVars Identifier
hi def link tiWindowVars Identifier
hi def link tiYVars Identifier
hi def link tiSubscripts Special
hi def link tiConditional Conditional
hi def link tiLabel Label
hi def link tiListVars Identifier
hi def link tiUserInputCommand Statement
hi def link tiFunctions Function
hi def link tiOperators Operator
hi def link tiMiscStatement Statement

let b:current_syntax = "tibasic"