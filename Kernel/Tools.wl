(* ::Package:: *)

(* ::Input:: *)
(*SetOptions[EvaluationNotebook[],StyleDefinitions->$UserBaseDirectory<>"/SystemFiles/FrontEnd/StyleSheets/maTHEMEatica.nb"]*)


(* ::Section:: *)
(*Beginning*)


(* ::Subsection:: *)
(*Beginning*)


BeginPackage["Teukolsky`PN`Tools`",{"Teukolsky`","Teukolsky`PN`"}]


(* ::Subsection:: *)
(*Unprotecting*)


ClearAttributes[{\[Nu]MST, aMST,MSTCoefficients}, {Protected, ReadProtected}];


ClearAttributes[{SeriesTake, SeriesMinOrder,SeriesMaxOrder,SeriesLength,SeriesCollect,SeriesTerms,IgnoreExpansionParameter}, {Protected, ReadProtected}];


ClearAttributes[{PNScalings, RemovePN,Zero,One}, {Protected, ReadProtected}];


ClearAttributes[{ExpandLog, ExpandGamma,ExpandPolyGamma,PochhammerToGamma,GammaToPochhammer,ExpandDiracDelta,ExpandSpheroidals,CollectDerivatives}, {Protected, ReadProtected}];


ClearAttributes[{TeukolskyAmplitudePN, InvariantWronskian,TeukolskySourceCircularOrbit,TeukolskyEquation}, {Protected, ReadProtected}];


(* ::Section:: *)
(*Public*)


(* ::Subsection::Closed:: *)
(*MST Coefficients*)


