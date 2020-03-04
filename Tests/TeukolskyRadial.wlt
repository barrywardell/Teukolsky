(* Mathematica Test File *)

\[Psi] = TeukolskyRadial[2, 2, 2, 0.5, 0.1];
\[Psi]In = \[Psi]["In"];

(****************************************************************)
(* TeukolskyRadial                                              *)
(****************************************************************)
VerificationTest[
    \[Psi]
    ,
    TeukolskyRadialFunction[2, 2, 2, 0.5, 0.1, <|"s" -> 2, "l" -> 2, "m" -> 2, "\[Omega]" -> 0.1,
      "Method" -> {"MST", "RenormalizedAngularMomentum" -> \[Nu]_}, 
      "BoundaryConditions" -> {"In", "Up"}, "Eigenvalue" -> \[Lambda]_, 
      "Amplitudes" ->
        <|"In" -> <|"Incidence" -> _,
                    "Transmission" -> _,
                    "Reflection" -> _ |>,
          "Up" -> <|"Transmission" -> _ |>|>,
      "SolutionFunctions" -> {Teukolsky`MST`MST`Private`MSTRadialIn[2, 2, 2, 0.5, 0.2, 
         \[Nu]_, \[Lambda]_, _], Teukolsky`MST`MST`Private`MSTRadialUp[2, 2, 
         2, 0.5, 0.2, \[Nu]_, \[Lambda]_, _]}|>]
    ,
    TestID->"TeukolskyRadial",
    SameTest -> MatchQ
]

(****************************************************************)
(* InvalidKey                                                   *)
(****************************************************************)
VerificationTest[
    \[Psi]["NotAKey"]
    ,
    Missing["KeyAbsent", "NotAKey"]
    ,
    TestID->"InvalidKey"
]


(****************************************************************)
(* BoundaryConditions                                           *)
(****************************************************************)
VerificationTest[
    \[Psi]["BoundaryConditions"]
    ,
    {"In", "Up"}
    ,
    TestID->"BoundaryConditions"
]


(****************************************************************)
(* Method                                                       *)
(****************************************************************)
VerificationTest[
    \[Psi]["Method"]
    ,
    {"MST", "RenormalizedAngularMomentum" -> _}
    ,
    TestID->"Method",
    SameTest -> MatchQ
]


(****************************************************************)
(* Eigenvalue                                                   *)
(****************************************************************)
VerificationTest[
    \[Psi]["Eigenvalue"]
    ,
    -0.33267928615316333
    ,
    TestID->"Eigenvalue"
]


(****************************************************************)
(* SolutionFunctions                                            *)
(****************************************************************)
VerificationTest[
    \[Psi]["SolutionFunctions"]
    ,
    TeukolskyRadialFunction[2, 2, 2, 0.5, 0.1, <|"s" -> 2, "l" -> 2, "m" -> 2, "\[Omega]" -> 0.1,
       "Method" -> {"MST", "RenormalizedAngularMomentum" -> \[Nu]_}, 
       "BoundaryConditions" -> {"In", "Up"}, "Eigenvalue" -> \[Lambda]_, 
       "Amplitudes" ->
         <|"In" -> <|"Incidence" -> _,
                     "Transmission" -> _,
                     "Reflection" -> _ |>,
           "Up" -> <|"Transmission" -> _ |>|>,
       "SolutionFunctions" -> {Teukolsky`MST`MST`Private`MSTRadialIn[2, 2, 2, 0.5, 0.2, 
          \[Nu]_, \[Lambda]_, _], Teukolsky`MST`MST`Private`MSTRadialUp[2, 2, 
          2, 0.5, 0.2, \[Nu]_, \[Lambda]_, _]}|>]["SolutionFunctions"]
    ,
    TestID->"SolutionFunctions",
    SameTest -> MatchQ
]


(****************************************************************)
(* Numerical Evaluation                                         *)
(****************************************************************)
VerificationTest[
    \[Psi][10.0]
    ,
    <|"In" -> 0.8151274455692021 + 0.5569358329985141*I,
      "Up" -> 1.999804503329915*^-6 + 0.000013378466321641552*I|>
    ,
    TestID->"Numerical Evaluation",
    SameTest -> withinRoundoff
]


(****************************************************************)
(* Derivative Numerical Evaluation                              *)
(****************************************************************)
VerificationTest[
    \[Psi]'[10.0]
    ,
    <|"In" -> 0.03200583839610331 - 0.07297367974124275*I,
      "Up" -> -2.593598129598713*^-6 - 7.151271833408181*^-6*I|>
    ,
    TestID->"Derivative Numerical Evaluation ",
    SameTest -> withinRoundoff
]


(****************************************************************)
(* Higher Derivative Numerical Evaluation                       *)
(****************************************************************)
VerificationTest[
    \[Psi]''''[10.0]
    ,
    <|"In" -> -0.0003139910712826748 + 0.00007805860280741137*I,
      "Up" -> 2.171038044040099*^-6 + 2.775091588344741*^-6*I|>
    ,
    TestID->"Higher Derivative Numerical Evaluation ",
    SameTest -> withinRoundoff
]


(****************************************************************)
(* Subcase                                                      *)
(****************************************************************)
VerificationTest[
    \[Psi]In
    ,
    TeukolskyRadialFunction[2, 2, 2, 0.5, 0.1, <|"s" -> 2, "l" -> 2, "m" -> 2, "\[Omega]" -> 0.1,
      "Method" -> {"MST", "RenormalizedAngularMomentum" -> \[Nu]_}, 
      "BoundaryConditions" -> "In", "Eigenvalue" -> \[Lambda]_, 
      "Amplitudes" -> 
        <|"Incidence" -> _,
          "Transmission" -> _,
          "Reflection" -> _ |>,
      "SolutionFunctions" -> Teukolsky`MST`MST`Private`MSTRadialIn[2, 2, 2, 0.5, 0.2, 
        \[Nu]_, \[Lambda]_, _]|>]
    ,
    TestID->"Subcase",
    SameTest -> MatchQ
]

(****************************************************************)
(* Single Subcase Boundary Conditions                           *)
(****************************************************************)
VerificationTest[
    \[Psi]In["BoundaryConditions"]
    ,
    "In"
    ,
    TestID->"Single Subcase Boundary Conditions"
]

(****************************************************************)
(* Single Subcase Numerical Evaluation                          *)
(****************************************************************)
VerificationTest[
    \[Psi]In[10.0]
    ,
    0.8151274455692021 + 0.5569358329985141*I
    ,
    TestID->"Single Subcase Numerical Evaluation",
    SameTest -> withinRoundoff
]


(****************************************************************)
(* Single Subcase Derivative Numerical Evaluation               *)
(****************************************************************)
VerificationTest[
    \[Psi]In'[10.0]
    ,
    0.03200583839610331 - 0.07297367974124275*I
    ,
    TestID->"Single Subcase Derivative Numerical Evaluation ",
    SameTest -> withinRoundoff
]


