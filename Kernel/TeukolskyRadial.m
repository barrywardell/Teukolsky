(* ::Package:: *)

(* ::Title:: *)
(*TeukolskyRadial*)


(* ::Section::Closed:: *)
(*Create Package*)


(* ::Subsection::Closed:: *)
(*BeginPackage*)


BeginPackage["Teukolsky`TeukolskyRadial`",
  {
  "Teukolsky`SasakiNakamura`",
   "Teukolsky`NumericalIntegration`",
   "Teukolsky`MST`RenormalizedAngularMomentum`",
   "Teukolsky`MST`MST`",
   "SpinWeightedSpheroidalHarmonics`"
  }
];


(* ::Subsection::Closed:: *)
(*Unprotect symbols*)


ClearAttributes[{TeukolskyRadial, TeukolskyRadialFunction}, {Protected, ReadProtected}];


(* ::Subsection::Closed:: *)
(*Usage messages*)


TeukolskyRadial::usage = "TeukolskyRadial[s, l, m, a, \[Omega]] computes homogeneous solutions to the radial Teukolsky equation."
TeukolskyRadialFunction::usage = "TeukolskyRadialFunction[s, l, m, a, \[Omega], assoc] is an object representing a homogeneous solution to the radial Teukolsky equation."


(* ::Subsection::Closed:: *)
(*Error Messages*)


TeukolskyRadial::precw = "The precision of `1`=`2` is less than WorkingPrecision (`3`).";
TeukolskyRadial::optx = "Unknown options in `1`";
TeukolskyRadial::params = "Invalid parameters s=`1`, l=`2`, m=`3`";
TeukolskyRadial::cmplx = "Only real values of a are allowed, but a=`1` specified.";
TeukolskyRadial::dm = "Option `1` is not valid with BoundaryConditions \[RightArrow] `2`.";
TeukolskyRadial::sopt = "Option `1` not supported for static (\[Omega]=0) modes.";
TeukolskyRadial::hc = "Method HeunC is only supported with Mathematica version 12.1 and later.";
TeukolskyRadial::hcopt = "Option `1` not supported for HeunC method.";
TeukolskyRadialFunction::dmval = "Radius `1` lies outside the computational domain.";
TeukolskyRadial::opti = "Options in set `1` are incompatible.";


(* ::Subsection::Closed:: *)
(*Begin Private section*)


Begin["`Private`"];


(* ::Section::Closed:: *)
(*Utility Functions*)


(* ::Subsection::Closed:: *)
(*Horizon Locations*)


rp[a_,M_] := M+Sqrt[M^2-a^2];
rm[a_,M_] := M-Sqrt[M^2-a^2];


(* ::Subsection::Closed:: *)
(*Hyperboloidal Transformation Functions*)


f[r_] := 1-2/r;
rs[r_,a_]:=r+2/(rp[a,1]-rm[a,1]) (rp[a,1] Log[(r-rp[a,1])/2]-rm[a,1] Log[(r-rm[a,1])/2]);
\[CapitalDelta][r_,a_]:=r^2+a^2-2r;
\[Phi]Reg[r_,a_]:=a /(rp[a,1]-rm[a,1]) Log[(r-rp[a,1])/(r-rm[a,1])];


(* ::Section::Closed:: *)
(*TeukolskyRadial*)


(* ::Subsection::Closed:: *)
(*Numerical Integration Method*)


Options[TeukolskyRadialNumericalIntegration] = Join[
  {"Domain" -> All},
  FilterRules[Options[NDSolve], Except[WorkingPrecision|AccuracyGoal|PrecisionGoal]]];


domainQ[domain_] := MatchQ[domain, {_?NumericQ, _?NumericQ} | (_?NumericQ) | All];