\[Nu]MST::usage="\[Nu]MST is representative of the \[Nu] coefficient in the MST solutions"
aMST::usage="aMST[\!\(\*
StyleBox[\"n\",\nFontSlant->\"Italic\"]\)] is the \!\(\*SuperscriptBox[
StyleBox[\"n\",\nFontSlant->\"Italic\"], \(th\)]\) MST coefficient";
MSTCoefficients::usage="MSTCoefficients[\[ScriptS],\[ScriptL],\[ScriptM],a,order\[Eta]] gives the PN expanded MST coefficients aMST[n] for a given {\[ScriptS],\[ScriptL],\[ScriptM]} mode up to \[Eta]^order\[Eta]."
(*KerrMSTSeries::usage="KerrMSTSeries[\!\(\*
StyleBox[\"\[ScriptS]\",\nFontSlant->\"Italic\"]\),\!\(\*
StyleBox[\"\[ScriptL]\",\nFontSlant->\"Italic\"]\),\!\(\*
StyleBox[\"\[ScriptM]\",\nFontSlant->\"Italic\"]\),\!\(\*
StyleBox[\"order\[Epsilon]\",\nFontSlant->\"Italic\"]\)] gives the PN expanded MST coefficients a[n] for a given {\!\(\*
StyleBox[\"\[ScriptS]\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"\[ScriptL]\",\nFontSlant->\"Italic\"]\), \!\(\*
StyleBox[\"\[ScriptM]\",\nFontSlant->\"Italic\"]\)} mode up to \!\(\*SuperscriptBox[\(\[Epsilon]\), \(order\[Epsilon]\)]\). Where the relation to \[Eta] is given by \[Epsilon]=2 \[Omega] \!\(\*SuperscriptBox[\(\[Eta]\), \(3\)]\)."*)


(* ::Subsection:: *)
(*General Tools for Series*)


SeriesTake::usage="SeriesTake[series, n] takes the first n terms of series"
SeriesMinOrder::usage="SeriesMinOrder[series] gives the leading order of series"
SeriesMaxOrder::usage="SeriesMaxOrder[series] gives the first surpressed order of series"
SeriesLength::usage="SeriesLenght[series] gives the number of terms in series"
SeriesCollect::usage="SeriesCollect[expr, var, func] works like Collect but applied to each order individually. Crucially, unlike Collect it keeps the SeriesData structure."
SeriesTerms::usage="SeriesTerms[series, {x, x0, n}] works exactly like Series, with the difference that n gives the desired number of terms instead of a maximum order"
IgnoreExpansionParameter::usage="IgnoreExpansionParameter[series,x] sets all occurences of the expansion parameter in the series coefficients to x. If no value is entered x defaults to 1." 


(* ::Subsection:: *)
(*Tools for PN Scalings*)


Scalings::usage="Scalings[params,var][expr] applies the given powercounting scalings to the expression. E.g. Scalings[{{\[Omega],3,r,-2},\[Eta]][\[Omega] r]"
PNScalings::usage="Same as Scalings but with different input. Just here to not break my older code but you should use Scalings instead"
RemovePN::usage="PNScalings[expr,var] takes the Normal[] and sets var to 1"
Zero::usage="Zero[expr,vars] sets all vars in expr to 0"
One::usage="One[expr,vars] sets all vars in expr to 1"


(* ::Subsection:: *)
(*Tools for Logs, Gammas, and PolyGammas*)


ExpandLog::usage="ExpandLog[expr] replaces all Logs in expr with a PowerExpanded version"
ExpandGamma::usage="ExpandGamma[expr] factors out all Integer facors out of the Gammas in expr. E.g. Gamma[x+1]->x Gamma[x]"
ExpandPolyGamma::usage="ExpandPolyGamma[expr] factors out all Integer facors out of the PolyGammas in expr. E.g. PolyGamma[x+1]->\!\(\*FractionBox[\(1\), \(x\)]\) PolyGamma[x]"
PochhammerToGamma::usage="PochhammerToGamma[expr] replaces all Pochhammer in expr with the respecive Gamma."
GammaToPochhammer::usage="PochhammerToGamma[expr,n] replaces all Gamma in expr that contain n with the respective Pochhammer[__,n]"



(* ::Subsection:: *)
(*Tools for DiracDelta *)


ExpandDiracDelta::usage="ExpandDiracDelta[expr,r] applies identities for Dirac deltas and it's derivatives to expr."


(* ::Subsection:: *)
(*Tools  for SpinWeightedSpheroidalHarmonics *)


ExpandSpheroidals::usage="ExpandSpheroidal[expr,{param,order}] returns a all SpinWeightedSpheroidalHarmonicS in expr have been Series expanded around param->0 to order."


(* ::Subsection:: *)
(*Other Tools*)


CollectDerivatives::usage="CollectDerivatives[expr,f] works exactly like Collect[] but also collects for derivatives of f."


(* ::Subsection:: *)
(*Amplitudes*)


TeukolskyAmplitudePN::usage="TeukolskyAmplitudePN[\"sol\"][\[ScriptS], \[ScriptL], \[ScriptM], a, \[Omega], {\[Eta], n}] gives the desired PN expanded amplitude. Options for sol are as follows: 
\"A+\": Sasaki Tagoshi Eq.(157), 
\"A-\": ST Eq.(158), 
\"Btrans\": ST Eq.(167), 
\"Binc\": ST Eq.(168) divided by \!\(\*SubscriptBox[\(\[ScriptCapitalK]\), \(\[Nu]\)]\), 
\"Ctrans\": Eq.(170) ST, 
\"\[ScriptCapitalK]\": , 
\"\[ScriptCapitalK]\[Nu]\": , 
\"\[ScriptCapitalK]-\[Nu]-1\": "


(* ::Subsection:: *)
(*Wronskian*)


InvariantWronskian::usage="InvariantWronskian[\[ScriptS], \[ScriptL], \[ScriptM], a, \[Omega], {\[Eta], n}] gives the invariant Wronskian."


(* ::Subsection:: *)
(*Source*)


TeukolskySourceCircularOrbit::usage="TeukolskySource[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{r,r\:2080}] gives an analytical expression for the Teukolsky point particle source for a given {\[ScriptS],\[ScriptL],\[ScriptM]} mode. "


(* ::Subsection:: *)
(*Teukolsky Equation*)


TeukolskyEquation::usage="TeukolskyEquation[\[ScriptS],\[ScriptL],\[ScriptM],a,\[Omega],{\[Eta],order},R[r]] gives the Teukolsky equation with for a given {\[ScriptS],\[ScriptL],\[ScriptM]} mode with included \[Eta] scalings. The {\[Eta],order} argument can be left out for a general expression."


(* ::Section:: *)
(*Private*)


Begin["Private`"]


(* ::Subsection::Closed:: *)
(*MST Coefficients*)


MSTCoefficients=Teukolsky`PN`Private`MSTCoefficients


(* ::Subsection:: *)
(*General  Tools  for  Series*)


SeriesTake=Teukolsky`PN`Private`SeriesTake
SeriesMinOrder=Teukolsky`PN`Private`SeriesMinOrder
SeriesMaxOrder=Teukolsky`PN`Private`SeriesMaxOrder
SeriesLength=Teukolsky`PN`Private`SeriesLength
SeriesCollect=Teukolsky`PN`Private`SeriesCollect
SeriesTerms=Teukolsky`PN`Private`SeriesTerms
IgnoreExpansionParameter=Teukolsky`PN`Private`IgnoreExpansionParameter


(* ::Subsection:: *)
(*Tools for PN Scalings*)


PNScalings=Teukolsky`PN`Private`PNScalings
Scalings=Teukolsky`PN`Private`Scalings
RemovePN=Teukolsky`PN`Private`RemovePN
Zero=Teukolsky`PN`Private`Zero
One=Teukolsky`PN`Private`One


(* ::Subsection::Closed:: *)
(*Tools for Logs, Gammas, and PolyGammas*)


ExpandLog=Teukolsky`PN`Private`ExpandLog
ExpandGamma=Teukolsky`PN`Private`ExpandGamma
ExpandPolyGamma=Teukolsky`PN`Private`ExpandPolyGamma
PochhammerToGamma=Teukolsky`PN`Private`PochhammerToGamma
GammaToPochhammer=Teukolsky`PN`Private`GammaToPochhammer


(* ::Subsection::Closed:: *)
(*Tools for DiracDelta *)


ExpandDiracDelta=Teukolsky`PN`Private`ExpandDiracDelta


(* ::Subsection::Closed:: *)
(*Tools  for SpinWeightedSpheroidalHarmonics *)


ExpandSpheroidals=Teukolsky`PN`Private`ExpandSpheroidals


(* ::Subsection::Closed:: *)
(*Other Tools*)


CollectDerivatives=Teukolsky`PN`Private`CollectDerivatives


(* ::Subsection::Closed:: *)
(*Amplitudes*)


TeukolskyAmplitudePN=Teukolsky`PN`Private`TeukolskyAmplitudePN


(* ::Subsection::Closed:: *)
(*Wronskian*)


InvariantWronskian=Teukolsky`PN`Private`InvariantWronskian


(* ::Subsection::Closed:: *)
(*Source*)


TeukolskySourceCircularOrbit=Teukolsky`PN`Private`TeukolskySourceCircularOrbit


(* ::Subsection::Closed:: *)
(*TeukolskyEquation*)


TeukolskyEquation=Teukolsky`PN`Private`TeukolskyEquation


(* ::Section:: *)
(*Ending Package*)


(* ::Subsection:: *)
(*Protecting*)


SetAttributes[{\[Nu]MST, aMST,MSTCoefficients}, {Protected, ReadProtected}];


SetAttributes[{SeriesTake, SeriesMinOrder,SeriesMaxOrder,SeriesLength,SeriesTerms,IgnoreExpansionParameter}, {Protected, ReadProtected}];


SetAttributes[{SeriesCollect}, {Protected, ReadProtected,Listable}];


SetAttributes[{PNScalings, RemovePN,Zero,One}, {Protected, ReadProtected}];


SetAttributes[{ExpandLog, ExpandGamma,ExpandPolyGamma,PochhammerToGamma,GammaToPochhammer,ExpandDiracDelta,ExpandSpheroidals,CollectDerivatives}, {Protected, ReadProtected}];


SetAttributes[{TeukolskyAmplitudePN, InvariantWronskian,TeukolskySourceCircularOrbit,TeukolskyEquation}, {Protected, ReadProtected}];


(* ::Subsection:: *)
(*Ending*)


End[]
EndPackage[]
