(* ::Package:: *)

(* ::Input:: *)
(*SetOptions[EvaluationNotebook[],StyleDefinitions->$UserBaseDirectory<>"/SystemFiles/FrontEnd/StyleSheets/maTHEMEatica.nb"]*)


(* ::Section:: *)
(*Beginning Package*)


(* ::Subsection:: *)
(*Setting Context*)


BeginPackage["Teukolsky`PN`",{"Teukolsky`"}]


(* ::Subsection:: *)
(*Unprotecting*)


ClearAttributes[{TeukolskyRadialPN, TeukolskyRadialFunctionPN,TeukolskyPointParticleModePN}, {Protected, ReadProtected}];


(* ::Section:: *)
(*Public *)


(* ::Subsection::Closed:: *)
(*MST Coefficients*)


(* ::Input:: *)
(*(*\[Nu]MST::usage="\[Nu]MST is representative of the \[Nu] coefficient in the MST solutions"*)
(*aMST::usage="aMST[\!\(\**)
(*StyleBox[\"n\",\nFontSlant->\"Italic\"]\)] is the \!\(\*SuperscriptBox[*)
(*StyleBox[\"n\",\nFontSlant->\"Italic\"], \(th\)]\) MST coefficient";*)
(*MSTCoefficients::usage="MSTCoefficients[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]] gives the PN expanded MST coefficients aMST[n] for a given {\!\(\**)
(*StyleBox[\"\[ScriptS]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptL]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptM]\",\nFontSlant->\"Italic\"]\)} mode up to \!\(\*SuperscriptBox[\(\[Eta]\), \(\!\(\**)
(*StyleBox[\"order\[Eta]\",\nFontSlant->\"Italic\"]\)\)]\)."*)
(*KerrMSTSeries::usage="KerrMSTSeries[\!\(\**)
(*StyleBox[\"\[ScriptS]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptL]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptM]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"order\[Epsilon]\",\nFontSlant->\"Italic\"]\)] gives the PN expanded MST coefficients a[n] for a given {\!\(\**)
(*StyleBox[\"\[ScriptS]\",\nFontSlant->\"Italic\"]\), \!\(\**)
(*StyleBox[\"\[ScriptL]\",\nFontSlant->\"Italic\"]\), \!\(\**)
(*StyleBox[\"\[ScriptM]\",\nFontSlant->\"Italic\"]\)} mode up to \!\(\*SuperscriptBox[\(\[Epsilon]\), \(order\[Epsilon]\)]\). Where the relation to \[Eta] is given by \[Epsilon]=2 \[Omega] \!\(\*SuperscriptBox[\(\[Eta]\), \(3\)]\)."*)*)


(* ::Subsection::Closed:: *)
(*Spacetime replacements*)


(* ::Input:: *)
(*(*Kerr\[CapitalDelta]::usage="Kerr\[CapitalDelta][a,r] gives the Kerr \[CapitalDelta] \!\(\*SuperscriptBox[\(r\), \(2\)]\)-2r+\!\(\*SuperscriptBox[\(a\), \(2\)]\)"*)*)


(* ::Input:: *)
(*(*(*replsKerr::usage="a list of replacements for a Kerr spacetime."*)
(*replsSchwarzschild::usage="a list of replacements for Schwarzschild spacetime."*)*)
(*(*Schwarzschild::usage="Schwarzschild[\!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)] will set a to 0 in \!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)."*)
(**)*)*)


(* ::Subsection::Closed:: *)
(*Tools for Series*)


(* ::Subsubsection::Closed:: *)
(*General Tools for Series*)


(* ::Input:: *)
(*(*SeriesTake::usage="SeriesTake[series, n] takes the first n terms of series"*)
(*SeriesMinOrder::usage="SeriesMinOrder[series] gives the leading order of series"*)
(*SeriesMaxOrder::usage="SeriesMaxOrder[series] gives the first surpressed order of series"*)
(*SeriesLength::usage="SeriesLenght[series] gives the number of terms in series"*)
(*SeriesCollect::usage="SeriesCollect[expr, var, func] works like Collect but applied to each order individually. Crucially, unlike Collect it keeps the SeriesData structure."*)
(*SeriesTerms::usage="SeriesTerms[series, {x, \!\(\*SubscriptBox[\(x\), \(0\)]\), n}] works exactly like Series, with the difference that n gives the desired number of terms instead of a maximum order"*)
(*IgnoreExpansionParameter::usage="IgnoreExpansionParameter[series,x] sets all occurences of the expansion parameter in the series coefficients to x. If no value is entered x defaults to 1." *)*)


(* ::Subsubsection::Closed:: *)
(*Tools for PN Scalings*)


(* ::Input:: *)
(*(*PNScalings::usage="PNScalings[expr,params,var] applies the given powercounting scalings to the expression. E.g. PNScalings[\[Omega] r,{{\[Omega],3},{r,-2},\[Eta]]"*)
(*RemovePN::usage="PNScalings[expr,var] takes the Normal[] and sets var to 1"*)
(*Zero::usage="Zero[expr,vars] sets all vars in expr to 0"*)
(*One::usage="One[expr,vars] sets all vars in expr to 1"*)*)


(* ::Input:: *)
(*(*ExpandSpheroidals::usage="ExpandSpheroidal[expr,{param,order}] returns a all SpinWeightedSpheroidalHarmonicS in expr have been Series expanded around param->0 to order."*)*)


(* ::Input:: *)
(*(*CollectDerivatives::usage="CollectDerivatives[expr,f] works exactly like Collect[] but also collects for derivatives of f."*)*)


(* ::Subsection::Closed:: *)
(*Tools for Logs, Gammas, and PolyGammas*)


(* ::Input:: *)
(*(*ExpandLog::usage="ExpandLog[\!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)] replaces all Logs in \!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)\!\(\**)
(*StyleBox[\" \",\nFontSlant->\"Italic\"]\)with a PowerExpanded version"*)
(*ExpandGamma::usage="ExpandGamma[\!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)] factors out all Integer facors out of the Gammas in \!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\). E.g. Gamma[x+1]->x Gamma[x]"*)
(*ExpandPolyGamma::usage="ExpandPolyGamma[\!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)] factors out all Integer facors out of the PolyGammas in \!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\). E.g. PolyGamma[x+1]->\!\(\*FractionBox[\(1\), \(x\)]\) PolyGamma[x]"*)
(*PochhammerToGamma::usage="PochhammerToGamma[\!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)] replaces all Pochhammer in \!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\) with the respecive Gamma."*)
(*GammaToPochhammer::usage="PochhammerToGamma[\!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"n\",\nFontSlant->\"Italic\"]\)] replaces all Gamma in \!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)\!\(\**)
(*StyleBox[\" \",\nFontSlant->\"Italic\"]\)that contain \!\(\**)
(*StyleBox[\"n\",\nFontSlant->\"Italic\"]\) with the respective Pochhammer[__,\!\(\**)
(*StyleBox[\"n\",\nFontSlant->\"Italic\"]\)]"*)
(**)*)


(* ::Subsection::Closed:: *)
(*Tools for DiracDelta*)


(* ::Input:: *)
(*(*ExpandDiracDelta::usage="ExpandDiracDelta[expr,r] applies identities for Dirac deltas and it's derivatives to expr."*)*)


(* ::Subsection::Closed:: *)
(*Amplitudes*)


(* ::Input:: *)
(*AAmplitude::usage="AAmplitude[\"+\"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]] gives the factor \!\(\*SubscriptBox[\(A\), \(+\)]\) from Sasaki Tagoshi Eq.(157). Likewise for [\"-\"]"*)
(*BAmplitude::usage="BAmplitude[\"trans\"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]] gives the factor \!\(\*SuperscriptBox[\(B\), \(trans\)]\) from Sasaki Tagoshi Eq.(167). Likewise for [\"inc\"]"*)
(*CAmplitude::usage="CAmplitude[\"trans\"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]] gives the factor \!\(\*SuperscriptBox[\(C\), \(trans\)]\) from Sasaki Tagoshi Eq.(170)."*)
(*\[ScriptCapitalK]Amplitude::usage="\[ScriptCapitalK]Amplitude[\"\[Nu]\"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]] gives the \!\(\*SuperscriptBox[\(\[ScriptCapitalK]\), \(\[Nu]\)]\) factor for \!\(\*SubscriptBox[\(R\), \(In\)]\). Likewise for \[ScriptCapitalK]Amplitude[\"-\[Nu]-1\"]. \[ScriptCapitalK]Amplitude[\"Ratio\"] gives the tidal response function \!\(\*FractionBox[SuperscriptBox[\(\[ScriptCapitalK]\), \(\(-\[Nu]\) - 1\)], SuperscriptBox[\(\[ScriptCapitalK]\), \(\[Nu]\)]]\)."*)


(* ::Input:: *)
(*(*TeukolskyAmplitudePN::usage="TeukolskyAmplitudePN[\"sol\"][\[ScriptS], \[ScriptL], \[ScriptM], a, \[Omega], {\[Eta], n}] gives the desired PN expanded amplitude. Options for sol are as follows: *)
(*\"A+\": Sasaki Tagoshi Eq.(157), *)
(*\"A-\": ST Eq.(158), *)
(*\"Btrans\": ST Eq.(167), *)
(*\"Binc\": ST Eq.(168) divided by \!\(\*SubscriptBox[\(\[ScriptCapitalK]\), \(\[Nu]\)]\), *)
(*\"Ctrans\": Eq.(170) ST, *)
(*\"\[ScriptCapitalK]\": , *)
(*\"\[ScriptCapitalK]\[Nu]\": , *)
(*\"\[ScriptCapitalK]-\[Nu]-1\": "*)*)


(* ::Subsection::Closed:: *)
(*Wronskian*)


(* ::Input:: *)
(*(*InvariantWronskian::usage="InvariantWronskian[\[ScriptS], \[ScriptL], \[ScriptM], a, \[Omega], {\[Eta], n}] gives the invariant Wronskian."*)*)


(* ::Subsection:: *)
(*Radial solutions*)


TeukolskyRadialPN::usage="TeukolskyRadialPN[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{\[Eta],n}] gives the In and Up solution to the radial Teukolsky equation. {\[ScriptS],\[ScriptL],\[ScriptM]} specify the mode, a is the Kerr spin parameter, \[Omega] is the frequency, \[Eta] is the PN expansion parameter and n the number of terms."
TeukolskyRadialFunctionPN::usage="TeukolskyRadialFunctionPN[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{\[Eta],n},\"sol\"] gives the specified solution to the radial Teukolsky equation. {\[ScriptS],\[ScriptL],\[ScriptM]} specify the mode, a is the Kerr spin parameter, \[Omega] is the frequency, \[Eta] is the PN expansion parameter and n the number of terms. Possible options for sol are In, Up, C\[Nu], and C-\[Nu]-1"


TeukolskyRadialFunctionPN::optx="`1` is not a valid boundary condition. Possible options are In, Up, C\[Nu], and C-\[Nu]-1";
TeukolskyRadialFunctionPN::param\[ScriptS]="\[ScriptL]=`1` \[ScriptS]=`2`. \[ScriptL] has to be more or equal than |\[ScriptS]|";
TeukolskyRadialFunctionPN::param\[ScriptM]="\[ScriptL]=`1` \[ScriptM]=`2`. \[ScriptL] has to be  more or equal than |\[ScriptM]|";
TeukolskyRadialFunctionPN::paramPN="varPN=`1`. The PN parameter has to be a Symbol. E.g. \[Eta] will work while \!\(\*SuperscriptBox[\(\[Eta]\), \(3\)]\) won't.";
TeukolskyRadialFunctionPN::paramaC="a=`1`. What do you even mean by a complex Kerr a???";
TeukolskyRadialFunctionPN::parama="a=`1`. Numeric values for the Kerr parameter a have to be within [0,1]. It can however be left arbitrary.";
TeukolskyRadialFunctionPN::param\[Omega]="\[Omega]=`1`. Complex frequencies are not yet supported";
TeukolskyRadialFunctionPN::paramorder="order=`1`. The given number of terms has to be an Integer";
TeukolskyRadialFunctionPN::PNInput="Input String does not contain \"PN\". Assume PN orders are desired (calulate `1` terms in the Series).";


(* ::Subsection:: *)
(*Sourced things*)


(* ::Input:: *)
(*(*TeukolskySourceCircularOrbit::usage="TeukolskySource[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{r,r\:2080}] gives an analytical expression for the Teukolsky point particle source for a given {\[ScriptS],\[ScriptL],\[ScriptM]} mode. "*)*)


TeukolskyPointParticleModePN::usage="TeukolskyPointParticleModePN[s, l, m, orbit, {\[Eta], n}] produces a TeukolskyModePN representing a PN expanded analyitcal solution to the radial Teukolsky equation with a point particle source. s, l, and m specify the mode and need to be Integers. orbit needs to be a KerrGeoOrbitFunction (computed with KerrGeoOrbit[]). {\[Eta], n} specify the PN information. \[Eta] needs to be a symbol, while n is an integer specifying the amount of terms (including the Newtonian order), i.e., n=2 PNorder+1. "


TeukolskyModePN::usage="aa"


TeukolskyPointParticleModePN::orbit="As of now TeukolskyPointParticleModePN only supports circular equatorial orbits, i.e., e=0 and x=1.";
TeukolskyPointParticleModePN::particle="TeukolskyPointParticleModePN cannot be evaluated at the particle.";


\[CapitalOmega]Kerr::usage="This is here as a quick fix. It is the particles orbital frequency, i.e., \!\(\*SqrtBox[FractionBox[\(1\), SuperscriptBox[SubscriptBox[\(r\), \(0\)], \(3\)]]]\) in Schwarzschild."


(* ::Subsection::Closed:: *)
(*Teukolsky Equation*)


(* ::Input:: *)
(*(*TeukolskyEquation::usage="TeukolskyEquation[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{\[Eta],order},R[r]] gives the Teukolsky equation with for a given {\[ScriptS],\[ScriptL],\[ScriptM]} mode with included \[Eta] scalings. The {\[Eta],order} argument can be left out for a general expression."*)*)


(* ::Subsection::Closed:: *)
(*Developer options*)


(* ::Input:: *)
(*(*integrateDelta::usage="aala"*)
(*\[Delta]*)
(*\[Theta]*)
(**)
(*PNScalings*)*)


(* ::Input:: *)
(*(*z::usage="iuaeouia"*)
(*\[CapitalDelta]::usage="\[CapitalDelta][\!\(\**)
(*StyleBox[\"a\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"M\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"r\",\nFontSlant->\"Italic\"]\)] is the usual length scale of the Kerr spacetime"*)*)


(* ::Subsubsection::Closed:: *)
(*Post Newtonian Scalings*)


(* ::Input:: *)
(*(*replsPN="Replacements for PN scalings"*)
(*PNScalingsInternal::usage="PNScalingsInternal[\!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)] reapplies the PN scalings to \!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\). Should not be used on SeriesData objects. "*)
(*redo\[Eta]Repls::usage="iuaeuiae"*)
(*RemovePNInternal::usage="RemovePNInternal[expr] removes all PN scalings in the expression, i.e., taking the Normal and setting \[Eta]->1"*)
(*polyToSeries*)
(*IgnoreLog\[Eta]::usage="IgnoreLog\[Eta][\!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\)] sets all \[Eta] factors within \!\(\**)
(*StyleBox[\"expr\",\nFontSlant->\"Italic\"]\) to 1. This can be helpful when using SeriesCollect"*)*)


(* ::Subsubsection::Closed:: *)
(*Radial functions*)


(* ::Input:: *)
(*(*RPN::usage="RPN[\"In\"][\!\(\**)
(*StyleBox[\"\[ScriptS]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptL]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptM]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"a\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"order\[Eta]\",\nFontSlant->\"Italic\"]\)] Gives the In solution to the radial Teukolsky equation. Analogously for \"Up\", \"C\", or \"secondTerm\". The inhomogeneous solution for a circular orbit can be obtained with \"CO\""*)
(*RPNF::usage="RPNF[\!\(\**)
(*StyleBox[\"\[ScriptS]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptL]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptM]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"a\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[Omega]\",\nFontSlant->\"Italic\"]\),{\!\(\**)
(*StyleBox[\"\[Eta]\",\nFontSlant->\"Italic\"]\),order\[Eta]}] gives a function"*)
(*integrateDelta::usage="Function that integrates Dirac delta distributions. Used when getting the inhomogeneous solutions."*)
(*Normalization::usage="Normalization[\"In\"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]] gives a PN expanded normaliztion coefficient. If you divide RPN by it it will match the result of the toolkit"*)*)


(* ::Input:: *)
(*(*CCoefficient::usage="CCoefficient[\"In\"][\!\(\**)
(*StyleBox[\"\[ScriptS]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptL]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptM]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"a\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"order\[Eta]\",\nFontSlant->\"Italic\"]\)] gives the \!\(\*SubscriptBox[\(c\), \(\(in\)\(\\\ \)\)]\)coefficient for the sourced solution R=\!\(\*SubscriptBox[\(c\), \(in\)]\) \!\(\*SubscriptBox[\(R\), \(in\)]\) + \!\(\*SubscriptBox[\(c\), \(up\)]\) \!\(\*SubscriptBox[\(R\), \(up\)]\). Likewise for [\"Up\"]"*)
(*InvariantWronskian::usage="InvariantWronskian[\!\(\**)
(*StyleBox[\"\[ScriptS]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptL]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"\[ScriptM]\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"a\",\nFontSlant->\"Italic\"]\),\!\(\**)
(*StyleBox[\"order\[Eta]\",\nFontSlant->\"Italic\"]\)] gives the invariant Wronskian. C.f. Sasaki Tagoshi Eq.(23)"*)
(**)*)


(* ::Section:: *)
(*Private*)


Begin["`Private`"]


(* ::Subsection::Closed:: *)
(*Loading dependencies*)


(*<<BlackHoleAnalysis`SeriesTools`*)
<<SpinWeightedSpheroidalHarmonics`


(* ::Subsection::Closed:: *)
(*Adrian's code for MST coefficients*)


(*KerrMSTSeries[ss_,ll_,mm_,ExpOrderReq_]:=Module[{s=-Abs[ss],pos=Positive[ss],ExpOrder=ExpOrderReq,l=ll,m=mm,\[CapitalDelta]\[Nu]pC,\[CapitalDelta]\[Nu]p2C,\[CapitalDelta]\[Nu]p3C,\[CapitalDelta]\[Nu]p4C,\[CapitalDelta]\[Nu]p5C,\[CapitalDelta]\[Nu]p6C,\[CapitalDelta]\[Nu]pcq,\[Alpha]C,\[Beta]C,\[Gamma]C,\[CapitalDelta]\[Alpha]\[Beta]C,\[Kappa]Simplify,aLeadingBehaviour,acSolved,acqSolved,aShift,eqShift,StructureGrid,AngExpOrder,\[CapitalDelta]E,\[CapitalDelta]EC,ProgressGrid,FinalProgressGrid,aMST,ac,acq,eqnlist,\[CapitalDelta]\[Nu]p,\[CapitalDelta]\[Nu]pc,EqC,\[CapitalDelta]EqC,EqCL,\[CapitalDelta]EqCL,\[CapitalDelta]EqCTable,Solveac,Solve\[CapitalDelta]\[Nu],i,j,k,n,p,flip,\[Nu]MST,MST},

If[pos,ExpOrder+=2];  (* This is a kludge that needs to be fixed - the issue is that the s-> -s transform has factors \[Epsilon]^-2 for negative s *)
ClearAll[\[CapitalDelta]\[Nu]p2C];
\[CapitalDelta]\[Nu]p2C[k_]:=\[CapitalDelta]\[Nu]p2C[k]=Sum[Expand[\[CapitalDelta]\[Nu]pC[i2]*\[CapitalDelta]\[Nu]pC[- i2 + k]], {i2, 0, k}];
\[CapitalDelta]\[Nu]p3C[k_]:=\[CapitalDelta]\[Nu]p3C[k]=Sum[Expand[\[CapitalDelta]\[Nu]p2C[k - i3]*\[CapitalDelta]\[Nu]pC[i3]], {i3, 0, k}];
\[CapitalDelta]\[Nu]p4C[k_]:=\[CapitalDelta]\[Nu]p4C[k]=Sum[Expand[\[CapitalDelta]\[Nu]p3C[k - i4]*\[CapitalDelta]\[Nu]pC[i4]], {i4, 0, k}];
\[CapitalDelta]\[Nu]p5C[k_]:=\[CapitalDelta]\[Nu]p5C[k]=Sum[Expand[\[CapitalDelta]\[Nu]p4C[k - i5]*\[CapitalDelta]\[Nu]pC[i5]], {i5, 0, k}];
\[CapitalDelta]\[Nu]p6C[k_]:=\[CapitalDelta]\[Nu]p6C[k]=Sum[Expand[\[CapitalDelta]\[Nu]p5C[k - i6]*\[CapitalDelta]\[Nu]pC[i6]], {i6, 0, k}];

\[Alpha]C[n_,k_]:=\[Alpha]C[n,k]=((l-2 l^2+n-4 l n-2 n^2) If[-4+k==0,1,0]+I (2 l^2+n (-1+2 n)+l (-1+4 n)) (-I m q+(1+l+n) \[Kappa]) If[-3+k==0,1,0]+(-2 l^2-n (-1+2 n)-l (-1+4 n)) (1+l+n+s)^2 If[-2+k==0,1,0]+I (2 l^2+n (-1+2 n)+l (-1+4 n)) (1+l+n+s)^2 (-I m q+(1+l+n) \[Kappa]) If[-1+k==0,1,0]+
2 I \[Kappa] \[CapitalDelta]\[Nu]p3C[k-9]+(-3-8 l-8 n-4 s) \[CapitalDelta]\[Nu]p3C[k-8]+I (-I m q (3+8 l+8 n+4 s)+(3+20 l^2+20 n^2+6 s+2 s^2+4 n (5+4 s)+4 l (5+10 n+4 s)) \[Kappa]) \[CapitalDelta]\[Nu]p3C[k-7]-
2 \[CapitalDelta]\[Nu]p4C[k-10]+I (-2 I m q+(5+10 l+10 n+4 s) \[Kappa]) \[CapitalDelta]\[Nu]p4C[k-9]+2 I \[Kappa] \[CapitalDelta]\[Nu]p5C[k-11]-2\[CapitalDelta]\[Nu]p2C[k-8]+I (-2 I m q+\[Kappa]+6 l \[Kappa]+6 n \[Kappa]) \[CapitalDelta]\[Nu]p2C[k-7]+
(-12 l^2-12 n^2-2 s (1+s)-3 n (3+4 s)-3 l (3+8 n+4 s))\[CapitalDelta]\[Nu]p2C[k-6]+I (-I m q (12 n^2+2 s (1+s)+3 n (3+4 s))+20 l^3 \[Kappa]+
(-1+20 n^3+s^2+6 n^2 (5+4 s)+3 n (3+6 s+2 s^2)) \[Kappa]+6 l^2 (-2 I m q+(5+10 n+4 s) \[Kappa])+3 l (-I m q (3+8 n+4 s)+(3+20 n^2+6 s+2 s^2+4 n (5+4 s)) \[Kappa])) \[CapitalDelta]\[Nu]p2C[k-5]+
(1-4 l-4 n) \[CapitalDelta]\[Nu]pC[-6+k]+I (-I m (-1+4 l+4 n) q+(-1+6 l^2+2 n+6 n^2+2 l (1+6 n)) \[Kappa]) \[CapitalDelta]\[Nu]pC[-5+k]+
(-8 l^3-8 n^3-4 n s (1+s)+(1+s)^2-3 n^2 (3+4 s)-3 l^2 (3+8 n+4 s)-2 l (12 n^2+2 s (1+s)+3 n (3+4 s))) \[CapitalDelta]\[Nu]pC[-4+k]+
I (1+l+n+s) (-I m q (-1+l+8 l^2+n+16 l n+8 n^2-s+4 l s+4 n s)+
(-1+10 l^3+10 n^3-s+n (-1+2 s)+2 n^2 (5+3 s)+2 l^2 (5+15 n+3 s)+l (-1+30 n^2+2 s+4 n (5+3 s))) \[Kappa]) \[CapitalDelta]\[Nu]pC[-3+k]);

\[Beta]C[n_,k_]:=\[Beta]C[n,k]=((-3+4 l^2+4 n+4 n^2+l (4+8 n)) If[-4+k==0,1,0]-m (-3+4 l^2+4 n+4 n^2+l (4+8 n)) q If[-3+k==0,1,0]+
1/4 (3-4 l^2-4 n-4 n^2-l (4+8 n)) (l^2 (-8+q^2)+n (-8+q^2)+n^2 (-8+q^2)+l (1+2 n) (-8+q^2)-4 s^2) If[-2+k==0,1,0]-
m (-3+4 l^2+4 n+4 n^2+l (4+8 n)) q s^2 If[-1+k==0,1,0]+n (8 l^5+4 l^4 (5+9 n)+n (1+n)^2 (-3+4 n+4 n^2)+2 l^3 (5+36 n+32 n^2)+
l^2 (-5+29 n+96 n^2+56 n^3)+l (-3-7 n+28 n^2+56 n^3+24 n^4)) If[k==0,1,0]-8 (1+2 l+2 n) Sum[\[CapitalDelta]\[Nu]p3C[k-6-i]*\[CapitalDelta]EC[s, l, m, i], {i, 0, k-6}]-
4 Sum[\[CapitalDelta]\[Nu]p4C[k-8-i]*\[CapitalDelta]EC[s, l, m, i], {i, 0, k - 8}]+(-1-24 l^2-24 n-24 n^2-24 l (1+2 n))Sum[\[CapitalDelta]\[Nu]p2C[k-4-i]*\[CapitalDelta]EC[s, l, m, i], {i, 0, k - 4}]-
2 (1+2 l+2 n) (-8+q^2) \[CapitalDelta]\[Nu]p3C[k-8]+(-2+64 l^3+36 n+120 n^2+80 n^3+32 l^2 (3+7 n)+4 l (7+56 n+60 n^2))\[CapitalDelta]\[Nu]p3C[k-6]+
(8-q^2) \[CapitalDelta]\[Nu]p4C[k-10]+(9+56 l^2+60 n+60 n^2+8 l (7+15 n))\[CapitalDelta]\[Nu]p4C[k-8] +12 (1+2 l+2 n) \[CapitalDelta]\[Nu]p5C[k-10]+
4 \[CapitalDelta]\[Nu]p6C[k-12]+(3-16 l^3-2 n-24 n^2-16 n^3-24 l^2 (1+2 n)-l (2+48 n+48 n^2)) Sum[\[CapitalDelta]EC[s, l, m, i]*\[CapitalDelta]\[Nu]pC[-2 - i + k], {i, 0, -2 + k}]+
4 \[CapitalDelta]\[Nu]p2C[k-8]-4 m q \[CapitalDelta]\[Nu]p2C[k-7]+(2-q^2/4-6 l^2 (-8+q^2)-6 n (-8+q^2)-6 n^2 (-8+q^2)-6 l (1+2 n) (-8+q^2)+4 s^2) \[CapitalDelta]\[Nu]p2C[k-6]-
4 m q s^2 \[CapitalDelta]\[Nu]p2C[k-5]+(-3+36 l^4-6 n+54 n^2+120 n^3+60 n^4+24 l^3 (3+8 n)+l^2 (29+288 n+336 n^2)+l (-7+84 n+336 n^2+240 n^3)) \[CapitalDelta]\[Nu]p2C[k-4]+
(-4 l^4-8 l^3 (1+2 n)-l^2 (1+24 n+24 n^2)-n (-3+n+8 n^2+4 n^3)-l (-3+2 n+24 n^2+16 n^3)) \[CapitalDelta]EC[s,l,m,k]+(4+8 l+8 n) \[CapitalDelta]\[Nu]pC[-6+k]-
4 m (1+2 l+2 n) q \[CapitalDelta]\[Nu]pC[-5+k]+1/4 (-1-2 l-2 n) (24-3 q^2+8 l^2 (-8+q^2)+8 n (-8+q^2)+8 n^2 (-8+q^2)+8 l (1+2 n) (-8+q^2)-16 s^2) \[CapitalDelta]\[Nu]pC[-4+k]-
4 m (1+2 l+2 n) q s^2 \[CapitalDelta]\[Nu]pC[-3+k]+(8 l^5+4 l^4 (5+18 n)+2 l^3 (5+72 n+96 n^2)+l^2 (-5+58 n+288 n^2+224 n^3)+6 n (-1-n+6 n^2+10 n^3+4 n^4)+
l (-3-14 n+84 n^2+224 n^3+120 n^4)) \[CapitalDelta]\[Nu]pC[-2+k]);

\[Gamma]C[n_,k_]:=\[Gamma]C[n,k]=((-3-2 l^2-5 n-2 n^2-l (5+4 n)) If[-4+k==0,1,0]-I (3+2 l^2+5 n+2 n^2+l (5+4 n)) (I m q+(l+n) \[Kappa]) If[-3+k==0,1,0]+
(-3-2 l^2-5 n-2 n^2-l (5+4 n)) (l+n-s)^2 If[-2+k==0,1,0]-I (3+2 l^2+5 n+2 n^2+l (5+4 n)) (l+n-s)^2 (I m q+(l+n) \[Kappa]) If[-1+k==0,1,0]-
2 I \[Kappa] \[CapitalDelta]\[Nu]p3C[k-9]+(-5-8 l-8 n+4 s)\[CapitalDelta]\[Nu]p3C[k-8]-I (I m q (5+8 l+8 n-4 s)+(3+20 l^2+20 n+20 n^2+4 l (5+10 n-4 s)-10 s-16 n s+2 s^2) \[Kappa]) \[CapitalDelta]\[Nu]p3C[k-7]-
2 \[CapitalDelta]\[Nu]p4C[k-10]-I (2 I m q+(5+10 l+10 n-4 s) \[Kappa]) \[CapitalDelta]\[Nu]p4C[k-9]-2 I \[Kappa] \[CapitalDelta]\[Nu]p5C[k-11]-2 \[CapitalDelta]\[Nu]p2C[k-8]-I (2 I m q+(5+6 l+6 n) \[Kappa])\[CapitalDelta]\[Nu]p2C[k-7]+
(-3-12 l^2-12 n^2-3 l (5+8 n-4 s)+10 s-2 s^2+3 n (-5+4 s))\[CapitalDelta]\[Nu]p2C[k-6]-I (I m q (3+12 l^2+12 n^2+3 l (5+8 n-4 s)-10 s+2 s^2-3 n (-5+4 s))+
(20 l^3+20 n^3+6 l^2 (5+10 n-4 s)-6 n^2 (-5+4 s)+s (-6+5 s)+n (9-30 s+6 s^2)+l (9+60 n^2+n (60-48 s)-30 s+6 s^2)) \[Kappa]) \[CapitalDelta]\[Nu]p2C[k-5]+
(-5-4 l-4 n) \[CapitalDelta]\[Nu]pC[-6+k]-I (I m (5+4 l+4 n) q+(3+6 l^2+10 n+6 n^2+2 l (5+6 n)) \[Kappa]) \[CapitalDelta]\[Nu]pC[-5+k]+
(-8 l^3-8 n^3-3 l^2 (5+8 n-4 s)+(6-5 s) s+3 n^2 (-5+4 s)+n (-6+20 s-4 s^2)-2 l (3+12 n^2-10 s+2 s^2-3 n (-5+4 s))) \[CapitalDelta]\[Nu]pC[-4+k]-
I (l+n-s) (I m q (6+8 l^2+8 n^2+n (15-4 s)+l (15+16 n-4 s)-5 s)+
(10 l^3+10 n^3+n (9-10 s)+l (9+30 n^2+n (40-12 s)-10 s)+n^2 (20-6 s)+l^2 (20+30 n-6 s)-3 s) \[Kappa]) \[CapitalDelta]\[Nu]pC[-3+k]);

Do[\[CapitalDelta]\[Nu]pC[k]=0,{k,-12,-1}];
\[Beta]C[-l,2]=\[Beta]C[-l,2]//Simplify;
\[Beta]C[-l,1]=\[Beta]C[-l,1]//Simplify;
\[Alpha]C[-l-1,2]=\[Alpha]C[-l-1,2]//Simplify;

\[Kappa]Simplify[x_]:=Expand[x]/.\[Kappa]^2->(1-q^2);
\[CapitalDelta]\[Alpha]\[Beta]C[n_,k_]:=(\[Beta]C[-l,k]- \[Alpha]C[-l-1,k])//\[Kappa]Simplify;

ProgressGrid:=Grid[
Table[
If[i==0,If[j<2||NumericQ[\[CapitalDelta]\[Nu]pC[j-2]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]}],Item[j,Background->Green],Item[j,Background->Yellow]],
If[TrueQ[acSolved[i,j]],If[NumericQ[ac[i,j]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]}],If[(ac[i,j]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]})==0,Item[" ",Background->LightRed],Item[" ",Background->Red]],Item[" ",Background->Orange]] ,If[j<aLeadingBehaviour[l,i] ,If[j==-1,Item[i],Item[" "]] ,Item[" ",Background->Blue]]]],{i,ExpOrder+2,-ExpOrder-2,-1},{j,-1,ExpOrder+2}],ItemSize->All,Frame->All];

(*
FinalProgressGrid:=Grid[
Table[
If[i==0,If[j<2||NumericQ[\[CapitalDelta]\[Nu]pC[j-2]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]}],Item[j,Background->Green],If[j==-1,Item["\[Nu]",Background->White],Item[j,Background->Yellow]]],
If[NumericQ[ac[i,j]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]}],If[(ac[i,j]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]})==0,Item[" ",Background->White],Item[" ",Background->Red]],If[j<aLeadingBehaviour[l,i] ,If[j==-1,Item[i],Item[" "]] ,Item[" ",Background->Blue]]]],
{i,ExpOrder+2,-ExpOrder-2,-1},{j,-1,ExpOrder+2}],ItemSize->All,Frame->All];
*);

FinalProgressGrid:=Grid[
Table[
If[i==0,If[j>=0 && NumericQ[\[CapitalDelta]\[Nu]pC[j-2]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]}],Item[j,Background->Green],If[j==-1,Item["\[Nu]",Background->White],Item[j,Background->Yellow]]],
If[NumericQ[ac[i,j]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]}],If[(ac[i,j]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]})==0,Item[" ",Background->White],Item[" ",Background->Red]],If[j<aLeadingBehaviour[l,i] ,If[j==-1,Item[i],Item[" "]] ,Item[" ",Background->Blue]]]],
{i,ExpOrder+2,-ExpOrder-2,-1},{j,-1,ExpOrder+2}],ItemSize->All,Frame->All];

StructureGrid:=Grid[
Table[
If[i==0,Item[j,Background->Yellow],
If[j<aLeadingBehaviour[l,i],If[j==-1,Item[i],Item[" "]] ,Switch[i-j,-2l,Item[" ",Background->Cyan],-4l,Item[" ",Background->Gray],_,Item[" ",Background->Blue]]]],{i,ExpOrder+2,-ExpOrder-2,-1},{j,-1,ExpOrder+2}],ItemSize->All,Frame->All];

<<SpinWeightedSpheroidalHarmonics`;

AngExpOrder=ExpOrder+Boole[s==0 && l==1]+2 Boole[s==0 && l==0]+2 Boole[s==-1 && l==1];

\[CapitalDelta]E[s,l,m]= (Normal[Series[SpinWeightedSpheroidalEigenvalue[s,l,m,\[Gamma]],{\[Gamma],0,AngExpOrder}]]/.\[Gamma]->q \[Epsilon]/2)+O[\[Epsilon]]^(AngExpOrder+1)-l(l+1)+s(s+1)+ m q \[Epsilon]-(q \[Epsilon]/2)^2;
\[CapitalDelta]EC[s,l,m,0]=0;
Do[\[CapitalDelta]EC[s,l,m,i]=Coefficient[\[CapitalDelta]E[s,l,m],\[Epsilon],i],{i,1,AngExpOrder}];

ClearAll[aMST,ac,acq,eqnlist,\[CapitalDelta]\[Nu]p,\[CapitalDelta]\[Nu]pc];

If[s==-2,
	aShift[l,n_]:=Which[n<=l-2,0,n==l-1,2,n==l,1,
		n>l&&n<2l+1,0,
		n>=2l+1,-2];
	eqShift[l,n_]:=Which[n<=l-3,0,n==l-2,4,n==l-1,4,n==l,5-Boole[l==2],
		n>l&&n<2l+1,1,
		n>=2l+1,-1];];
If[s==-1,
	  aShift[l,n_]:=Which[n<=l-2,0,n==l-1,0,n==l,1, 
		n>l&&n<2l+1,0,
		n>=2l+1,-2];
	eqShift[l,n_]:=Which[n<=l-3,0,n==l-2,0,n==l-1,3,n==l,4,
		n>l&&n<2l+1,1,
		n>=2l+1,-1];];
If[s==0,aShift[l,n_]:=Which[n<2l+1,0,n>=2l+1,-2+Boole[l==0]];
	eqShift[l,n_]:=Which[n<=l-3,0,n==l-2,2,n==l-1,4,n==l,3,
		n>l&&n<2l+1,1,
		n>=2l+1,-1];];	

aLeadingBehaviour[l,n_]=aLeadingBehaviour[l,n]=If[n>=0,n,-n+aShift[l,-n]];

aMST[0]=1;
ac[0,_]=0;
ac[0,0]=1;
Do[aMST[n]=Sum[ac[n,i]\[Epsilon]^i,{i,n,ExpOrder+1}],{n,1,ExpOrder+2}];
Do[ac[n,i]=0,{n,1,ExpOrder+2},{i,0,n-1}];
Do[ac[n,i]=If[EvenQ[i],Sum[acq[n,i,j]q^j,{j,0,i,2}]+I \[Kappa] Sum[acq[n,i,j]q^j,{j,1,i,2}],Sum[acq[n,i,j]q^j,{j,1,i,2}]+I \[Kappa] Sum[acq[n,i,j]q^j,{j,0,i,2}]],{n,1,ExpOrder+2},{i,n,ExpOrder+2}];
Do[aMST[-n]=Sum[ac[-n,i]\[Epsilon]^i,{i,n+aShift[l,n],ExpOrder+1}],{n,1,ExpOrder+4}];
Do[ac[-n,i]=0,{n,1,ExpOrder+4},{i,0,n+aShift[l,n]-1}];
Do[ac[-n,i]=If[EvenQ[i],Sum[acq[-n,i,j]q^j,{j,0,i,2}]+I \[Kappa] Sum[acq[-n,i,j]q^j,{j,1,i,2}],Sum[acq[-n,i,j]q^j,{j,1,i,2}]+I \[Kappa] Sum[acq[-n,i,j]q^j,{j,0,i,2}]],{n,1,ExpOrder+4},{i,n+aShift[l,n],ExpOrder+3}];
If[m == 0,Do[Do[acq[-n,n-2,i]=0;acqSolved[-n,n-2,i]=True,{i,0,n-2}];acSolved[-n,n-2]=True,{n,2l+1,ExpOrder+4}]];

\[CapitalDelta]\[Nu]p=Sum[\[CapitalDelta]\[Nu]pC[i] \[Epsilon]^i,{i,0,ExpOrder+2}];
Do[\[CapitalDelta]\[Nu]pC[i]=If[EvenQ[i],Sum[\[CapitalDelta]\[Nu]pcq[i,j]q^j,{j,0,i,2}],Sum[\[CapitalDelta]\[Nu]pcq[i,j]q^j,{j,1,i,2}]],{i,0,ExpOrder+2}];

EqC[n_,k_]:=Sum[\[Alpha]C[n-1,k-i]ac[n,i]+\[Beta]C[n-1,k-i]ac[n-1,i]+\[Gamma]C[n-1,k-i]ac[n-2,i],{i,Min[Abs[n]+aShift[l,-n],Abs[n-1]+aShift[l,-(n-1)],Abs[n-2]+aShift[l,-(n-2)]],k}];
\[CapitalDelta]EqC[n_,k_]:=Sum[\[Alpha]C[n,k-i]ac[n+1,i]+(\[Beta]C[n,k-i]- \[Alpha]C[n-1,k-i])ac[n,i]+(\[Gamma]C[n,k-i]- \[Beta]C[n-1,k-i])ac[n-1,i]+(-\[Gamma]C[n-1,k-i])ac[n-2,i],{i,Min[Abs[n+1]+aShift[l,-(n+1)],Abs[n]+aShift[l,-n],Abs[n-1]+aShift[l,-(n-1)],Abs[n-2]+aShift[l,-(n-2)]],k}];

EqCL[n_,p_]:=\[Kappa]Simplify[EqC[n,Min[Abs[n]-eqShift[l,-n]+If[n>1,0,2]+p,ExpOrder+eqShift[l,-n]+2]]];
\[CapitalDelta]EqCL[n_,p_]:=\[Kappa]Simplify[\[CapitalDelta]EqC[n,Min[Abs[n]-eqShift[l,-n]+If[n>1,0,2]+p,ExpOrder+eqShift[l,-n]+2]]];

\[CapitalDelta]EqCTable[n_,k_]:=Table[{\[Alpha]C[n,k-i]ac[n+1,i],(\[Beta]C[n,k-i]- \[Alpha]C[n-1,k-i])ac[n,i]+(\[Gamma]C[n,k-i]- \[Beta]C[n-1,k-i])ac[n-1,i],(-\[Gamma]C[n-1,k-i])ac[n-2,i]},{i,Min[Abs[n+1]+aShift[l,-(n+1)],Abs[n]+aShift[l,-n],Abs[n-1]+aShift[l,-(n-1)],Abs[n-2]+aShift[l,-(n-2)]],k}];

Clear[Solveac];
Solveac[i_?IntegerQ,j_?IntegerQ,Eq_,drop_?IntegerQ]:=Module[{tmpEq,tmp,tmpN,tmpD,shift,Verbose=False,acSolve=True},
If[(i>0&&j(*+i*)>ExpOrder+Boole[l==0]+2Boole[s==-1&&l==1])||(i<0&&j(*-i*)>ExpOrder+2),acSolve=False;Return[]];
(* remove commented terms if only want \[Nu] *)
If[Abs[j]<=ExpOrder+3&&acSolve,tmpEq=Drop[CoefficientList[Eq,q],drop];
If[Verbose,Print[tmpEq,"\t",Dimensions[tmpEq][[1]]]];
shift=0; 
Do[
	tmpN=\[Kappa]Simplify[Coefficient[tmpEq[[k+1]],acq[i,j,k+shift],0]];
	tmpD=-\[Kappa]Simplify[Coefficient[tmpEq[[k+1]],acq[i,j,k+shift]]];
	If[Verbose,Print["i=",i,"\t j=",j, "\t k=",k,"\t tmpN:=",tmpN,"\t tmpD:=",tmpD]];
	If[tmpD==0,\[SZ]t["Attempted division by 0 in Solveac\n i=",i,"\t j=",j,"\t k+shift=",k+shift,"\t tmpEq=",Simplify[tmpEq]];Continue[]];
	tmp=tmpN/tmpD;
	If[Verbose,Print["Eq:\t",tmpEq,"\t",tmpN,"\t",tmpD,"\t",tmp]];
	acq[i,j,k+shift]=\[Kappa]Simplify[tmp];
	acqSolved[i,j,k+shift]=True;
	If[Verbose && acq[i,j,k+shift]==0,Print["Vanishing acq for i=",i,"\t j=",j,"\t k=",k]],
{k,0,j}];
ac[i,j]=Collect[ac[i,j],\[Kappa]];
acSolved[i,j]=True];
If[Verbose,Print[ac[i,j]]];
];

PrintCLSolveac[a_,b_,c_,d_]:=Print[a,"\t",b,"\t",CoefficientList[c,q],"\t",d];

Clear[Solve\[CapitalDelta]\[Nu]];
Solve\[CapitalDelta]\[Nu][i_?IntegerQ,p_?IntegerQ, OptionsPattern[]]:=Module[{tmpEq,tmp,tmpN,tmpD,shift,Verbose=False},
shift=If[EvenQ[i],0,1];
tmpEq=Take[CoefficientList[EqCL[1,p],q],{shift+1,-1,2}];
Do[
	tmpN=Coefficient[tmpEq[[k+1]],\[CapitalDelta]\[Nu]pcq[i,2k+shift],0];
	tmpD=-Coefficient[tmpEq[[k+1]],\[CapitalDelta]\[Nu]pcq[i,2k+shift]];	
	If[tmpD==0,Print["Attempted division by 0 in Solve\[CapitalDelta]\[Nu] (i=",i,"\t 2k+shift=",2k+shift,")"],tmp=tmpN/tmpD];
	\[CapitalDelta]\[Nu]pcq[i,2k+shift]=\[Kappa]Simplify[tmp],
{k,0,Floor[i/2]}];
If[Verbose,Print["i=",i,"\t \[CapitalDelta]\[Nu]pC[",i,"]=",\[CapitalDelta]\[Nu]pC[i]]];
];


Which[s==-2,
	(*Print["s =-2 code"];*)
		Which[l==2 && m!=0,
		
		Do[
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
		Solve\[CapitalDelta]\[Nu][p,p-1],
		{p,0,1}];
		p=1;
		Solveac[-1,p+2,EqCL[0,p+4],0];		
		Do[
			Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
			Solve\[CapitalDelta]\[Nu][p,p-1];
			Solveac[-1,p+2,EqCL[0,p+4],0];
			If[p==2,Solveac[-2,3,EqCL[-1,5],1]];
			If[p<ExpOrder,Solveac[-2,p+2,(\[Beta]C[-2,2]- \[Alpha]C[-3,2])EqCL[-1,p+3]- \[Beta]C[-2,1] \[CapitalDelta]EqCL[-2,p+4],1]];
			Solveac[-3,p+1,EqCL[-2,p+3],0];
			If[p<=ExpOrder,
				Solveac[-4,p+2,EqCL[-3,p-2],0];
				Solveac[-5,p+1,EqCL[-4,p-2],0];
				Do[If[n+p-4<=ExpOrder+1,Solveac[-n,n+p-4,EqCL[-n+1,p-6],0]],{n,6,ExpOrder+2+Boole[ExpOrder==3]}]],
		{p,2,ExpOrder}],
				
		l==2 && m==0,
		
		p=0;
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
		Solve\[CapitalDelta]\[Nu][p,p-1];
		p=1;
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
		Solve\[CapitalDelta]\[Nu][p,p-1];
		Solveac[-1,p+2,EqCL[0,p+4],0];
		Do[
			Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
			Solve\[CapitalDelta]\[Nu][p,p-1];
			Solveac[-1,p+2,EqCL[0,p+4],0];
			Solveac[-2,p+1,EqCL[-1,p+4],0];
			Solveac[-3,p+1,EqCL[-2,p+3],0];
			Solveac[-4,p+2,EqCL[-3,p-2],0];
			If[p>2&&p<=ExpOrder,
				Solveac[-5,p+1,EqCL[-4,p-2],0];
				Do[If[n+p-4<=ExpOrder+1,Solveac[-n,n+p-4,EqCL[-n+1,p-6],0]],{n,6,ExpOrder+2}]],
		{p,2,ExpOrder}],
		
		l>2,
		Do[
		   Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
		   Do[Solveac[-n,n+p,EqCL[-n+1,p-1],0],{n,1,l-2}];
		   Solve\[CapitalDelta]\[Nu][p,p-1],
		{p,0,3}];
		
		p=3;
		If[m != 0,Solveac[-(l-1),l+1+(p-3),EqCL[-(l-2),(p-3)+5],0]];
		
		Do[
			If[m == 0,Solveac[-(l+1),l+1+(p-4),EqCL[-(l-1),p+2],0],Solveac[-(l+1),l+1+(p-4),EqCL[-(l-1),p+1],1]];
			If[m == 0,Solveac[-l,l+1+(p-4),EqCL[-l,p+2],0],Solveac[-l,l+1+(p-4),(\[Beta]C[-l,2]- \[Alpha]C[-l-1,2])EqCL[-l+1,p+2]- \[Beta]C[-l,1] \[CapitalDelta]EqCL[-l,p+3],0]]; 
			If[m == 0,Solveac[-(l-1),l+1+(p-4),EqCL[-(l-2),p+1],0],Solveac[-(l-1),l+2+(p-4),EqCL[-(l-2),p+2],0]];
			
			Do[If[n+p-4<=ExpOrder+2,Solveac[-n,n+(p-4),EqCL[-n+1,p-4],0]],{n,l+2,2l-1}];
			If[p>3+Boole[m==0]&&2l+p-4<=ExpOrder+1,Solveac[-2l-1,2l+(p-4)-1,EqCL[-2l,(p-4)],0]];
		    If[p>3+Boole[m==0]&&2l+p-4<=ExpOrder+1,Solveac[-2l-2,2l+(p-4),EqCL[-2l-1,(p-4)-4],0]];
		    If[2l+p-4<=ExpOrder+1,Solveac[-2l,2l+(p-4),EqCL[-2l+1,p-4],0]];
			Do[If[p>3+Boole[m==0]&&n-1+p-4<=ExpOrder,Solveac[-n-1,n-1+p-4,EqCL[-n,(p-4)-4],0]],{n,2l+2,ExpOrder+1}];
			Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder-p}]; 
			Do[If[n+p<=ExpOrder,Solveac[-n,n+p,EqCL[-n+1,p-1],0]],{n,1,l-2}];
			
			If[p<=ExpOrder,Solve\[CapitalDelta]\[Nu][p,p-1]],
		{p,4,ExpOrder+Boole[l==2]}]],

s==-1,
	(*Print["s =-1 code"];*)
	  Which[l==1 (* && m!=0 *),
	    (* Print["l = 1, m != 0 code"]; *)
	    
	    p=0;
			Do[If[n+p<=ExpOrder+3,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder+1}]; 
			Solveac[-1,p+2,\[CapitalDelta]EqCL[-1,p+5],0];
			Solve\[CapitalDelta]\[Nu][p,p-1];
		
		Do[
			Do[If[n+p<=ExpOrder+1,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder+1}]; 
			Solveac[-1,p+2,\[CapitalDelta]EqCL[-1,p+5],0];
			Solveac[-2,p+1,EqCL[0,p+4],0];
			Solve\[CapitalDelta]\[Nu][p,p-1];
			Solveac[-3,p+Boole[m==0],EqCL[-2,p-1+Boole[m==0]],0];
			Do[If[p+(n-4)+1+Boole[m==0]<=ExpOrder+1,Solveac[-n,p+(n-4)+1+Boole[m==0],EqCL[-n+1,p-5+Boole[m==0]],0]],{n,4,ExpOrder+2}],
		{p,1,ExpOrder}],	 
		
		(*
		l==1 && m==0,		
		(*Print["l = 1, m = 0 code"];*)
		
		Do[
			Do[If[n+p<=ExpOrder+2,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
			If[p>0,
				Solveac[-1,p+1,\[CapitalDelta]EqCL[-1,p+5],0];
				Solveac[-2,p+1,EqCL[-1,p+5],0]];
			If[p>1,
				Solveac[-4,p+1,EqCL[-3,p-5],0];
				Solveac[-3,p,EqCL[-2,p-1],0];
				Do[Solveac[-n,p+n-3,EqCL[-n+1,p-5],0],{n,5,ExpOrder+2}]];
			Solve\[CapitalDelta]\[Nu][p,p+3],
		{p,0,ExpOrder}],			    			    			    			    
	    *)
	    
		l>1,
	    (* Print["|s| = 1, l > 1 code"]; *)
	    	    
		Do[
		  Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
		  Do[Solveac[-n,n+p,EqCL[-n+1,p-1],0],{n,1,l-1}];
		  Solve\[CapitalDelta]\[Nu][p,p-1],
		{p,0,4}];
		
		p=4;
		If[m==0,If[p+(l-3)<=ExpOrder+1,Solveac[-l,p+(l-3),EqCL[-l+1,p+1],0]]];
		Solveac[-l-1,p+(l-3),EqCL[-l,p+Boole[m==0]],1-Boole[m==0]];
		If[m==0,Do[If[n+(p-4)<=ExpOrder+1,Solveac[-n,n+(p-4),EqCL[-n+1,p-4],0]],{n,l+2,2l}]];
		
		Do[
			Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
			Do[Solveac[-n,n+p,EqCL[-n+1,p-1],0],{n,1,l-1}];
			If[p<= ExpOrder,Solve\[CapitalDelta]\[Nu][p,p-1]];
			If[m!=0,
				(* m !=0 *)
				Solveac[-l-1,p+(l-3),EqCL[-l+1,p],1] ;
				Solveac[-l,p+(l-4),EqCL[-l+1,p]+q(EqCL[-l+1,p+1]-EqCL[-l,p+1]),0],
				(* m==0 *)
				Solveac[-l,p+(l-3),EqCL[-l+1,p+1],0];
				Solveac[-l-1,p+(l-3),EqCL[-l,p+Boole[m==0]],1-Boole[m==0]]];
			Do[If[n+(p-5)+Boole[m==0]<=ExpOrder+1,Solveac[-n,n+(p-5)+Boole[m==0],EqCL[-n+1,p-5+Boole[m==0]],0]],{n,l+2,2l}];
			If[p+2l-6+Boole[m==0]<=ExpOrder+1,Solveac[-2l-1,p+2l-6+Boole[m==0],EqCL[-2l,p-5+Boole[m==0]],0]];
			If[p+2l-5+Boole[m==0]<=ExpOrder+1,Solveac[-2l-2,p+2l-5+Boole[m==0],EqCL[-2l-1,p-9+Boole[m==0]],0]];
			Do[If[n-1+p-5+Boole[m==0]<=ExpOrder+1,Solveac[-n-1,n-1+p-5+Boole[m==0],EqCL[-n,p-9+Boole[m==0]],0]],{n,2l+2,ExpOrder+1}],
		{p,5,ExpOrder+Max[4-l,0]}];
		],

s==0,
	(*Print["s =0 code"];*)
Which[
	l==0,
	(*Print["l = 0 code"];*)
		p=0;
		Solveac[1,1+p,EqCL[1+1,p+1],0];		
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,2,ExpOrder-p}]; 
		Solveac[-2,1,EqCL[-1,-3],0];
		Solveac[-1,0,EqCL[0,5],0];
		(* \[CapitalDelta]\[Nu]pcq[0,0]=\[CapitalDelta]\[Nu]pcq[0,0]/.Solve[CoefficientList[EqCL[1,5],q]==0,\[CapitalDelta]\[Nu]pcq[0,0]][[1]] gives multiple solutions so hard code;*);
		\[CapitalDelta]\[Nu]pcq[0,0]=-(7/6);
		Do[Solveac[-n,n-1,EqCL[-n+1,-3],0],{n,3,ExpOrder+1}];
	
		Do[
		Solveac[1,1+p,EqCL[1+1,p+1],0];
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,2,ExpOrder-p}]; 
		Solveac[-2,1+p,EqCL[-1,-3+p],0];
		Solveac[-1,p,EqCL[0,5+p],0];
		Solve\[CapitalDelta]\[Nu][p,p+5];
		Do[Solveac[-n,n-1+p,EqCL[-n+1,-3+p],0],{n,3,ExpOrder-p+2}],
		{p,1,ExpOrder}],		
	l==1,
	(*Print["l = 1 code"];*)
		 If[m==0&&l!=0,ac[-2l,2l]=0;acSolved[-2l,2l]=True];
		 
		 Do[
			 Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder-p}]; 
			Solveac[-(l),l+p,EqCL[-(l-1),p+5],0];
			Solve\[CapitalDelta]\[Nu][p,p+1];
			If[p>=Boole[m==0],
			Solveac[-2l,2l+p,EqCL[-(2l-1),(p+4)],0];
			Solveac[-(2l+2),2l+p,EqCL[-(2l+1),p-4],0];
			Solveac[-(2l+1),2l-1+p,EqCL[-2l,p],0];
			Do[If[n+(p-2)<=ExpOrder+1,Solveac[-n-1,n+p-1,EqCL[-n,p-4],0]],{n,2l+2,ExpOrder-(p-1)}]],
		{p,0,ExpOrder-1}],
	l>=2,
	(*Print["l >= 2 code"];*)
		 If[m==0&&l!=0,ac[-2l,2l]=0;acSolved[-2l,2l]=True];
		 
		 Do[
		   Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
		   Do[If[n+p<=ExpOrder,Solveac[-n,n+p,EqCL[-n+1,p-1],0]],{n,1,l-2}];
		   Solve\[CapitalDelta]\[Nu][p,p-1];
		   Solveac[-(l-1),l-1+p,EqCL[-(l-2),p+1],0];
		   Solveac[-(l),l+p,EqCL[-(l-1),p+5],0];
		   Solveac[-(l+1),l+1+p,EqCL[-l,p+4],0];
		   Do[Solveac[-n,n+p,EqCL[-(n-1),p],0],{n,l+2,2l-1}];
		   If[p>=2+Boole[m==0],
				Solveac[-(2l+2),2l+(p-2),EqCL[-(2l+1),(p-2)-4],0];
		       Solveac[-2l,2l+(p-2),EqCL[-(2l-1),(p-2)],0];
		       Solveac[-(2l+1),2l-1+(p-2),EqCL[-2l,(p-2)],0];
		    Do[If[p<ExpOrder,Solveac[-n-1,n+(p-2)-1,EqCL[-n,(p-2)-4],0]],{n,2l+2,ExpOrder+1}]],
		{p,0,ExpOrder-1}]]
];

\[Nu]MST=l+Sum[\[CapitalDelta]\[Nu]pC[i] \[Epsilon]^(i+2),{i,0,ExpOrder-2}]+O[\[Epsilon]]^(ExpOrder+1);

If[pos,
ClearAll[flip];
flip[n_]:=flip[n]=Which[n>0,((n + \[Nu]MST + s)^2 +  \[Epsilon]^2)/((n + \[Nu]MST- s)^2 +  \[Epsilon]^2) flip[n-1],n==0,1,n<0,((n +1+ \[Nu]MST- s)^2 +  \[Epsilon]^2)/((n +1+ \[Nu]MST+ s)^2 +  \[Epsilon]^2) flip[n+1]];
Do[aMST[n]=flip[n]aMST[n],{n,-ExpOrder-2,ExpOrder}];
Print[Table[{n,Series[flip[n],{\[Epsilon],0,1}]},{n,-ExpOrder-2,ExpOrder}]];
Do[ac[n,i]=Coefficient[aMST[n],\[Epsilon],i],{i,0,ExpOrder+2},{n,-ExpOrder-2,ExpOrder}]
];
If[pos,ExpOrder-=2];

Print[FinalProgressGrid];

MST=Association[{\[Nu]->\[Nu]MST+O[\[Epsilon]]^(ExpOrder+1)}];
MST=Append[MST,Table[a[n]->aMST[n]+If[n==0,0,O[\[Epsilon]]^(ExpOrder+1)],{n,-ExpOrder-2,ExpOrder}]]

]*)


KerrMSTSeries[ss_,ll_,mm_,ExpOrder_]:=Module[{s=ss,l=ll,m=mm,\[CapitalDelta]\[Nu]pC,\[CapitalDelta]\[Nu]p2C,\[CapitalDelta]\[Nu]p3C,\[CapitalDelta]\[Nu]p4C,\[CapitalDelta]\[Nu]p5C,\[CapitalDelta]\[Nu]p6C,\[CapitalDelta]\[Nu]pcq,\[Alpha]C,\[Beta]C,\[Gamma]C,\[CapitalDelta]\[Alpha]\[Beta]C,\[Kappa]Simplify,aLeadingBehaviour,acSolved,acqSolved,aShift,eqShift,StructureGrid,AngExpOrder,\[CapitalDelta]E,\[CapitalDelta]EC,ProgressGrid,aMST,ac,acq,eqnlist,\[CapitalDelta]\[Nu]p,\[CapitalDelta]\[Nu]pc,EqC,\[CapitalDelta]EqC,EqCL,\[CapitalDelta]EqCL,\[CapitalDelta]EqCTable,Solveac,Solve\[CapitalDelta]\[Nu],i,j,k,n,p,\[Nu]MST,MST},


ClearAll[\[CapitalDelta]\[Nu]p2C];
\[CapitalDelta]\[Nu]p2C[k_]:=\[CapitalDelta]\[Nu]p2C[k]=Sum[Expand[\[CapitalDelta]\[Nu]pC[i2]*\[CapitalDelta]\[Nu]pC[- i2 + k]], {i2, 0, k}];
\[CapitalDelta]\[Nu]p3C[k_]:=\[CapitalDelta]\[Nu]p3C[k]=Sum[Expand[\[CapitalDelta]\[Nu]p2C[k - i3]*\[CapitalDelta]\[Nu]pC[i3]], {i3, 0, k}];
\[CapitalDelta]\[Nu]p4C[k_]:=\[CapitalDelta]\[Nu]p4C[k]=Sum[Expand[\[CapitalDelta]\[Nu]p3C[k - i4]*\[CapitalDelta]\[Nu]pC[i4]], {i4, 0, k}];
\[CapitalDelta]\[Nu]p5C[k_]:=\[CapitalDelta]\[Nu]p5C[k]=Sum[Expand[\[CapitalDelta]\[Nu]p4C[k - i5]*\[CapitalDelta]\[Nu]pC[i5]], {i5, 0, k}];
\[CapitalDelta]\[Nu]p6C[k_]:=\[CapitalDelta]\[Nu]p6C[k]=Sum[Expand[\[CapitalDelta]\[Nu]p5C[k - i6]*\[CapitalDelta]\[Nu]pC[i6]], {i6, 0, k}];

\[Alpha]C[n_,k_]:=\[Alpha]C[n,k]=((l-2 l^2+n-4 l n-2 n^2) If[-4+k==0,1,0]+I (2 l^2+n (-1+2 n)+l (-1+4 n)) (-I m q+(1+l+n) \[Kappa]) If[-3+k==0,1,0]+(-2 l^2-n (-1+2 n)-l (-1+4 n)) (1+l+n+s)^2 If[-2+k==0,1,0]+I (2 l^2+n (-1+2 n)+l (-1+4 n)) (1+l+n+s)^2 (-I m q+(1+l+n) \[Kappa]) If[-1+k==0,1,0]+
2 I \[Kappa] \[CapitalDelta]\[Nu]p3C[k-9]+(-3-8 l-8 n-4 s) \[CapitalDelta]\[Nu]p3C[k-8]+I (-I m q (3+8 l+8 n+4 s)+(3+20 l^2+20 n^2+6 s+2 s^2+4 n (5+4 s)+4 l (5+10 n+4 s)) \[Kappa]) \[CapitalDelta]\[Nu]p3C[k-7]-
2 \[CapitalDelta]\[Nu]p4C[k-10]+I (-2 I m q+(5+10 l+10 n+4 s) \[Kappa]) \[CapitalDelta]\[Nu]p4C[k-9]+2 I \[Kappa] \[CapitalDelta]\[Nu]p5C[k-11]-2\[CapitalDelta]\[Nu]p2C[k-8]+I (-2 I m q+\[Kappa]+6 l \[Kappa]+6 n \[Kappa]) \[CapitalDelta]\[Nu]p2C[k-7]+
(-12 l^2-12 n^2-2 s (1+s)-3 n (3+4 s)-3 l (3+8 n+4 s))\[CapitalDelta]\[Nu]p2C[k-6]+I (-I m q (12 n^2+2 s (1+s)+3 n (3+4 s))+20 l^3 \[Kappa]+
(-1+20 n^3+s^2+6 n^2 (5+4 s)+3 n (3+6 s+2 s^2)) \[Kappa]+6 l^2 (-2 I m q+(5+10 n+4 s) \[Kappa])+3 l (-I m q (3+8 n+4 s)+(3+20 n^2+6 s+2 s^2+4 n (5+4 s)) \[Kappa])) \[CapitalDelta]\[Nu]p2C[k-5]+
(1-4 l-4 n) \[CapitalDelta]\[Nu]pC[-6+k]+I (-I m (-1+4 l+4 n) q+(-1+6 l^2+2 n+6 n^2+2 l (1+6 n)) \[Kappa]) \[CapitalDelta]\[Nu]pC[-5+k]+
(-8 l^3-8 n^3-4 n s (1+s)+(1+s)^2-3 n^2 (3+4 s)-3 l^2 (3+8 n+4 s)-2 l (12 n^2+2 s (1+s)+3 n (3+4 s))) \[CapitalDelta]\[Nu]pC[-4+k]+
I (1+l+n+s) (-I m q (-1+l+8 l^2+n+16 l n+8 n^2-s+4 l s+4 n s)+
(-1+10 l^3+10 n^3-s+n (-1+2 s)+2 n^2 (5+3 s)+2 l^2 (5+15 n+3 s)+l (-1+30 n^2+2 s+4 n (5+3 s))) \[Kappa]) \[CapitalDelta]\[Nu]pC[-3+k]);

\[Beta]C[n_,k_]:=\[Beta]C[n,k]=((-3+4 l^2+4 n+4 n^2+l (4+8 n)) If[-4+k==0,1,0]-m (-3+4 l^2+4 n+4 n^2+l (4+8 n)) q If[-3+k==0,1,0]+
1/4 (3-4 l^2-4 n-4 n^2-l (4+8 n)) (l^2 (-8+q^2)+n (-8+q^2)+n^2 (-8+q^2)+l (1+2 n) (-8+q^2)-4 s^2) If[-2+k==0,1,0]-
m (-3+4 l^2+4 n+4 n^2+l (4+8 n)) q s^2 If[-1+k==0,1,0]+n (8 l^5+4 l^4 (5+9 n)+n (1+n)^2 (-3+4 n+4 n^2)+2 l^3 (5+36 n+32 n^2)+
l^2 (-5+29 n+96 n^2+56 n^3)+l (-3-7 n+28 n^2+56 n^3+24 n^4)) If[k==0,1,0]-8 (1+2 l+2 n) Sum[\[CapitalDelta]\[Nu]p3C[k-6-i]*\[CapitalDelta]EC[s, l, m, i], {i, 0, k-6}]-
4 Sum[\[CapitalDelta]\[Nu]p4C[k-8-i]*\[CapitalDelta]EC[s, l, m, i], {i, 0, k - 8}]+(-1-24 l^2-24 n-24 n^2-24 l (1+2 n))Sum[\[CapitalDelta]\[Nu]p2C[k-4-i]*\[CapitalDelta]EC[s, l, m, i], {i, 0, k - 4}]-
2 (1+2 l+2 n) (-8+q^2) \[CapitalDelta]\[Nu]p3C[k-8]+(-2+64 l^3+36 n+120 n^2+80 n^3+32 l^2 (3+7 n)+4 l (7+56 n+60 n^2))\[CapitalDelta]\[Nu]p3C[k-6]+
(8-q^2) \[CapitalDelta]\[Nu]p4C[k-10]+(9+56 l^2+60 n+60 n^2+8 l (7+15 n))\[CapitalDelta]\[Nu]p4C[k-8] +12 (1+2 l+2 n) \[CapitalDelta]\[Nu]p5C[k-10]+
4 \[CapitalDelta]\[Nu]p6C[k-12]+(3-16 l^3-2 n-24 n^2-16 n^3-24 l^2 (1+2 n)-l (2+48 n+48 n^2)) Sum[\[CapitalDelta]EC[s, l, m, i]*\[CapitalDelta]\[Nu]pC[-2 - i + k], {i, 0, -2 + k}]+
4 \[CapitalDelta]\[Nu]p2C[k-8]-4 m q \[CapitalDelta]\[Nu]p2C[k-7]+(2-q^2/4-6 l^2 (-8+q^2)-6 n (-8+q^2)-6 n^2 (-8+q^2)-6 l (1+2 n) (-8+q^2)+4 s^2) \[CapitalDelta]\[Nu]p2C[k-6]-
4 m q s^2 \[CapitalDelta]\[Nu]p2C[k-5]+(-3+36 l^4-6 n+54 n^2+120 n^3+60 n^4+24 l^3 (3+8 n)+l^2 (29+288 n+336 n^2)+l (-7+84 n+336 n^2+240 n^3)) \[CapitalDelta]\[Nu]p2C[k-4]+
(-4 l^4-8 l^3 (1+2 n)-l^2 (1+24 n+24 n^2)-n (-3+n+8 n^2+4 n^3)-l (-3+2 n+24 n^2+16 n^3)) \[CapitalDelta]EC[s,l,m,k]+(4+8 l+8 n) \[CapitalDelta]\[Nu]pC[-6+k]-
4 m (1+2 l+2 n) q \[CapitalDelta]\[Nu]pC[-5+k]+1/4 (-1-2 l-2 n) (24-3 q^2+8 l^2 (-8+q^2)+8 n (-8+q^2)+8 n^2 (-8+q^2)+8 l (1+2 n) (-8+q^2)-16 s^2) \[CapitalDelta]\[Nu]pC[-4+k]-
4 m (1+2 l+2 n) q s^2 \[CapitalDelta]\[Nu]pC[-3+k]+(8 l^5+4 l^4 (5+18 n)+2 l^3 (5+72 n+96 n^2)+l^2 (-5+58 n+288 n^2+224 n^3)+6 n (-1-n+6 n^2+10 n^3+4 n^4)+
l (-3-14 n+84 n^2+224 n^3+120 n^4)) \[CapitalDelta]\[Nu]pC[-2+k]);

\[Gamma]C[n_,k_]:=\[Gamma]C[n,k]=((-3-2 l^2-5 n-2 n^2-l (5+4 n)) If[-4+k==0,1,0]-I (3+2 l^2+5 n+2 n^2+l (5+4 n)) (I m q+(l+n) \[Kappa]) If[-3+k==0,1,0]+
(-3-2 l^2-5 n-2 n^2-l (5+4 n)) (l+n-s)^2 If[-2+k==0,1,0]-I (3+2 l^2+5 n+2 n^2+l (5+4 n)) (l+n-s)^2 (I m q+(l+n) \[Kappa]) If[-1+k==0,1,0]-
2 I \[Kappa] \[CapitalDelta]\[Nu]p3C[k-9]+(-5-8 l-8 n+4 s)\[CapitalDelta]\[Nu]p3C[k-8]-I (I m q (5+8 l+8 n-4 s)+(3+20 l^2+20 n+20 n^2+4 l (5+10 n-4 s)-10 s-16 n s+2 s^2) \[Kappa]) \[CapitalDelta]\[Nu]p3C[k-7]-
2 \[CapitalDelta]\[Nu]p4C[k-10]-I (2 I m q+(5+10 l+10 n-4 s) \[Kappa]) \[CapitalDelta]\[Nu]p4C[k-9]-2 I \[Kappa] \[CapitalDelta]\[Nu]p5C[k-11]-2 \[CapitalDelta]\[Nu]p2C[k-8]-I (2 I m q+(5+6 l+6 n) \[Kappa])\[CapitalDelta]\[Nu]p2C[k-7]+
(-3-12 l^2-12 n^2-3 l (5+8 n-4 s)+10 s-2 s^2+3 n (-5+4 s))\[CapitalDelta]\[Nu]p2C[k-6]-I (I m q (3+12 l^2+12 n^2+3 l (5+8 n-4 s)-10 s+2 s^2-3 n (-5+4 s))+
(20 l^3+20 n^3+6 l^2 (5+10 n-4 s)-6 n^2 (-5+4 s)+s (-6+5 s)+n (9-30 s+6 s^2)+l (9+60 n^2+n (60-48 s)-30 s+6 s^2)) \[Kappa]) \[CapitalDelta]\[Nu]p2C[k-5]+
(-5-4 l-4 n) \[CapitalDelta]\[Nu]pC[-6+k]-I (I m (5+4 l+4 n) q+(3+6 l^2+10 n+6 n^2+2 l (5+6 n)) \[Kappa]) \[CapitalDelta]\[Nu]pC[-5+k]+
(-8 l^3-8 n^3-3 l^2 (5+8 n-4 s)+(6-5 s) s+3 n^2 (-5+4 s)+n (-6+20 s-4 s^2)-2 l (3+12 n^2-10 s+2 s^2-3 n (-5+4 s))) \[CapitalDelta]\[Nu]pC[-4+k]-
I (l+n-s) (I m q (6+8 l^2+8 n^2+n (15-4 s)+l (15+16 n-4 s)-5 s)+
(10 l^3+10 n^3+n (9-10 s)+l (9+30 n^2+n (40-12 s)-10 s)+n^2 (20-6 s)+l^2 (20+30 n-6 s)-3 s) \[Kappa]) \[CapitalDelta]\[Nu]pC[-3+k]);

Do[\[CapitalDelta]\[Nu]pC[k]=0,{k,-12,-1}];
\[Beta]C[-l,2]=\[Beta]C[-l,2]//Simplify;
\[Beta]C[-l,1]=\[Beta]C[-l,1]//Simplify;
\[Alpha]C[-l-1,2]=\[Alpha]C[-l-1,2]//Simplify;

\[Kappa]Simplify[x_]:=Expand[x]/.\[Kappa]^2->(1-q^2);
\[CapitalDelta]\[Alpha]\[Beta]C[n_,k_]:=(\[Beta]C[-l,k]- \[Alpha]C[-l-1,k])//\[Kappa]Simplify;

ProgressGrid:=Grid[
Table[
If[i==0,If[j<2||NumericQ[\[CapitalDelta]\[Nu]pC[j-2]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]}],Item[j,Background->Green],Item[j,Background->Yellow]],
If[TrueQ[acSolved[i,j]],If[NumericQ[ac[i,j]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]}],If[(ac[i,j]/.{q->1/Sqrt[2],\[Kappa]->1/Sqrt[2]})==0,Item[" ",Background->Magenta],Item[" ",Background->Red]],Item[" ",Background->Orange]] ,If[j<aLeadingBehaviour[l,i] ,If[j==-1,Item[i],Item[" "]] ,Item[" ",Background->Blue]]]],{i,ExpOrder+2,-ExpOrder-2,-1},{j,-1,ExpOrder+2}],ItemSize->All,Frame->All];
StructureGrid:=Grid[
Table[
If[i==0,Item[j,Background->Yellow],
If[j<aLeadingBehaviour[l,i],If[j==-1,Item[i],Item[" "]] ,Switch[i-j,-2l,Item[" ",Background->Cyan],-4l,Item[" ",Background->Gray],_,Item[" ",Background->Blue]]]],{i,ExpOrder+2,-ExpOrder-2,-1},{j,-1,ExpOrder+2}],ItemSize->All,Frame->All];

<<SpinWeightedSpheroidalHarmonics`;

AngExpOrder=ExpOrder+Boole[s==0 && l==1]+2 Boole[s==0 && l==0]+Boole[s==-1 && l==1];

\[CapitalDelta]E[s,l,m]= (Normal[Series[SpinWeightedSpheroidalEigenvalue[s,l,m,\[Gamma]],{\[Gamma],0,AngExpOrder}]]/.\[Gamma]->q \[Epsilon]/2)+O[\[Epsilon]]^(AngExpOrder+1)-l(l+1)+s(s+1)+ m q \[Epsilon]-(q \[Epsilon]/2)^2;
\[CapitalDelta]EC[s,l,m,0]=0;
Do[\[CapitalDelta]EC[s,l,m,i]=Coefficient[\[CapitalDelta]E[s,l,m],\[Epsilon],i],{i,1,AngExpOrder}];

ClearAll[aMST,ac,acq,eqnlist,\[CapitalDelta]\[Nu]p,\[CapitalDelta]\[Nu]pc];

If[s==-2,
	aShift[l,n_]:=Which[n<=l-2,0,n==l-1,2,n==l,1,
		n>l&&n<2l+1,0,
		n>=2l+1,-2];
	eqShift[l,n_]:=Which[n<=l-3,0,n==l-2,4,n==l-1,4,n==l,5-Boole[l==2],
		n>l&&n<2l+1,1,
		n>=2l+1,-1];];
If[s==-1,
	aShift[l,n_]:=Which[n<=l-2,0,n==l-1,If[l==1||m==0,0,2],n==l,1+Boole[l>1&&m==0],
		n>l&&n<2l+1,Boole[l>1&&m==0],
		n>=2l+1,-2];
	eqShift[l_,n_]:=Which[n<=l-3,0,n==l-2,4,n==l-1,4,n==l,5,
		n>l&&n<2l+1,1,
		n>=2l+1,-1];];
If[s==0,aShift[l,n_]:=Which[n<2l+1,0,n>=2l+1,-2+Boole[l==0]];
	(*aShift[l_,n_]:=Which[n<2l+1,0,n>=2l+1,-2];*)
	eqShift[l,n_]:=Which[n<=l-3,0,n==l-2,2,n==l-1,4,n==l,3,
		n>l&&n<2l+1,1,
		n>=2l+1,-1];
		];	

aLeadingBehaviour[l,n_]=aLeadingBehaviour[l,n]=If[n>=0,n,-n+aShift[l,-n]];

(*aMST[0]=1;
ac[0,_]=0;
ac[0,0]=1;
Do[aMST[n]=Sum[ac[n,i]\[Epsilon]^i,{i,n,ExpOrder+1}],{n,1,ExpOrder+2}];
Do[ac[n,i]=0,{n,1,ExpOrder+2},{i,0,n-1}];
Do[ac[n,i]=If[EvenQ[i],Sum[acq[n,i,j]q^j,{j,0,i,2}]+I \[Kappa] Sum[acq[n,i,j]q^j,{j,1,i,2}],Sum[acq[n,i,j]q^j,{j,1,i,2}]+I \[Kappa] Sum[acq[n,i,j]q^j,{j,0,i,2}]],{n,1,ExpOrder+2},{i,n,ExpOrder+1}];
Do[aMST[-n]=Sum[ac[-n,i]\[Epsilon]^i,{i,n+aShift[l,n],ExpOrder+1}],{n,1,ExpOrder+3}];
Do[ac[-n,i]=0,{n,1,ExpOrder+3},{i,0,n+aShift[l,n]-1}];
Do[ac[-n,i]=If[EvenQ[i],Sum[acq[-n,i,j]q^j,{j,0,i,2}]+I \[Kappa] Sum[acq[-n,i,j]q^j,{j,1,i,2}],Sum[acq[-n,i,j]q^j,{j,1,i,2}]+I \[Kappa] Sum[acq[-n,i,j]q^j,{j,0,i,2}]],{n,1,ExpOrder+2},{i,n+aShift[l,n],ExpOrder+1}];
If[m == 0,Do[Do[acq[-n,n-2,i]=0;acqSolved[-n,n-2,i]=True,{i,0,n-2}];acSolved[-n,n-2]=True,{n,2l+1,ExpOrder+2}]];
*)
aMST[0]=1;
ac[0,_]=0;
ac[0,0]=1;
Do[aMST[n]=Sum[ac[n,i]\[Epsilon]^i,{i,n,ExpOrder+1}],{n,1,ExpOrder+2}];
Do[ac[n,i]=0,{n,1,ExpOrder+2},{i,0,n-1}];
Do[ac[n,i]=If[EvenQ[i],Sum[acq[n,i,j]q^j,{j,0,i,2}]+I \[Kappa] Sum[acq[n,i,j]q^j,{j,1,i,2}],Sum[acq[n,i,j]q^j,{j,1,i,2}]+I \[Kappa] Sum[acq[n,i,j]q^j,{j,0,i,2}]],{n,1,ExpOrder+2},{i,n,ExpOrder+1}];
Do[aMST[-n]=Sum[ac[-n,i]\[Epsilon]^i,{i,n+aShift[l,n],ExpOrder+1}],{n,1,ExpOrder+4}];
Do[ac[-n,i]=0,{n,1,ExpOrder+4},{i,0,n+aShift[l,n]-1}];
Do[ac[-n,i]=If[EvenQ[i],Sum[acq[-n,i,j]q^j,{j,0,i,2}]+I \[Kappa] Sum[acq[-n,i,j]q^j,{j,1,i,2}],Sum[acq[-n,i,j]q^j,{j,1,i,2}]+I \[Kappa] Sum[acq[-n,i,j]q^j,{j,0,i,2}]],{n,1,ExpOrder+4},{i,n+aShift[l,n],ExpOrder+1}];
If[m == 0,Do[Do[acq[-n,n-2,i]=0;acqSolved[-n,n-2,i]=True,{i,0,n-2}];acSolved[-n,n-2]=True,{n,2l+1,ExpOrder+4}]];
(*SetAttributes[aMST,NHoldAll];
SetAttributes[ac,NHoldAll];*)

\[CapitalDelta]\[Nu]p=Sum[\[CapitalDelta]\[Nu]pC[i] \[Epsilon]^i,{i,0,ExpOrder+1}];
Do[\[CapitalDelta]\[Nu]pC[i]=If[EvenQ[i],Sum[\[CapitalDelta]\[Nu]pcq[i,j]q^j,{j,0,i,2}],Sum[\[CapitalDelta]\[Nu]pcq[i,j]q^j,{j,1,i,2}]],{i,0,ExpOrder+1}];

EqC[n_,k_]:=Sum[\[Alpha]C[n-1,k-i]ac[n,i]+\[Beta]C[n-1,k-i]ac[n-1,i]+\[Gamma]C[n-1,k-i]ac[n-2,i],{i,Min[Abs[n]+aShift[l,-n],Abs[n-1]+aShift[l,-(n-1)],Abs[n-2]+aShift[l,-(n-2)]],k}];
\[CapitalDelta]EqC[n_,k_]:=Sum[\[Alpha]C[n,k-i]ac[n+1,i]+(\[Beta]C[n,k-i]- \[Alpha]C[n-1,k-i])ac[n,i]+(\[Gamma]C[n,k-i]- \[Beta]C[n-1,k-i])ac[n-1,i]+(-\[Gamma]C[n-1,k-i])ac[n-2,i],{i,Min[Abs[n+1]+aShift[l,-(n+1)],Abs[n]+aShift[l,-n],Abs[n-1]+aShift[l,-(n-1)],Abs[n-2]+aShift[l,-(n-2)]],k}];

EqCL[n_,p_]:=\[Kappa]Simplify[EqC[n,Min[Abs[n]-eqShift[l,-n]+If[n>1,0,2]+p,ExpOrder+eqShift[l,-n]+2]]];
\[CapitalDelta]EqCL[n_,p_]:=\[Kappa]Simplify[\[CapitalDelta]EqC[n,Min[Abs[n]-eqShift[l,-n]+If[n>1,0,2]+p,ExpOrder+eqShift[l,-n]+2]]];

\[CapitalDelta]EqCTable[n_,k_]:=Table[{\[Alpha]C[n,k-i]ac[n+1,i],(\[Beta]C[n,k-i]- \[Alpha]C[n-1,k-i])ac[n,i]+(\[Gamma]C[n,k-i]- \[Beta]C[n-1,k-i])ac[n-1,i],(-\[Gamma]C[n-1,k-i])ac[n-2,i]},{i,Min[Abs[n+1]+aShift[l,-(n+1)],Abs[n]+aShift[l,-n],Abs[n-1]+aShift[l,-(n-1)],Abs[n-2]+aShift[l,-(n-2)]],k}];

Clear[Solveac];
Solveac[i_?IntegerQ,j_?IntegerQ,Eq_,drop_?IntegerQ]:=Module[{tmpEq,tmp,tmpN,tmpD,shift,Verbose=False,acSolve=True},
If[(i>0&&j(*+i*)>ExpOrder+Boole[l==0])||(i<0&&j(*-i*)>ExpOrder+2),acSolve=False;Return[]];(* remove commented terms if only want \[Nu] *)
If[Abs[j]<=ExpOrder+1&&acSolve,tmpEq=Drop[CoefficientList[Eq,q],drop];
If[Verbose,Print[tmpEq,"\t",Dimensions[tmpEq][[1]]]];
shift=0; 
Do[
	tmpN=\[Kappa]Simplify[Coefficient[tmpEq[[k+1]],acq[i,j,k+shift],0]];
	tmpD=-\[Kappa]Simplify[Coefficient[tmpEq[[k+1]],acq[i,j,k+shift]]];
	If[Verbose,Print["i=",i,"\t j=",j, "\t k=",k,"\t tmpN:=",tmpN,"\t tmpD:=",tmpD]];
	If[tmpD==0,Print["Attempted division by 0 in Solveac\n i=",i,"\t j=",j,"\t k+shift=",k+shift,"\t tmpEq=",Simplify[tmpEq]];Continue[]];
	tmp=tmpN/tmpD;
	If[Verbose,Print["Eq:\t",tmpEq,"\t",tmpN,"\t",tmpD,"\t",tmp]];
	acq[i,j,k+shift]=\[Kappa]Simplify[tmp];
	acqSolved[i,j,k+shift]=True;
	If[Verbose && acq[i,j,k+shift]==0,Print["Vanishing acq for i=",i,"\t j=",j,"\t k=",k]],
{k,0,j}];
ac[i,j]=Collect[ac[i,j],\[Kappa]];
acSolved[i,j]=True];
If[Verbose,Print[ac[i,j]]];
];

Clear[Solve\[CapitalDelta]\[Nu]];
Solve\[CapitalDelta]\[Nu][i_?IntegerQ,p_?IntegerQ, OptionsPattern[]]:=Module[{tmpEq,tmp,tmpN,tmpD,shift,Verbose=False},
shift=If[EvenQ[i],0,1];
tmpEq=Take[CoefficientList[EqCL[1,p],q],{shift+1,-1,2}];
Do[
	tmpN=Coefficient[tmpEq[[k+1]],\[CapitalDelta]\[Nu]pcq[i,2k+shift],0];
	tmpD=-Coefficient[tmpEq[[k+1]],\[CapitalDelta]\[Nu]pcq[i,2k+shift]];	
	If[tmpD==0,Print["Attempted division by 0 in Solve\[CapitalDelta]\[Nu] (i=",i,"\t 2k+shift=",2k+shift,")"],tmp=tmpN/tmpD];
	\[CapitalDelta]\[Nu]pcq[i,2k+shift]=\[Kappa]Simplify[tmp],
{k,0,Floor[i/2]}];
If[Verbose,Print["i=",i,"\t \[CapitalDelta]\[Nu]pC[",i,"]=",\[CapitalDelta]\[Nu]pC[i]]];
];


Which[s==-2,
	(*Print["s =-2 code"];*)
		Which[l==2 && m!=0,
		
		p=0;
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
		Solve\[CapitalDelta]\[Nu][p,p-1];
		p=1;
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
		Solve\[CapitalDelta]\[Nu][p,p-1];
		Solveac[-1,p+2,EqCL[0,p+4],0];		
		Do[
			Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
			Solve\[CapitalDelta]\[Nu][p,p-1];
			Solveac[-1,p+2,EqCL[0,p+4],0];
			If[p==2,Solveac[-2,3,EqCL[-1,5],1]];
			Solveac[-2,p+2,(\[Beta]C[-2,2]- \[Alpha]C[-3,2])EqCL[-1,p+3]- \[Beta]C[-2,1] \[CapitalDelta]EqCL[-2,p+4],1];
			Solveac[-3,p+1,EqCL[-2,p+3],0];
			If[p<ExpOrder,
				Solveac[-4,p+2,EqCL[-3,p-2],0];
				Solveac[-5,p+1,EqCL[-4,p-2],0];
				Do[Solveac[-n,n+p-4,EqCL[-n+1,p-6],0],{n,6,ExpOrder+2+Boole[ExpOrder==3]}]],
		{p,2,ExpOrder}],
				
		l==2 && m==0,
		
		p=0;
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
		Solve\[CapitalDelta]\[Nu][p,p-1];
		p=1;
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
		Solve\[CapitalDelta]\[Nu][p,p-1];
		Solveac[-1,p+2,EqCL[0,p+4],0];
		Do[
			Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}];
			Solve\[CapitalDelta]\[Nu][p,p-1];
			Solveac[-1,p+2,EqCL[0,p+4],0];
			Solveac[-2,p+1,EqCL[-1,p+4],0];
			Solveac[-3,p+1,EqCL[-2,p+3],0];
			Solveac[-4,p+2,EqCL[-3,p-2],0];
			If[p>2&&p<ExpOrder,
				Solveac[-5,p+1,EqCL[-4,p-2],0];
				Do[Solveac[-n,n+p-4,EqCL[-n+1,p-6],0],{n,6,ExpOrder+2}]],
		{p,2,ExpOrder}],
		
		l>2,
		Do[
		   Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
		   Do[Solveac[-n,n+p,EqCL[-n+1,p-1],0],{n,1,l-2}];
		   Solve\[CapitalDelta]\[Nu][p,p-1],
		{p,0,3}];
		
		p=3;
		If[m != 0,Solveac[-(l-1),l+1+(p-3),EqCL[-(l-2),(p-3)+5],0]];
		
		Do[
			If[m == 0,Solveac[-(l+1),l+1+(p-4),EqCL[-(l-1),p+2],0],Solveac[-(l+1),l+1+(p-4),EqCL[-(l-1),p+1],1]];
			If[m == 0,Solveac[-l,l+1+(p-4),EqCL[-l,p+2],0],Solveac[-l,l+1+(p-4),(\[Beta]C[-l,2]- \[Alpha]C[-l-1,2])EqCL[-l+1,p+2]- \[Beta]C[-l,1] \[CapitalDelta]EqCL[-l,p+3],0]]; 
			If[m == 0,Solveac[-(l-1),l+1+(p-4),EqCL[-(l-2),p+1],0],Solveac[-(l-1),l+2+(p-4),EqCL[-(l-2),p+2],0]];
			
			Do[If[n+p-4<=ExpOrder+2,Solveac[-n,n+(p-4),EqCL[-n+1,p-4],0]],{n,l+2,2l-1}];
			If[p>3+Boole[m==0]&&2l+p-4<=ExpOrder+1,Solveac[-2l-1,2l+(p-4)-1,EqCL[-2l,(p-4)],0]];
		    If[p>3+Boole[m==0]&&2l+p-4<=ExpOrder+1,Solveac[-2l-2,2l+(p-4),EqCL[-2l-1,(p-4)-4],0]];
		    If[2l+p-4<=ExpOrder+1,Solveac[-2l,2l+(p-4),EqCL[-2l+1,p-4],0]];
			Do[If[p>3+Boole[m==0]&&n-1+p-4<=ExpOrder,Solveac[-n-1,n-1+p-4,EqCL[-n,(p-4)-4],0]],{n,2l+2,ExpOrder+1}];
			Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder-p}]; 
			Do[If[n+p<=ExpOrder,Solveac[-n,n+p,EqCL[-n+1,p-1],0]],{n,1,l-2}];
			
			If[p<=ExpOrder,Solve\[CapitalDelta]\[Nu][p,p-1]],
		{p,4,ExpOrder+Boole[l==2]}]],

s==-1,
	(*Print["s =-1 code"];*)
	  Which[l==1 && m!=0,
	    (*Print["l = 1, m != 0 code"];*)
	    If[m==0,ac[-2l,2l]=0;acSolved[-2l,2l]=True];
	    
        Do[
		Do[If[n+p<=ExpOrder+2,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
		Which[p>0&&p!=3, 
				Solveac[-1,p+1,\[CapitalDelta]EqCL[-1,p+5],0],
			p==3,
				Solveac[-1,p+1,FromDigits[Reverse[Join[Drop[CoefficientList[(\[Beta]C[-l,2]- \[Alpha]C[-l-1,2])EqCL[-l+1,p+4]- \[Beta]C[-l,1] \[CapitalDelta]EqCL[-l,p+5],q],1],Drop[CoefficientList[EqCL[-l+1,p+4],q],4]]],q],0]];
		Which[p>0&&p<3,	
				Solveac[-2,p+1,EqCL[-1,p+5],0],
			p>3,
				Solveac[-2,p,FromDigits[Reverse[Join[CoefficientList[(\[Beta]C[-l,2]- \[Alpha]C[-l-1,2])EqCL[-l+1,p+4]- \[Beta]C[-l,1] \[CapitalDelta]EqCL[-l,p+5],q],Drop[CoefficientList[EqCL[-l+1,p+4],q],4]]],q],0]];
		If[p>1,
			Solveac[-4,p,EqCL[-3,p-6],0];
			Solveac[-3,p-1,EqCL[-2,p-2],0];
			Do[Solveac[-n,p+n-4,EqCL[-n+1,p-6],0],{n,5,ExpOrder+2}]];
		Solve\[CapitalDelta]\[Nu][p,p+3],
		{p,0,ExpOrder+1}],	 
		
		l==1 && m==0,		
		(*Print["l = 1, m = 0 code"];*)
		
		Do[
			Do[If[n+p<=ExpOrder+2,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
			If[p>0,
				Solveac[-1,p+1,\[CapitalDelta]EqCL[-1,p+5],0];
				Solveac[-2,p+1,EqCL[-1,p+5],0]];
			If[p>1,
				Solveac[-4,p+1,EqCL[-3,p-5],0];
				Solveac[-3,p,EqCL[-2,p-1],0];
				Do[Solveac[-n,p+n-3,EqCL[-n+1,p-5],0],{n,5,ExpOrder+2}]];
			Solve\[CapitalDelta]\[Nu][p,p+3],
		{p,0,ExpOrder}],			    			    			    			    
	    
		l>1,
	    (*Print["l > 1 code"];*)
	    Do[
		   Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
		   Do[Solveac[-n,n+p,EqCL[-n+1,p-1],0],{n,1,l-2}];
		   If[m==0,Solveac[-(l-1),(l-1)+p,EqCL[-(l-1)+1,p+3],0]];
		   Solve\[CapitalDelta]\[Nu][p,p-1],
		{p,0,3}];
        
		Do[
			Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
			Do[If[n+p<=ExpOrder,Solveac[-n,n+p,EqCL[-n+1,p-1],0]],{n,1,l-2}];
			If[m==0,
						Solveac[-l,l+p-2,EqCL[-l+1,p+3],0];
						Solveac[-(l+1),l+1+p-3,EqCL[-l,p+3],0];
						Solveac[-(l-1),(l-1)+p,EqCL[-(l-1)+1,p+3],0],
						Solveac[-(l+1),l+p-3,EqCL[-(l-1),p+1],1];
						Solveac[-l,l+1+(p-4),(\[Beta]C[-l,2]- \[Alpha]C[-l-1,2])EqCL[-l+1,p+2]- \[Beta]C[-l,1] \[CapitalDelta]EqCL[-l,p+3],0];
						Solveac[-(l-1),(l-1)+p-2,EqCL[-(l-2),p+1],0]];
			Do[If[True,Solveac[-n,n+(p-4)+Boole[m==0],EqCL[-n+1,p-4+Boole[m==0]],0]],{n,l+2,2l-1}];
			If[True,Solveac[-2l-1,2l+(p-4)-1+Boole[m==0],EqCL[-2l,(p-4)+Boole[m==0]],0]];
			If[2l-1+p-4<=ExpOrder+1,Solveac[-2l-2,2l+(p-4)+Boole[m==0],EqCL[-2l-1,(p-4)-4+Boole[m==0]],0]];
			If[True,Solveac[-2l,2l+(p-4)+Boole[m==0],EqCL[-2l+1,p-4+Boole[m==0]],0]];
			Do[If[True,Solveac[-n-1,n-1+p-4+Boole[m==0],EqCL[-n,(p-4)-4+Boole[m==0]],0]],{n,2l+2,ExpOrder-p+5}];
			If[p<=ExpOrder,Solve\[CapitalDelta]\[Nu][p,p-1]],
		{p,4,ExpOrder+Boole[l==2]}]],

s==0,
	(*Print["s =0 code"];*)
Which[
	l==0,
	(*Print["l = 0 code"];*)
		p=0;
		Solveac[1,1+p,EqCL[1+1,p+1],0];		
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,2,ExpOrder-p}]; 
		Solveac[-2,1,EqCL[-1,-3],0];
		Solveac[-1,0,EqCL[0,5],0];
		(* \[CapitalDelta]\[Nu]pcq[0,0]=\[CapitalDelta]\[Nu]pcq[0,0]/.Solve[CoefficientList[EqCL[1,5],q]==0,\[CapitalDelta]\[Nu]pcq[0,0]][[1]] gives multiple solutions so hard code;*);
		\[CapitalDelta]\[Nu]pcq[0,0]=-(7/6);
		Do[Solveac[-n,n-1,EqCL[-n+1,-3],0],{n,3,ExpOrder+1}];
	
		Do[
		Solveac[1,1+p,EqCL[1+1,p+1],0];
		Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,2,ExpOrder-p}]; 
		Solveac[-2,1+p,EqCL[-1,-3+p],0];
		Solveac[-1,p,EqCL[0,5+p],0];
		Solve\[CapitalDelta]\[Nu][p,p+5];
		Do[Solveac[-n,n-1+p,EqCL[-n+1,-3+p],0],{n,3,ExpOrder-p+2}],
		{p,1,ExpOrder}],		
	l==1,
	(*Print["l = 1 code"];*)
		 If[m==0&&l!=0,ac[-2l,2l]=0;acSolved[-2l,2l]=True];
		 
		 Do[
			 Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder-p}]; 
			Solveac[-(l),l+p,EqCL[-(l-1),p+5],0];
			Solve\[CapitalDelta]\[Nu][p,p+1];
			If[p>=Boole[m==0],
			Solveac[-2l,2l+p,EqCL[-(2l-1),(p+4)],0];
			Solveac[-(2l+2),2l+p,EqCL[-(2l+1),p-4],0];
			Solveac[-(2l+1),2l-1+p,EqCL[-2l,p],0];
			Do[If[n+(p-2)<=ExpOrder+1,Solveac[-n-1,n+p-1,EqCL[-n,p-4],0]],{n,2l+2,ExpOrder-(p-1)}]],
		{p,0,ExpOrder-1}],
	l>=2,
	(*Print["l >= 2 code"];*)
		 If[m==0&&l!=0,ac[-2l,2l]=0;acSolved[-2l,2l]=True];
		 
		 Do[
		   Do[If[n+p<=ExpOrder,Solveac[n,n+p,EqCL[n+1,p-1],0]],{n,1,ExpOrder}]; 
		   Do[If[n+p<=ExpOrder,Solveac[-n,n+p,EqCL[-n+1,p-1],0]],{n,1,l-2}];
		   Solve\[CapitalDelta]\[Nu][p,p-1];
		   Solveac[-(l-1),l-1+p,EqCL[-(l-2),p+1],0];
		   Solveac[-(l),l+p,EqCL[-(l-1),p+5],0];
		   Solveac[-(l+1),l+1+p,EqCL[-l,p+4],0];
		   Do[Solveac[-n,n+p,EqCL[-(n-1),p],0],{n,l+2,2l-1}];
		   If[p>=2+Boole[m==0],
				Solveac[-(2l+2),2l+(p-2),EqCL[-(2l+1),(p-2)-4],0];
		       Solveac[-2l,2l+(p-2),EqCL[-(2l-1),(p-2)],0];
		       Solveac[-(2l+1),2l-1+(p-2),EqCL[-2l,(p-2)],0];
		    Do[If[p<ExpOrder,Solveac[-n-1,n+(p-2)-1,EqCL[-n,(p-2)-4],0]],{n,2l+2,ExpOrder+1}]],
		{p,0,ExpOrder-1}]]
];


Print[ProgressGrid];
\[Nu]MST=l+Sum[\[CapitalDelta]\[Nu]pC[i] \[Epsilon]^(i+2),{i,0,ExpOrder-2}]+O[\[Epsilon]]^(ExpOrder+1);
MST=Association[{\[Nu]->\[Nu]MST}];
MST=Append[MST,Table[a[i]->aMST[i]+If[i==0,0,O[\[Epsilon]]^(ExpOrder+1)],{i,-ExpOrder-2,ExpOrder}]]

]


(* ::Subsection::Closed:: *)
(*Definitions, replacements and auxiliary functions*)


(* ::Subsubsection::Closed:: *)
(*Assumptions *)


assumps={r>2,r0>2,a>=0,\[Eta]>0,\[Omega]>=0}


(* ::Subsubsection::Closed:: *)
(*MST Coefficients*)


(*replsMST[]:=Module[{aux,values,order\[Eta]=30},
aux=Normal/@Block[{Print},KerrMSTSeries[-2,2,2,order\[Eta]/3//Ceiling]//.replsKerr];
values=Replace[#,a_:>a+O[\[Eta]]^Ceiling[order\[Eta]+1,3]]&/@(Values@aux/.\[Epsilon]->2\[Omega]/.replsPN);
AssociationThread[Keys[aux]->values]];*)
(*
replsMST[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,order\[Eta]_]:=Module[{aux,values,res,\[Nu]Value},
aux=Normal/@Block[{Print},KerrMSTSeries[\[ScriptS],\[ScriptL],\[ScriptM],order\[Eta]/3+1//Ceiling]//.replsKerr/.q->a];
\[Nu]Value=Replace[#,a_:>a+O[\[Eta]]^Ceiling[order\[Eta]+1,3]]&@(aux[\[Nu]]/.\[Epsilon]->2\[Omega]/.replsPN);
values=Replace[#,a_:>a+O[\[Eta]]^Ceiling[order\[Eta]+1,3]]&/@(Values@KeyDrop[#,\[Nu]]&@aux/.\[Epsilon]->2\[Omega]/.replsPN);
values=Insert[values,\[Nu]Value,1];
res=AssociationThread[Keys[aux]->values]];*)

replsMST[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,order\[Eta]_]:=Module[{aux,values,res,\[Nu]Value},
aux=Normal/@Block[{Print},KerrMSTSeries[\[ScriptS],\[ScriptL],\[ScriptM],order\[Eta]/3+1//Ceiling]//.replsKerr/.q->a];
\[Nu]Value=Replace[#,a_:>a+O[\[Eta]]^(order\[Eta]+1)]&@(aux[\[Nu]]/.\[Epsilon]->2\[Omega]/.replsPN);
values=Replace[#,a_:>a+O[\[Eta]]^(order\[Eta]+1)]&/@(Values@KeyDrop[#,\[Nu]]&@aux/.\[Epsilon]->2\[Omega]/.replsPN);
values=Insert[values,\[Nu]Value,1];
res=AssociationThread[Keys[aux]->values]];


MSTCoefficientsInternal[\[ScriptS]_Integer,\[ScriptL]_Integer,\[ScriptM]_,aKerr_,order\[Eta]_Integer]:=Block[{aux,values,keys},
aux=replsMST[\[ScriptS],\[ScriptL],\[ScriptM],order\[Eta]];
values=Values[aux]/.a->aKerr;
keys=Keys[aux]/.{a[n_]:>aMST[n],\[Nu]->\[Nu]MST};
keys->values//Thread//Association
]


MSTCoefficients[\[ScriptS]_Integer,\[ScriptL]_Integer,\[ScriptM]_,aKerr_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_Integer}]:=MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],aKerr,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var}


(* ::Subsubsection::Closed:: *)
(*Spacetime replacements*)


(*x[r_]:=((1+\[Kappa])-r)/(2 \[Kappa]);*)
z[r_]:=\[Epsilon] \[Kappa] (1-((1+\[Kappa])-r)/(2 \[Kappa]));
replsKerr={\[Tau]->(\[Epsilon]-\[ScriptM] a)/\[Kappa],\[Kappa]->Sqrt[1-a^2]};
replsSchwarzschild={a->0,\[Kappa]->1,\[Lambda]->\[ScriptL](\[ScriptL]+1)-\[ScriptS](\[ScriptS]+1),\[Tau]->\[Epsilon]};
Schwarzschild=#/.replsSchwarzschild&;
Kerr\[CapitalDelta][a_,r_]:=\[CapitalDelta][a,1,r];


(* ::Subsubsection::Closed:: *)
(*Post Newtonian Scalings*)


replsPN={r->r \[Eta]^-2,r0->r0 \[Eta]^-2,\[Omega]->\[Omega] \[Eta]^3,\[CapitalOmega]Kerr->\[CapitalOmega]Kerr \[Eta]^3};
RemovePNInternal=Normal[#]/.\[Eta]->1&
RemovePN[expr_,\[Eta]_Symbol]:=Normal[expr]/.\[Eta]->1


PNScalingsInternal[expr_]:=expr/.\[Eta]->1/.replsPN
PNScalingsInternal[series_SeriesData]:=Module[{aux,termOrder},
termOrder=series//SeriesLength;
aux=series//RemovePNInternal;
aux//PNScalingsInternal//SeriesTerms[#,{\[Eta],0,termOrder}]&
]


Options[PNScalings]={"IgnoreHarmonics"->False}


PNScalings[expr_,arguments_List,\[Eta]_Symbol,OptionsPattern[]]:=Module[{aux,check,repls,replsOpt},
check=MatchQ[#,{a_Symbol,b_Integer}]&/@{{\[Omega],3},{r,2}}//Union;
If[!check,Return[$Failed]];
repls=(#[[1]]->#[[1]]\[Eta]^#[[2]]&)/@arguments;
replsOpt=If[OptionValue["IgnoreHarmonics"],{ SpinWeightedSpheroidalHarmonicS[a___]:>( SpinWeightedSpheroidalHarmonicS[a]/.{\[Eta]->1})},{}];
expr/.\[Eta]->1/.repls/.replsOpt
]

PNScalings[series_SeriesData,arguments_List,\[Eta]_Symbol,opt:OptionsPattern[]]:=Module[{aux,termOrder},
termOrder=series//SeriesLength;
aux=series//RemovePN[#,\[Eta]]&;
aux//PNScalings[#,arguments,\[Eta],opt]&//SeriesTerms[#,{\[Eta],0,termOrder}]&
]


Scalings[list_List,\[Eta]_Symbol][expr_]:=Module[{aux,repls,arguments},
arguments=list//Partition[#,2]&;
repls=(#[[1]]->#[[1]]\[Eta]^#[[2]]&)/@arguments;
expr/.\[Eta]->1/.repls
]
Scalings[arguments_List,\[Eta]_Symbol][series_SeriesData]:=Module[{aux,termOrder},
termOrder=series//SeriesLength;
aux=series//RemovePN[#,\[Eta]]&;
aux//Scalings[arguments,\[Eta]]//SeriesTerms[#,{\[Eta],0,termOrder}]&
]
Scalings[arguments_List,\[Eta]_Symbol][list_List]:=Scalings[arguments,\[Eta]][#]&/@list;


IgnoreExpansionParameter[series_SeriesData,symbol_:1]:=Module[{aux,param,newList},
param=series[[1]];
newList=series[[3]]/.param->symbol;
ReplacePart[series,3->newList]
]


Zero[var_Symbol][expr_]:=Module[{aux,repls},
repls=var->0;
expr/.repls]
Zero[vars_List][expr_]:=Module[{aux,repls},
repls=vars->0//Thread;
expr/.repls]
One[var_Symbol][expr_]:=Module[{aux,repls},
repls=var->1;
expr/.repls]
One[vars_List][expr_]:=Module[{aux,repls},
repls=vars->1//Thread;
expr/.repls]


CollectDerivatives[expr_,func_,extra_:Identity]:=Module[{aux,list},
list={func[__],Derivative[__][func][__]};
Collect[expr,list,extra]
];
CollectDerivatives[expr_,funcs_List,extra_:Identity]:=Module[{aux,list},
list={#[__],Derivative[__][#][__]}&/@funcs//Flatten;
Collect[expr,list,extra]
];


ExpandSpheroidals[expr_/;MatchQ[expr,SpinWeightedSpheroidalHarmonicS[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,\[Gamma]_][\[Theta]_,\[Phi]_]],{\[Eta]_,n_}]:=Module[{aux,\[ScriptS],\[ScriptL],\[ScriptM],\[Gamma],\[Theta],\[Phi],gam,n\[Gamma]},
{\[ScriptS],\[ScriptL],\[ScriptM],\[Gamma],\[Theta],\[Phi]}=expr/.{SpinWeightedSpheroidalHarmonicS[s_,l_,m_,gamma_][\[CurlyTheta]_,\[CurlyPhi]_]:>{s,l,m,gamma,\[CurlyTheta],\[CurlyPhi]}};
n\[Gamma]=\[Gamma]//Exponent[#,\[Eta]]&;
aux=SpinWeightedSpheroidalHarmonicS[\[ScriptS],\[ScriptL],\[ScriptM],gam][\[Theta],\[Phi]]//Series[#,{gam,0,n/n\[Gamma]//Ceiling}]&;
aux=Normal[aux]/.gam->\[Gamma];
aux//Series[#,{\[Eta],0,n}]&
]
ExpandSpheroidals[expr_/;MatchQ[expr,Derivative[__][SpinWeightedSpheroidalHarmonicS[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,\[Gamma]_]][\[Theta]_,\[Phi]_]],{\[Eta]_,n_}]:=Module[{aux,d\[Theta],d\[Phi],\[ScriptS],\[ScriptL],\[ScriptM],\[Gamma],\[Theta],\[Phi],gam,n\[Gamma],aux\[Theta],aux\[Phi]},
{d\[Theta],d\[Phi],\[ScriptS],\[ScriptL],\[ScriptM],\[Gamma],\[Theta],\[Phi]}=expr/.{Derivative[d\[CurlyTheta]_,d\[CurlyPhi]_][SpinWeightedSpheroidalHarmonicS[s_,l_,m_,gamma_]][\[CurlyTheta]_,\[CurlyPhi]_]:>{d\[CurlyTheta],d\[CurlyPhi],s,l,m,gamma,\[CurlyTheta],\[CurlyPhi]}};
aux=SpinWeightedSpheroidalHarmonicS[\[ScriptS],\[ScriptL],\[ScriptM],\[Gamma]][aux\[Theta],aux\[Phi]]//ExpandSpheroidals[#,{\[Eta],n}]&;
aux=aux//D[#,{aux\[Theta],d\[Theta]}]&//D[#,{aux\[Phi],d\[Phi]}]&;
aux=aux/.{aux\[Theta]->\[Theta],aux\[Phi]->\[Phi]}
]
ExpandSpheroidals[expr_Plus,{\[Eta]_,n_}]:=ExpandSpheroidals[#,{\[Eta],n}]&/@expr;
ExpandSpheroidals[expr_Times,{\[Eta]_,n_}]:=ExpandSpheroidals[#,{\[Eta],n}]&/@expr;
ExpandSpheroidals[expr_,{\[Eta]_,n_}]:=expr;


(* ::Subsubsection::Closed:: *)
(*Tools for Series*)


SeriesMinOrder[series_SeriesData]:=Block[{},
series[[4]]/series[[6]]
]
SeriesMinOrder[1]=0;
Attributes[SeriesMinOrder]={Listable};

SeriesMaxOrder[series_SeriesData]:=Block[{},
series[[5]]/series[[6]]
]
Attributes[SeriesMaxOrder]={Listable};

SeriesLength[series_SeriesData]:=Block[{},
SeriesMaxOrder[series]-SeriesMinOrder[series]
]
Attributes[SeriesLenght]={Listable};



SeriesCollect[series_SeriesData,var__,func_:Identity]:=Collect[#,var,func]&/@series;
SeriesCollect[list_List,var__,func_:Identity]:=SeriesCollect[#,var,func]&/@list;
SeriesCollect[expr_,var__,func_:Identity]:=Collect[#,var,func]&@expr;


SeriesTake[series_SeriesData,order_Integer:1]:=Block[{aux},
series(1+O[series[[1]]]^(order))
]
SeriesTake[series_SeriesData,0]:=Block[{aux,minOrder},
minOrder=series//SeriesMinOrder;
O[series[[1]]]^(minOrder)
]
SeriesTake[series_O,order_Integer:1]:=Block[{aux,minOrder},
series
]
SeriesTake[expr_/;MatchQ[expr,Times[__,_SeriesData]],order_Integer]:=Block[{aux,factor,series},
factor=expr/.Times[a__,b_SeriesData]:>a;
series=expr/.Times[a__,b_SeriesData]:>b;
factor SeriesTake[series,order]
]
Attributes[SeriesTake]={Listable};



SeriesTerms[expr_,{x_,x0_,termOrder_}]:=Module[{aux,minOrder},
minOrder=Series[expr,x->x0]//SeriesMinOrder;
Series[expr,{x,x0,minOrder+termOrder-1}]
];
SeriesTerms[expr___]:=Module[{aux},
Series[expr]]


polyToSeries[poly_,x_:\[Eta],x\:2080_:0]:=Block[{aux,maxPower},
maxPower=poly//Exponent[#,x]&//Ceiling;
poly+O[(x-x\:2080)]^(maxPower+1)]
polyToSeries[0,x_:\[Eta],x\:2080_:0]:=Block[{aux,maxPower},
0
]


(* ::Subsubsection::Closed:: *)
(*Tools for Logs, Gammas, and PolyGammas*)


IgnoreLog\[Eta][expr_]:=expr/.Log[x_]/;!FreeQ[x,\[Eta]]:>Log[x/.\[Eta]->1];
ExpandLog[expr_]:=(expr/.Log[a_]:>PowerExpand[Log[a]]);
ExpandGamma[expr_]:=(expr/. Gamma[n_Integer+x_]:>(\!\(
\*UnderoverscriptBox[\(\[Product]\), \(i = 0\), \(n - 1\)]\((x + i)\)\))(\!\(
\*UnderoverscriptBox[\(\[Product]\), \(i = n\), \(-1\)]
\*SuperscriptBox[\((x + i)\), \(-1\)]\))  Gamma[x]);
ExpandPolyGamma[expr_]:=(expr/.PolyGamma[m_Integer,n_Integer+x_]:>(-1)^m (m!)(\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(i = 0\), \(n - 1\)]
\*FractionBox[\(1\), 
SuperscriptBox[\((x + i)\), \(m + 1\)]]\)-\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(i = n\), \(-1\)]
\*FractionBox[\(1\), 
SuperscriptBox[\((x + i)\), \(m + 1\)]]\))+PolyGamma[m,x]);
PochhammerToGamma[expr_]:=(expr/.Pochhammer[x_,n_]:>Gamma[x+n]/Gamma[x]);
GammaToPochhammer[expr_,n_]:=expr/.(Gamma[x_+sign_. n]:>Pochhammer[x,sign n]Gamma[x]);


(* ::Subsubsection::Closed:: *)
(*Tools for DiracDeltas*)


ExpandDiracDelta[expr_,x_]/;MatchQ[expr,__ DiracDelta[a__]/;!FreeQ[a,x]]:=Module[{aux,f,f0,arg,repls,sign,flip},
f=expr/.{f_ DiracDelta[arg_]:>f};
arg=expr/.{f_ DiracDelta[arg_]:>arg};
sign=arg//Coefficient[#,x]&;
flip=If[sign==-1,-1,1];
repls=Solve[arg==0,x]//Flatten;
f0=f/.repls;
f0 DiracDelta[flip arg]
]

ExpandDiracDelta[expr_,x_]/;MatchQ[expr,__ Derivative[__][DiracDelta][a__]/;!FreeQ[a,x]]:=Module[{aux,ret,f,n,f0,df0,arg,repls,coeff},
f=expr/.{f_ Derivative[n_][DiracDelta][arg_]/;!FreeQ[arg,x]:>f};
n=expr/.{f_ Derivative[n_][DiracDelta][arg_]/;!FreeQ[arg,x]:>n};
arg=expr/.{f_ Derivative[n_][DiracDelta][arg_]/;!FreeQ[arg,x]:>arg};
coeff=arg//Coefficient[#,x]&;
repls=Solve[arg==0,x]//Flatten;
f0[i_]:=D[f,{x,i}]/.repls;
ret=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(i = 0\), \(n\)]\(
\*SuperscriptBox[\((\(-1\))\), \(i\)] 
\*SuperscriptBox[\((
\*FractionBox[\(1\), \(coeff\)])\), \(i\)]\  Binomial[n, i]\  f0[i]\  \(\(Derivative[n - i]\)[DiracDelta]\)[arg]\)\);
ret
]

ExpandDiracDelta[expr_List,x_]:=ExpandDiracDelta[#,x]&/@expr;

ExpandDiracDelta[expr_,x_]/;!FreeQ[expr,DiracDelta[a_]/;!FreeQ[a,x]]:=Module[{aux,ret},
aux=expr//Collect[#,{DiracDelta[__],Derivative[__][DiracDelta][__]}]&;
ExpandDiracDelta[#,x]&/@aux
]

ExpandDiracDelta[expr_SeriesData,x_]/;!FreeQ[expr,DiracDelta[a_]/;!FreeQ[a,x]]:=Module[{aux,ret},
aux=expr//SeriesCollect[#,{DiracDelta[__],Derivative[__][DiracDelta][__]}]&;
ExpandDiracDelta[#,x]&/@aux
]


ExpandDiracDelta[expr_Plus,x_]:=(ExpandDiracDelta[#,x]&/@expr);
ExpandDiracDelta[expr_,x_]:=expr;


(* ::Subsection::Closed:: *)
(*Point particle source*)


(* ::Subsubsection::Closed:: *)
(*Interface*)


Options[TeukolskySourceCircularOrbit]={"InvariantWronskianForm"->False};


TeukolskySourceCircularOrbit[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aVar_,{rVar_,r0Var_},opt:OptionsPattern[]]:=Module[{aux},
TeukolskySource[\[ScriptS],\[ScriptL],\[ScriptM],aVar,{rVar,r0Var},opt]
]


(* ::Subsubsection::Closed:: *)
(*\[ScriptS] = -2*)


Options[TeukolskySource]={"Form"->"Default"};


TeukolskySource[-2,\[ScriptL]_,\[ScriptM]_,a_,{r_,r0_},OptionsPattern[]] :=Assuming[{r0>0,r>0,1>a>=0},
 Module[{\[ScriptS]=-2,aux,auxFactor, \[ScriptCapitalE], \[ScriptCapitalL], \[Theta]0, \[CapitalDelta],\[CapitalDelta]1d,\[CapitalDelta]2d, Kt, \[CapitalUpsilon]t, \[Omega],\[CapitalOmega], SH,S0, dS0, d2S0, L1, L2, L2S, L2p, L1Sp, L1L2S, rcomp, invFactor0,invFactor1,invFactor2,\[Theta]comp, \[Rho], \[Rho]bar, \[CapitalSigma], Ann0, Anmbar0, Anmbar1, Ambarmbar0, Ambarmbar1, Ambarmbar2, Cnnp1p1, Cnmbarp1p1, Cmbarmbarp1p1,ret},
\[ScriptCapitalE]=(a+(-2+r0) Sqrt[r0])/Sqrt[2 a r0^(3/2)+(-3+r0) r0^2];
\[ScriptCapitalL]=(a^2-2 a Sqrt[r0]+r0^2)/(Sqrt[2 a+(-3+r0) Sqrt[r0]] r0^(3/4));

  \[CapitalUpsilon]t = (r0^(5/4) (a+r0^(3/2)))/Sqrt[2 a+(-3+r0) Sqrt[r0]];
\[Omega]=\[ScriptM] \[CapitalOmega]Kerr;
(*\[CapitalOmega]=1/Sqrt[r0^3];*)
  \[Theta]0 = \[Pi]/2;

  \[CapitalDelta] = Kerr\[CapitalDelta][a,r0];
  \[CapitalDelta]1d=D[\[CapitalDelta],r0];
  \[CapitalDelta]2d=D[\[CapitalDelta],{r0,2}];
  
  Kt=(r0^2+a^2)\[Omega]-\[ScriptM] a;
  SH=SpinWeightedSpheroidalHarmonicS[\[ScriptS],\[ScriptL],\[ScriptM],a \[Omega]];
  S0 = SH[\[Theta]0, 0];
  dS0 = Derivative[1,0][SH][\[Theta]0, 0];
  d2S0 = Derivative[2,0][SH][\[Theta]0, 0];
  L1 = -\[ScriptM]/Sin[\[Theta]0] + a \[Omega] Sin[\[Theta]0] + Cos[\[Theta]0]/Sin[\[Theta]0];
  L2 = -\[ScriptM]/Sin[\[Theta]0] + a \[Omega] Sin[\[Theta]0] + 2 Cos[\[Theta]0]/Sin[\[Theta]0];
  L2S = dS0 + L2 S0;
  L2p = \[ScriptM] Cos[\[Theta]0]/Sin[\[Theta]0]^2 + a \[Omega] Cos[\[Theta]0] - 2/Sin[\[Theta]0]^2;
  L1Sp = d2S0 + L1 dS0;
  L1L2S = L1Sp + L2p S0 + L2 dS0 + L1 L2 S0;

  \[Rho] = -1/(r0 - I a Cos[\[Theta]0]);
  \[Rho]bar = -1/(r0 + I a Cos[\[Theta]0]);
  \[CapitalSigma] = 1/(\[Rho] \[Rho]bar);

  Ann0 = -\[Rho]^(-2) \[Rho]bar^(-1) (Sqrt[2] \[CapitalDelta])^(-2) (\[Rho]^(-1) L1L2S + 3 I a Sin[\[Theta]0] L1 S0 + 3 I a Cos[\[Theta]0] S0 + 2 I a Sin[\[Theta]0] dS0 - I a Sin[\[Theta]0] L2 S0 );
  Anmbar0 = \[Rho]^(-3) (Sqrt[2]\[CapitalDelta])^(-1) ( (\[Rho] + \[Rho]bar - I Kt/\[CapitalDelta]) L2S + (\[Rho] - \[Rho]bar) a Sin[\[Theta]0] Kt/\[CapitalDelta] S0 );
  Anmbar1 = -\[Rho]^(-3) (Sqrt[2]\[CapitalDelta])^(-1) ( L2S + I (\[Rho] - \[Rho]bar) a Sin[\[Theta]0] S0 );
  Ambarmbar0 = (Kt^2 S0 \[Rho]bar)/(4 \[CapitalDelta]^2 \[Rho]^3)+(I Kt S0 (1-r0+\[CapitalDelta] \[Rho]) \[Rho]bar)/(2 \[CapitalDelta]^2 \[Rho]^3)+(I r0 S0 \[Rho]bar \[Omega])/(2 \[CapitalDelta] \[Rho]^3);
  Ambarmbar1 = -\[Rho]^(-3) \[Rho]bar S0/2 ( I Kt/\[CapitalDelta] - \[Rho] );
  Ambarmbar2 = -\[Rho]^(-3) \[Rho]bar S0/4;

  rcomp = (\[ScriptCapitalE](r0^2+a^2) - a \[ScriptCapitalL])/(2\[CapitalSigma]);
  \[Theta]comp = \[Rho] (I Sin[\[Theta]0](a \[ScriptCapitalE] - \[ScriptCapitalL]/Sin[\[Theta]0]^2))/Sqrt[2];
    
  {Cnnp1p1, Cnmbarp1p1, Cmbarmbarp1p1} = {rcomp^2, rcomp \[Theta]comp, \[Theta]comp^2};
    
  aux =(-8Pi)/\[CapitalUpsilon]t ((Ann0*Cnnp1p1 + Anmbar0*Cnmbarp1p1 + Ambarmbar0*Cmbarmbarp1p1) DiracDelta[r-r0]+(Anmbar1*Cnmbarp1p1 + Ambarmbar1*Cmbarmbarp1p1)  DiracDelta'[r-r0]+(Ambarmbar2*Cmbarmbarp1p1) DiracDelta''[r-r0]);
auxFactor=Switch[OptionValue["Form"],"Default",Kerr\[CapitalDelta][a,r]^-\[ScriptS],"InvariantWronskian",1];
If[auxFactor//MatchQ[#,_Switch]&,Return[$Failed]];
aux=auxFactor aux//ExpandDiracDelta[#,r]&//Collect[#,{DiracDelta[__],Derivative[__][DiracDelta][__]},Simplify]&;
ret=aux;
ret
]]


(* ::Subsubsection::Closed:: *)
(*\[ScriptS] = -1*)


TeukolskySource[-1,\[ScriptL]_,\[ScriptM]_,a_,{r_,r0_},OptionsPattern[]] :=Assuming[{r0>0,r>0,1>a>=0},
 Module[{aux,auxFactor,\[ScriptS]=-1, \[ScriptCapitalE], \[ScriptCapitalL], \[CapitalDelta], Kt, \[CapitalUpsilon]t,SH,\[Omega],\[CapitalOmega],\[Theta]0,S0,dS0,L1,\[Rho],\[Rho]bar,\[CapitalSigma],An0,Ambar0,Ambar1,rcomp,\[Theta]comp,Cnp1,Cmbarp1,ret},
\[ScriptCapitalE]=(a+(-2+r0) Sqrt[r0])/Sqrt[2 a r0^(3/2)+(-3+r0) r0^2];
\[ScriptCapitalL]=(a^2-2 a Sqrt[r0]+r0^2)/(Sqrt[2 a+(-3+r0) Sqrt[r0]] r0^(3/4));
 \[CapitalUpsilon]t = (r0^(5/4) (a+r0^(3/2)))/Sqrt[2 a+(-3+r0) Sqrt[r0]];
\[CapitalDelta] = r0^2-2r0+a^2;
Kt=(r0^2+a^2)\[Omega]-\[ScriptM] a;
\[Omega]=\[ScriptM] \[CapitalOmega]Kerr;
(*\[CapitalOmega]=1/Sqrt[r0^3];*)
SH=  SpinWeightedSpheroidalHarmonicS[\[ScriptS],\[ScriptL],\[ScriptM],a \[Omega]];
S0 = SH[\[Theta]0, 0];
dS0 = Derivative[1,0][SH][\[Theta]0, 0];
L1 = -\[ScriptM]/Sin[\[Theta]0] + a \[Omega] Sin[\[Theta]0] + Cos[\[Theta]0]/Sin[\[Theta]0];
\[Rho] = -1/(r0 - I a Cos[\[Theta]0]);
\[Rho]bar = -1/(r0 + I a Cos[\[Theta]0]);
\[CapitalSigma] = 1/(\[Rho] \[Rho]bar);
\[Theta]0 =\[Pi]/2;

An0 =-((dS0+L1 S0+I a S0 \[Rho] Sin[\[Theta]0])/(2Sqrt[2] \[CapitalDelta] \[Rho]^2 \[Rho]bar));
Ambar0 =(S0 (-((I Kt)/\[CapitalDelta])+\[Rho]))/(4 \[Rho]^2);
Ambar1 =-(S0/(4 \[Rho]^2));

rcomp = (\[ScriptCapitalE](r0^2+a^2) - a \[ScriptCapitalL] )/(2\[CapitalSigma]);
\[Theta]comp = \[Rho] (I Sin[\[Theta]0](a \[ScriptCapitalE] - \[ScriptCapitalL]/Sin[\[Theta]0]^2))/Sqrt[2];
Cnp1=rcomp;
Cmbarp1=\[Theta]comp;

aux=(-8Pi)/\[CapitalUpsilon]t (-(An0*Cnp1 + Ambar0*Cmbarp1) DiracDelta[r-r0]-(Ambar1*Cmbarp1) DiracDelta'[r-r0]);
auxFactor=Switch[OptionValue["Form"],"Default",Kerr\[CapitalDelta][a,r]^-\[ScriptS],"InvariantWronskian",1];
If[auxFactor//MatchQ[#,_Switch]&,Return[$Failed]];
aux=auxFactor aux//ExpandDiracDelta[#,r]&//Collect[#,{DiracDelta[__],Derivative[__][DiracDelta][__]},Simplify]&;
ret=aux;
ret
 ]]


(* ::Subsubsection::Closed:: *)
(*\[ScriptS] = 0*)


TeukolskySource[0,\[ScriptL]_,\[ScriptM]_,a_,{r_,r0_},OptionsPattern[]] :=Assuming[{r0>0,r>0,1>a>=0},
 Module[{aux,auxFactor,\[ScriptS]=0, \[Theta]0, \[Omega],\[CapitalOmega], \[CapitalUpsilon]t, S,SH,ret,\[CapitalDelta]},
\[CapitalUpsilon]t =(r0^(5/4) (a+r0^(3/2)))/Sqrt[2 a+(-3+r0) Sqrt[r0]];
\[Theta]0 = \[Pi]/2;
\[CapitalDelta] = r0^2-2r0+a^2;
\[Omega]=\[ScriptM] \[CapitalOmega]Kerr;
(*\[CapitalOmega]=1/Sqrt[r0^3];*)
SH=  SpinWeightedSpheroidalHarmonicS[\[ScriptS],\[ScriptL],\[ScriptM],a \[Omega]];
S = SH[\[Pi]/2,0];
aux = -((4 \[Pi])/\[CapitalUpsilon]t)  r0^2  S DiracDelta[r-r0];
auxFactor=Switch[OptionValue["Form"],"Default",Kerr\[CapitalDelta][a,r]^-\[ScriptS],"InvariantWronskian",1];
If[auxFactor//MatchQ[#,_Switch]&,Return[$Failed]];
aux=auxFactor aux//ExpandDiracDelta[#,r]&//Collect[#,{DiracDelta[__],Derivative[__][DiracDelta][__]},Simplify]&;
ret=aux;
ret
]]


(*TeukolskySource[0,\[ScriptL]_,\[ScriptM]_,order\[Eta]_:"exact",OptionsPattern[]] :=
 Block[{s=0,l=\[ScriptL],m=\[ScriptM],a, p,r0, \[Theta]0, \[Omega],\[Gamma], \[CapitalUpsilon]t, S,SH,ret,aux,\[CapitalDelta],invFactor0},
p = r0;
\[CapitalUpsilon]t =(p^(5/4) (a+p^(3/2)))/Sqrt[2 a+(-3+p) Sqrt[p]];
r0 = p;
\[Theta]0 = \[Pi]/2;
SH=  SpinWeightedSpheroidalHarmonicS[s,l,m,\[Gamma]];
S = SH[\[Pi]/2,0];
\[CapitalDelta] = r0^2-2r0+a^2;
invFactor0=If[OptionValue["InvariantWronskianForm"],1,\[CapitalDelta]^-1];
If[order\[Eta]!="exact",
S=S//Series[#,{\[Gamma],0,order\[Eta]/3//Ceiling}]&//Normal;
];
S=S/.\[Gamma]->a \[Omega];
If[order\[Eta]!="exact",
ret = -((4 \[Pi])/\[CapitalUpsilon]t) r0^2 invFactor0  S \[Delta][r-r0]/.replsPN//Series[#,{\[Eta],0,order\[Eta]}]&,
(*else*)
ret= -((4 \[Pi])/\[CapitalUpsilon]t) r0^2 invFactor0 S \[Delta][r-r0]
];
ret
]*)


(* ::Subsubsection::Closed:: *)
(*s = +2*)


(* ::Input:: *)
(*(*TeukolskySource[2,\[ScriptL]_,\[ScriptM]_,OptionsPattern[]] := *)
(* Block[{s=2,l=\[ScriptL], m=\[ScriptM], a, p, \[ScriptCapitalE], \[ScriptCapitalL], \[CapitalUpsilon]t,SH, \[Omega], r0, \[Theta]0, \[CapitalDelta],d\[CapitalDelta],d2\[CapitalDelta], Kt, S0, dS0, d2S0, \[Delta]L\[Dagger]1, \[Delta]L\[Dagger]2, d\[Delta]L\[Dagger]2, \[Rho], \[Rho]bar, d\[Rho]over\[Rho], d2\[Rho]over\[Rho], u\[Theta]0,invFactor0,invFactor1,invFactor2, rcomp, \[Theta]comp, All0, Alm0, Alm1, Amm0, Amm1, Amm2, Cllp1p1, Clmp1p1, Cmmp1p1, Cllp1m1, Clmp1m1,ret,A,B,C},*)
(*  a = \[ScriptA];*)
(*  p=r0;*)
(*  \[ScriptCapitalE]=(a+(-2+p) Sqrt[p])/Sqrt[2 a p^(3/2)+(-3+p) p^2];*)
(*\[ScriptCapitalL]=(a^2-2 a Sqrt[p]+p^2)/(Sqrt[2 a+(-3+p) Sqrt[p]] p^(3/4));*)
(*  \[CapitalUpsilon]t = (p^(5/4) (a+p^(3/2)))/Sqrt[2 a+(-3+p) Sqrt[p]];*)
(*  \[Theta]0 = \[Pi]/2;*)
(* *)
(*  \[CapitalDelta] = r0^2 + a^2 - 2 r0;*)
(*d\[CapitalDelta]=2 (-1+r0);*)
(*d2\[CapitalDelta]=2;*)
(*  Kt = (r0^2 + a^2) \[Omega] - m a;*)
(*  *)
(*  invFactor0=If[OptionValue["InvariantWronskianForm"],1,\[CapitalDelta]^-3+3 d\[CapitalDelta]/\[CapitalDelta]^4-3 (-4 d\[CapitalDelta]^2+\[CapitalDelta] d2\[CapitalDelta])/\[CapitalDelta]^5];*)
(*  invFactor1=If[OptionValue["InvariantWronskianForm"],1,(6 d\[CapitalDelta])/\[CapitalDelta]^4+\[CapitalDelta]^-3];*)
(*  invFactor2=If[OptionValue["InvariantWronskianForm"],1,\[CapitalDelta]^-3];*)
(*  *)
(*  \[Rho] = -1/(r0 - I a Cos[\[Theta]0]);*)
(*  \[Rho]bar = -1/(r0 + I a Cos[\[Theta]0]);*)
(**)
(*  SH=SpinWeightedSpheroidalHarmonicS[s,l,m,a \[Omega]];*)
(*  S0 = SH[\[Theta]0, 0];*)
(*  dS0 = Derivative[1,0][SH][\[Theta]0, 0];*)
(*  d2S0 = Derivative[2,0][SH][\[Theta]0, 0];*)
(*  \[Delta]L\[Dagger]1 = m/Sin[\[Theta]0] - a \[Omega] Sin[\[Theta]0] + Cos[\[Theta]0]/Sin[\[Theta]0];*)
(*  \[Delta]L\[Dagger]2 = m/Sin[\[Theta]0] - a \[Omega] Sin[\[Theta]0] + 2 Cos[\[Theta]0]/Sin[\[Theta]0];*)
(*  d\[Delta]L\[Dagger]2 = -m Cos[\[Theta]0]/Sin[\[Theta]0]^2 - a \[Omega] Cos[\[Theta]0] - 2/Sin[\[Theta]0]^2;*)
(*  d\[Rho]over\[Rho] = I a \[Rho] Sin[\[Theta]0];*)
(*  d2\[Rho]over\[Rho] = I a \[Rho](Cos[\[Theta]0] + 2 Sin[\[Theta]0] d\[Rho]over\[Rho]);*)
(*  *)
(*  All0 = -(1/2) \[Rho]^(-1) \[Rho]bar (d2S0 + (\[Delta]L\[Dagger]1 + \[Delta]L\[Dagger]2 + 2 d\[Rho]over\[Rho])dS0 + (d\[Delta]L\[Dagger]2 + \[Delta]L\[Dagger]1 \[Delta]L\[Dagger]2 - 6 d\[Rho]over\[Rho]^2 + 3 d2\[Rho]over\[Rho] + (3 \[Delta]L\[Dagger]1 - \[Delta]L\[Dagger]2)d\[Rho]over\[Rho]) S0);*)
(*  Alm0 = (2/Sqrt[2]) \[Rho]^(-1) ( -(\[Rho] + \[Rho]bar + I Kt/\[CapitalDelta]) (dS0 + \[Delta]L\[Dagger]2 S0) + (\[Rho] - \[Rho]bar) a Sin[\[Theta]0] Kt/\[CapitalDelta] S0 );*)
(*  Alm1 = (2/Sqrt[2]) \[Rho]^(-1) ( (dS0 + \[Delta]L\[Dagger]2 S0) + I (\[Rho] - \[Rho]bar) a Sin[\[Theta]0] S0 );*)
(*  Amm0 = (Kt^2 S0)/(\[CapitalDelta]^2 \[Rho] \[Rho]bar)+(2 I Kt S0 (-1+r0-\[CapitalDelta] \[Rho]))/(\[CapitalDelta]^2 \[Rho] \[Rho]bar)-(2 I r0 S0 \[Omega])/(\[CapitalDelta] \[Rho] \[Rho]bar);*)
(*  Amm1 = 2 \[Rho]^(-1) \[Rho]bar^(-1) S0 ( I Kt/\[CapitalDelta] + \[Rho] );*)
(*  Amm2 = -\[Rho]^(-1) \[Rho]bar^(-1) S0;*)
(**)
(*  rcomp = (\[ScriptCapitalE](r0^2+a^2) - a \[ScriptCapitalL])/(\[CapitalDelta]);*)
(*  \[Theta]comp = -\[Rho]bar (I Sin[\[Theta]0](a \[ScriptCapitalE] - \[ScriptCapitalL]/Sin[\[Theta]0]^2))/Sqrt[2];*)
(*    *)
(*  {Cllp1p1,Clmp1p1,Cmmp1p1} = {rcomp^2, rcomp \[Theta]comp, \[Theta]comp^2};*)
(*A=(All0*Cllp1p1 + Alm0*Clmp1p1 + Amm0*Cmmp1p1);*)
(*B=(Alm1*Clmp1p1 + Amm1*Cmmp1p1);*)
(*C=Amm2*Cmmp1p1;*)
(*    *)
(*  ret =-((8Pi)/\[CapitalUpsilon]t)(invFactor0(\[CapitalDelta]^2 A -2\[CapitalDelta] d\[CapitalDelta] B+2(d\[CapitalDelta]^2+\[CapitalDelta] d2\[CapitalDelta])C )\[Delta][r-r0]+ invFactor1(\[CapitalDelta]^2 B-4 \[CapitalDelta] d\[CapitalDelta] C) \[Delta]'[r-r0] +invFactor2 \[CapitalDelta]^2 C  \[Delta]''[r-r0]);*)
(*ret//Simplify*)
(*]*)*)


TeukolskySource[2,\[ScriptL]_,\[ScriptM]_,a_,{r_,r0_},OptionsPattern[]] :=Assuming[{r0>0,r>0,1>a>=0},
 Module[{aux,auxFactor,\[ScriptS]=2, \[ScriptCapitalE], \[ScriptCapitalL], \[CapitalUpsilon]t,SH, \[Omega], \[CapitalOmega], \[Theta]0, \[CapitalDelta],d\[CapitalDelta],d2\[CapitalDelta], Kt, S0, dS0, d2S0, \[Delta]L\[Dagger]1, \[Delta]L\[Dagger]2, d\[Delta]L\[Dagger]2, \[Rho], \[Rho]bar, d\[Rho]over\[Rho], d2\[Rho]over\[Rho], u\[Theta]0, rcomp, \[Theta]comp, All0, Alm0, Alm1, Amm0, Amm1, Amm2, Cllp1p1, Clmp1p1, Cmmp1p1, Cllp1m1, Clmp1m1,ret,A,B,C},
  \[ScriptCapitalE]=(a+(-2+r0) Sqrt[r0])/Sqrt[2 a r0^(3/2)+(-3+r0) r0^2];
\[ScriptCapitalL]=(a^2-2 a Sqrt[r0]+r0^2)/(Sqrt[2 a+(-3+r0) Sqrt[r0]] r0^(3/4));
  \[CapitalUpsilon]t = (r0^(5/4) (a+r0^(3/2)))/Sqrt[2 a+(-3+r0) Sqrt[r0]];
  \[Theta]0 = \[Pi]/2;

\[Omega]=\[ScriptM] \[CapitalOmega]Kerr;
(*\[CapitalOmega]=1/Sqrt[r0^3];*)
 
  \[CapitalDelta] = r0^2 + a^2 - 2 r0;
d\[CapitalDelta]=2 (-1+r0);
d2\[CapitalDelta]=2;
  Kt = (r0^2 + a^2) \[Omega] - \[ScriptM] a;
  
  \[Rho] = -1/(r0 - I a Cos[\[Theta]0]);
  \[Rho]bar = -1/(r0 + I a Cos[\[Theta]0]);

  SH=SpinWeightedSpheroidalHarmonicS[\[ScriptS],\[ScriptL],\[ScriptM],a \[Omega]];
  S0 = SH[\[Theta]0, 0];
  dS0 = Derivative[1,0][SH][\[Theta]0, 0];
  d2S0 = Derivative[2,0][SH][\[Theta]0, 0];
  \[Delta]L\[Dagger]1 = \[ScriptM]/Sin[\[Theta]0] - a \[Omega] Sin[\[Theta]0] + Cos[\[Theta]0]/Sin[\[Theta]0];
  \[Delta]L\[Dagger]2 = \[ScriptM]/Sin[\[Theta]0] - a \[Omega] Sin[\[Theta]0] + 2 Cos[\[Theta]0]/Sin[\[Theta]0];
  d\[Delta]L\[Dagger]2 = -\[ScriptM] Cos[\[Theta]0]/Sin[\[Theta]0]^2 - a \[Omega] Cos[\[Theta]0] - 2/Sin[\[Theta]0]^2;
  d\[Rho]over\[Rho] = I a \[Rho] Sin[\[Theta]0];
  d2\[Rho]over\[Rho] = I a \[Rho](Cos[\[Theta]0] + 2 Sin[\[Theta]0] d\[Rho]over\[Rho]);
  
  All0 = -(1/2) \[Rho]^(-1) \[Rho]bar (d2S0 + (\[Delta]L\[Dagger]1 + \[Delta]L\[Dagger]2 + 2 d\[Rho]over\[Rho])dS0 + (d\[Delta]L\[Dagger]2 + \[Delta]L\[Dagger]1 \[Delta]L\[Dagger]2 - 6 d\[Rho]over\[Rho]^2 + 3 d2\[Rho]over\[Rho] + (3 \[Delta]L\[Dagger]1 - \[Delta]L\[Dagger]2)d\[Rho]over\[Rho]) S0);
  Alm0 = (2/Sqrt[2]) \[Rho]^(-1) ( -(\[Rho] + \[Rho]bar + I Kt/\[CapitalDelta]) (dS0 + \[Delta]L\[Dagger]2 S0) + (\[Rho] - \[Rho]bar) a Sin[\[Theta]0] Kt/\[CapitalDelta] S0 );
  Alm1 = (2/Sqrt[2]) \[Rho]^(-1) ( (dS0 + \[Delta]L\[Dagger]2 S0) + I (\[Rho] - \[Rho]bar) a Sin[\[Theta]0] S0 );
  Amm0 = (Kt^2 S0)/(\[CapitalDelta]^2 \[Rho] \[Rho]bar)+(2 I Kt S0 (-1+r0-\[CapitalDelta] \[Rho]))/(\[CapitalDelta]^2 \[Rho] \[Rho]bar)-(2 I r0 S0 \[Omega])/(\[CapitalDelta] \[Rho] \[Rho]bar);
  Amm1 = 2 \[Rho]^(-1) \[Rho]bar^(-1) S0 ( I Kt/\[CapitalDelta] + \[Rho] );
  Amm2 = -\[Rho]^(-1) \[Rho]bar^(-1) S0;

  rcomp = (\[ScriptCapitalE](r0^2+a^2) - a \[ScriptCapitalL])/(\[CapitalDelta]);
  \[Theta]comp = -\[Rho]bar (I Sin[\[Theta]0](a \[ScriptCapitalE] - \[ScriptCapitalL]/Sin[\[Theta]0]^2))/Sqrt[2];
    
  {Cllp1p1,Clmp1p1,Cmmp1p1} = {rcomp^2, rcomp \[Theta]comp, \[Theta]comp^2};
A=(All0*Cllp1p1 + Alm0*Clmp1p1 + Amm0*Cmmp1p1);
B=(Alm1*Clmp1p1 + Amm1*Cmmp1p1);
C=Amm2*Cmmp1p1;
    
  aux =-((8Pi)/\[CapitalUpsilon]t)(A DiracDelta[r-r0]+ B DiracDelta'[r-r0] +C  DiracDelta''[r-r0]);
auxFactor=Switch[OptionValue["Form"],"Default",1,"InvariantWronskian",Kerr\[CapitalDelta][a,r]^\[ScriptS]];
If[auxFactor//MatchQ[#,_Switch]&,Return[$Failed]];
aux=auxFactor aux//ExpandDiracDelta[#,r]&//Collect[#,{DiracDelta[__],Derivative[__][DiracDelta][__]},Simplify]&;
ret=aux;
ret
]]


(* ::Subsection::Closed:: *)
(*Teukolsky Equation*)


rstar[a_,M_,r_]:=Block[{rp=M (1+Sqrt[1-(a/M)^2]),rm=M (1-Sqrt[1-(a/M)^2])},r+((2 M rp) Log[(r-rp)/(2 M)])/(rp-rm)-((2 M rm) Log[(r-rm)/(2 M)])/(rp-rm)];
s\[Lambda]\[ScriptL]\[ScriptM][0,\[ScriptL]_,\[ScriptM]_,\[Omega]_,a_]:=SpheroidalEigenvalue[\[ScriptL],\[ScriptM],I a \[Omega]]-2 \[ScriptM] a \[Omega];
s\[Lambda]\[ScriptL]\[ScriptM][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,\[Omega]_,0]:=\[ScriptL](\[ScriptL]+1)-\[ScriptS](\[ScriptS]+1);
s\[Lambda]\[ScriptL]\[ScriptM][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,\[Omega]_,a_]/;\[ScriptS]!=0&&a!=0:=(Print["Unsupported: \[ScriptS]=",\[ScriptS]," a=",a];Abort[];)
\[CapitalDelta][a_,M_,r_]:=r^2-2 M r+a^2;
ClearAll[equation]
equation[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,\[Omega]_,a_,M_,r_]:=\[CapitalDelta][a,M,r]^-\[ScriptS] D[(\[CapitalDelta][a,M,r]^(\[ScriptS]+1) D[R[r],r]),r]+(1/\[CapitalDelta][a,M,r] ((r^2+a^2)^2 \[Omega]^2-4 a M r \[Omega] \[ScriptM]+a^2 \[ScriptM]^2+2 I a (r-M) \[ScriptM] \[ScriptS]-2 I M (r^2-a^2) \[Omega] \[ScriptS])+2 I r \[Omega] \[ScriptS]-SpinWeightedSpheroidalEigenvalue[\[ScriptS],\[ScriptL],\[ScriptM],a \[Omega]]-2 a \[ScriptM] \[Omega]) R[r]
equation[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,\[Omega]_,a_,M_,r_,order\[Eta]_]:=\[CapitalDelta][a,M,r]^-\[ScriptS] D[(\[CapitalDelta][a,M,r]^(\[ScriptS]+1) D[R[r],r]),r]+(1/\[CapitalDelta][a,M,r] ((r^2+a^2)^2 \[Omega]^2-4 a M r \[Omega] \[ScriptM]+a^2 \[ScriptM]^2+2 I a (r-M) \[ScriptM] \[ScriptS]-2 I M (r^2-a^2) \[Omega] \[ScriptS])+2 I r \[Omega] \[ScriptS]-eigenValue[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]-2 a \[ScriptM] \[Omega]) R[r]


\[Lambda][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Block[{aux,order\[Epsilon],\[Gamma],\[ScriptA]=a,\[Omega]},
order\[Epsilon]=order\[Eta]/3//Ceiling;
aux=SpinWeightedSpheroidalEigenvalue[\[ScriptS],\[ScriptL],\[ScriptM],\[Gamma]];
aux=aux//Series[#,{\[Gamma],0,order\[Epsilon]}]&//Normal;
aux/.\[Gamma]->\[ScriptA] \[Omega]/.replsPN//Series[#,{\[Eta],0,order\[Eta]}]&
]


TeukolskyEquation[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_] := Collect[equation[\[ScriptS], \[ScriptL], \[ScriptM], \[Omega], a, 1, r]/.R->(R[# \[Eta]^2]&)/.replsPN,Derivative[__][R][__],Simplify];
TeukolskyEquation[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_] := Collect[equation[\[ScriptS], \[ScriptL], \[ScriptM], \[Omega], a, 1, r,order\[Eta]]/.R->(R[# \[Eta]^2]&)/.replsPN/.eigenValue->\[Lambda],{R[__],Derivative[__][R][__]},Simplify];


TeukolskyEquation[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order_},RVar_[rvar_]]:=Module[{aux},
aux=SeriesCollect[equation[\[ScriptS], \[ScriptL], \[ScriptM], \[Omega], a, 1, r,order]/.R->(R[# \[Eta]^2]&)/.replsPN/.eigenValue->\[Lambda],{R[__],Derivative[__][R][__]},Simplify];
aux/.{\[Eta]->\[Eta]Var,\[Omega]->\[Omega]Var,R->RVar,r->rvar}]


TeukolskyEquation[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,RVar_[rvar_]]:=Module[{aux},
aux=Collect[equation[\[ScriptS], \[ScriptL], \[ScriptM], \[Omega], a, 1, r,order]/.eigenValue[___]->SpinWeightedSpheroidalEigenvalue[\[ScriptS],\[ScriptL],\[ScriptM],a \[Omega]],{R[__],Derivative[__][R][__]},Simplify];
aux/.{\[Omega]->\[Omega]Var,R->RVar,r->rvar}]


teukolsky[r_] := Collect[equation[-2, 2, \[ScriptM], \[Omega], 0, 1, r],Derivative[__][R][__],Simplify];
teukolsky[\[ScriptS]_,\[ScriptL]_] := Collect[equation[\[ScriptS], \[ScriptL], 0, \[Omega], 0, 1, r],Derivative[__][R][__],Simplify];
teukolsky[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,order\[Eta]_] := Collect[equation[\[ScriptS], \[ScriptL], \[ScriptM], \[Omega], \[ScriptA], 1, r,order\[Eta]]/.eigenValue->\[Lambda],Derivative[__][R][__],Simplify];


(* ::Subsection::Closed:: *)
(*integrateDelta*)


integrateDelta[expr_Plus,dx_,toInf_?BooleanQ]:=integrateDelta[#,dx,toInf]&/@expr;
integrateDelta[expr_,dx_,toInf_?BooleanQ]:=Module[{collected,sign,border},
	sign=If[toInf,-1,1];
	border=If[toInf,\[Infinity],0];
	(*collected=Collect[expr,{DiracDelta[__],HeavisideTheta[__],Derivative[__][DiracDelta][__]}];*)
	collected=Expand@expr;
	If[MatchQ[collected,_Plus],
		integrateDelta[#,dx,toInf]&@collected,
		(*else*)
		sign(#-Quiet[Check[(#/.{dx->dx^sign}/.{dx->0}), \:2665 Normal@Series[#,dx->border]]])&@\[Integral]expr \[DifferentialD]dx
	]
]

integrateDelta[expr_/;MatchQ[expr,__ \[Delta][__]],dx_,toInf_?BooleanQ]:=Module[{repl,sign,border,arg,flip},
	sign=If[toInf,-1,1];
	border=If[toInf,\[Infinity],0];
	arg=expr/.{__ \[Delta][arg_]:>arg};
	flip=Coefficient[arg,dx];
	repl={a_ \[Delta][arg_]:> (a/.Flatten@Solve[arg==0,dx])\[Theta][flip sign arg]};
	expr/.repl
]
integrateDelta[expr_/;MatchQ[expr,__ Derivative[__][\[Delta]][__]],dx_,toInf_?BooleanQ]:=Module[{repl,sign,arg,flip},
	sign=If[toInf,-1,1];
	arg=expr/.__ Derivative[__][\[Delta]][arg_]:>arg;
	flip=Coefficient[arg,dx];
	(*To keep the boundary terms just uncomment the first term in the line below*)
	repl={(a_ Derivative[n_][\[Delta]][arg_]):>(*( \!\(
\*UnderoverscriptBox[\(\[Sum]\), \(i = 0\), \(n - 1\)]\ \(sign\ flip
\*SuperscriptBox[\((\(-flip\))\), \(i\)]\ D[a, {dx, i}]\ \(\(Derivative[n - i]\)[\[Theta]]\)[arg]\)\))*)+(-flip)^n (D[a,{dx,n}]/.Flatten@Solve[arg==0,dx])\[Theta][flip sign arg] };
expr/.repl
]

integrateDelta[expr_/;MatchQ[expr,__ \[Theta][__]],dx_,toInf_?BooleanQ]:=Module[{repl,sign,border,arg,basePiece,x\:2080},
	sign=If[toInf,-1,1];
	border=If[toInf,\[Infinity],0];
	arg=expr/.__ \[Theta][arg_]:>arg;
	x\:2080=Flatten@Solve[arg==0,dx];
	basePiece=Negative[Coefficient[arg,dx] sign];
	repl={a_ \[Theta][arg_]:>((sign \[Theta][arg](#-(#/.x\:2080))-If[basePiece, sign (Quiet[Check[(Simplify[#/.{dx->dx^sign}]/.{dx->0}), \:2665 Normal@Series[#,dx->border]]]-(#/.x\:2080)),0])&@\[Integral]a \[DifferentialD]dx)};
	expr/.repl
]



\[Theta]'[arg_]:=\[Delta][arg]
Derivative[n_][\[Theta]][arg_]:=Derivative[n-1][\[Delta]][arg];
\[Theta][\[Eta]^-2 a_]:=\[Theta][a];
\[Delta][\[Eta]^-2 a_]:=\[Eta]^2 \[Delta][a];
\[Delta]'[\[Eta]^-2 a_]:=\[Eta]^2 \[Delta]'[a];
\[Delta]''[\[Eta]^-2 a_]:=\[Eta]^2 \[Delta]''[a];


(* ::Subsection:: *)
(*Amplitudes*)


(* ::Subsubsection::Closed:: *)
(*A Amplitudes*)


(* ::Text:: *)
(*These are the amplitudes \!\(\*SubscriptBox[\(A\), \(\[PlusMinus]\)]\) from Sasaki Tagoshi Eq.(157-158)*)


AAmplitude["+"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,\[CurlyEpsilon],\[Kappa],\[CurlyEpsilon]p,\[Tau],nMax,nMin},
\[CurlyEpsilon]=2 \[Omega];
\[Kappa]=Sqrt[1-a^2];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
nMax=order\[Eta]/3//Ceiling;
nMin=-(order\[Eta]/3+2)//Floor;
aux=E^(-(\[Pi]/2)\[CurlyEpsilon]) E^(\[Pi]/2 I(\[Nu]MST+1+\[ScriptS])) 2^(-1+\[ScriptS]-I \[CurlyEpsilon]) Gamma[\[Nu]MST+1-\[ScriptS]+I \[CurlyEpsilon]]/Gamma[\[Nu]MST+1+\[ScriptS]-I \[CurlyEpsilon]] \!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = nMin\), \(nMax\)]\(aMST[n]\)\)//PNScalingsInternal;
aux/.MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+3]//SeriesTake[#,order\[Eta]]&//IgnoreExpansionParameter
]


AAmplitude["-"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,\[CurlyEpsilon],\[Kappa],\[CurlyEpsilon]p,\[Tau],nMax,nMin},
\[CurlyEpsilon]=2 \[Omega];
\[Kappa]=Sqrt[1-a^2];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
nMax=order\[Eta]/3//Ceiling;
nMin=-(order\[Eta]/3+2)//Floor;
aux=2^(-1-\[ScriptS]+I \[CurlyEpsilon]) E^(-(\[Pi]/2)I(\[Nu]MST+1+\[ScriptS])) E^(-(\[Pi]/2)\[CurlyEpsilon]) \!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = nMin\), \(nMax\)]\(
\*SuperscriptBox[\((\(-1\))\), \(n\)] 
\*FractionBox[\(Pochhammer[\[Nu]MST + 1 + \[ScriptS] - I\  \[CurlyEpsilon], n]\), \(Pochhammer[\[Nu]MST + 1 - \[ScriptS] + I\  \[CurlyEpsilon], n]\)] aMST[n]\)\)//PNScalingsInternal;
aux/.MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+3]//SeriesTake[#,order\[Eta]]&//IgnoreExpansionParameter
]


(* ::Subsubsection::Closed:: *)
(*B Amplitudes*)


(* ::Text:: *)
(*These are the amplitudes Subscript[B, trans] and Subscript[B, inc] from Sasaki Tagoshi Eq.(167-169) TODO: Add Subscript[B, ref]*)


Options[BAmplitude]={"Normalization"->"Default"}


BAmplitude["Inc",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,\[CurlyEpsilon],\[Kappa],\[CurlyEpsilon]p,\[Tau],\[ScriptCapitalK]1,\[ScriptCapitalK]2,A},
\[CurlyEpsilon]=2 \[Omega];
\[Kappa]=Sqrt[1-a^2];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
aux=\[Omega]^-1 (\[ScriptCapitalK]1 -I E^(-I \[Pi] \[Nu]MST) Sin[\[Pi](\[Nu]MST-\[ScriptS]+I \[CurlyEpsilon])]/Sin[\[Pi](\[Nu]MST+\[ScriptS]-I \[CurlyEpsilon])] \[ScriptCapitalK]2) A E^(-I(\[CurlyEpsilon] Log[\[CurlyEpsilon]]-(1-\[Kappa])/2 \[CurlyEpsilon]))//PNScalingsInternal;
aux=aux/.MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+3]//IgnoreExpansionParameter;
\[ScriptCapitalK]1=Switch[OptionValue["Normalization"],
	"Default",1,
	"SasakiTagoshi",\[ScriptCapitalK]Amplitude["\[Nu]"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]//ExpandPolyGamma//ExpandGamma//SeriesCollect[#,PolyGamma[__,__]]&
];
\[ScriptCapitalK]2=Switch[OptionValue["Normalization"],
	"Default",\[ScriptCapitalK]Amplitude["Ratio"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]//ExpandPolyGamma//ExpandGamma//SeriesCollect[#,PolyGamma[__,__]]&,
	"SasakiTagoshi",\[ScriptCapitalK]Amplitude["-\[Nu]-1"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]//ExpandPolyGamma//ExpandGamma//SeriesCollect[#,PolyGamma[__,__]]&
];
A=AAmplitude["+"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]//SeriesCollect[#,Log[__]]&//IgnoreExpansionParameter;
aux//SeriesTake[#,order\[Eta]]&//IgnoreExpansionParameter
]


BAmplitude["Trans",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,\[CurlyEpsilon],\[Kappa],\[CurlyEpsilon]p,\[Tau],\[ScriptCapitalK],nMin,nMax},
\[CurlyEpsilon]=2 \[Omega];
\[Kappa]=Sqrt[1-a^2];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
nMax=order\[Eta]/3//Ceiling;
nMin=-(order\[Eta]/3+2)//Floor;
\[ScriptCapitalK]=Switch[OptionValue["Normalization"],
	"Default",\[ScriptCapitalK]Amplitude["\[Nu]"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]//ExpandPolyGamma//ExpandGamma//SeriesCollect[#,PolyGamma[__,__]]&,
	"SasakiTagoshi",1
];
aux=((\[CurlyEpsilon] \[Kappa])/\[Omega])^(2\[ScriptS]) E^(I \[Kappa] \[CurlyEpsilon]p(1+(2 Log[\[Kappa]])/(1+\[Kappa]))) \!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = nMin\), \(nMax\)]\(aMST[n]\)\)//PNScalingsInternal;
aux=aux/.MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+3]//SeriesTake[#,order\[Eta]]&//IgnoreExpansionParameter;
aux=aux \[ScriptCapitalK]^-1;
aux//IgnoreExpansionParameter
]


BAmplitude["Ref",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,\[CurlyEpsilon],\[Kappa],\[CurlyEpsilon]p,\[Tau],\[ScriptCapitalK]1,\[ScriptCapitalK]2,A},
\[CurlyEpsilon]=2 \[Omega];
\[Kappa]=Sqrt[1-a^2];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
aux=(\[Omega]^(-1-2 \[ScriptS]) E^(-I \[CurlyEpsilon](Log[\[CurlyEpsilon]]-(1-\[Kappa])/2)) (\[ScriptCapitalK]1+I E^(I \[Pi] \[Nu]MST) \[ScriptCapitalK]2) A)/\[Omega]//PNScalingsInternal;
aux=IgnoreExpansionParameter[aux/. MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+3]];
\[ScriptCapitalK]1=Switch[OptionValue["Normalization"],"Default",1,"SasakiTagoshi",(SeriesCollect[#1,PolyGamma[__,__]]&)[ExpandGamma[ExpandPolyGamma[\[ScriptCapitalK]Amplitude["\[Nu]"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]]]]];
\[ScriptCapitalK]2=Switch[OptionValue["Normalization"],"Default",(SeriesCollect[#1,PolyGamma[__,__]]&)[ExpandGamma[ExpandPolyGamma[\[ScriptCapitalK]Amplitude["Ratio"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]]]],"SasakiTagoshi",(SeriesCollect[#1,PolyGamma[__,__]]&)[ExpandGamma[ExpandPolyGamma[\[ScriptCapitalK]Amplitude["-\[Nu]-1"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]]]]];
A=IgnoreExpansionParameter[(SeriesCollect[#1,Log[__]]&)[AAmplitude["-"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]]];
IgnoreExpansionParameter[(SeriesTake[#1,order\[Eta]]&)[aux]]]


BAmplitude["Inc","Normalization"->"UnitTransmission"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=BAmplitude["Inc"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/BAmplitude["Trans"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]];
BAmplitude["Ref","Normalization"->"UnitTransmission"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=BAmplitude["Ref"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/BAmplitude["Trans"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]];
BAmplitude["Trans","Normalization"->"UnitTransmission"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=1 (1+O[\[Eta]] \[Eta]^(order\[Eta]-1));


(* ::Subsubsection:: *)
(*C Amplitude*)


(* ::Text:: *)
(*These is the amplitudes Subscript[C, trans] from Sasaki Tagoshi Eq.(170) TODO: Add Subscript[C, ref] and Subscript[C, inc]*)


Options[CAmplitude]={"Normalization"->"Default"}


CAmplitude["Trans","Normalization"->"UnitTransmission"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=1 (1+O[\[Eta]] \[Eta]^(order\[Eta]-1));


CAmplitude["Trans",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,\[CurlyEpsilon],\[Kappa],\[CurlyEpsilon]p,\[Tau],\[ScriptCapitalK],A},
\[CurlyEpsilon]=2 \[Omega];
\[Kappa]=Sqrt[1-a^2];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
aux=\[Omega]^(-1-2\[ScriptS]) A E^(I (\[CurlyEpsilon] Log[\[CurlyEpsilon]]-(1-\[Kappa])/2 \[CurlyEpsilon]))//PNScalingsInternal;
aux=aux/.MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+3];
A=AAmplitude["-"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]];
aux//SeriesTake[#,order\[Eta]]&//IgnoreExpansionParameter
]


CAmplitude["Inc",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,\[CurlyEpsilon],\[Kappa],\[CurlyEpsilon]p,\[Tau],\[ScriptCapitalK],A},
"Not Computed"
]


CAmplitude["Ref",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,\[CurlyEpsilon],\[Kappa],\[CurlyEpsilon]p,\[Tau],\[ScriptCapitalK],A},
"Not Computed"
]


(* ::Subsubsection::Closed:: *)
(*\[ScriptCapitalK] Amplitude*)


(* ::Text:: *)
(*These is the amplitudes \[ScriptCapitalK]^\[Nu]and \[ScriptCapitalK]^(-\[Nu]-1) from Sasaki Tagoshi Eq.(165)*)


Options[\[ScriptCapitalK]Amplitude]={"PochhammerForm"->True}


\[ScriptCapitalK]Amplitude["\[Nu]",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_,OptionsPattern[]]:=Module[{\[ScriptR]=0,ret,\[CapitalGamma]=Gamma,PH=Pochhammer,coeff,sumUp,sumUpPHCoeff,sumUpPH,sumDown,\[CurlyEpsilon]p,\[Tau],\[CurlyEpsilon],\[Kappa]=Sqrt[1-a^2],nMax,nMin,jump,jumpCount,repls,repls\[Nu]},
\[CurlyEpsilon]=2 \[Omega];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
jump[1]=2+2\[ScriptL]+\[ScriptR]<=Abs[n];
jump[2]=1+\[ScriptS]+\[ScriptL]<=n;
jump[3]=1-\[ScriptS]+\[ScriptL]<=n;
jumpCount=1+(jump[#]&/@Range[3]//Boole//Total);
jumpCount=1;
repls=MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+3];
repls\[Nu]=<|\[Nu]MST->(repls[\[Nu]MST]//SeriesTake[#,order\[Eta]-Floor[Abs[n]/3]+3jumpCount]&)|>;
coeff=E^(I \[CurlyEpsilon] \[Kappa] ) (\[CurlyEpsilon] \[Kappa])^(\[ScriptS]-\[Nu]MST-\[ScriptR]) 2^-\[Nu]MST I^-\[ScriptR] (\[CapitalGamma][1-\[ScriptS]-2I \[CurlyEpsilon]p]\[CapitalGamma][\[ScriptR]+2 \[Nu]MST+2])/\[CapitalGamma][\[ScriptR]+\[Nu]MST+1-\[ScriptS]+I \[CurlyEpsilon]]  If[\[ScriptR]==0&&OptionValue["PochhammerForm"],1,1/(\[CapitalGamma][\[ScriptR]+\[Nu]MST+1+\[ScriptS]+I \[CurlyEpsilon]] \[CapitalGamma][\[ScriptR]+\[Nu]MST+1+I \[Tau]])]//IgnoreExpansionParameter;
nMax=Ceiling[order\[Eta]/3];
nMin=Ceiling[-(order\[Eta]/3)-2];
(*sumUp=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = \[ScriptR]\), \(nMax\)]\(
\*FractionBox[
SuperscriptBox[\((\(-1\))\), \(n\)], \(\((n - \[ScriptR])\)!\)]\[CapitalGamma][n + \[ScriptR] + 2 \[Nu]MST + 1]
\*FractionBox[\(\[CapitalGamma][n + \[Nu]MST + 1 + \[ScriptS] + I\ \[CurlyEpsilon]]\[CapitalGamma][n + \[Nu]MST + 1 + I\ \[Tau]]\), \(\[CapitalGamma][n + \[Nu]MST + 1 - \[ScriptS] - I\ \[CurlyEpsilon]]\[CapitalGamma][n + \[Nu]MST + 1 - I\ \[Tau]]\)]aMST[n]\)\)/.repls;*)
sumUpPH=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = \[ScriptR]\), \(nMax\)]\(\((\(
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(n\)]\  PH[1 + \[ScriptS] + I\  \[CurlyEpsilon] + \[Nu]MST, n]\  PH[1 + \[ScriptR] + 2\  \[Nu]MST, n]\  PH[1 + \[Nu]MST + I\  \[Tau], n]\), \(\(\((n - \[ScriptR])\)!\)\  PH[1 - \[ScriptS] - I\  \[CurlyEpsilon] + \[Nu]MST, n]\  PH[1 + \[Nu]MST - I\  \[Tau], n]\)] /. replsPN\) /. repls\[Nu])\) \((aMST[n]\  /. repls)\)\)\)//IgnoreExpansionParameter;
sumUpPHCoeff= Gamma[1+\[ScriptR]+2 \[Nu]MST] /(Gamma[1-\[ScriptS]-I \[CurlyEpsilon]+\[Nu]MST] Gamma[1+\[Nu]MST-I \[Tau]]) If[\[ScriptR]==0,1,Gamma[1+\[ScriptS]+I \[CurlyEpsilon]+\[Nu]MST] Gamma[1+\[Nu]MST+I \[Tau]]]//IgnoreExpansionParameter;
coeff=(coeff If[OptionValue["PochhammerForm"],sumUpPHCoeff,1])/.replsPN/.repls//IgnoreExpansionParameter;

sumDown=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = nMin\), \(\[ScriptR]\)]\(\((\(
\*FractionBox[
SuperscriptBox[\((\(-1\))\), \(n\)], \(\(\((\[ScriptR] - n)\)!\) PH[\[ScriptR] + 2\  \[Nu]MST + 2, n]\)] 
\*FractionBox[\(PH[\[Nu]MST + 1 + \[ScriptS] - I\  \[CurlyEpsilon], n]\), \(PH[\[Nu]MST + 1 - \[ScriptS] + I\  \[CurlyEpsilon], n]\)] /. replsPN\) /. repls\[Nu])\) \((aMST[n] /. repls)\)\)\)//IgnoreExpansionParameter;
ret=coeff/sumDown If[OptionValue["PochhammerForm"],sumUpPH,sumUp]//IgnoreExpansionParameter;
ret//SeriesTake[#,order\[Eta]]&
]


\[ScriptCapitalK]Amplitude["C-\[Nu]-1",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_,OptionsPattern[]]:=Module[{\[ScriptR]=0,ret,\[CapitalGamma]=Gamma,PH=Pochhammer,coeff,sumUp,sumUpPHCoeff,sumUpPH,sumDown,\[CurlyEpsilon]p,\[Tau],\[CurlyEpsilon],\[Kappa]=Sqrt[1-a^2],nMax,nMin,jump,jumpCount,repls,repls\[Nu]},
\[CurlyEpsilon]=2 \[Omega];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
jump[1]=2+2\[ScriptL]+\[ScriptR]<=Abs[n];
jump[2]=1+\[ScriptS]+\[ScriptL]<=n;
jump[3]=1-\[ScriptS]+\[ScriptL]<=n;
jumpCount=1+(jump[#]&/@Range[3]//Boole//Total);
repls=MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+3];
repls\[Nu]=<|\[Nu]MST->(repls[\[Nu]MST]//SeriesTake[#,order\[Eta]-Floor[n/3]+3jumpCount]&)|>;
coeff=I^-\[ScriptR] 2^(1+\[Nu]MST) E^(I \[CurlyEpsilon] \[Kappa]) (\[CurlyEpsilon] \[Kappa])^(1-\[ScriptR]+\[ScriptS]+\[Nu]MST) ( \[CapitalGamma][1-\[ScriptS]-2 I \[CurlyEpsilon]p] \[CapitalGamma][\[ScriptR]-2 \[Nu]MST])/\[CapitalGamma][\[ScriptR]-\[ScriptS]+I \[CurlyEpsilon]-\[Nu]MST]  If[\[ScriptR]==0&&OptionValue["PochhammerForm"],1,1/(\[CapitalGamma][\[ScriptR]-\[Nu]MST+I \[Tau]]\[CapitalGamma][\[ScriptR]+\[ScriptS]+I \[CurlyEpsilon]-\[Nu]MST] )]//IgnoreExpansionParameter;
nMax=Ceiling[order\[Eta]/3];
nMin=Ceiling[-(order\[Eta]/3)-2];
sumUp=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = nMin\), \(-\[ScriptR]\)]\(
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(-n\)]\ \  \[CapitalGamma][\(-1\) - n + \[ScriptR] - 2\  \[Nu]MST]\  \[CapitalGamma][\(-n\) + \[ScriptS] + I\  \[CurlyEpsilon] - \[Nu]MST]\  \[CapitalGamma][\(-n\) - \[Nu]MST + I\  \[Tau]]\), \(\(\((\(-n\) - \[ScriptR])\)!\)\  \[CapitalGamma][\(-n\) - \[ScriptS] - I\  \[CurlyEpsilon] - \[Nu]MST]\  \[CapitalGamma][\(-n\) - \[Nu]MST - I\  \[Tau]]\)] aMST[n]\)\)/.repls//IgnoreExpansionParameter;
sumUpPH=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = nMin\), \(-\[ScriptR]\)]\(\((\(
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(-n\)]\  PH[\(-1\) + \[ScriptR] - 2\  \[Nu]MST, \(-n\)]\  PH[\[ScriptS] + I\  \[CurlyEpsilon] - \[Nu]MST, \(-n\)]\  PH[\(-\[Nu]MST\) + I\  \[Tau], \(-n\)]\), \(\(\((\(-n\) - \[ScriptR])\)!\)\  PH[\(-\[ScriptS]\) - I\  \[CurlyEpsilon] - \[Nu]MST, \(-n\)]\  PH[\(-\[Nu]MST\) - I\  \[Tau], \(-n\)]\)] /. replsPN\) /. repls\[Nu])\) \((aMST[n]\  /. repls)\)\)\)//IgnoreExpansionParameter;
sumUpPHCoeff=Gamma[-1+\[ScriptR]-2 \[Nu]MST] /(Gamma[-\[ScriptS]-I \[CurlyEpsilon]-\[Nu]MST] Gamma[-\[Nu]MST-I \[Tau]]) If[\[ScriptR]==0,1,Gamma[\[ScriptS]+I \[CurlyEpsilon]-\[Nu]MST] Gamma[-\[Nu]MST+I \[Tau]]]//IgnoreExpansionParameter;
coeff=(coeff If[OptionValue["PochhammerForm"],sumUpPHCoeff,1])/.replsPN/.repls;

sumDown=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = \(-\[ScriptR]\)\), \(nMax\)]\(\((\(
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(-n\)]\  PH[\[ScriptS] - I\  \[CurlyEpsilon] - \[Nu]MST, \(-n\)]\), \(\(\((n + \[ScriptR])\)!\)\  PH[\[ScriptR] - 2\  \[Nu]MST, \(-n\)]\  PH[\(-\[ScriptS]\) + I\  \[CurlyEpsilon] - \[Nu]MST, \(-n\)]\)] /. replsPN\) /. repls\[Nu])\) \((aMST[n] /. repls)\)\)\)//IgnoreExpansionParameter;
ret=coeff/sumDown If[OptionValue["PochhammerForm"],sumUpPHCoeff sumUpPH,sumUp]//IgnoreExpansionParameter;
ret//SeriesTake[#,order\[Eta]]&
]


\[ScriptCapitalK]Amplitude["Ratio"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_,OptionsPattern[]]:=Module[{\[ScriptR]=0,ret,\[CapitalGamma]=Gamma,PH=Pochhammer,coeff,sumUp,sumUp2,sumUpPHCoeff,sumUpPH,sumDown,sumDown2,\[CurlyEpsilon]p,\[Tau],\[CurlyEpsilon],\[Kappa]=Sqrt[1-a^2],nMax,nMin,jump,jumpCount,repls,repls\[Nu]},
\[CurlyEpsilon]=2 \[Omega];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
jumpCount=1;
repls=MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+6];
repls\[Nu]=<|\[Nu]MST->(repls[\[Nu]MST]//SeriesTake[#,order\[Eta]-Floor[n/3]+6jumpCount]&)|>;
coeff=2^(1+2 \[Nu]MST) \[CurlyEpsilon] \[Kappa] (\[CurlyEpsilon] \[Kappa])^(2 \[Nu]MST) (\[CapitalGamma][\[ScriptR]-2 \[Nu]MST] \[CapitalGamma][1+\[ScriptR]-\[ScriptS]+I \[CurlyEpsilon]+\[Nu]MST])/(\[CapitalGamma][\[ScriptR]-\[ScriptS]+I \[CurlyEpsilon]-\[Nu]MST] \[CapitalGamma][2+\[ScriptR]+2 \[Nu]MST]) If[\[ScriptR]==0,1,(\[CapitalGamma][\[ScriptR]+\[Nu]MST+1+\[ScriptS]+I \[CurlyEpsilon]] \[CapitalGamma][\[ScriptR]+\[Nu]MST+1+I \[Tau]])/(\[CapitalGamma][\[ScriptR]-\[Nu]MST+I \[Tau]]\[CapitalGamma][\[ScriptR]+\[ScriptS]+I \[CurlyEpsilon]-\[Nu]MST] )]//IgnoreExpansionParameter;
nMax=Ceiling[order\[Eta]/3];
nMin=Ceiling[-(order\[Eta]/3)-2];
sumUpPH=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = nMin\), \(-\[ScriptR]\)]\(\((\(
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(-n\)]\  PH[\(-1\) + \[ScriptR] - 2\  \[Nu]MST, \(-n\)]\  PH[\[ScriptS] + I\  \[CurlyEpsilon] - \[Nu]MST, \(-n\)]\  PH[\(-\[Nu]MST\) + I\  \[Tau], \(-n\)]\), \(\(\((\(-n\) - \[ScriptR])\)!\)\  PH[\(-\[ScriptS]\) - I\  \[CurlyEpsilon] - \[Nu]MST, \(-n\)]\  PH[\(-\[Nu]MST\) - I\  \[Tau], \(-n\)]\)] /. replsPN\) /. repls\[Nu])\) \((aMST[n]\  /. repls)\)\)\)//IgnoreExpansionParameter;
sumUp2=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = nMin\), \(\[ScriptR]\)]\(\((\(
\*FractionBox[
SuperscriptBox[\((\(-1\))\), \(n\)], \(\(\((\[ScriptR] - n)\)!\) PH[\[ScriptR] + 2\  \[Nu]MST + 2, n]\)] 
\*FractionBox[\(PH[\[Nu]MST + 1 + \[ScriptS] - I\  \[CurlyEpsilon], n]\), \(PH[\[Nu]MST + 1 - \[ScriptS] + I\  \[CurlyEpsilon], n]\)] /. replsPN\) /. repls\[Nu])\) \((aMST[n] /. repls)\)\)\)//IgnoreExpansionParameter;
sumUpPHCoeff=(Gamma[-1+\[ScriptR]-2 \[Nu]MST] Gamma[1-\[ScriptS]-I \[CurlyEpsilon]+\[Nu]MST] Gamma[1+\[Nu]MST-I \[Tau]])/(Gamma[-\[ScriptS]-I \[CurlyEpsilon]-\[Nu]MST] Gamma[1+\[ScriptR]+2 \[Nu]MST] Gamma[-\[Nu]MST-I \[Tau]]) If[\[ScriptR]==0,1,(Gamma[\[ScriptS]+I \[CurlyEpsilon]-\[Nu]MST] Gamma[-\[Nu]MST+I \[Tau]])/(Gamma[1+\[ScriptS]+I \[CurlyEpsilon]+\[Nu]MST] Gamma[1+\[Nu]MST+I \[Tau]])]//IgnoreExpansionParameter;
coeff=(coeff sumUpPHCoeff)/.replsPN/.repls//IgnoreExpansionParameter;

sumDown=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = \(-\[ScriptR]\)\), \(nMax\)]\(\((\(
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(-n\)]\  PH[\[ScriptS] - I\  \[CurlyEpsilon] - \[Nu]MST, \(-n\)]\), \(\(\((n + \[ScriptR])\)!\)\  PH[\[ScriptR] - 2\  \[Nu]MST, \(-n\)]\  PH[\(-\[ScriptS]\) + I\  \[CurlyEpsilon] - \[Nu]MST, \(-n\)]\)] /. replsPN\) /. repls\[Nu])\) \((aMST[n] /. repls)\)\)\)//IgnoreExpansionParameter;
sumDown2=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = \[ScriptR]\), \(nMax\)]\(\((\(
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(n\)]\  PH[1 + \[ScriptS] + I\  \[CurlyEpsilon] + \[Nu]MST, n]\  PH[1 + \[ScriptR] + 2\  \[Nu]MST, n]\  PH[1 + \[Nu]MST + I\  \[Tau], n]\), \(\(\((n - \[ScriptR])\)!\)\  PH[1 - \[ScriptS] - I\  \[CurlyEpsilon] + \[Nu]MST, n]\  PH[1 + \[Nu]MST - I\  \[Tau], n]\)] /. replsPN\) /. repls\[Nu])\) \((aMST[n]\  /. repls)\)\)\)//IgnoreExpansionParameter;
ret=coeff  sumUp2/sumDown  sumUpPH/sumDown2//IgnoreExpansionParameter;
ret//SeriesTake[#,order\[Eta]]&
]


(* ::Subsubsection:: *)
(*Interface*)


Options[TeukolskyAmplitudePN]={"Normalization"->"Default"}


TeukolskyAmplitudePN["A+",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=AAmplitude["+"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};
TeukolskyAmplitudePN["A-",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=AAmplitude["-"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};


TeukolskyAmplitudePN["Binc",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=BAmplitude["Inc",opt][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};
TeukolskyAmplitudePN["Btrans",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=BAmplitude["Trans",opt][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};
TeukolskyAmplitudePN["Bref",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=BAmplitude["Ref",opt][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};


TeukolskyAmplitudePN["Ctrans",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=CAmplitude["Trans",opt][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};
TeukolskyAmplitudePN["Cinc",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=CAmplitude["Inc",opt][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};
TeukolskyAmplitudePN["Cref",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=CAmplitude["Ref",opt][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};


TeukolskyAmplitudePN["\[ScriptCapitalK]\[Nu]",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=\[ScriptCapitalK]Amplitude["\[Nu]"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};
TeukolskyAmplitudePN["\[ScriptCapitalK]-\[Nu]-1",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=\[ScriptCapitalK]Amplitude["C-\[Nu]-1"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};
TeukolskyAmplitudePN["\[ScriptCapitalK]",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}] :=\[ScriptCapitalK]Amplitude["Ratio"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};


(* ::Subsection::Closed:: *)
(*Wronskian*)


(* ::Subsubsection::Closed:: *)
(*Invariant Wronskian*)


InvariantWronskian[\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_,order\[Eta]_}]:=Module[{aux,Rup,Rin,B,C,ret},
C=CAmplitude["Trans"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]//ExpandPolyGamma//ExpandGamma;
B=BAmplitude["Inc"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]//ExpandPolyGamma//ExpandGamma;
aux=PNScalingsInternal[2 I \[Omega]]B C//ExpandLog//SeriesCollect[#,Log[__]]&;
ret=aux/.{\[Omega]->\[Omega]Var,\[Eta]->\[Eta]Var};
ret
]


(* ::Subsection::Closed:: *)
(*Subscript[R, In]*)


(* ::Text:: *)
(*To construct Subscript[R, In] we follow Eq.166 in Sasaki Tagoshi ( https://doi.org/10.12942/lrr-2003-6 ). Subscript[R, in]=Subscript[R, C]^\[Nu]+Subscript[\[ScriptCapitalK], -\[Nu]-1]/Subscript[\[ScriptCapitalK], \[Nu]] Subscript[R, C]^(-\[Nu]-1). Notice that we have divided out a factor of Subscript[\[ScriptCapitalK], \[Nu]], which is allowed since Subscript[\[ScriptCapitalK], \[Nu]] does not depend on r. This is helpful as the second term now dies off drastically with the increase of \[ScriptL]. \[ScriptCapitalK]^\[Nu] ~\[Omega]^-\[ScriptL]. \[ScriptCapitalK]^(-\[Nu]-1) ~\[Omega]^\[ScriptL] (Schwarzschild?)*)


(* ::Subsubsection::Closed:: *)
(*Definitions (depreciated)*)


(* ::Text:: *)
(*We start by typing up the definitions given in Sasaki Tagoshi Eq.162 - Eq.165. Notice that we use the symmetry Subscript[a, n]^(-\[Nu]-1)=Subscript[a, -n]^\[Nu] for the MST coefficients. One key challenge is figuring out where to truncate the infinite sums for a given scaling in \[Eta] most efficiently. This will be solved later in tableOverNJ[]. *)


(*c["In"][z_]:=E^(-I z) 2^\[Nu] z^\[Nu] (z-\[Epsilon] \[Kappa])^-s (1-(\[Epsilon] \[Kappa])/z)^(-I \[Epsilon]p);
\[Epsilon]p=(\[Epsilon]+\[Tau])/2;
\[ConstantC]D[\[Nu],n_,j_]:=((-1)^n (2 I)^(n+j) Gamma[n+\[Nu]+1-s+I \[Epsilon]] Pochhammer[\[Nu]+1+s-I \[Epsilon],n] Pochhammer[n+\[Nu]+1-s+I \[Epsilon],j] a[n])/(Gamma[2 n+2 \[Nu]+2] Pochhammer[\[Nu]+1-s+I \[Epsilon],n] Pochhammer[2 n+2 \[Nu]+2,j] j!);
\[ConstantC]D[-\[Nu]-1,n_,j_]:=((-1)^n (2 I)^(n+j) Gamma[n+\[Nu]+1-s+I \[Epsilon]] Pochhammer[\[Nu]+1+s-I \[Epsilon],n] Pochhammer[n+\[Nu]+1-s+I \[Epsilon],j] a[-n])/(Gamma[2 n+2 \[Nu]+2] Pochhammer[\[Nu]+1-s+I \[Epsilon],n] Pochhammer[2 n+2 \[Nu]+2,j] j!)/. \[Nu]->-\[Nu]-1;
(*\[ScriptCapitalK][\[Nu],order\[Eta]_]:=((E^(I \[Epsilon] \[Kappa]) (2 \[Epsilon] \[Kappa])^(s-\[Nu]-rInt) 2^-s I^rInt Gamma[1-s-2 I \[Epsilon]p] Gamma[rInt+2 \[Nu]+2]) \!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = rInt\), \(Ceiling[
\*FractionBox[\(order\[Eta]\), \(3\)]]\)]
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(n\)]\ Gamma[n + rInt + 2\ \[Nu] + 1]\ Gamma[n + \[Nu] + 1 + s + I\ \[Epsilon]]\ Gamma[n + \[Nu] + 1 + I\ \[Tau]]\ a[n]\), \(\(\((n - rInt)\)!\)\ Gamma[n + \[Nu] + 1 - s - I\ \[Epsilon]]\ Gamma[n + \[Nu] + 1 - I\ \[Tau]]\)]\))/((Gamma[rInt+\[Nu]+1-s+I \[Epsilon]] Gamma[rInt+\[Nu]+1+I \[Tau]] Gamma[rInt+\[Nu]+1+s+I \[Epsilon]]) \!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = Floor[\(-
\*FractionBox[\(1\), \(3\)]\)\ \((order\[Eta] + 6)\)]\), \(rInt\)]
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(n\)]\ Pochhammer[\[Nu] + 1 + s - I\ \[Epsilon], n]\ a[n]\), \(\((\(\((rInt - n)\)!\)\ Pochhammer[rInt + 2\ \[Nu] + 2, n])\)\ Pochhammer[\[Nu] + 1 - s + I\ \[Epsilon], n]\)]\))/. rInt->Ceiling[order\[Eta]/3];
\[ScriptCapitalK][-\[Nu]-1,order\[Eta]_]:=((E^(I \[Epsilon] \[Kappa]) (2 \[Epsilon] \[Kappa])^(s-\[Nu]-rInt) 2^-s I^rInt Gamma[1-s-2 I \[Epsilon]p] Gamma[rInt+2 \[Nu]+2]) \!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = rInt\), \(Ceiling[
\*FractionBox[\(order\[Eta] + 6\), \(3\)]]\)]
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(n\)]\ Gamma[n + rInt + 2\ \[Nu] + 1]\ Gamma[n + \[Nu] + 1 + s + I\ \[Epsilon]]\ Gamma[n + \[Nu] + 1 + I\ \[Tau]]\ a[\(-n\)]\), \(\(\((n - rInt)\)!\)\ Gamma[n + \[Nu] + 1 - s - I\ \[Epsilon]]\ Gamma[n + \[Nu] + 1 - I\ \[Tau]]\)]\))/((Gamma[rInt+\[Nu]+1-s+I \[Epsilon]] Gamma[rInt+\[Nu]+1+I \[Tau]] Gamma[rInt+\[Nu]+1+s+I \[Epsilon]]) \!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = Floor[\(-
\*FractionBox[\(order\[Eta]\), \(3\)]\)]\), \(rInt\)]
\*FractionBox[\(
\*SuperscriptBox[\((\(-1\))\), \(n\)]\ Pochhammer[\[Nu] + 1 + s - I\ \[Epsilon], n]\ a[\(-n\)]\), \(\((\(\((rInt - n)\)!\)\ Pochhammer[rInt + 2\ \[Nu] + 2, n])\)\ Pochhammer[\[Nu] + 1 - s + I\ \[Epsilon], n]\)]\))/. {rInt->0,\[Nu]->-\[Nu]-1};*)*)


(* ::Subsubsection::Closed:: *)
(*Alternative Definitions*)


z[a_,r_]:=(-1+Sqrt[1-a^2]+r) \[Omega]//PNScalingsInternal;


c["In"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,z_]:=Module[{aux,\[CurlyEpsilon]p,\[Tau],\[CurlyEpsilon],\[Kappa]},
\[CurlyEpsilon]=2 \[Omega];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Kappa]=Sqrt[1-a^2];
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
aux=E^(-I z) 2^\[Nu]MST z^\[Nu]MST (z-\[CurlyEpsilon] \[Kappa])^-\[ScriptS] (1-(\[CurlyEpsilon] \[Kappa])/z)^(-I \[CurlyEpsilon]p);
aux//PNScalingsInternal]


\[ConstantC]D["\[Nu]"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,n_,j_]:=Module[{aux,\[CapitalGamma]=Gamma,PH=Pochhammer,\[CurlyEpsilon]p,\[Tau],\[CurlyEpsilon],\[Kappa]},
\[CurlyEpsilon]=2 \[Omega];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Kappa]=Sqrt[1-a^2];
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
aux=((-1)^n (2 I)^(n+j) \[CapitalGamma][n+\[Nu]MST+1-\[ScriptS]+I \[CurlyEpsilon]] PH[\[Nu]MST+1+\[ScriptS]-I \[CurlyEpsilon],n] PH[n+\[Nu]MST+1-\[ScriptS]+I \[CurlyEpsilon],j] aMST[n])/(\[CapitalGamma][2 n+2 \[Nu]MST+2] PH[\[Nu]MST+1-\[ScriptS]+I \[CurlyEpsilon],n] PH[2 n+2 \[Nu]MST+2,j] j!);
aux//PNScalingsInternal
];


\[ConstantC]D["C-\[Nu]-1"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,n_,j_]:=Module[{aux,\[CapitalGamma]=Gamma,PH=Pochhammer,\[CurlyEpsilon]p,\[Tau],\[CurlyEpsilon],\[Kappa]},
\[CurlyEpsilon]=2 \[Omega];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Kappa]=Sqrt[1-a^2];
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
aux=((-1)^n (2 I)^(j+n)  PH[\[ScriptS]-I \[CurlyEpsilon]-\[Nu]MST,n] PH[n-\[ScriptS]+I \[CurlyEpsilon]-\[Nu]MST,j] \[CapitalGamma][n-\[ScriptS]+I \[CurlyEpsilon]-\[Nu]MST])/(j! PH[2 n-2 \[Nu]MST,j] PH[-\[ScriptS]+I \[CurlyEpsilon]-\[Nu]MST,n] \[CapitalGamma][2 n-2 \[Nu]MST]) aMST[-n];
aux//PNScalingsInternal
];


(* ::Subsubsection::Closed:: *)
(*Constructing \!\(\*SubsuperscriptBox[\(R\), \(C\), \(\[Nu]\)]\)*)


(* ::Text:: *)
(*To construct Subscript[R, C]^\[Nu] we follow the first instance of Eq.162, i.e., Subscript[R, C]^\[Nu]=coeff \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(n = \(-\[Infinity]\)\), \(\[Infinity]\)]\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(j = 0\), \(\[Infinity]\)]\[ConstantC]D[\[Nu], n, j]\ *)
(*\*SuperscriptBox[\(z[r]\), \(n + j\)]\)\). To execute the sums we use tableOverNJ[] which constructs a table of all needed terms. You can find some plots illustrating the variables nMin, nMax and firstRegularj in the Hyperlink["Plots section",{NotebookObject["c6ff3b79-aebc-4585-b130-dd1a930b511b", "9e23625d-8944-48d8-a536-bca7efa5e050"], "\[Nu]Plots"}]. These are essential in telling you where to truncate the sums. *)


(* ::Input:: *)
(*(*tableOverNJ["C\[Nu]"][\[ScriptL]_,term_,repls_,order\[Eta]_]:=Block[{table,aux,finalj,firstRegularj,firstRegular\[Eta],leading\[Eta]OrderTerm,leading\[Eta]Order,goal\[Eta]Order,replsAux,replsLeading,auxOrder,nMin,nMax},*)
(*replsLeading=SeriesTake[#,7]&/@repls;*)
(*firstRegularj=(Abs[2+2\[ScriptL]+2 n]+1);*)
(*leading\[Eta]Order=(term/.j->#/.n->0/.replsLeading//SeriesMinOrder)&/@{0,firstRegularj}//Min;*)
(*goal\[Eta]Order=order\[Eta]+leading\[Eta]Order;*)
(*nMin=-(goal\[Eta]Order/2)//Ceiling;*)
(*nMax=goal\[Eta]Order/4//Floor;*)
(*table=Table[*)
(*firstRegular\[Eta]=(term/.j->firstRegularj/.replsLeading//SeriesMinOrder);*)
(*finalj=firstRegularj+(goal\[Eta]Order-firstRegular\[Eta]);*)
(*Table[*)
(*leading\[Eta]OrderTerm=term/.replsLeading//SeriesMinOrder;*)
(*If[leading\[Eta]OrderTerm<=goal\[Eta]Order,*)
(*auxOrder=goal\[Eta]Order-leading\[Eta]OrderTerm+If[n<0,6,0]//Max[#,7]&;*)
(*replsAux=SeriesTake[#,auxOrder]&/@repls;*)
(*aux=term/.replsAux;*)
(*,(*else*)*)
(*aux=O[\[Eta]]^(goal\[Eta]Order+1);*)
(*];*)
(*aux*)
(*,{j,0,finalj}]*)
(*,{n,nMin,nMax}]//Simplify;*)
(*table]*)
(**)
(*RPN["C\[Nu]"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]Var_,aKerr_,order\[Eta]_]:=Block[{s=\[ScriptS],l=\[ScriptL],m=\[ScriptM]Var,\[ScriptM]=\[ScriptM]Var,a=aKerr,\[ScriptA]=aKerr,aux,repls,replsAux,replsCoeff,replsLeading,coeff,term,status,table},*)
(*Monitor[status="getting repls";*)
(*repls=replsMST[\[ScriptS],\[ScriptL],\[ScriptM],Max[Ceiling[order\[Eta],3]+4,7]];*)
(*replsCoeff=SeriesTake[#,Max[order\[Eta],7]]&/@repls;*)
(*status="coefficient";*)
(*coeff=(c["In"][z[r]]//.replsKerr/.\[Epsilon]->2\[Omega]/.replsPN//Simplify)/.replsCoeff;*)
(*status="term";*)
(*term=\[ConstantC]D[\[Nu],n,j] z[r]^(n+j)//.replsKerr/.\[Epsilon]->2\[Omega]/.replsPN;*)
(*status="tableing";*)
(*table=tableOverNJ["C\[Nu]"][\[ScriptL],term,repls,order\[Eta]];*)
(*status="summing";*)
(*table=table//Flatten//Total;*)
(*status="assembling";*)
(*coeff table//SeriesTake[#,order\[Eta]]&*)
(*,{status,n,j}]]*)*)


RPN["C\[Nu]"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,repls,replsAux,replsCoeff,replsLeading,coeff,term,status,table,ret,nMin},
nMin=Ceiling[(order\[Eta]+7)/3];
repls=MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+nMin+1];
replsCoeff=SeriesTake[#,Max[order\[Eta],7]]&/@repls;
coeff=c["In"][\[ScriptS],\[ScriptL],\[ScriptM],a,z[a,r]]/.replsCoeff;
term=\[ConstantC]D["\[Nu]"][\[ScriptS],\[ScriptL],\[ScriptM],a,n,j] z[a,r]^(n+j);
table=tableOverNJ["C\[Nu]"][\[ScriptL],term,repls,order\[Eta]];
table=table//Flatten//Total;
ret=coeff table//SeriesTake[#,order\[Eta]]&;
ret
]


tableOverNJ["C\[Nu]"][\[ScriptL]_,term_,repls_,order\[Eta]_]:=Module[{table,aux,finalj,firstRegularj,firstRegular\[Eta],leading\[Eta]OrderTerm,leading\[Eta]Order,goal\[Eta]Order,replsAux,replsLeading,auxOrder,nMin,nMax},replsLeading=(SeriesTake[#1,7]&)/@repls;firstRegularj=Abs[2+2 \[ScriptL]+2 n]+1;leading\[Eta]Order=(term/. j->#1&/@{0,firstRegularj})/. n->0/. replsLeading//SeriesMinOrder//Min;goal\[Eta]Order=order\[Eta]+leading\[Eta]Order;
nMin=Ceiling[-((goal\[Eta]Order+3)/2)];
nMax=Floor[goal\[Eta]Order/4];
table=Simplify[Table[firstRegular\[Eta]=SeriesMinOrder[term/. j->firstRegularj/. replsLeading];
finalj=firstRegularj+(goal\[Eta]Order-firstRegular\[Eta]);
Table[leading\[Eta]OrderTerm=SeriesMinOrder[term/. replsLeading];
If[leading\[Eta]OrderTerm<=goal\[Eta]Order,
auxOrder=(Max[#1,7]&)[goal\[Eta]Order-leading\[Eta]OrderTerm+If[n<0,7,0]];
replsAux=(SeriesTake[#1,auxOrder]&)/@repls;
aux=term/.replsAux;
,(*else*)
aux=O[\[Eta]]^(goal\[Eta]Order+1);
];
aux,{j,0,finalj}]
,{n,nMin,nMax}]];table]


(* ::Subsubsection::Closed:: *)
(*Constructing \!\(\*SubsuperscriptBox[\(R\), \(C\), \(\(-\[Nu]\) - 1\)]\) *)


(* ::Text:: *)
(*The construction of the second term is very similar to Subscript[R, C] just with different scalings and coefficients. Again Plots can be found in the Hyperlink["Plots section",{NotebookObject["c6ff3b79-aebc-4585-b130-dd1a930b511b", "9e23625d-8944-48d8-a536-bca7efa5e050"], "2ndPlots"}]*)


(* ::Input:: *)
(*(*RPN["2ndTerm"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]Var_,aKerr_,order\[Eta]_]:=Block[{s=\[ScriptS],l=\[ScriptL],m=\[ScriptM]Var,\[ScriptM]=\[ScriptM]Var,\[ScriptA]=aKerr,a=aKerr,aux,ret,repls,repls\[ScriptCapitalK],replsLeading,coeff,term,status,table,factor\[ScriptCapitalK],replsCut},*)
(*Monitor[status="getting repls";*)
(*repls=replsMST[\[ScriptS],\[ScriptL],\[ScriptM],Max[Ceiling[order\[Eta],3]+10,7]];*)
(*	status="\[ScriptCapitalK] factor";*)
(*replsCut=SeriesTake[#,Max[order\[Eta]+1,7]]&/@repls;*)
(*repls\[ScriptCapitalK]=SeriesTake[#,Max[order\[Eta]+7,7]]&/@repls;*)
(*(*EchoTiming[factor\[ScriptCapitalK]=(\[ScriptCapitalK][-\[Nu]-1,order\[Eta](*-2 \[ScriptL]*)]/\[ScriptCapitalK][\[Nu],order\[Eta](*-2 \[ScriptL]*)]//.replsKerr/.\[Epsilon]->2\[Omega]/.replsPN)/.repls\[ScriptCapitalK];*)
(*factor\[ScriptCapitalK]=factor\[ScriptCapitalK]//Collect[#,{\[Eta],Gamma[__]},Simplify]&//polyToSeries;*)
(*,"\[ScriptCapitalK] factor"];*)*)
(*factor\[ScriptCapitalK]=\[ScriptCapitalK]Amplitude["Ratio"][\[ScriptS],\[ScriptL],\[ScriptM]Var,aKerr,order\[Eta]]//ExpandGamma//ExpandPolyGamma//SeriesCollect[#,{Gamma[__],PolyGamma[__,__]},Simplify]&;*)
(*	status="coeff";*)
(*coeff=(c["In"][z[r]] /.\[Nu]->-\[Nu]-1//.replsKerr/.\[Epsilon]->2\[Omega]/.replsPN//Simplify);*)
(*coeff=coeff/.replsCut//Collect[#,{\[Eta],Log[__]}]&//Simplify//polyToSeries;*)
(*	status="table";*)
(*term=\[ConstantC]D[-\[Nu]-1,n,j] z[r]^(n+j)//.replsKerr/.\[Epsilon]->2\[Omega]/.replsPN;*)
(*table=tableOverNJ["2ndTerm"][\[ScriptL],term,repls,order\[Eta]];*)
(*	status="summing";*)
(*table=table//Flatten//Total//Simplify;*)
(*	status="assembling";*)
(*ret=factor\[ScriptCapitalK] coeff table;*)
(*	status="cutting the result";*)
(**)
(*(*EchoTiming[ret=ret//Collect[#,{\[Eta],Gamma[__]},Simplify]&//polyToSeries,"collecting"];*)
(*Print[ret];*)*)
(*ret=ret//SeriesTake[#,order\[Eta]]&;*)
(*ret*)
(*,{status,n,j}]]*)*)


tableOverNJ["C-\[Nu]-1"][\[ScriptL]_,term_,repls_,order\[Eta]_]:=Block[{table,aux,finalj,firstRegularj,firstRegular\[Eta],leading\[Eta]OrderTerm,leading\[Eta]Order,goal\[Eta]Order,replsAux,replsLeading,auxOrder,nMin,nMax},
replsLeading=repls//SeriesTake[#1,7]&;
firstRegularj=Abs[-2 \[ScriptL]+2 n]+1;
leading\[Eta]Order=Min[(SeriesMinOrder[term/. j->#1/. n->0/. replsLeading]&)/@{0,firstRegularj}];
goal\[Eta]Order=order\[Eta]+leading\[Eta]Order;
nMin=(Min[#1,0]&)[Ceiling[(3-goal\[Eta]Order)/2]];
nMax=Floor[(6+goal\[Eta]Order)/4];
table=Table[firstRegular\[Eta]=SeriesMinOrder[term/. j->firstRegularj/. replsLeading];
finalj=firstRegularj+(goal\[Eta]Order-firstRegular\[Eta]);
Table[leading\[Eta]OrderTerm=SeriesMinOrder[term/. replsLeading];
If[leading\[Eta]OrderTerm<=goal\[Eta]Order,auxOrder=(Max[#1,7]&)[goal\[Eta]Order-leading\[Eta]OrderTerm+6];
replsAux=(SeriesTake[#1,auxOrder]&)/@repls;
aux=term/. replsAux;
,aux=O[\[Eta]]^(goal\[Eta]Order+1);];
aux,{j,0,finalj}],{n,nMin,nMax}];
table]


RPN["C-\[Nu]-1"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,ret,repls,repls\[ScriptCapitalK],replsLeading,coeff,term,table,factor\[ScriptCapitalK],replsCut},
repls=MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,Max[Ceiling[order\[Eta],3]+10,7]];
replsCut=repls//SeriesTake[#,Max[order\[Eta]+1,7]]&;
coeff=c["In"][\[ScriptS],\[ScriptL],\[ScriptM],a,z[a,r]]/. \[Nu]MST->-\[Nu]MST-1/.replsCut//SeriesCollect[#,Log[__],Simplify]&;
term=\[ConstantC]D["C-\[Nu]-1"][\[ScriptS],\[ScriptL],\[ScriptM],a,n,j] z[a,r]^(n+j)//PNScalingsInternal;
table=tableOverNJ["C-\[Nu]-1"][\[ScriptL],term,repls,order\[Eta]];
table=Simplify[Total[Flatten[table]]];
ret=coeff table;
ret=(SeriesTake[#1,order\[Eta]]&)[ret];
ret
]


(* ::Input:: *)
(*(*RPN["2ndTerm"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]Var_,aKerr_,order\[Eta]_]:=Block[{s=\[ScriptS],l=\[ScriptL],m=\[ScriptM]Var,\[ScriptM]=\[ScriptM]Var,\[ScriptA]=aKerr,a=aKerr,aux,ret,repls,repls\[ScriptCapitalK],replsLeading,coeff,term,status,table,factor\[ScriptCapitalK],replsCut},*)
(*Monitor[status="getting repls";*)
(*repls=replsMST[\[ScriptS],\[ScriptL],\[ScriptM],Max[Ceiling[order\[Eta],3]+10,7]];*)
(*	status="\[ScriptCapitalK] factor";*)
(*replsCut=SeriesTake[#,Max[order\[Eta]+1,7]]&/@repls;*)
(*repls\[ScriptCapitalK]=SeriesTake[#,Max[order\[Eta]+7,7]]&/@repls;*)
(*factor\[ScriptCapitalK]=(\[ScriptCapitalK]Amplitude[-\[Nu]-1][\[ScriptS],\[ScriptL],\[ScriptM]Var,aKerr,order\[Eta](*-2 \[ScriptL]*)]/\[ScriptCapitalK]Amplitude[\[Nu]][\[ScriptS],\[ScriptL],\[ScriptM]Var,aKerr,order\[Eta](*-2 \[ScriptL]*)])//ExpandGamma//ExpandPolyGamma;*)
(*factor\[ScriptCapitalK]=factor\[ScriptCapitalK]//Collect[#,{\[Eta],Gamma[__]},Simplify]&//polyToSeries;*)
(*	status="coeff";*)
(*coeff=(c["In"][z[r]] /.\[Nu]->-\[Nu]-1//.replsKerr/.\[Epsilon]->2\[Omega]/.replsPN//Simplify);*)
(*coeff=coeff/.replsCut//Collect[#,{\[Eta],Log[__]}]&//Simplify//polyToSeries;*)
(*	status="table";*)
(*term=\[ConstantC]D[-\[Nu]-1,n,j] z[r]^(n+j)//.replsKerr/.\[Epsilon]->2\[Omega]/.replsPN;*)
(*table=tableOverNJ["2ndTerm"][\[ScriptL],term,repls,order\[Eta]];*)
(*	status="summing";*)
(*table=table//Flatten//Total//Simplify;*)
(*	status="assembling";*)
(*ret=factor\[ScriptCapitalK] coeff table;*)
(*	status="cutting the result";*)
(**)
(*(*EchoTiming[ret=ret//Collect[#,{\[Eta],Gamma[__]},Simplify]&//polyToSeries,"collecting"];*)
(*Print[ret];*)*)
(*ret=ret//SeriesTake[#,order\[Eta]]&;*)
(*ret*)
(*,{status,n,j}]]*)*)


(* ::Subsubsection::Closed:: *)
(*Constructing Subscript[R, In]*)


(* ::Text:: *)
(*Subscript[R, in] is now simply the sum of the two terms. A visualisation of the gap can be found in the Hyperlink["Plots section",{NotebookObject["c6ff3b79-aebc-4585-b130-dd1a930b511b", "9e23625d-8944-48d8-a536-bca7efa5e050"], "gapPlot"}]*)


InGap[\[ScriptL]_,\[ScriptM]aKerr_]:=4\[ScriptL]-1;
InGap[0,\[ScriptM]aKerr_]:=0
InGap[0,0]=0;
InGap[\[ScriptL]_,0]:=4\[ScriptL]+2;


Options[RPN]={"Normalization"->"Default"}


RPN["In",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,ret,gap,\[ScriptCapitalK],secondTerm,secondR,normalization},
gap=InGap[\[ScriptL],\[ScriptM] a];
\[ScriptCapitalK]=If[order\[Eta]>=gap,\[ScriptCapitalK]Amplitude["Ratio"][\[ScriptS],\[ScriptL],\[ScriptM],a,Max[order\[Eta]-gap,2]]//ExpandGamma//ExpandPolyGamma//SeriesCollect[#,PolyGamma[__,__]]&,1];
secondR=If[order\[Eta]>=gap,RPN["C-\[Nu]-1"][\[ScriptS],\[ScriptL],\[ScriptM],a,Max[order\[Eta]-gap,2]],0];
secondTerm=\[ScriptCapitalK] secondR;
aux=RPN["C\[Nu]"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]+secondTerm;
normalization=Switch[OptionValue["Normalization"],
	"Default",1,
	"SasakiTagoshi",\[ScriptCapitalK]Amplitude["\[Nu]"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]],
	"UnitTransmission",1/BAmplitude["Trans"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]
];
ret=normalization aux;
ret//IgnoreExpansionParameter
]


RPN["In"][0,0,0,aKerr_,1]:=49/81+O[\[Eta]]
RPN["In"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aKerr_,1]:=(2^\[ScriptL] (-\[ScriptS]+\[ScriptL])!)/(2\[ScriptL]+1)! (r \[Omega] \[Eta])^(-\[ScriptS]+\[ScriptL]) +O[\[Eta]] \[Eta]^(-\[ScriptS]+\[ScriptL])

RPN["C\[Nu]"][0,0,0,aKerr_,1]:=7/9+O[\[Eta]]
RPN["C\[Nu]"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aKerr_,1]:=RPN["In"][\[ScriptS],\[ScriptL],\[ScriptM],aKerr,1]


RPN["In"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aKerr_,0]:=O[\[Eta]] \[Eta]^(-\[ScriptS]+\[ScriptL]-1)
RPN["C\[Nu]"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aKerr_,0]:=O[\[Eta]] \[Eta]^(-\[ScriptS]+\[ScriptL]-1)


(* ::Subsection::Closed:: *)
(*Subscript[R, Up]*)


(* ::Text:: *)
(*To construct Subscript[R, up] we follow Eq.159 in Sasaki Tagoshi ( https://doi.org/10.12942/lrr-2003-6 ) where \[CapitalPsi] is identical to HypergeometricU[]..*)


(* ::Subsubsection::Closed:: *)
(*Definitions (depreciated)*)


(* ::Text:: *)
(*We expand the Hypergeometrics in Kummer functions (c.f. Eq.13.2.42 in the Digital Library of Mathematical Functions https://dlmf.nist.gov/13.2#E42 ) and then expand the Kummer functions in Pochhammers ( c.f. https://dlmf.nist.gov/13.2#E2 ). The result of this are the individual elements over which we will table again, just as we did for Subscript[R, in].*)


(*(*z[r_]:=\[Omega](r-(1-\[Kappa]))*)

(*kummerM[a_,b_,z_,order_]:=\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(i = 0\), \(order\)]\(
\*FractionBox[\(Pochhammer[a, i]\), \(Pochhammer[b, i]\)]
\*FractionBox[\(1\), \(i!\)]
\*SuperscriptBox[\(z\), \(i\)]\)\);
UtoM[order_]:=(HypergeometricU[a_,b_,z_]:>
Gamma[1-b]/Gamma[a-b+1]kummerM[a,b,z,order]+Gamma[b-1]/Gamma[a]z^(1-b) kummerM[a-b+1,2-b,z,order]);

term["up"][n_,z_,order_]:=a[n](2 \[ImaginaryI] z)^nPochhammer[1+s+\[Nu]-\[ImaginaryI] \[Epsilon],n]/Pochhammer[1+s+\[Nu]+\[ImaginaryI] \[Epsilon]-2s,n]HypergeometricU[n+1+s+\[Nu]-\[ImaginaryI] \[Epsilon],2n+2+2\[Nu],-2\[ImaginaryI] z]/.UtoM[order];
R["up"][z_,order_]:=c["up"][z](*Gamma[\[Nu]-s+1+\[ImaginaryI] \[Epsilon]]/Gamma[\[Nu]+s+1-\[ImaginaryI] \[Epsilon]]*)\!\(
\*UnderoverscriptBox[\(\[Sum]\), \(n = \(-\((order + 2)\)\)\), \(order\)]\(\(term["\<up\>"]\)[n, z, order]\)\)*)
(*c["up"][z_]:=2^\[Nu]\[ExponentialE]^(-\[Pi] \[Epsilon])\[ExponentialE]^(-\[ImaginaryI] \[Pi](\[Nu]+1+s))\[ExponentialE]^(\[ImaginaryI] z)z^(\[Nu]+\[ImaginaryI](\[Epsilon]+\[Tau])/2)/(z-\[Epsilon] \[Kappa])^(s+\[ImaginaryI] (\[Epsilon]+\[Tau])/2);*)
c["Up"][z_]:=2^\[Nu] E^(-\[Pi] \[Epsilon]) E^(-I \[Pi](\[Nu]+1+s)) E^(I z) (z-\[Epsilon] \[Kappa])^-s z^\[Nu] (1-(\[Epsilon] \[Kappa])/z)^(-I \[Epsilon]p)
element["Up"][n_,j_,z_]:=2^n (I z)^n Pochhammer[1+s-I \[Epsilon]+\[Nu],n]/Pochhammer[1-s+I \[Epsilon]+\[Nu],n] ((2^(-1+j-2 n-2 \[Nu]) (-I z)^(-1+j-2 n-2 \[Nu]) Gamma[1+2 n+2 \[Nu]] Pochhammer[-n+s-I \[Epsilon]-\[Nu],j])/(j! Gamma[1+n+s-I \[Epsilon]+\[Nu]] Pochhammer[-2 n-2 \[Nu],j])+(2^j (-I z)^j Gamma[-1-2 n-2 \[Nu]] Pochhammer[1+n+s-I \[Epsilon]+\[Nu],j])/(j! Gamma[-n+s-I \[Epsilon]-\[Nu]] Pochhammer[2+2 n+2 \[Nu],j]))*)


(* ::Subsubsection:: *)
(*Constructions (depreciated)*)


(* ::Text:: *)
(*The construction of Subscript[R, up] is very much like the one for Subscript[R, C]. To execute the sums we use tableOverNJ[] which constructs a table of all needed terms. Again you can find some plots illustrating the variables nMin, nMax and firstRegularj in the Hyperlink["plot section",{NotebookObject["c6ff3b79-aebc-4585-b130-dd1a930b511b", "9e23625d-8944-48d8-a536-bca7efa5e050"], "plotsUp"}]. These are essential in telling you where to truncate the sums. *)


(*tableOverNJ["Up"][\[ScriptL]_,term_,repls_,order\[Eta]_]:=Block[{table,tableNeg,tablePos,aux,aux2,finalj,firstRegularj,firstRegular\[Eta],leading\[Eta]OrderTerm,leading\[Eta]Order,goal\[Eta]Order,aux\[Eta],replsAux,replsLeading,auxOrder,nMin,nMax,status},
	status="tableing setup";
replsLeading=SeriesTake[#,7]&/@repls;
firstRegularj=Min[Abs[2+2\[ScriptL]+2 n]+1,Abs[-2 n-2 \[ScriptL]]+1];
leading\[Eta]Order=(term/.j->#/.n->0/.replsLeading//SeriesMinOrder)&/@{0,firstRegularj}//Min;
goal\[Eta]Order=order\[Eta]+leading\[Eta]Order;
nMin=Min[1/4 (-1-goal\[Eta]Order-2 \[ScriptL]),1/2 (-3-goal\[Eta]Order)]//Ceiling;
nMax=1/2 (1+goal\[Eta]Order+2 \[ScriptL])//Floor;
table=Table[
status="getting finalj";
firstRegular\[Eta]=(term/.j->firstRegularj/.replsLeading//SeriesMinOrder);
finalj=firstRegularj+(goal\[Eta]Order-firstRegular\[Eta]);
Table[
status="j table";
leading\[Eta]OrderTerm=term/.replsLeading//SeriesMinOrder;
If[leading\[Eta]OrderTerm<=goal\[Eta]Order,
status="entered doing something";
auxOrder=goal\[Eta]Order-leading\[Eta]OrderTerm+6//Max[#,7]&;
replsAux=SeriesTake[#,auxOrder]&/@repls;
status="doing something";
aux=term/.replsAux;,
(*else*)
status="entered doing nothing";
aux=Quiet[O[\[Eta]]^(goal\[Eta]Order+1)];
];
aux
,{j,0,finalj}]
,{n,nMin,nMax}];
table]

RPN["Up"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]Var_,aKerr_,order\[Eta]_]:=Block[{s=\[ScriptS],l=\[ScriptL],m=\[ScriptM]Var,\[ScriptM]=\[ScriptM]Var,\[ScriptA]=aKerr,a=aKerr,aux,aux2,repls,replsCoeff,coeff,table,tableNeg,tablePos,status,list,term},
Monitor[
	status="repls";
repls=replsMST[\[ScriptS],\[ScriptL],\[ScriptM],Max[Ceiling[order\[Eta],3]+9,7]];
	status="coeff";
replsCoeff=SeriesTake[#,Max[order\[Eta],7]]&/@repls;
coeff=(c["Up"][z[r]]//.replsKerr/.\[Epsilon]->2\[Omega]/.replsPN//Simplify)/.replsCoeff;
	status="constructing term";
term=element["Up"][n,j,z[r]]a[n]//.replsKerr/.\[Epsilon]->2\[Omega]/.replsPN;
	status="tableing";
table=tableOverNJ["Up"][\[ScriptL],term,repls,order\[Eta]];
	status="flattening";
table=Total@Flatten@table;
	status="assembling";
coeff table//SeriesTake[#,order\[Eta]]&
,{status,n,j}]]
*)


(* ::Subsubsection::Closed:: *)
(*Constructing Subscript[R, up] from Subscript[R, C]*)


(* ::Text:: *)
(*We turn to Throwe's bachelor thesis where  Eq.(B.7) gives Subscript[R, up] in terms of \!\(\*SubsuperscriptBox[\(R\), \(C\), \(\[Nu]\)]\) and \!\(\*SubsuperscriptBox[\(R\), \(C\), \(\(-\[Nu]\) - 1\)]\).*)


RPN["Up",OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Module[{aux,ret,\[CurlyEpsilon],\[CurlyEpsilon]p,\[Kappa],\[Tau],C1,C2,repls,term1,term2,coeff,normalization},
\[CurlyEpsilon]=2 \[Omega];
\[CurlyEpsilon]p=(\[CurlyEpsilon]+\[Tau])/2;
\[Kappa]=Sqrt[1-a^2];
\[Tau]=(-a \[ScriptM]+\[CurlyEpsilon])/\[Kappa];
repls=MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]+7];
coeff=(-I E^(-\[Pi] \[CurlyEpsilon]-I \[Pi] \[ScriptS])Sin[\[Pi](\[Nu]MST+\[ScriptS]-I \[CurlyEpsilon])]/Sin[2\[Pi] \[Nu]MST]);
(*coeff=1;*)
C1=PNScalingsInternal[coeff]/.repls;
C2=PNScalingsInternal[coeff I E^(-I \[Pi] \[Nu]MST) Sin[\[Pi](\[Nu]MST-\[ScriptS]+I \[CurlyEpsilon])]/ Sin[\[Pi](\[Nu]MST+\[ScriptS]-I \[CurlyEpsilon])]]/.repls;
term1=C1 RPN["C-\[Nu]-1"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]];
term2=C2 RPN["C\[Nu]"][\[ScriptS],\[ScriptL],\[ScriptM],a,Max[order\[Eta]-2\[ScriptL]+2,0]];
aux=term1+term2;
normalization=Switch[OptionValue["Normalization"],
	"Default",1,
	"SasakiTagoshi",1,
	"UnitTransmission",1/CAmplitude["Trans"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]
];
aux=aux//SeriesTake[#,order\[Eta]]&;
ret=aux normalization;
ret//IgnoreExpansionParameter
] 


RPN["Up"][0,0,0,aKerr_,1]:=-((7 I)/(18 r \[Omega] \[Eta]))+O[\[Eta]] \[Eta]^-1
RPN["Up"][\[ScriptS]_/;\[ScriptS]<=0,\[ScriptL]_,\[ScriptM]Var_,aKerr_,1]:=((-1)^(\[ScriptS]+1) 2^-\[ScriptL] \[ScriptL] ( r \[Eta] \[Omega])^(-\[ScriptL]-\[ScriptS]-1) (2 \[ScriptL]-1)!)/(\[ScriptL]+\[ScriptS])!+O[\[Eta]] \[Eta]^(-\[ScriptS]-\[ScriptL]-1)


RPN["Up"][\[ScriptS]_/;\[ScriptS]<=0,\[ScriptL]_,\[ScriptM]Var_,aKerr_,0]:=O[\[Eta]] \[Eta]^(-\[ScriptS]-\[ScriptL]-2)
RPN["Up"][0,0,0,aKerr_,0]:=O[\[Eta]]^-1


(* ::Subsubsection::Closed:: *)
(*Normalization*)


(* ::Input:: *)
(*Normalization["Up"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aKerr_,order\[Eta]_]:=Block[{s=\[ScriptS],l=\[ScriptL],m=\[ScriptM],a=aKerr,maxn,minn,ret},*)
(*maxn=order\[Eta]/3//Ceiling;*)
(*minn=-(order\[Eta]/3+2)//Floor;*)
(*ret=2^(-1-s+4 I \[Eta]^3 \[Omega]) E^(-(1/2) I \[Pi] (1+s+\[Nu]MST)+I (-1+Sqrt[1-a^2]) \[Eta]^3 \[Omega]-\[Pi] \[Eta]^3 \[Omega]) (\[Eta]^3 \[Omega])^(-1-2 s+2 I \[Eta]^3 \[Omega]) \!\( *)
(*\*UnderoverscriptBox[\(\[Sum]\), \(n = minn\), \(maxn\)]\(aMST[n]\)\)/.MSTCoefficientsInternal[\[ScriptS],\[ScriptL],\[ScriptM],aKerr,order\[Eta]]*)
(*]*)


(* ::Subsection::Closed:: *)
(*Outputting Radial solutions as functions*)


Options[RPNF]={"Normalization"->"Default","Simplify"->True}


RPNF[sol_,opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]Var_,{\[Eta]Var_/;MatchQ[\[Eta]Var,_Symbol],order_}]:=Block[{aux,ret},
aux=RPN[sol,"Normalization"->OptionValue["Normalization"]][\[ScriptS],\[ScriptL],\[ScriptM],a,order]/.{\[Eta]->\[Eta]Var,\[Omega]->\[Omega]Var};
If[OptionValue["Simplify"],aux=aux//Simplify];
ret=Function[r,Evaluate[aux]];
ret
]


(* ::Subsection::Closed:: *)
(*Positive spins *)


(* ::Subsubsection:: *)
(*Teukolsky-Starobinsky identities*)


\[ScriptCapitalL]\[Dagger][n_][x_]:=D[x,\[Theta]]-\[ScriptM] Csc[\[Theta]]x+n Cot[\[Theta]]x;
\[ScriptCapitalL][n_][x_]:=D[x,\[Theta]]+\[ScriptM] Csc[\[Theta]]x+n Cot[\[Theta]]x;
\[ScriptCapitalD][n_][x_]:=D[x,r]-( I((r^2+\[ScriptA]^2)\[Omega]-\[ScriptM] \[ScriptA]))/\[CapitalDelta][\[ScriptA],1,r] x+2n (r-M)/\[CapitalDelta][\[ScriptA],1,r];
\[ScriptCapitalD]\[Dagger][n_][x_]:=D[x,r]+(I ((r^2+\[ScriptA]^2)\[Omega]-\[ScriptM] \[ScriptA]))/\[CapitalDelta][\[ScriptA],1,r] x+2n (r-M)/\[CapitalDelta][\[ScriptA],1,r];


RPN["In",opt:OptionsPattern[]][2,\[ScriptL]_,\[ScriptM]Var_,aVar_,order\[Eta]_]:=Block[{aux,\[ScriptA]=aVar,a=aVar,m=\[ScriptM]Var,\[ScriptM]=\[ScriptM]Var},
aux=RPN["In",opt][-2,\[ScriptL],\[ScriptM],a,order\[Eta]];
aux=\[ScriptCapitalD][0]@\[ScriptCapitalD][0]@\[ScriptCapitalD][0]@\[ScriptCapitalD][0]@aux;
aux//Simplify//PNScalings[#,{{\[Omega],3},{r,-2}},\[Eta]]&//Simplify//SeriesTake[#,order\[Eta]]&]

RPN["Up",opt:OptionsPattern[]][2,\[ScriptL]_,\[ScriptM]Var_,aVar_,order\[Eta]_]:=Block[{aux,\[ScriptA]=aVar,a=aVar,m=\[ScriptM]Var,\[ScriptM]=\[ScriptM]Var},
aux=RPN["Up",opt][-2,\[ScriptL],\[ScriptM],a,order\[Eta]+1];
aux=\[ScriptCapitalD][0]@\[ScriptCapitalD][0]@\[ScriptCapitalD][0]@\[ScriptCapitalD][0]@aux;
aux//Simplify//PNScalings[#,{{\[Omega],3},{r,-2}},\[Eta]]&//Simplify//SeriesTake[#,order\[Eta]]&]

RPN["In",opt:OptionsPattern[]][1,\[ScriptL]_,\[ScriptM]Var_,aVar_,order\[Eta]_]:=Block[{aux,\[ScriptA]=aVar,a=aVar,m=\[ScriptM]Var,\[ScriptM]=\[ScriptM]Var},
aux=RPN["In",opt][-1,\[ScriptL],\[ScriptM],a,order\[Eta]];
aux=\[ScriptCapitalD][0]@\[ScriptCapitalD][0][aux];
aux//Simplify//PNScalings[#,{{\[Omega],3},{r,-2}},\[Eta]]&//Simplify//SeriesTake[#,order\[Eta]]&]
RPN["Up",opt:OptionsPattern[]][1,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Block[{aux,\[ScriptA]=a},
aux=RPN["Up",opt][-1,\[ScriptL],\[ScriptM],a,order\[Eta]+1];
aux=\[ScriptCapitalD][0]@\[ScriptCapitalD][0][aux];
aux//Simplify//redo\[Eta]Repls//Simplify//SeriesTake[#,order\[Eta]]&]


(* ::Subsection::Closed:: *)
(*Inhomogeneous solution (depreciated)*)


(* ::Text:: *)
(*This part is now handled directly by TeukolskyPointParticleMode*)


(* ::Subsubsection::Closed:: *)
(*Coefficients*)


(* ::Input:: *)
(*CCoefficient["Up"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aKerr_,order\[Eta]_]:=Block[{aux,W,S,a=aKerr,R,RF,auxF,list,ret},*)
(*Assuming[{assumps},W=InvariantWronskian[\[ScriptS],\[ScriptL],\[ScriptM],aKerr,order\[Eta]];*)
(*S=TeukolskySource[\[ScriptS],\[ScriptL],\[ScriptM],"InvariantWronskianForm"->True]//Simplify;*)
(*R=RPN["In"][\[ScriptS],\[ScriptL],\[ScriptM],aKerr,order\[Eta]];*)
(*RF=r|->Evaluate[R];*)
(*aux=integrateDelta[auxF[r] S,r,False]//RemovePNInternal;*)
(*aux=aux//Collect[#,{auxF[__],Derivative[__][auxF][__]},Collect[#,{SpinWeightedSpheroidalHarmonicS[__][__],Derivative[__][SpinWeightedSpheroidalHarmonicS[__]][__]},Simplify]&]&;*)
(*aux=PNScalingsInternal[aux]/.{auxF->(auxF[# \[Eta]^2]&),\[Theta]->(\[Theta][# \[Eta]^2]&),SpinWeightedSpheroidalHarmonicS[args___]:>(SpinWeightedSpheroidalHarmonicS[args]/. {\[Eta]->1})};*)
(*aux=aux/.auxF->RF;*)
(*ret=aux/W;*)
(*ret*)
(*]]*)


(* ::Input:: *)
(*CCoefficient["In"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aKerr_,order\[Eta]_]:=Block[{aux,W,S,a=aKerr,R,RF,auxF,list,ret},*)
(*Assuming[{assumps},W=InvariantWronskian[\[ScriptS],\[ScriptL],\[ScriptM],aKerr,order\[Eta]];*)
(*S=TeukolskySource[\[ScriptS],\[ScriptL],\[ScriptM],"InvariantWronskianForm"->True]//Simplify;*)
(*R=RPN["Up"][\[ScriptS],\[ScriptL],\[ScriptM],aKerr,order\[Eta]];*)
(*RF=r|->Evaluate[R];*)
(*aux=integrateDelta[auxF[r] S,r,True]//RemovePNInternal;*)
(*aux=aux//Collect[#,{auxF[__],Derivative[__][auxF][__]},Collect[#,{SpinWeightedSpheroidalHarmonicS[__][__],Derivative[__][SpinWeightedSpheroidalHarmonicS[__]][__]},Simplify]&]&;*)
(*aux=PNScalingsInternal[aux]/.{auxF->(auxF[# \[Eta]^2]&),\[Theta]->(\[Theta][# \[Eta]^2]&),SpinWeightedSpheroidalHarmonicS[args___]:>(SpinWeightedSpheroidalHarmonicS[args]/. {\[Eta]->1})};*)
(*aux=aux/.auxF->RF;*)
(*ret=aux/W;*)
(*ret*)
(*]]*)


(* ::Subsubsection::Closed:: *)
(*Sourced solution *)


(* ::Input:: *)
(*RPN["CO"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aKerr_,order\[Eta]_]:=Assuming[{assumps},Block[{s=\[ScriptS],l=\[ScriptL],m=\[ScriptM],\[ScriptA]=aKerr,a=aKerr,Rup,RupF,Rin,RinF,wronskian,integrandUp,integrandIn,cIn,cUp,aux,auxF},*)
(*EchoTiming[Rup=RPN["Up"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]//Simplify;*)
(*RupF[r_]:=Evaluate[Rup],"Rup"];*)
(*EchoTiming[Rin=RPN["In"][\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]]//Simplify;*)
(*RinF[r_]:=Evaluate[Rin],"Rin"];*)
(*EchoTiming[wronskian=\[CapitalDelta][\[ScriptA],1,r \[Eta]^-2]^(\[ScriptS]+1) (Rin D[Rup,r]-D[Rin,r] Rup)//Simplify[#,Assumptions->r>2]&,"wronskian"];*)
(*EchoTiming[cIn=1/ wronskian integrateDelta[auxF[r]Simplify[TeukolskySource[\[ScriptS],\[ScriptL],\[ScriptM],"InvariantWronskianForm"->True]],r,True]//Normal//Simplify,"integrating cIn"];*)
(*EchoTiming[cIn=cIn/.auxF->RupF//redo\[Eta]Repls,"subbing cIn"];*)
(*EchoTiming[cUp=1/ wronskian integrateDelta[auxF[r]Simplify[TeukolskySource[\[ScriptS],\[ScriptL],\[ScriptM],"InvariantWronskianForm"->True]],r,False]//Normal//Simplify,"integrating cUp"];*)
(*EchoTiming[cUp=cUp/.auxF->RinF//redo\[Eta]Repls,"subbing cUp"];*)
(*EchoTiming[aux=cIn Rin+cUp Rup,"assembling"]//Simplify[#,Assumptions->{\[Eta]>0,r0>2,r>2}]&*)
(*]]*)


(* ::Input:: *)
(*RPN["CO"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,order\[Eta]_]:=Assuming[{assumps},*)
(*Module[{aux,Rin,Rup,wronskian,integrandUp,integrandIn,cIn,cUp,auxF,sourceCoeffs},*)
(*aux=TeukolskyRadialPN[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{\[Eta],order\[Eta]}];*)
(*Rin=aux["In"]["RadialFunction"];*)
(*Rup=aux["Up"]["RadialFunction"];*)
(*wronskian=EchoTiming[wronskian=(Simplify[#1,Assumptions->r>2]&)[\[CapitalDelta][a,1,r/\[Eta]^2]^(\[ScriptS]+1) (Rin[r] Rup'[r]-Rin'[r] Rup[r])],"wronskian"];*)
(*EchoTiming[sourceCoeffs=TeukolskySourceCircularOrbit[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{r,r0}]//Coefficient[#,{DiracDelta[r-r0],Derivative[1][DiracDelta][r-r0],Derivative[2][DiracDelta][r-r0]}]&,"coeffs"];*)
(*EchoTiming[sourceCoeffs=redo\[Eta]Repls[sourceCoeffs]//Simplify,"PNScalings"];*)
(*cIn=integrateDelta[f[r]#,r,True]&/@{\[Delta][r-r0],\[Delta]'[r-r0],\[Delta]''[r-r0]};*)
(*cUp=integrateDelta[f[r]#,r,False]&/@{\[Delta][r-r0],\[Delta]'[r-r0],\[Delta]''[r-r0]};*)
(*EchoTiming[cIn=cIn/.f->Rin,"subbing In"];*)
(*EchoTiming[cUp=cUp/.f->Rup,"subbing Up"];*)
(*EchoTiming[cIn=sourceCoeffs cIn//Total,"total In"];*)
(*EchoTiming[cUp=sourceCoeffs cUp//Total,"total Up"];*)
(*(cIn Rin[r])/wronskian+(cUp Rup[r])/wronskian//Simplify*)
(*]]*)


(* ::Subsection::Closed:: *)
(*Checking input is correct*)


PossibleSols={"In","Up","C\[Nu]","C-\[Nu]-1"}


CheckInput[sol_,\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]_,{varPN_,order_}]:=Module[{aux},
(*Checking boundary conditions*)
If[!MemberQ[PossibleSols,sol],Message[TeukolskyRadialFunctionPN::optx,sol];Abort[];];
(*Checking modes*)
If[\[ScriptL]<Abs[\[ScriptS]],Message[TeukolskyRadialFunctionPN::param\[ScriptS],\[ScriptL],\[ScriptS]];Abort[];];
If[\[ScriptL]<Abs[\[ScriptM]],Message[TeukolskyRadialFunctionPN::param\[ScriptM],\[ScriptL],\[ScriptM]];Abort[];];
(*Checking Kerr parameter*)
If[MatchQ[a,_Complex],Message[TeukolskyRadialFunctionPN::paramaC,a];Abort[];];
If[a>1||a<0,Message[TeukolskyRadialFunctionPN::parama,a];Abort[];];
(*Checking \[Omega] is real*)
If[MatchQ[\[Omega],_Complex],Message[TeukolskyRadialFunctionPN::param\[Omega],\[Omega]];Abort[];];
(*Checking PN parameter is a symbol*)
If[!MatchQ[varPN,_Symbol],Message[TeukolskyRadialFunctionPN::parama,varPN];Abort[];];
(*Checking order is an integer*)
If[!MatchQ[order,_Integer],Message[TeukolskyRadialFunctionPN::paramorder,order];Abort[];];
]


(* ::Subsection:: *)
(*TeukolskyRadialFunctionPN*)


(* ::Subsubsection::Closed:: *)
(*Icons*)


icons = <|
 "In" -> Graphics[{
         Line[{{0,1/2},{1/2,1},{1,1/2},{1/2,0},{0,1/2}}],
         Line[{{3/4,1/4},{1/2,1/2}}],
         {Arrowheads[0.2],Arrow[Line[{{1/2,1/2},{1/4,3/4}}]]},
         {Arrowheads[0.2],Arrow[Line[{{1/2,1/2},{3/4,3/4}}]]}},
         Background -> White,
         ImageSize -> Dynamic[{Automatic, 3.5 CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[Magnification]}]],
 "Up" -> Graphics[{
         Line[{{0,1/2},{1/2,1},{1,1/2},{1/2,0},{0,1/2}}],
         Line[{{1/4,1/4},{1/2,1/2}}],
         {Arrowheads[0.2],Arrow[Line[{{1/2,1/2},{1/4,3/4}}]]},
         {Arrowheads[0.2],Arrow[Line[{{1/2,1/2},{3/4,3/4}}]]}},
         Background -> White,
         ImageSize -> Dynamic[{Automatic, 3.5 CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[Magnification]}]],
"CO"->Graphics[{
			Black,Disk[{0,0},{1,1},{\[Pi]-.1,2\[Pi]+.1}],Red,Thick,Circle[{0,0},{2,.5}],Black,Disk[{0,0},{1,1},{0,\[Pi]}]},
			Background->White,
			ImageSize -> Dynamic[{Automatic, 3.5 CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[Magnification]}]]
|>;


(* ::Subsubsection:: *)
(*TeukolskyRadialPN*)


Options[RadialAssociation]={"Normalization"->"Default", "Amplitudes"->False, "Simplify"->True}
Options[TeukolskyRadialPN]={"Normalization"->"Default", "Amplitudes"->False, "Simplify"->True}


RadialAssociation[sol_String,opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,\[Omega]_,{varPN_,order_}]/;MemberQ[PossibleSols,sol]:=Module[{aux,ret,R,BC,lead,termCount,normalization,amplitudes,trans,inc,ref},
CheckInput[sol,\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order}];
R=RPNF[sol,"Normalization"->OptionValue["Normalization"],"Simplify"->OptionValue["Simplify"]][\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order}];
BC=sol;
lead=RPNF[sol,"Normalization"->OptionValue["Normalization"],"Simplify"->OptionValue["Simplify"]][\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,1}];
termCount=R[r]//SeriesLength;
normalization=OptionValue["Normalization"];
trans=If[OptionValue["Amplitudes"],TeukolskyAmplitudePN[Switch[sol,"In","Btrans","Up","Ctrans"],"Normalization"->OptionValue["Normalization"]][\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order}],"Not Computed"];
inc=If[OptionValue["Amplitudes"],TeukolskyAmplitudePN[Switch[sol,"In","Binc","Up","Cinc"],"Normalization"->OptionValue["Normalization"]][\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order}],"Not Computed"];
ref=If[OptionValue["Amplitudes"],TeukolskyAmplitudePN[Switch[sol,"In","Bref","Up","Cref"],"Normalization"->OptionValue["Normalization"]][\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order}],"Not Computed"];
If[OptionValue["Simplify"],{trans,inc,ref}={trans,inc,ref}//Simplify];
amplitudes=<|"Incidence"->inc,"Transmission"->trans,"Reflection"->ref|>;
ret=<|"s"->\[ScriptS],"l"->\[ScriptL],"m"->\[ScriptM],"a"->a,"PN"->{varPN,order},"RadialFunction"->R,"BoundaryCondition"->BC,"LeadingOrder"->lead,"TermCount"->termCount,"Normalization"->normalization,"Amplitudes"->amplitudes,"Simplify"->OptionValue["Simplify"]|>;
ret
]


PNStringToOrder[pn_String]:=Module[{aux,ret,check1,check2},
check1=StringContainsQ[pn,"PN"];
aux=pn//StringReplace[#,"PN"->""]&;
aux=aux//ToExpression;
aux=2aux+1;
ret=aux//IntegerPart;
check2=ret-aux===0`;
If[!check1,Message[TeukolskyRadialFunctionPN::PNInput,ret]];
If[!check2,ret=aux];
ret
]


TeukolskyRadialPN[\[ScriptS]_, \[ScriptL]_, \[ScriptM]_, a_, \[Omega]_,{varPN_,order_String},opt:OptionsPattern[]]:=Module[{aux},
aux=order//PNStringToOrder;
TeukolskyRadialPN[\[ScriptS], \[ScriptL], \[ScriptM], a, \[Omega],{varPN,aux},opt]
]


TeukolskyRadialPN[\[ScriptS]_, \[ScriptL]_, \[ScriptM]_, a_, \[Omega]_,{varPN_,order_},opt:OptionsPattern[]]:=Module[{aux,Rin,Rup,assocUp,assocIn,retIn,retUp},
assocIn=RadialAssociation["In",opt][\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order}];
retIn=TeukolskyRadialFunctionPN[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order},assocIn];
assocUp=RadialAssociation["Up",opt][\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order}];
retUp=TeukolskyRadialFunctionPN[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order},assocUp];
<|"In"->retIn,"Up"->retUp|>
]


(* ::Subsubsection:: *)
(*TeukolskyRadialFunctionPN*)


Options[TeukolskyRadialFunctionPN]={"Normalization"->"Default"}


TeukolskyRadialFunctionPN /:
 MakeBoxes[trf:TeukolskyRadialFunctionPN[s_, l_, m_, a_, \[Omega]_,{varPN_,order_},assoc_], form:(StandardForm|TraditionalForm)] :=
 Module[{summary, extended},
 CheckInput[assoc["BoundaryCondition"],s,l,m,a,\[Omega],{varPN,order}];
  summary = {Row[{BoxForm`SummaryItem[{"s: ", s}], "  ",
                  BoxForm`SummaryItem[{"l: ", l}], "  ",
                  BoxForm`SummaryItem[{"m: ", m}], "  ",
                  BoxForm`SummaryItem[{"a: ", a}], "  ",
                  BoxForm`SummaryItem[{"\[Omega]: ", \[Omega]}],"  ",
 BoxForm`SummaryItem[{"PN parameter: ", varPN}],"  ",
 BoxForm`SummaryItem[{"PN order: ", N[(order-1)/2]"PN"}]
}],
             BoxForm`SummaryItem[{"Boundary Condition: ", assoc["BoundaryCondition"]}]};           
  extended = {BoxForm`SummaryItem[{"Leading order: ",assoc["LeadingOrder"]["r"]}],
  BoxForm`SummaryItem[{"Normalization: ",assoc["Normalization"]}],
  BoxForm`SummaryItem[{"Simplify: ",assoc["Simplify"]}],
  BoxForm`SummaryItem[{"Number of terms: ",assoc["TermCount"]}]};

  BoxForm`ArrangeSummaryBox[
    TeukolskyRadialFunctionPN,
    trf,
 Lookup[icons, assoc["BoundaryCondition"], None],
    summary,
    extended,
    form]
];


TeukolskyRadialFunctionPN[\[ScriptS]_, \[ScriptL]_, \[ScriptM]_, a_, \[Omega]_,{varPN_,order_},sol_String,opt:OptionsPattern[]]:=Module[{aux,assoc,ret},
assoc=RadialAssociation[sol,opt][\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order}];
ret=TeukolskyRadialFunctionPN[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{varPN,order},assoc];
ret
]


(* ::Subsubsection:: *)
(*TeukolskyPointParticleModePN*)


Options[RadialSourcedAssociation]={"Normalization"->"Default","Simplify"->True}


RadialSourcedAssociation["CO",opt:OptionsPattern[]][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,aVar_,r0Var_,{varPN_,order_}]:=Assuming[{varPN>0,r0>0,r>0,1>a>=0,\[ScriptA]>=0},Module[{aux,ret,Rin,dRin,ddRin,Rup,dRup,ddRup,wronskian,source,sourceCoeffs,cUp,cIn,deltaCoeff,innerF,outerF,inner,outer,radialF,ampAssoc},
CheckInput["Up",\[ScriptS],\[ScriptL],\[ScriptM],aVar,\[ScriptM]/Sqrt[r0Var^3],{varPN,order}];
aux=TeukolskyRadialPN[\[ScriptS],\[ScriptL],\[ScriptM],aVar,If[\[ScriptM]!=0,\[ScriptM],Style["0",Red]]\[CapitalOmega]Kerr,{varPN,order},"Normalization"->OptionValue["Normalization"]];
Rin=aux["In"]["RadialFunction"];
Rup=aux["Up"]["RadialFunction"];
dRup=Rup';
dRin=Rin';
ddRup=dRup';
ddRin=dRin';
(*The replacements in the wronskian are a quick fix for non vanishing r dependence in case a has a numerical value*)
wronskian=(Simplify[#1,Assumptions->r>2]&)[Kerr\[CapitalDelta][aVar,r/varPN^2]^(\[ScriptS]+1) varPN^2 (Rin[r] dRup[r]-dRin[r] Rup[r])];
wronskian=wronskian/.Log[__ r]->0/.r^a_/;a<0:>r^-a/.r->0;
source=TeukolskySourceCircularOrbit[\[ScriptS],\[ScriptL],\[ScriptM],a,{#,r0},"Form"->"InvariantWronskian"]&;
sourceCoeffs=source[r]//Coefficient[#,{DiracDelta[r-r0],Derivative[1][DiracDelta][r-r0],Derivative[2][DiracDelta][r-r0]}]&;
sourceCoeffs=Collect[#,{SpinWeightedSpheroidalHarmonicS[__][__],Derivative[__][SpinWeightedSpheroidalHarmonicS[__]][__]},Simplify]&/@sourceCoeffs;
sourceCoeffs=sourceCoeffs//PNScalings[#,{{r0,-2},{\[CapitalOmega]Kerr,3}},varPN,"IgnoreHarmonics"->True]&//Simplify;
cIn=1/wronskian Total[sourceCoeffs {Rup[r0],-varPN^2dRup[r0],varPN^4 ddRup[r0]}]//SeriesTake[#,order]&;
cUp=1/wronskian Total[sourceCoeffs {Rin[r0],-varPN^2dRin[r0],varPN^4 ddRin[r0]}]//SeriesTake[#,order]&;
deltaCoeff=Coefficient[source[r],Derivative[2][DiracDelta][r-r0]]/Kerr\[CapitalDelta][a,r0];
deltaCoeff=Assuming[{varPN>0},If[deltaCoeff===0,0,deltaCoeff//PNScalings[#,{{r0,-2},{\[CapitalOmega]Kerr,3}},varPN,"IgnoreHarmonics"->True]&//SeriesTerms[#,{varPN,0,order}]&]];
{cIn,cUp,deltaCoeff,source}={cIn,cUp,deltaCoeff,source}/.r0->r0Var/.a->aVar;
If[OptionValue["Simplify"],{cIn,cUp,deltaCoeff,source}={cIn,cUp,deltaCoeff,source}//SeriesCollect[#,{SpinWeightedSpheroidalHarmonicS[__],Derivative[__][SpinWeightedSpheroidalHarmonicS][__]},(Simplify[#,{aVar>=0,r0Var>0,varPN>0}]&)]&];
inner=cIn Rin[r];
outer=cUp Rup[r];
If[OptionValue["Simplify"],{inner,outer}={inner,outer}//SeriesCollect[#,{SpinWeightedSpheroidalHarmonicS[__],Derivative[__][SpinWeightedSpheroidalHarmonicS][__]},(Simplify[#,{aVar>=0,r0Var>0,varPN>0}]&)]&];
innerF=inner/.r->#&;
outerF=outer/.r->#&;

ampAssoc=<|"\[ScriptCapitalI]"->cUp,"\[ScriptCapitalH]"->cIn|>;
radialF=innerF[#] HeavisideTheta[r0Var-#] + outerF[#] HeavisideTheta[#-r0Var]+deltaCoeff DiracDelta[#-r0Var]&;
ret=<|"s"->\[ScriptS],"l"->\[ScriptL],"m"->\[ScriptM],"a"->aVar,"r0"->r0Var,"PN"->{varPN,order},"RadialFunction"->radialF,("ExtendedHomogeneous"->"\[ScriptCapitalI]")->innerF,("ExtendedHomogeneous"->"\[ScriptCapitalH]")->outerF,"\[Delta]"->deltaCoeff,"Amplitudes"->ampAssoc,"Wronskian"->wronskian,"Source"->source,"In"->aux["In"],"Up"->aux["Up"],"Simplify"->OptionValue["Simplify"],"Normalization"->OptionValue["Normalization"]|>;
ret
]
]


(* ::Input:: *)
(*(*RadialSourcedAssociation["CO"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,r0Var_,{varPN_,order_}]/;NumericQ[a]:=Module[{aux,keys,values},*)
(*aux=RadialSourcedAssociation["CO"][\[ScriptS],\[ScriptL],\[ScriptM],\[ScriptA],r0Var,{varPN,order}];*)
(*keys=aux//Keys;*)
(*values=Values[aux]/.\[ScriptA]->a;*)
(*AssociationThread[keys,values]*)
(*]*)
(*RadialSourcedAssociation["CO"][\[ScriptS]_,\[ScriptL]_,\[ScriptM]_,a_,r0Var_,{varPN_,order_}]/;NumericQ[r0Var]:=RadialSourcedAssociation["CO"][\[ScriptS],\[ScriptL],\[ScriptM],a,r0,{varPN,order}]/.r0->r0Var;*)*)


Options[TeukolskyPointParticleModePN]={"Normalization"->"Default","Simplify"->True}


TeukolskyModePN /:
 MakeBoxes[trf:TeukolskyModePN[s_, l_, m_, a_,r0_,{varPN_,order_},assoc_], form:(StandardForm|TraditionalForm)] :=
 Module[{summary, extended},
(* CheckInput[assoc["BoundaryCondition"],s,l,m,a,\[Omega],{varPN,order}];*)
  summary = {Row[{BoxForm`SummaryItem[{"s: ", s}], "  ",
                  BoxForm`SummaryItem[{"l: ", l}], "  ",
                  BoxForm`SummaryItem[{"m: ", m}], "  ",
                  BoxForm`SummaryItem[{"a: ", a}], "  ",
                  BoxForm`SummaryItem[{"\[Omega]: ", m \[CapitalOmega]Kerr}],"  ",
                  BoxForm`SummaryItem[{"\!\(\*SubscriptBox[\(r\), \(0\)]\): ", r0}],"  ",
 BoxForm`SummaryItem[{"PN parameter: ", varPN}],"  ",
 BoxForm`SummaryItem[{"PN order: ", N[(order-1)/2]"PN"}]
}],
             BoxForm`SummaryItem[{"Orbit: ", "Circular Equatorial"}]};           
  extended = {BoxForm`SummaryItem[{"Simplify: ",assoc["Simplify"]}],
  BoxForm`SummaryItem[{"Homogeneous Normalization: ",assoc["Normalization"]}]};

  BoxForm`ArrangeSummaryBox[
    TeukolskyModePN,
    trf,
 Lookup[icons, "CO", None],
    summary,
    extended,
    form]
];


TeukolskyPointParticleModePN[\[ScriptS]_, \[ScriptL]_, \[ScriptM]_,orbit_KerrGeodesics`KerrGeoOrbit`KerrGeoOrbitFunction,{varPN_,order_},opt:OptionsPattern[]]:=Module[{aux,assoc,ret,a,r0Var,eccentricity,inclination},
{a,r0Var,eccentricity,inclination}=orbit[#]&/@{"a","p","e","Inclination"};
If[!(eccentricity===0),Message[TeukolskyPointParticleModePN::orbit];Abort[];];
If[!(inclination===1),Message[TeukolskyPointParticleModePN::orbit];Abort[];];
assoc=RadialSourcedAssociation["CO",opt][\[ScriptS],\[ScriptL],\[ScriptM],a,r0Var,{varPN,order}];
ret=TeukolskyModePN[\[ScriptS],\[ScriptL],\[ScriptM],a,r0Var,{varPN,order},assoc];
ret
]


TeukolskyPointParticleModePN[\[ScriptS]_, \[ScriptL]_, \[ScriptM]_,orbit_KerrGeodesics`KerrGeoOrbit`KerrGeoOrbitFunction,{varPN_,order_String},opt:OptionsPattern[]]:=Module[{aux},
aux=order//PNStringToOrder;
TeukolskyPointParticleModePN[\[ScriptS], \[ScriptL], \[ScriptM],orbit,{varPN,aux},opt]
]


(* ::Subsubsection:: *)
(*Accessing functions and keys*)


TeukolskyRadialFunctionPN[s_, l_, m_, a_, r0_,{varPN_,order_},assoc_][y_String]:=
  assoc[y];


TeukolskyRadialFunctionPN[s_, l_, m_, a_, r0_,{varPN_,order_},assoc_][r_Symbol] :=assoc["RadialFunction"][r]
TeukolskyRadialFunctionPN[s_, l_, m_, a_, r0_,{varPN_,order_},assoc_][r_/;NumericQ[r]] :=assoc["RadialFunction"][r]


Derivative[n_Integer][trf_TeukolskyRadialFunctionPN][r_Symbol]:=trf[[6,1]]^(2 n) Derivative[n][trf["RadialFunction"]][r]


Keys[trfpn_TeukolskyRadialFunctionPN]^:=trfpn[[-1]]//Keys


TeukolskyModePN[s_, l_, m_, a_, r0_,{varPN_,order_},assoc_][y:(_String|("ExtendedHomogeneous"->"\[ScriptCapitalH]")|("ExtendedHomogeneous"->"\[ScriptCapitalI]"))]:=
  assoc[y];


TeukolskyModePN[s_, l_, m_, a_, r0_,{varPN_,order_},assoc_][r0_] :=Message[TeukolskyModePN::particle]Abort[];
TeukolskyModePN[s_, l_, m_, a_, r0_,{varPN_,order_},assoc_][r_Symbol] :=assoc["RadialFunction"][r]
TeukolskyModePN[s_, l_, m_, a_, r0_,{varPN_,order_},assoc_][r_/;NumericQ[r]] :=assoc["RadialFunction"][r]


Keys[trfpn_TeukolskyModePN]^:=trfpn[[-1]]//Keys


Derivative[n_Integer][tppm_TeukolskyModePN][r_Symbol]:=tppm[[6,1]]^(2 n) Derivative[n][tppm["RadialFunction"]][r]


(* ::Section:: *)
(*Ending Package*)


(* ::Subsection:: *)
(*Protecting*)


SetAttributes[{TeukolskyRadialPN, TeukolskyRadialFunctionPN, TeukolskyPointParticleModePN}, {Protected, ReadProtected}];


(* ::Subsection:: *)
(*Ending*)


End[]
EndPackage[]