TeukolskyRadialNumericalIntegration[s_Integer, l_Integer, m_Integer, a_, \[Omega]_, \[Lambda]_, \[Nu]_, BCs_, norms_, {wp_, prec_, acc_}, opts:OptionsPattern[]] :=
 Module[{TRF, amps, ndsolveopts, solFuncs, domains},
  (* Function to construct a single TeukolskyRadialFunction *)
  TRF[bc_, ns_, sf_, domain_,  ndsolveopts___] :=
   Module[{solutionFunction, bcdir, amp},
    solutionFunction = sf[domain];
    bcdir = bc /. {"In" -> -1, "Up" -> +1};
    (*  Rescale amplitudes to give unit transmission coefficient. *)
    amp = ns/ns[["Transmission"]];
    TeukolskyRadialFunction[s, l, m, a, \[Omega],
     Association["s" -> s, "l" -> l, "m" -> m, "a" -> a, "\[Omega]" -> \[Omega], "Eigenvalue" -> \[Lambda], "RenormalizedAngularMomentum" -> \[Nu],
      "Method" -> {"NumericalIntegration", ndsolveopts},
      "BoundaryConditions" -> bc, "Amplitudes" -> amp, "UnscaledAmplitudes" -> ns,
      "Domain" -> If[domain === All, {rp[a, 1], \[Infinity]}, First[solutionFunction["Domain"]]],
      "RadialFunction" -> (Evaluate[#^-1 \[CapitalDelta][#,a]^-s Exp[bcdir I \[Omega] rs[#,a]] Exp[I m \[Phi]Reg[#,a]] solutionFunction[#]]&)
     ]
    ]
   ];

  (* Domain over which the numerical solution can be evaluated *)
  domains = OptionValue["Domain"];
  If[ListQ[BCs],
    If[domains === All, domains = Thread[BCs -> All]];
    If[!MatchQ[domains, (List|Association)[Rule["In"|"Up",_?domainQ]..]],
      Message[TeukolskyRadial::dm, "Domain" -> domains, BCs];
      Return[$Failed];
    ];
    domains = Lookup[domains, BCs, None]; 
    If[!AllTrue[domains, domainQ],
      Message[TeukolskyRadial::dm, "Domain" -> OptionValue["Domain"], BCs];
      Return[$Failed];
    ];
  ,
    If[!domainQ[domains],
      Message[TeukolskyRadial::dm, "Domain" -> domains, BCs];
      Return[$Failed];
    ];
  ];
  
  (* Solution functions for the specified boundary conditions *)
  ndsolveopts = Sequence@@FilterRules[{opts}, Options[NDSolve]];
  solFuncs =
   <|"In" :> Teukolsky`NumericalIntegration`Private`psi[s, \[Lambda], l, m, a, \[Omega], "In", norms, \[Nu], WorkingPrecision -> wp, PrecisionGoal -> prec, AccuracyGoal -> acc, ndsolveopts],
     "Up" :> Teukolsky`NumericalIntegration`Private`psi[s, \[Lambda], l, m, a, \[Omega], "Up", norms, \[Nu], WorkingPrecision -> wp, PrecisionGoal -> prec, AccuracyGoal -> acc, ndsolveopts]|>;
  solFuncs = Lookup[solFuncs, BCs];

  (* Select normalisation coefficients for the specified boundary conditions *)
  amps = Lookup[norms, BCs];

  If[ListQ[BCs],
    Return[Association[MapThread[#1 -> TRF[#1, #2, #3, #4, ndsolveopts]&, {BCs, amps, solFuncs, domains}]]],
    Return[TRF[BCs, amps, solFuncs, domains, ndsolveopts]]
  ];
];


(* ::Subsection::Closed:: *)
(*Sasaki-Nakamura Method*)


Options[TeukolskyRadialSasakiNakamura] = Join[
  {"Domain" -> None},
  FilterRules[Options[NDSolve], Except[WorkingPrecision|AccuracyGoal|PrecisionGoal]]];


domainQ[domain_] := MatchQ[domain, {_?NumericQ, _?NumericQ} | (_?NumericQ) | All];


TeukolskyRadialSasakiNakamura[s_Integer, l_Integer, m_Integer, a_, \[Omega]_, \[Lambda]_, \[Nu]_, BCs_, norms_, {wp_, prec_, acc_}, opts:OptionsPattern[]] :=
 Module[{TRF, amps, ndsolveopts, solFuncs, domains},
  (* Function to construct a single TeukolskyRadialFunction *)
  TRF[bc_, ns_, sf_, domain_, ndsolveopts___] :=
   Module[{solutionFunction, amp},
    If[sf === $Failed, Return[$Failed]];
    solutionFunction = sf[domain];
    (*  Rescale amplitudes to give unit transmission coefficient. *)
    amp = ns/ns[["Transmission"]];
    TeukolskyRadialFunction[s, l, m, a, \[Omega],
     Association["s" -> s, "l" -> l, "m" -> m, "a" -> a, "\[Omega]" -> \[Omega], "Eigenvalue" -> \[Lambda], "RenormalizedAngularMomentum" -> \[Nu],
      "Method" -> {"SasakiNakamura", ndsolveopts},
      "BoundaryConditions" -> bc, "Amplitudes" -> amp, "UnscaledAmplitudes" -> ns,
      "Domain" -> If[domain === All, {rp[a, 1], \[Infinity]}, First[solutionFunction["Domain"]]],
      "RadialFunction" -> solutionFunction
     ]
    ]
   ];

  (* Domain over which the numerical solution can be evaluated *)
  domains = OptionValue["Domain"];
  If[ListQ[BCs],
    If[!MatchQ[domains, (List|Association)[Rule["In"|"Up",_?domainQ]..]],
      Message[TeukolskyRadial::dm, "Domain" -> domains, BCs];
      Return[$Failed];
    ];
    domains = Lookup[domains, BCs, None]; 
    If[!AllTrue[domains, domainQ],
      Message[TeukolskyRadial::dm, "Domain" -> OptionValue["Domain"], BCs];
      Return[$Failed];
    ];
  ,
    If[!domainQ[domains],
      Message[TeukolskyRadial::dm, "Domain" -> domains, BCs];
      Return[$Failed];
    ];
  ];

  (* Solution functions for the specified boundary conditions *)
  ndsolveopts = Sequence@@FilterRules[{opts}, Options[NDSolve]];
  solFuncs =
   <|"In" :> $Failed,
     "Up" :> Teukolsky`SasakiNakamura`Private`TeukolskyRadialUp[s, \[Lambda], m, a, \[Omega](*, WorkingPrecision -> wp, PrecisionGoal -> prec, AccuracyGoal -> acc, ndsolveopts*)]
     |>;
  solFuncs = Lookup[solFuncs, BCs];

  (* Select normalisation coefficients for the specified boundary conditions *)
  amps = Lookup[norms, BCs];

  If[ListQ[BCs],
    Return[Association[MapThread[#1 -> TRF[#1, #2, #3, #4, ndsolveopts]&, {BCs, amps, solFuncs, domains}]]],
    Return[TRF[BCs, amps, solFuncs, domains, ndsolveopts]]
  ];
];


(* ::Subsection::Closed:: *)
(*MST Method*)


Options[TeukolskyRadialMST] = {};


TeukolskyRadialMST[s_Integer, l_Integer, m_Integer, a_, \[Omega]_, \[Lambda]_, \[Nu]_, BCs_, norms_, {wp_, prec_, acc_}, opts:OptionsPattern[]] :=
 Module[{amps, solFuncs, TRF},
  (* Function to construct a TeukolskyRadialFunction *)
  TRF[bc_, ns_, sf_] := Module[{amp},
    (*  Rescale amplitudes to give unit transmission coefficient. *)
    amp = ns/ns[["Transmission"]];
    TeukolskyRadialFunction[s, l, m, a, \[Omega],
     Association["s" -> s, "l" -> l, "m" -> m, "a" -> a, "\[Omega]" -> \[Omega], "Eigenvalue" -> \[Lambda], "RenormalizedAngularMomentum" -> \[Nu],
      "Method" -> {"MST"},
      "BoundaryConditions" -> bc, "Amplitudes" -> amp, "UnscaledAmplitudes" -> ns,
      "Domain" -> {rp[a, 1], \[Infinity]}, "RadialFunction" -> sf
     ]
    ]
  ];

  (* Solution functions for the specified boundary conditions *)
  solFuncs =
    <|"In" :> Teukolsky`MST`MST`Private`MSTRadialIn[s,l,m,a,2\[Omega],\[Nu],\[Lambda],norms["In", "Transmission"], {wp, prec, acc}],
      "Up" :> Teukolsky`MST`MST`Private`MSTRadialUp[s,l,m,a,2\[Omega],\[Nu],\[Lambda],norms["Up", "Transmission"], {wp, prec, acc}]|>;
  solFuncs = Lookup[solFuncs, BCs];

  (* Select normalisation coefficients for the specified boundary conditions *)
  amps = Lookup[norms, BCs];

  If[ListQ[BCs],
    Return[Association[MapThread[#1 -> TRF[#1, #2, #3]&, {BCs, amps, solFuncs}]]],
    Return[TRF[BCs, amps, solFuncs]]
  ];
];


(* ::Subsection::Closed:: *)
(*HeunC*)


Options[TeukolskyRadialHeunC] = {};


TeukolskyRadialHeunC[s_Integer, l_Integer, m_Integer, a_, \[Omega]_, \[Lambda]_, \[Nu]_, BCs_, norms_, {wp_, prec_, acc_}, opts:OptionsPattern[]] :=
 Module[{amps, solFuncs, TRF, \[Omega]c, \[Lambda]c},
  (* The HeunC method is only supported on version 12.1 and newer *)
  If[$VersionNumber < 12.1,
    Message[TeukolskyRadial::hc];
    Return[$Failed]
  ];

  (* Function to construct a TeukolskyRadialFunction *)
  TRF[bc_, ns_, sf_] := Module[{amp},
    (*  Rescale amplitudes to give unit transmission coefficient. *)
    amp = ns/ns[["Transmission"]];
    If[sf === $Failed, $Failed,
      TeukolskyRadialFunction[s, l, m, a, \[Omega],
        Association["s" -> s, "l" -> l, "m" -> m, "a" -> a, "\[Omega]" -> \[Omega], "Eigenvalue" -> \[Lambda], "RenormalizedAngularMomentum" -> \[Nu],
          "Method" -> {"HeunC"},
          "BoundaryConditions" -> bc, "Amplitudes" -> amp, "UnscaledAmplitudes" -> ns,
          "Domain" -> {rp[a, 1], \[Infinity]}, "RadialFunction" -> sf
        ]
      ]
    ]
  ];

  (* Solution functions for the specified boundary conditions *)
  \[Omega]c = Conjugate[\[Omega]];
  \[Lambda]c = Conjugate[\[Lambda]];
  solFuncs =
    <|"In" :> ((2^((-I a m-Sqrt[1-a^2] s+2 I \[Omega])/Sqrt[1-a^2]) (1-a^2)^((I a m)/(2 (1+Sqrt[1-a^2]))-s-I \[Omega]) E^(1/2 I (a m-2 # \[Omega])) ((-1-Sqrt[1-a^2]+#)/Sqrt[1-a^2])^((I a m)/(2 Sqrt[1-a^2])-s-I (1+1/Sqrt[1-a^2]) \[Omega]) ((-1+Sqrt[1-a^2]+#)/Sqrt[1-a^2])^((I (a m+2 (-1+Sqrt[1-a^2]) \[Omega]))/(2 Sqrt[1-a^2])) HeunC[s+s^2+\[Lambda]-(a m-2 \[Omega])^2/(-1+a^2)-4 \[Omega]^2+(I (-a m-4 (-1+s) \[Omega]+2 a^2 (-1+2 s) \[Omega]))/Sqrt[1-a^2],-4 \[Omega] (-I Sqrt[1-a^2]+a m+I Sqrt[1-a^2] s-2 \[Omega]+2 Sqrt[1-a^2] \[Omega]),1-s+(I (a m-2 \[Omega]))/Sqrt[1-a^2]-2 I \[Omega],1+s+(I (a m-2 \[Omega]))/Sqrt[1-a^2]+2 I \[Omega],4 I Sqrt[1-a^2] \[Omega],(1+Sqrt[1-a^2]-#)/(2 Sqrt[1-a^2])])&),
      "Up" :> (norms["Up"]["Reflection"]/norms["Up"]["Transmission"](2^((-I a m-Sqrt[1-a^2] s+2 I \[Omega])/Sqrt[1-a^2]) (1-a^2)^((I a m)/(2 (1+Sqrt[1-a^2]))-s-I \[Omega]) E^(1/2 I (a m-2 # \[Omega])) ((-1-Sqrt[1-a^2]+#)/Sqrt[1-a^2])^((I a m)/(2 Sqrt[1-a^2])-s-I (1+1/Sqrt[1-a^2]) \[Omega]) ((-1+Sqrt[1-a^2]+#)/Sqrt[1-a^2])^((I (a m+2 (-1+Sqrt[1-a^2]) \[Omega]))/(2 Sqrt[1-a^2])) HeunC[s+s^2+\[Lambda]-(a m-2 \[Omega])^2/(-1+a^2)-4 \[Omega]^2+(I (-a m-4 (-1+s) \[Omega]+2 a^2 (-1+2 s) \[Omega]))/Sqrt[1-a^2],-4 \[Omega] (-I Sqrt[1-a^2]+a m+I Sqrt[1-a^2] s-2 \[Omega]+2 Sqrt[1-a^2] \[Omega]),1-s+(I (a m-2 \[Omega]))/Sqrt[1-a^2]-2 I \[Omega],1+s+(I (a m-2 \[Omega]))/Sqrt[1-a^2]+2 I \[Omega],4 I Sqrt[1-a^2] \[Omega],(1+Sqrt[1-a^2]-#)/(2 Sqrt[1-a^2])])+
              norms["Up"]["Incidence"]/norms["Up"]["Transmission"](#^2-2 #+a^2)^-s (2^((I a m-Sqrt[1-a^2] (-s)-2 I \[Omega]c)/Sqrt[1-a^2]) (1-a^2)^((-I a m)/(2 (1+Sqrt[1-a^2]))-(-s)+I \[Omega]c) E^(-1/2 I (a m-2 # \[Omega]c)) ((-1-Sqrt[1-a^2]+#)/Sqrt[1-a^2])^((-I a m)/(2 Sqrt[1-a^2])-(-s)+I (1+1/Sqrt[1-a^2]) \[Omega]c) ((-1+Sqrt[1-a^2]+#)/Sqrt[1-a^2])^((-I (a m+2 (-1+Sqrt[1-a^2]) \[Omega]c))/(2 Sqrt[1-a^2])) HeunC[(-s)+(-s)^2+(\[Lambda]c+2s)-(a m-2 \[Omega]c)^2/(-1+a^2)-4 \[Omega]c^2+(-I (-a m-4 (-1+(-s)) \[Omega]c+2 a^2 (-1+2 (-s)) \[Omega]c))/Sqrt[1-a^2],-4 \[Omega]c (+I Sqrt[1-a^2]+a m-I Sqrt[1-a^2] (-s)-2 \[Omega]c+2 Sqrt[1-a^2] \[Omega]c),1-(-s)+(-I (a m-2 \[Omega]c))/Sqrt[1-a^2]+2 I \[Omega]c,1+(-s)+(-I (a m-2 \[Omega]c))/Sqrt[1-a^2]-2 I \[Omega]c,-4 I Sqrt[1-a^2] \[Omega]c,(1+Sqrt[1-a^2]-#)/(2 Sqrt[1-a^2])])&) |>;
  solFuncs = Lookup[solFuncs, BCs];

  (* Select normalisation coefficients for the specified boundary conditions *)
  amps = Lookup[norms, BCs];

  If[ListQ[BCs],
    Return[Association[MapThread[#1 -> TRF[#1, #2, #3]&, {BCs, amps, solFuncs}]]],
    Return[TRF[BCs, amps, solFuncs]]
  ];
];


(* ::Subsection::Closed:: *)
(*Static modes*)


staticAmplitudes[s_, l_, m_, a_] :=
 Module[{\[Tau] = -((m a)/Sqrt[1-a^2]), \[Kappa] = Sqrt[1 - a^2], ampIn1, ampIn2, ampUp3, ampUp4, ampUp5},
  (* Return results as an Association *)
  If[\[Tau]==0,
     <|"In" -> <|
         "\[ScriptCapitalH]" -> 1,
         "\[ScriptCapitalI]" -> ((2 \[Kappa])^(-l+Abs[s]) Gamma[2l+1] Gamma[1+Abs[s]])/(Gamma[l+1] Gamma[1+l+Abs[s]])|>,
       "Up" -> <|
         "\[ScriptCapitalH]" ->
           If[s==0,
             -((2 \[Kappa])^(-1-l) Gamma[3+2l])/(2 Gamma[l+2] Gamma[1+l]),
             ((2 \[Kappa])^(-1-l+Abs[s]) Gamma[2+2 l] Gamma[Abs[s]])/(Gamma[1+l+Abs[s]] Gamma[1+l])],
         "\[ScriptCapitalI]" -> 1|>|>
  ,
     <|"In" -> <|
         "\[ScriptCapitalH]" -> 1,
         "\[ScriptCapitalI]-" -> -((2^(l-s-I \[Tau]) \[Kappa]^(1-s) (-1)^(l+s) Gamma[1+l+s] Gamma[1-s-I \[Tau]])/(Gamma[2+2 l] Gamma[-l-I \[Tau]])),
         "\[ScriptCapitalI]+" -> ((2 \[Kappa])^(-l-s-I \[Tau]) Gamma[2l+1] Gamma[1-s-I \[Tau]])/(Gamma[1+l-s] Gamma[1+l-I \[Tau]])|>,
       "Up" -> <|
         "\[ScriptCapitalH]-" -> ((2 \[Kappa])^(-1-l+s+I \[Tau]) Gamma[2+2 l] Gamma[s+I \[Tau]])/(Gamma[1+l+s] Gamma[1+l+I \[Tau]]),
         "\[ScriptCapitalH]+" -> ((2 \[Kappa])^(-1-l-s-I \[Tau]) Gamma[2+2 l] Gamma[-s-I \[Tau]])/(Gamma[1+l-s] Gamma[1+l-I \[Tau]]),
         "\[ScriptCapitalI]" -> 1|>|>
  ]
 ];


TeukolskyRadialStatic[s_Integer, l_Integer, m_Integer, a_, \[Omega]_, \[Lambda]_, \[Nu]_, BCs_, norms_] :=
 Module[{amps, solFuncs, TRF},
  (* Function to construct a TeukolskyRadialFunction *)
  TRF[bc_, amp_, sf_] :=
    TeukolskyRadialFunction[s, l, m, a, \[Omega],
     Association["s" -> s, "l" -> l, "m" -> m, "a" -> a, "\[Omega]" -> \[Omega], "Eigenvalue" -> \[Lambda], "RenormalizedAngularMomentum" -> \[Nu],
      "Method" -> {"Static"},
      "BoundaryConditions" -> bc, "Amplitudes" -> amp, "UnscaledAmplitudes" -> amp,
      "Domain" -> {rp[a, 1], \[Infinity]}, "RadialFunction" -> sf
     ]
    ];

  (* Solution functions for the specified boundary conditions *)
  With[{\[Tau] = -((m a)/Sqrt[1-a^2]), \[Kappa] = Sqrt[1 - a^2]},
    With[{normIn = If[\[Tau]==0 && s>0, Gamma[s+1]Pochhammer[l+s+1,-2s], (2\[Kappa])^(-2s-I \[Tau]) Gamma[1-s-I \[Tau]]],
          normUp = (2 \[Kappa])^(-s-l-1)},
    solFuncs =
      <|"In" :> (normIn (-(1 + \[Kappa] - #)/(2 \[Kappa]))^(-s - I \[Tau]/2) (1 - (1 + \[Kappa] - #)/(2 \[Kappa]))^(-I \[Tau]/2) Hypergeometric2F1Regularized[-l - I \[Tau], l + 1 - I \[Tau], 1 - s - I \[Tau], (1 + \[Kappa] - #)/(2 \[Kappa])]&),
        "Up" :> (normUp (-(1 + \[Kappa] - #)/(2 \[Kappa]))^(-s - (I \[Tau])/2) (1 - (1 + \[Kappa] - #)/(2 \[Kappa]))^((I \[Tau])/2 - l - 1) Hypergeometric2F1[l + 1 - I \[Tau], l + 1 - s, 2 l + 2, 1/(1 - (1 + \[Kappa] - #)/(2 \[Kappa]))]&)
       |>;
    ];
  ];
  solFuncs = Lookup[solFuncs, BCs];

  (* Select normalisation coefficients for the specified boundary conditions *)
  amps = Lookup[norms, BCs];

  If[ListQ[BCs],
    Return[Association[MapThread[#1 -> TRF[#1, #2, #3]&, {BCs, amps, solFuncs}]]],
    Return[TRF[BCs, amps, solFuncs]]
  ];
];


(* ::Subsection::Closed:: *)
(*TeukolskyRadial*)


SyntaxInformation[TeukolskyRadial] =
 {"ArgumentsPattern" -> {_, _, _, _, _, OptionsPattern[]}};


Options[TeukolskyRadial] = {
  Method -> Automatic,
  "BoundaryConditions" -> {"In", "Up"},
  "Amplitudes" -> Automatic,
  "RenormalizedAngularMomentum" -> Automatic,
  "Eigenvalue" -> Automatic,
  WorkingPrecision -> Automatic,
  PrecisionGoal -> Automatic,
  AccuracyGoal -> Automatic
};


TeukolskyRadial[s_?NumericQ, l_?NumericQ, m_?NumericQ, a_, \[Omega]_, OptionsPattern[]] /;
  l < Abs[s] || Abs[m] > l || !AllTrue[{2s, 2l, 2m}, IntegerQ] || !IntegerQ[l-s] || !IntegerQ[m-s] := 
 (Message[TeukolskyRadial::params, s, l, m]; $Failed);


TeukolskyRadial[s_, l_, m_, a_Complex, \[Omega]_, OptionsPattern[]] :=
 (Message[TeukolskyRadial::cmplx, a]; $Failed);


(* ::Subsubsection::Closed:: *)
(*Static modes*)


TeukolskyRadial[s_Integer, l_Integer, m_Integer, a_, \[Omega]_, opts:OptionsPattern[]] /; AllTrue[{a, \[Omega]}, NumericQ] && \[Omega] == 0 :=
 Module[{\[Lambda], BCs, norms, wp, prec, acc},
  (* Determine which boundary conditions the homogeneous solution(s) should satisfy *)
  BCs = OptionValue["BoundaryConditions"];
  If[!MatchQ[BCs, "In"|"Up"|{("In"|"Up")..}], 
    Message[TeukolskyRadial::optx, "BoundaryConditions" -> BCs];
    Return[$Failed];
  ];

  (* Eigenvalue *)
  \[Lambda] = SpinWeightedSpheroidalEigenvalue[s, l, m, a \[Omega]];

  (* Some options are not supported for static modes *)
  Do[
    If[OptionValue[opt] =!= Automatic, Message[TeukolskyRadial::sopt, opt]];,
    {opt, {"Eigenvalue", "RenormalizedAngularMomentum", Method, WorkingPrecision, PrecisionGoal, AccuracyGoal}}
  ];

  (* Compute the asymptotic amplitudes *)
  Which[
  OptionValue["Amplitudes"] === False,
    norms = <|"In" -> <|"Transmission" -> 1|>, "Up" -> <|"Transmission" -> 1|>|>;,
  MatchQ[OptionValue["Amplitudes"], <|"In"-><|___|>, "Up" -> <|___|>|>],
    norms = OptionValue["Amplitudes"];,
  MatchQ[OptionValue["Amplitudes"], Automatic|True],
    norms = staticAmplitudes[s, l, m, a];,
  True,
    Message[TeukolskyRadial::optx, "Amplitudes" -> OptionValue["Amplitudes"]];
    Return[$Failed];
  ];

  (* Call the chosen implementation *)
  TeukolskyRadialStatic[s, l, m, a, \[Omega], \[Lambda], \[Lambda], BCs, norms]
]


(* ::Subsubsection::Closed:: *)
(*Non-static modes*)


TeukolskyRadial[s_Integer, l_Integer, m_Integer, a_, \[Omega]_, opts:OptionsPattern[]] /; AllTrue[{a, \[Omega]}, NumericQ] && (InexactNumberQ[a] || InexactNumberQ[\[Omega]]) :=
 Module[{TRF, subopts, BCs, norms, \[Nu], \[Lambda], wp, prec, acc},
  (* Extract suboptions from Method to be passed on. *)
  If[ListQ[OptionValue[Method]],
    subopts = Rest[OptionValue[Method]];,
    subopts = {};
  ];

  (* Determine which boundary conditions the homogeneous solution(s) should satisfy *)
  BCs = OptionValue["BoundaryConditions"];
  If[!MatchQ[BCs, "In"|"Up"|{("In"|"Up")..}], 
    Message[TeukolskyRadial::optx, "BoundaryConditions" -> BCs];
    Return[$Failed];
  ];

  (* Options associated with precision and accuracy *)
  {wp, prec, acc} = OptionValue[{WorkingPrecision, PrecisionGoal, AccuracyGoal}];
  If[wp === Automatic, wp = Precision[{a, \[Omega]}]];
  If[prec === Automatic, prec = wp / 2];
  If[acc === Automatic, acc = Infinity];
  If[Precision[a] < wp, Message[TeukolskyRadial::precw, "a", a, wp]];
  If[Precision[\[Omega]] < wp, Message[TeukolskyRadial::precw, "\[Omega]", \[Omega], wp]];

  (* Decide which implementation to use *)
  Switch[OptionValue[Method],
    Automatic,
      If[wp === MachinePrecision,
         TRF = TeukolskyRadialNumericalIntegration,
         TRF = TeukolskyRadialMST],
    "MST" | {"MST", OptionsPattern[TeukolskyRadialMST]},
      TRF = TeukolskyRadialMST,
    "NumericalIntegration" | {"NumericalIntegration", OptionsPattern[TeukolskyRadialNumericalIntegration]},
      TRF = TeukolskyRadialNumericalIntegration;,
    "HeunC",
      (* Some options are not supported for the HeunC method modes *)
      Do[
        If[OptionValue[opt] =!= Automatic, Message[TeukolskyRadial::hcopt, opt]];,
        {opt, {WorkingPrecision, PrecisionGoal, AccuracyGoal}}
      ];
      TRF = TeukolskyRadialHeunC;,
    _,
      Message[TeukolskyRadial::optx, Method -> OptionValue[Method]];
      Return[$Failed];
  ];

  (* Check only supported sub-options have been specified *)  
  If[subopts =!= (subopts = FilterRules[subopts, Options[TRF]]),
    Message[TeukolskyRadial::optx, Method -> OptionValue[Method]];
  ];

  (* Eigenvalue *)
  Which[
  OptionValue["Eigenvalue"] === False,
    \[Lambda] = Indeterminate;,
  NumericQ[OptionValue["Eigenvalue"]],
    \[Lambda] = OptionValue["Eigenvalue"];,
  True,
    \[Lambda] = SpinWeightedSpheroidalEigenvalue[s, l, m, a \[Omega]];
  ];

  (* Renormalized angular momentum *)
  Which[
  OptionValue["RenormalizedAngularMomentum"] === False,
    \[Nu] = Indeterminate;,
  NumericQ[OptionValue["RenormalizedAngularMomentum"]],
    \[Nu] = OptionValue["RenormalizedAngularMomentum"];,
  True,
    If[wp === MachinePrecision,
      \[Nu] = N[RenormalizedAngularMomentum[s, l, m, SetPrecision[a, 2 $MachinePrecision], SetPrecision[\[Omega], 2 $MachinePrecision], SetPrecision[\[Lambda], 2 $MachinePrecision], Method -> (OptionValue["RenormalizedAngularMomentum"] /. (Automatic|True) -> "Monodromy")]];,
      \[Nu] = RenormalizedAngularMomentum[s, l, m, a, \[Omega], \[Lambda], Method -> (OptionValue["RenormalizedAngularMomentum"] /. (Automatic|True) -> "Monodromy")];
    ];
  ];

  (* Compute the asymptotic amplitudes *)
  Which[
  OptionValue["Amplitudes"] === False,
    norms = <|"In" -> <|"Transmission" -> 1|>, "Up" -> <|"Transmission" -> 1|>|>;,
  MatchQ[OptionValue["Amplitudes"], <|"In"-><|___|>, "Up" -> <|___|>|>],
    norms = OptionValue["Amplitudes"];,
  MatchQ[OptionValue["Amplitudes"], Automatic|True],
    If[OptionValue["RenormalizedAngularMomentum"] === False,
      Message[TeukolskyRadial::opti, {"Amplitudes" -> OptionValue["Amplitudes"], "RenormalizedAngularMomentum" -> OptionValue["RenormalizedAngularMomentum"]}];
      Return[$Failed];
    ];
    If[wp === MachinePrecision,
      norms = N[Teukolsky`MST`MST`Private`Amplitudes[s, l, m, SetPrecision[a, 2 $MachinePrecision], SetPrecision[2\[Omega], 2 $MachinePrecision], SetPrecision[\[Nu], 2 $MachinePrecision], SetPrecision[\[Lambda], 2 $MachinePrecision], {2 $MachinePrecision, prec, acc}]];,
      norms = Teukolsky`MST`MST`Private`Amplitudes[s, l, m, a, 2\[Omega], \[Nu], \[Lambda], {wp, prec, acc}];
    ];,
  True,
    Message[TeukolskyRadial::optx, "Amplitudes" -> OptionValue["Amplitudes"]];
    Return[$Failed];
  ];

  (* Call the chosen implementation *)
  TRF[s, l, m, a, \[Omega], \[Lambda], \[Nu], BCs, norms, {wp, prec, acc}, Sequence@@subopts]
];


(* ::Section::Closed:: *)
(*TeukolskyRadialFunction*)


(* ::Subsection::Closed:: *)
(*Output format*)


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
         ImageSize -> Dynamic[{Automatic, 3.5 CurrentValue["FontCapHeight"]/AbsoluteCurrentValue[Magnification]}]]
|>;


(* ::Subsubsection::Closed:: *)
(*Formatting of TeukolskyRadialFunction*)


TeukolskyRadialFunction /:
 MakeBoxes[trf:TeukolskyRadialFunction[s_, l_, m_, a_, \[Omega]_, assoc_], form:(StandardForm|TraditionalForm)] :=
 Module[{summary, extended},
  summary = {Row[{BoxForm`SummaryItem[{"s: ", s}], "  ",
                  BoxForm`SummaryItem[{"l: ", l}], "  ",
                  BoxForm`SummaryItem[{"m: ", m}], "  ",
                  BoxForm`SummaryItem[{"a: ", a}], "  ",
                  BoxForm`SummaryItem[{"\[Omega]: ", \[Omega]}]}],
             BoxForm`SummaryItem[{"Domain: ", assoc["Domain"]}],
             BoxForm`SummaryItem[{"Boundary Conditions: " , assoc["BoundaryConditions"]}]};
  If[assoc["Method"] === {"Static"},
  extended = {BoxForm`SummaryItem[{"Eigenvalue: ", assoc["Eigenvalue"]}],
              BoxForm`SummaryItem[{"Amplitudes: ", assoc["Amplitudes"]}],
              BoxForm`SummaryItem[{"Method: ", First[assoc["Method"]]}]},
  extended = {BoxForm`SummaryItem[{"Eigenvalue: ", assoc["Eigenvalue"]}],
              BoxForm`SummaryItem[{"Renormalized angular momentum: ", assoc["RenormalizedAngularMomentum"]}],
              BoxForm`SummaryItem[{"Transmission Amplitude: ", assoc["Amplitudes", "Transmission"]}],
              BoxForm`SummaryItem[{"Incidence Amplitude: ", Lookup[assoc["Amplitudes"], "Incidence", Missing]}],
              BoxForm`SummaryItem[{"Reflection Amplitude: ", Lookup[assoc["Amplitudes"], "Reflection", Missing]}],
              BoxForm`SummaryItem[{"Method: ", First[assoc["Method"]]}],
              BoxForm`SummaryItem[{"Method options: ",Column[Rest[assoc["Method"]]]}]}];
  BoxForm`ArrangeSummaryBox[
    TeukolskyRadialFunction,
    trf,
    Lookup[icons, assoc["BoundaryConditions"], None],
    summary,
    extended,
    form]
];


(* ::Subsection::Closed:: *)
(*Accessing attributes*)


TeukolskyRadialFunction[s_, l_, m_, a_, \[Omega]_, assoc_][y_String] /; !MemberQ[{"RadialFunction"}, y] :=
  assoc[y];


Keys[m_TeukolskyRadialFunction] ^:= DeleteCases[Join[Keys[m[[-1]]], {}], "RadialFunction"];


(* ::Subsection::Closed:: *)
(*Numerical evaluation*)


SetAttributes[TeukolskyRadialFunction, {NHoldAll}];


outsideDomainQ[r_, rmin_, rmax_] := Min[r]<rmin || Max[r]>rmax;


TeukolskyRadialFunction[s_, l_, m_, a_, \[Omega]_, assoc_][r:(_?NumericQ|{_?NumericQ..})] :=
 Module[{rmin, rmax},
  {rmin, rmax} = assoc["Domain"];
  If[outsideDomainQ[r, rmin, rmax],
    Message[TeukolskyRadialFunction::dmval, #]& /@ Select[Flatten[{r}], outsideDomainQ[#, rmin, rmax]&];
    Return[Indeterminate];
  ];
  Quiet[assoc["RadialFunction"][r], InterpolatingFunction::dmval]
 ];


Derivative[n:1][TeukolskyRadialFunction[s_, l_, m_, a_, \[Omega]_, assoc_]][r:(_?NumericQ|{_?NumericQ..})] :=
 Module[{rmin, rmax},
  {rmin, rmax} = assoc["Domain"];
  If[outsideDomainQ[r, rmin, rmax],
    Message[TeukolskyRadialFunction::dmval, #]& /@ Select[Flatten[{r}], outsideDomainQ[#, rmin, rmax]&];
    Return[Indeterminate];
  ];
  Quiet[Derivative[n][assoc["RadialFunction"]][r], InterpolatingFunction::dmval]
 ];


Derivative[n_Integer/;n>1][trf:(TeukolskyRadialFunction[s_, l_, m_, a_, \[Omega]_, assoc_])][r0:(_?NumericQ|{_?NumericQ..})] :=
 Module[{Rderivs, R, r, i, res},
  Rderivs = D[R[r_], {r_, i_}] :> D[(-(-trf["Eigenvalue"] + 2 I r s 2 \[Omega] + (-2 I (-1 + r) s (-a m + (a^2 + r^2) \[Omega]) + (-a m + (a^2 + r^2) \[Omega])^2)/(a^2 - 2 r + r^2)) R[r] - (-2 + 2 r) (1 + s) R'[r])/(a^2 - 2 r + r^2), {r, i - 2}] /; i >= 2;
  Do[Derivative[i][R][r] = Collect[D[Derivative[i - 1][R][r], r] /. Rderivs, {R'[r], R[r]}, Simplify];, {i, 2, n}];
  res = Derivative[n][R][r] /. {
    R'[r] -> trf'[r0],
    R[r] -> trf[r0], r -> r0};
  Clear[Rderivs, i];
  Remove[R, r];
  res
];


(* ::Section::Closed:: *)
(*End Package*)


(* ::Subsection::Closed:: *)
(*Protect symbols*)


SetAttributes[{TeukolskyRadial, TeukolskyRadialFunction}, {Protected, ReadProtected}];


(* ::Subsection::Closed:: *)
(*End*)


End[];
EndPackage[];
