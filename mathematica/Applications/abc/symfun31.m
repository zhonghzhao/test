Needs["Combinatorica`"]

Off[General::spell]   (* To turn off irrelevant error messages *)

(* ::Section:: *)
(*Basic Commands: Entering and Manipulating Symmetric Functions*)


(* ::Subsection:: *)
(*H: definitions*)


h0[k_Integer,n_] := If[k>0,Coefficient[Series[Product[1/(1-t x[i]),{i,1,n}],{t,0,k}],t^k], If[k==0, 1, 0]]  (*private*)


h[lambda_List]:= Apply[Times, Map[h[#]&,lambda]]


hx[lambda_List,n_] := Apply[Times, Map[h0[#, n]&,lambda]]//Expand


he[n_] := Det[HEMat[n]]//Expand


hp[n_] := Det[HPMat[n]]/(n!)//Expand


HList[n_] := Map[h,Partitions[n]]


HList[n_, k_]:=Map[h, Partitions[n,Rows->k]]


HList2[n_, k_]:=Map[h, Partitions[n,Columns->k]]


(* ::Subsection:: *)
(*E: definitions*)


x0[lambda_List]:=Apply[Times, Map[x[#]&,lambda]]  (*private*)


e0[k_Integer,n_] := Apply[Plus, Map[x0[#]&, KSubsets[Range[n], k]]]   (*private*)


e[lambda_List]:= Apply[Times,Map[e[#]&, lambda]] 


ex[lambda_List,n_] := Apply[Times, Map[e0[#, n]&,lambda]]//Expand


eh[n_]:=Det[EHMat[n]]//Expand


ep[n_]:=Det[EPMat[n]]/(n!)//Expand


EList[n_]:=Map[e,Partitions[n]]


EList[n_, k_]:=Map[e,Map[ConjugateP, Partitions[n, Rows->k]]]


(* ::Subsection:: *)
(*M: definitions *)


monomial[list_] := Product[x[i]^list[[i]],{i,Length[list]}]


mx[lambda_List,n_] := Module[{exponents,perms,output},
If[n<Length[lambda],output=0,
(*else*)
exponents = lambda;
While[Length[exponents]<n,AppendTo[exponents,0]];
perms = Permutations[exponents];
output=Apply[Plus,Map[monomial,perms]]
];
output
]


m[lambda_List]:=Apply[m, lambda]


MList[n_]:=Map[m,Partitions[n]]


MList[n_, k_]:=Map[m,Partitions[n, Rows->k]]


(* ::Subsection:: *)
(*P: definitions*)


p0[k_Integer,n_] := Sum[x[i]^k,{i,n}]//Expand   (*private*)


px[list_List,n_] := Product[p0[list[[j]], n],{j,Length[list]}]//Expand


p[lambda_List]:= Apply[Times, Map[p[#]&,lambda]]


pe[n_]:=Det[PEMat[n]]


ph[n_]:=((-1)^(n-1))*Det[PHMat[n]]


PList[n_]:=Map[p,Partitions[n]]


PList[n_, k_]:=Map[p,Partitions[n, Rows->k]]


(* ::Subsection:: *)
(*S: definitions*)


s[lambda_List]:=Apply[s, lambda]


sh[lambda_List]:=Det[JTH[lambda]]
sh[numlist__]:=sh[{numlist}]
sh[n_Integer]:=h[n]


se[lambda_List]:=Det[JTE[lambda]]
se[x:(_Integer)..]:=se[{x}]


sx[lambda_List,n_] :=sh[lambda]/.h[k_]->h0[k, n]//Simplify//Expand


SList[n_]:=Map[s,Partitions[n]]


SList[n_, k_]:=Map[s,Partitions[n, Rows->k]]


(* ::Section:: *)
(*Basic Commands : Partitions, Degrees, Coefficients, Etc.*)


(* ::Subsection:: *)
(*Partitions*)


ConjugateP[lambda_]:=Table[Count[lambda, x_/; (x>=i)], {i, lambda[[1]]}]


Unprotect[Partitions];
Options[Partitions] = {Rows->Infinity,Columns->Infinity};
Partitions[n_,opts__] := Module[{rows,cols,partitions},
rows=Rows /.{opts}/.Options[Partitions];
cols=Columns /.{opts}/.Options[Partitions];
partitions=Partitions[n];
Select[partitions,((Length[#]<=rows)&&(#[[1]]<=cols))& ]
];
Protect[Partitions];


(* ::Subsection:: *)
(*Degrees in a polynomial*)


MonDegrees[f_, varlist_] := Module[{temp, temp2},
temp = CoefficientList[f,varlist];
temp2 = Position[temp,x_/;(x=!= 0),{Length[Dimensions[temp]]},Heads->False]-1;
Sort[Map[Apply[Plus,#]&,temp2]//Union, Greater]
]


XDegrees[f_]:=Module[{f1},
f1=Expand[f];
If[Head[f1]===Plus, 
Sort[Map[Apply[Plus, #]&,Map[XDegrees, Level[f1, 1]]]//Union, Greater],
If[Head[f1]===Times, Apply[Plus, Map[XDegrees, Level[f1, 1]]],
If[Head[f1]===Power, {Level[f1, 2][[-1]]},
If[Head[f1]===x, {1}, {0}]
]
]
]
]


SDegrees[f_]:= Module[{f1}, 
f1=Expand[f];
If[Head[f1]===Plus, Sort[Map[Apply[Plus, #]&,( Level[f, 1]/.{Times[_, s[l__]]->{l}, s[l__]->{l},Select[f1,Element[#,Reals]&]->{0}})]//Union, Greater],
If[Head[f1]===Times, {Apply[Plus, (f1/.{Times[_, s[l__]]->{l}, s[l__]->{l}})]},
If[Head[f1]===s,{Apply[Plus, Level[f1, 1]]}, {0}]
]
]
]


MDegrees[f_]:= Module[{f1}, 
f1=Expand[f];
If[Head[f1]===Plus, Sort[Map[Apply[Plus, #]&,( Level[f, 1]/.{Times[_, m[l__]]->{l}, m[l__]->{l},Select[f1,Element[#,Reals]&]->{0}})]//Union, Greater],
If[Head[f1]===Times, {Apply[Plus, (f1/.{Times[_, m[l__]]->{l}, m[l__]->{l}})]},
If[Head[f1]===m,{Apply[Plus, Level[f1, 1]]}, {0}]
]
]
]


EDegrees[f_]:=Module[{f1},
f1=Expand[f];
If[Head[f1]===Plus, DeleteCases[Sort[Map[Apply[Plus, #]&,Map[EDegrees, Level[f1, 1]]]//Union, Greater], -1],
If[Head[f1]===Times, Apply[Plus, Map[EDegrees, Level[f1, 1]]],
If[Head[f1]===Power, {Level[f1, 2][[1]]*Level[f1, 2][[-1]]},
If[Head[f1]===e, Level[f1, 1], {0}]
]
]
]
]


HDegrees[f_]:=Module[{f1},
f1=Expand[f];
If[Head[f1]===Plus, DeleteCases[Sort[Map[Apply[Plus, #]&,Map[HDegrees, Level[f1, 1]]]//Union, Greater], -1],
If[Head[f1]===Times, Apply[Plus, Map[HDegrees, Level[f1, 1]]],
If[Head[f1]===Power, {Level[f1, 2][[1]]*Level[f1, 2][[-1]]},
If[Head[f1]===h, Level[f1, 1],{0}]
]
]
]
]


PDegrees[f_]:=Module[{f1},
f1=Expand[f];
If[Head[f1]===Plus, DeleteCases[Sort[Map[Apply[Plus, #]&,Map[PDegrees, Level[f1, 1]]]//Union, Greater], -1],
If[Head[f1]===Times, Apply[Plus, Map[PDegrees, Level[f1, 1]]],
If[Head[f1]===Power, {Level[f1, 2][[1]]*Level[f1, 2][[-1]]},
If[Head[f1]===p, Level[f1, 1], {0}]
]
]
]
]


(* ::Subsection:: *)
(*Coefficients*)


GetCoefficients[expr_, varlist_]:=Table[((Coefficient[Expand[expr], varlist[[i]]])/._[_]->0), {i, 1, Length[varlist]}]


(* ::Subsection:: *)
(*Symmetry tests, symmetrization*)


Unprotect[SymmetricQ];
SymmetricQ[poly_,x_,n_]:=Module[{vars,k,ans=True},
vars=Table[x[k],{k,n}];
For[k=1,k<=Length[vars]-1,k++,
If[Expand[poly-(poly/.{vars[[k]]->vars[[k+1]],vars[[k+1]]->vars[[k]]})]=!=0,ans=False;Break[]];];
ans];
Protect[SymmetricQ];


Symmetrizee[f_,x_,n_] := Module[{sum=0,sn},  (*在原来的基础上加了e*)
sn = Permutations[Range[n]];
Do[
sum = sum + (f/. Table[x[i]-> x[sn[[j,i]]],{i,n}]), {j,n!}];
sum
]



(* ::Subsection:: *)
(*Restrict number of variables*)


Options[Restrict]={Bases->{H, E, P, S, M, X}}
Restrict[f_, n_, opts___]:=Module[{f1=Expand[f],bases, degs, i},
bases=Bases/.{opts}/.Options[Restrict];
If[MemberQ[bases, H],
degs=DeleteCases[HDegrees[f1], 0];
If[degs=!={},
For[i=1, i<=Length[degs], i++, f1=f1/.HRestrictionRules[degs[[i]], n]]
];
];
If[MemberQ[bases, P],
degs=DeleteCases[PDegrees[f1], 0];
If[degs=!={},
For[i=1, i<=Length[degs], i++, f1=f1/.PRestrictionRules[degs[[i]], n]]
];
];
If[MemberQ[bases, M],
f1=f1/.(m[l__]/;Length[{l}]>n)->0
];
If[MemberQ[bases, S],
f1=f1/.(s[l__]/;Length[{l}]>n)->0
];
If[MemberQ[bases, E],
f1=f1/.(e[a_]/;a>n)->0
];
If[MemberQ[bases, X],
f1=f1/.(x[a_]/;a>n)->0
];
f1//Expand
]


(* ::Section:: *)
(*Matrices*)


(* ::Subsection:: *)
(*JTH, JTE : Jacobi-Trudi Matrices*)


jfunh[lambda_, i_, j_]:=Module[{k},   (*private*)
k=lambda[[i]]+(j-i);
If[k>0,h[k], If[k==0, 1,0]]
]


JTH[lambda_] := Table[jfunh[lambda, i, j], {i, 1, Length[lambda]}, {j,1, Length[lambda]}]


jfune[lambda_, i_, j_]:=Module[{k},   (*private*)
k=lambda[[i]]+(j-i);
If[k>0,e[k], If[k==0, 1,0]]
]


JTE[lambda_] := Table[jfune[ConjugateP[lambda], i, j], {i, 1, lambda[[1]]}, {j,1, lambda[[1]]}]


(* ::Subsection:: *)
(*K, KInv,KStar,KTr : Kostka matrices*)


K[n_] := KStar[n]//Inverse//Transpose


K[n_, k_]:=KStar[n, k]//Inverse//Transpose


KInv[n_]:=KStar[n]//Transpose


KInv[n_, k_]:=KStar[n,k]//Transpose


KTr[n_]:=KStar[n]//Inverse


KTr[n_, k_]:=KStar[n, k]//Inverse


KStar[n_]:=Module[{i, parlist},
parlist=Partitions[n];
Table[GetCoefficients[sh[parlist[[i]]], HList[n]], {i,1,PartitionsP[n]}]
]


KStar[n_, k_]:=Module[{i, parlist},
parlist=Partitions[n, Rows->k];
Table[GetCoefficients[sh[parlist[[i]]], HList[n, k]], {i, 1, Length[parlist]}]
]


(* ::Subsection:: *)
(*Chi, ChiInv : Character matrices*)


ChiInv[n_]:=GetCoefficients[Map[SToP,SList[n]],PList[n]]
Chi[n_]:=Inverse[ChiInv[n]]


(* ::Subsection:: *)
(*J (transposition matrix), SToEMat, EToSMat, HToH2Mat, H2ToHMat (special matrices for restricted variable situations)*)


J[n_]:= Module[{parlist,i, j},
parlist=Partitions[n];
Table[If[ConjugateP[parlist[[i]]]==parlist[[j]], 1, 0], {i, 1, PartitionsP[n]}, {j, 1, PartitionsP[n]}]
]


SToEMat[n_, k_]:=Module[{i, parlist},
parlist=Partitions[n,Rows->k];
Table[GetCoefficients[se[parlist[[i]]], EList[n, k]], {i, 1, Length[parlist]}]
]


EToSMat[n_, k_]:=SToEMat[n, k]//Inverse


HToH2Mat[deg_, var_]:=Table[GetCoefficients[HList[deg, var][[i]]/.HRestrictionRules[deg, var], HList2[deg, var]], {i, 1, Length[HList[deg, var]]}]


H2ToHMat[deg_, var_]:=HToH2Mat[deg, var]//Inverse


(* ::Subsection:: *)
(*Other matrices: PEMat, PHMat, EPMat, EHMat, HPMat, HEMat *)


pfune[ i_, j_]:=If[i-j>=0,If[j==1, i*e[i], e[i-j+1]], If[i-j==-1, 1, 0]] (*private*)


PEMat[n_] := Table[pfune[i, j], {i, 1, n}, {j,1, n}]


pfunh[ i_, j_]:=If[i-j>=0,If[j==1, i*h[i], h[i-j+1]], If[i-j==-1, 1, 0]]  (*private*)


PHMat[n_] := Table[pfunh[i, j], {i, 1, n}, {j,1, n}]


EPMat[n_] := Table[If[i-j>=0, p[i-j+1], If[i-j==-1, i, 0]], {i, 1, n}, {j, 1 , n}]


EHMat[n_] := Table[If[j-i>=0, h[-i+j+1], If[j-i==-1, 1, 0]], {i, 1, n}, {j, 1 , n}]


HPMat[n_] := Table[If[i-j>=0, p[i-j+1], If[i-j==-1,- i, 0]], {i, 1, n}, {j, 1 , n}]


HEMat[n_] :=  Table[If[j-i>=0, e[-i+j+1], If[j-i==-1, 1, 0]], {i, 1, n}, {j, 1 , n}]


(* ::Section:: *)
(*Basis Conversions*)


(* ::Subsection:: *)
(*XTo[HEMPSAll]*)


(* ::Subsection:: *)
(*XToM *)


NumberOfVars[f_]:= Block[{k},
Max[Extract[f,Position[f,x[_]]]/. x[k_]->k]]


XToMRules[n_]:=XToMRules[n]=Module[{atab, pata},
atab=Table[Unique["a"], {n}];
pata=Map[Optional[Pattern[#, Blank[]]]&, atab];
If[n==0, {x[_]->0},
Flatten[Append[{(x[j_]/;j>n)->0, c_. Product[(x[i]^pata[[i]]), {i, 1, n}]/;(Apply[GreaterEqual, Table[atab[[i]], {i, 1, n}]]//Evaluate)->c m[Table[atab[[i]], {i, 1, n}]]}, XToMRules[n-1]]]
]
]


XToM[f_]:=Expand[f]/.XToMRules[NumberOfVars[f]]/.{x[_]->0}


(* ::Subsection:: *)
(*XTo[Others]*)


XToH[f_] := MToH[f//XToM,Vars->NumberOfVars[f]]
XToE[f_] := MToE[f//XToM,Vars->NumberOfVars[f]]
XToP[f_] := MToP[f//XToM,Vars->NumberOfVars[f]]
XToS[f_] := MToS[f//XToM,Vars->NumberOfVars[f]]
XToAll[f_] := MToAll[f//XToM,Vars->NumberOfVars[f]]


(* ::Subsection:: *)
(*STo[HEMPXAll]*)


(* ::Subsection:: *)
(*SToH*)


Options[SToH]={DegreeList->{}, Vars->0};
SToH[f_, opts___] := Module[{i, degs, n1},
n1=Vars/.{opts}/.Options[SToH];
If[n1== 0, Expand[(Expand[f]/.s->sh)],
degs=DegreeList/.{opts}/.Options[SToH];
If[degs==={}, degs=SDegrees[f]];
Expand[Expand[(Expand[f]/.s->sh)]/.Flatten[Table[HRestrictionRules[degs[[i]], n1], {i, 1, Length[degs]}]]]
]
]


(* ::Subsection:: *)
(*SToE *)


Options[SToE]={DegreeList->{}, Vars->0};SToE[f_, opts___] := Module[{n1},
n1=Vars/.{opts}/.Options[SToE];
If[n1==0, Expand[(Expand[f]/.s->se)],
Expand[(Expand[f]/.s->se)]/.{(e[a_]/;a>n1)->0}]
]


(* ::Subsection:: *)
(*SToM*)


Options[SToM]={DegreeList->{}, Vars->0};SToM[f_, opts___] := Module[{i,degs, n1},
degs= DegreeList/.{opts}/.Options[SToM];
n1=Vars/.{opts}/.Options[SToM];
If[degs==={}, degs=SDegrees[f]];
degs=DeleteCases[degs,0];
If[n1== 0,Plus[Expand[f]/.s[__]->0,Sum[Dot[Dot[GetCoefficients[f, SList[degs[[i]]]],K[degs[[i]]]], MList[degs[[i]]]], {i, 1, Length[degs]}]],Plus[Expand[f]/.s[__]->0,Sum[Dot[Dot[GetCoefficients[f, SList[degs[[i]], n1]],K[degs[[i]], n1]], MList[degs[[i]], n1]], {i, 1, Length[degs]}]]]
]


(* ::Subsection:: *)
(*SToP*)


Options[SToP]={DegreeList->{}, Vars->0};SToP[f_,opts___]:= Module[{n1},
n1=Vars/.{opts}/.Options[SToP];
If[n1== 0,EToP[SToE[f]],
EToP[SToE[f], opts]]
]


(* ::Subsection:: *)
(*SToX*)


SToX[f_,n_]:=Expand[f]//.{s->sh, h[k_]->h0[k, n]}//Expand


(* ::Subsection:: *)
(*SToAll *)


Options[SToAll]={Targets->{E,P,H,M, X}, Vars->0};SToAll[f_,opts___]  := Module[{targets,out={f}, n},
targets =  Targets/.{opts}/.Options[SToAll];
n=Vars/.{opts}/.Options[SToAll];
If[n==0,
If[MemberQ[targets,E],AppendTo[out,SToE[f]]];
If[MemberQ[targets,H],AppendTo[out,SToH[f]]];
If[MemberQ[targets,P],AppendTo[out,SToP[f]]];
If[MemberQ[targets,M],AppendTo[out,SToM[f]]];,
(* else *)
If[MemberQ[targets,E],AppendTo[out,SToE[f, Vars->n]]];
If[MemberQ[targets,H],AppendTo[out,SToH[f, Vars->n]]];
If[MemberQ[targets,P],AppendTo[out,SToP[f, Vars->n]]];
If[MemberQ[targets,M],AppendTo[out,SToM[f, Vars->n]]];
If[MemberQ[targets,X],AppendTo[out,SToX[f, n]]];
];
out
]


(* ::Subsection:: *)
(*PTo[HEMSXAll]*)


(* ::Subsection:: *)
(*PRestrictionRules *)


PRestrictionRules[deg_, var_]:=PRestrictionRules[deg, var]=Module[{pl=PList[deg], plr=PList[deg, var]},
Table[pl[[i]]->EToP[PToE[pl[[i]], Vars->var]], {i, 1, Length[pl]}]
]


(* ::Subsection:: *)
(*PToH *)


Options[PToH]={DegreeList->{}, Vars->0};PToH[f_, opts___]:=Module[{n1, degs, i},
n1=Vars/.{opts}/.Options[PToH];
If[n1==0, Expand[(Expand[f]/.p->ph)], 
(*else*)
 degs= DegreeList/.{opts}/.Options[PToH];
If[degs==={}, degs=PDegrees[f]];
Expand[Expand[(Expand[f]/.p->ph)]/.Flatten[Table[HRestrictionRules[degs[[i]], n1], {i, 1, Length[degs]}]] ]
]
]


(* ::Subsection:: *)
(*PToE *)


Options[PToE]={DegreeList->{}, Vars->0};PToE[f_, opts___]:=Module[{n1},
n1=Vars/.{opts}/.Options[PToE];
If[n1==0, Expand[(Expand[f]/.p->pe)], 
Expand[(Expand[f]/.p->pe)]/.{(e[a_]/;a>n1)->0}]
]


(* ::Subsection:: *)
(*PToM*)


Options[PToM]={DegreeList->{}, Vars->0};PToM[f_, opts___]:=HToM[PToH[f], opts]


(* ::Subsection:: *)
(*PToS*)


Options[PToS]={DegreeList->{}, Vars->0};PToS[f_,opts___]:= EToS[PToE[f], opts]


(* ::Subsection:: *)
(*PToX *)


PToX[f_, n_]:=Expand[f]/.p[k_]->px[{k}, n]//Expand 


(* ::Subsection:: *)
(*PToAll *)


Options[PToAll]={Targets->{E,H,S,M, X}, Vars->0};PToAll[f_,opts___]  := Module[{targets,out={f}, n},
targets =  Targets/.{opts}/.Options[PToAll];
n=Vars/.{opts}/.Options[PToAll];
If[n==0,
If[MemberQ[targets,E],AppendTo[out,PToE[f]]];
If[MemberQ[targets,H],AppendTo[out,PToH[f]]];
If[MemberQ[targets,S],AppendTo[out,PToS[f]]];
If[MemberQ[targets,M],AppendTo[out,PToM[f]]];,
(* else *)
If[MemberQ[targets,E],AppendTo[out,PToE[f, Vars->n]]];
If[MemberQ[targets,H],AppendTo[out,PToH[f, Vars->n]]];
If[MemberQ[targets,S],AppendTo[out,PToS[f, Vars->n]]];
If[MemberQ[targets,M],AppendTo[out,PToM[f, Vars->n]]];
If[MemberQ[targets,X],AppendTo[out,PToX[f, n]]];
];
out
]


(* ::Subsection:: *)
(*MTo[HEPSXAll]*)


(* ::Subsection:: *)
(*MToH*)


Options[MToH]={DegreeList->{}, Vars->0};MToH[f_, opts___] :=Module[{i, degs, n1,f1,h1},
degs= DegreeList/.{opts}/.Options[MToH];
n1=Vars/.{opts}/.Options[MToH];
f1=Expand[f];
If[degs==={}, degs=MDegrees[f1]];
degs=DeleteCases[degs,0];
h1=Plus[f1/.m[__]->0,Sum[Dot[Dot[GetCoefficients[f1, MList[degs[[i]]]],Dot[KInv[degs[[i]]], KStar[degs[[i]]]]], HList[degs[[i]]]], {i, 1, Length[degs]}]];
If[n1== 0,h1,h1/.HRestrictionRules[degs[[1]],n1]//Expand
]
]


(* ::Subsection:: *)
(*MToE*)


Options[MToE]={DegreeList->{}, Vars->0}; MToE[f_, opts___] := Module[{i, degs, n1,f1},
degs= DegreeList/.{opts}/.Options[MToE];
n1=Vars/.{opts}/.Options[MToE];
f1=Expand[f];
If[degs==={}, degs=MDegrees[f1]];
degs=DeleteCases[degs,0];
If[n1== 0,Plus[f1/.m[__]->0,Sum[Dot[Dot[GetCoefficients[f1, MList[degs[[i]]]],Dot[KInv[degs[[i]]], Dot[J[degs[[i]]], KStar[degs[[i]]]]]], EList[degs[[i]]]], {i, 1, Length[degs]}]],Plus[f1/.m[__]->0,
Sum[Dot[Dot[GetCoefficients[f1, MList[degs[[i]], n1]],Dot[KInv[degs[[i]], n1], SToEMat[degs[[i]], n1]]], EList[degs[[i]], n1]], {i, 1, Length[degs]}]] ]
]


(* ::Subsection:: *)
(*MToP*)


Options[MToP]={DegreeList->{}, Vars->0};MToP[f_, opts___]:=HToP[MToH[f], opts]


(* ::Subsection:: *)
(*MToS*)


Options[MToS]={DegreeList->{}, Vars->0}; MToS[f_, opts___] :=Module[{i, degs, n1,f1},
degs= DegreeList/.{opts}/.Options[MToS];
n1=Vars/.{opts}/.Options[MToS];
f1=Expand[f];
If[degs==={}, degs=MDegrees[f1]];
degs=DeleteCases[degs,0];
If[n1== 0,Plus[f1/.m[__]->0,Sum[Dot[Dot[GetCoefficients[f1, MList[degs[[i]]]],KInv[degs[[i]]]], SList[degs[[i]]]], {i, 1, Length[degs]}]],Plus[f1/.m[__]->0,
Sum[Dot[Dot[GetCoefficients[f1, MList[degs[[i]], n1]],KInv[degs[[i]], n1]], SList[degs[[i]], n1]], {i, 1, Length[degs]}]] ]
]


(* ::Subsection:: *)
(*MToX*)


MToX[f_,n_]:= Module[{mtemp,f1},
f1=(f/. m[seq__]->mtemp[{seq},n])/.mtemp->mx;
Expand[f1]
]


(* ::Subsection:: *)
(*MToAll*)


Options[MToAll]={Targets->{E,P,S,H, X}, Vars->0};MToAll[f_,opts___]  := Module[{targets,out={f}, n},
targets =  Targets/.{opts}/.Options[MToAll];
n=Vars/.{opts}/.Options[MToAll];
If[n==0,
If[MemberQ[targets,E],AppendTo[out,MToE[f]]];
If[MemberQ[targets,P],AppendTo[out,MToP[f]]];
If[MemberQ[targets,S],AppendTo[out,MToS[f]]];
If[MemberQ[targets,H],AppendTo[out,MToH[f]]];,
(* else *)
If[MemberQ[targets,E],AppendTo[out,MToE[f, Vars->n]]];
If[MemberQ[targets,P],AppendTo[out,MToP[f, Vars->n]]];
If[MemberQ[targets,S],AppendTo[out,MToS[f, Vars->n]]];
If[MemberQ[targets,H],AppendTo[out,MToH[f, Vars->n]]];
If[MemberQ[targets,X],AppendTo[out,MToX[f, n]]];
];
out
]


(* ::Subsection:: *)
(*ETo[HMPSXAll] *)


(* ::Subsection:: *)
(*EToH *)


Options[EToH]={DegreeList->{}, Vars->0}; EToH[f_, opts___] := Module[{i, n1, degs},
n1=Vars/.{opts}/.Options[EToH];
If[n1== 0,Expand[(Expand[f]/.e->eh)],
(*else*)
 degs= DegreeList/.{opts}/.Options[EToH];
If[degs==={}, degs=EDegrees[f]];
Expand[Expand[(Expand[f]/.e->eh)]/.Flatten[Table[HRestrictionRules[degs[[i]], n1], {i, 1, Length[degs]}]]]
]
]


(* ::Subsection:: *)
(*EToM *)


 Options[EToM]={DegreeList->{}, Vars->0};EToM[f_, opts___] := Module[{i, n1, degs,f1},
n1=Vars/.{opts}/.Options[EToM];
degs=DegreeList/.{opts}/.Options[EToM];
f1=Expand[f];
If[degs==={}, degs=Select[EDegrees[f1],#>0&]];
If[n1== 0,Plus[f1/.e[__]-> 0,Sum[Dot[Dot[GetCoefficients[f1, EList[degs[[i]]]],Dot[KTr[degs[[i]]], Dot[J[degs[[i]]], K[degs[[i]]]]]], MList[degs[[i]]]], {i, 1, Length[degs]}]],Plus[f1/.e[__]->0, 
Sum[Dot[Dot[GetCoefficients[f1, EList[degs[[i]], n1]],Dot[EToSMat[degs[[i]], n1], K[degs[[i]], n1]]], MList[degs[[i]], n1]], {i, 1, Length[degs]}]] ]
]


(* ::Subsection:: *)
(*EToP *)


Options[EToP]={DegreeList->{}, Vars->0}; EToP[f_, opts___] := Module[{i, n1, degs},
n1=Vars/.{opts}/.Options[EToP];
If[n1== 0,Expand[(Expand[f]/.e->ep)],
(*else*)
 degs= DegreeList/.{opts}/.Options[EToP];
If[degs==={}, degs=EDegrees[f]];
Expand[Expand[(Expand[f]/.e->ep)]/.Flatten[Table[PRestrictionRules[degs[[i]], n1], {i, 1, Length[degs]}]]]
]
]


(* ::Subsection:: *)
(*EToS *)


Options[EToS]={DegreeList->{}, Vars->0};EToS[f_, opts___] :=  Module[{i, n1, degs,f1},
n1=Vars/.{opts}/.Options[EToS];
degs= DegreeList/.{opts}/.Options[EToS];
f1=Expand[f];
If[degs==={}, degs=Select[EDegrees[f1],#>0&]];
If[n1== 0,Plus[f1/.e[__]->0,Sum[Dot[Dot[GetCoefficients[f1, EList[degs[[i]]]],Dot[KTr[degs[[i]]], J[degs[[i]]]]], SList[degs[[i]]]], {i, 1, Length[degs]}]],Plus[f1/.e[___]->0, 
Sum[Dot[Dot[GetCoefficients[f1, EList[degs[[i]], n1]],EToSMat[degs[[i]], n1]], SList[degs[[i]], n1]], {i, 1, Length[degs]}]] ]
]


(* ::Subsection:: *)
(*EToX*)


EToX[f_, n_] :=  Expand[f]/.e[l_]->e0[l, n]//Expand


(* ::Subsection:: *)
(*EToAll *)


Options[EToAll]={Targets->{H,P,S,M, X}, Vars->0};EToAll[f_,opts___]  := Module[{targets,out={f}, n},
targets =  Targets/.{opts}/.Options[EToAll];
n=Vars/.{opts}/.Options[EToAll];
If[n==0,
If[MemberQ[targets,H],AppendTo[out,EToH[f]]];
If[MemberQ[targets,P],AppendTo[out,EToP[f]]];
If[MemberQ[targets,S],AppendTo[out,EToS[f]]];
If[MemberQ[targets,M],AppendTo[out,EToM[f]]];,
(* else *)
If[MemberQ[targets,H],AppendTo[out,EToH[f, Vars->n]]];
If[MemberQ[targets,P],AppendTo[out,EToP[f, Vars->n]]];
If[MemberQ[targets,S],AppendTo[out,EToS[f, Vars->n]]];
If[MemberQ[targets,M],AppendTo[out,EToM[f, Vars->n]]];
If[MemberQ[targets,X],AppendTo[out,EToX[f, n]]];
];
out
]


(* ::Subsection:: *)
(*HTo[EMPSXAll]*)


(* ::Subsection:: *)
(*HRestrictionRules *)


HRestrictionRules[deg_, var_]:=HRestrictionRules[deg, var]=Module[{hl=HList[deg], hlr=HList[deg, var]},
Table[hl[[i]]->EToH[HToE[hl[[i]], Vars->var]], {i, 1, Length[hl]}]
]


(* ::Subsection:: *)
(*HToE *)


Options[HToE]={DegreeList->{}, Vars->0};HToE[f_, opts___] :=  Module[{n1},
n1=Vars/.{opts}/.Options[HToE];
If[n1== 0,Expand[(Expand[f]/.h->he)],
 Expand[(Expand[f]/.h->he)]/.{(e[a_]/;a>n1)->0}]
]


(* ::Subsection:: *)
(*HToM *)


Options[HToM]={DegreeList->{}, Vars->0};HToM[f_, opts___] := Module[{i, n1, degs,f1},
n1=Vars/.{opts}/.Options[HToM];
degs= DegreeList/.{opts}/.Options[HToM];
f1=Expand[f];
If[degs==={}, degs=Select[HDegrees[f1],#>0&]];
If[n1== 0,Plus[f1/.h[__]->0,Sum[Dot[Dot[GetCoefficients[f1, HList[degs[[i]]]],Dot[KTr[degs[[i]]],K[degs[[i]]]]], MList[degs[[i]]]], {i, 1, Length[degs]}]],Plus[f1/.h[__]->0, 
Sum[Dot[Dot[Dot[GetCoefficients[Expand[f1/.HRestrictionRules[degs[[i]], n1]], HList2[degs[[i]], n1]], H2ToHMat[degs[[i]], n1]],Dot[KTr[degs[[i]], n1],K[degs[[i]], n1]]], MList[degs[[i]], n1]], {i, 1, Length[degs]}]] ]
]


(* ::Subsection:: *)
(*HToP*)


Options[HToP]={DegreeList->{}, Vars->0};HToP[f_, opts___] := Module[{i, n1, degs},
n1=Vars/.{opts}/.Options[HToP];
If[n1== 0,Expand[(Expand[f]/.h->hp)],
(*else*)
 degs= DegreeList/.{opts}/.Options[HToP];
If[degs==={}, degs=HDegrees[f]];
Expand[Expand[(Expand[f]/.h->hp)]/.Flatten[Table[PRestrictionRules[degs[[i]], n1], {i, 1, Length[degs]}]]]
]
]


(* ::Subsection:: *)
(*HToS *)


Options[HToS]={DegreeList->{}, Vars->0};HToS[f_, opts___] := Module[{i, n1, degs,f1},
n1=Vars/.{opts}/.Options[HToS];
degs= DegreeList/.{opts}/.Options[HToS];
f1=Expand[f];
If[degs==={}, degs=Select[HDegrees[f1],#>0&]];
If[n1== 0,Plus[f1/.h[__]->0,Sum[Dot[Dot[GetCoefficients[f1, HList[degs[[i]]]],KTr[degs[[i]]]], SList[degs[[i]]]], {i, 1, Length[degs]}]],Plus[f1/.h[__]->0, 
Sum[Dot[Dot[Dot[GetCoefficients[Expand[f1/.HRestrictionRules[degs[[i]], n1]], HList2[degs[[i]], n1]], H2ToHMat[degs[[i]], n1]],KTr[degs[[i]], n1]], SList[degs[[i]], n1]], {i, 1, Length[degs]}]]
]
]


(* ::Subsection:: *)
(*HToX*)


HToX[f_, n_]:=Expand[f]/.h[k_]->h0[k, n]//Expand


(* ::Subsection:: *)
(*HToAll *)


Options[HToAll]={Targets->{E,P,S,M, X}, Vars->0};HToAll[f_,opts___]  := Module[{targets,out={f}, n},
targets =  Targets/.{opts}/.Options[HToAll];
n=Vars/.{opts}/.Options[HToAll];
If[n==0,
If[MemberQ[targets,E],AppendTo[out,HToE[f]]];
If[MemberQ[targets,P],AppendTo[out,HToP[f]]];
If[MemberQ[targets,S],AppendTo[out,HToS[f]]];
If[MemberQ[targets,M],AppendTo[out,HToM[f]]];,
(* else *)
If[MemberQ[targets,E],AppendTo[out,HToE[f, Vars->n]]];
If[MemberQ[targets,P],AppendTo[out,HToP[f, Vars->n]]];
If[MemberQ[targets,S],AppendTo[out,HToS[f, Vars->n]]];
If[MemberQ[targets,M],AppendTo[out,HToM[f, Vars->n]]];
If[MemberQ[targets,X],AppendTo[out,HToX[f, n]]];
];
out
]


(* ::Section:: *)
(*Miscellaneous*)


(* ::Subsection:: *)
(*LR*)


Yamanouchi[t_] := Table[Position[t,i][[1,1]],{i,Length[Flatten[t]]}]


Tableaux2[list_List]:=If[list!={1},Tableaux[list],{{{1}}}]


LatticePerms[type_] := Map[Yamanouchi,Tableaux2[type]]


SumFirstJ[lambda_,mu_,j_] := Sum[lambda[[i]]-mu[[i]],{i,j}]


SkewShapeX[lambda_,mu_]:= Module[{j},
Table[PadRight[Table[x[i],{i,SumFirstJ[lambda,mu,j-1]+lambda[[j]]-mu[[j]],SumFirstJ[lambda,mu,j-1]+1,-1}],lambda[[1]],0,mu[[j]]],{j,Length[lambda]}]
]


XLattice[nu_List]:=Module[{perms=LatticePerms[nu]},
Table[x[i]->perms[[j,i]],{j,Length[perms]},{i,Apply[Plus,nu]}]]


AllNonNegQ[list_] := Apply[And,Map[NonNegative,list]]


AllGreaterEqual[list1_,list2_] := If[Length[list1]<Length[list2],False,
AllNonNegQ[list1-PadRight[list2,Length[list1]]]]


MuFitPartitions[n_Integer,mu_List] := Module[{par=Partitions[n]},
Select[Table[If[Length[par[[j]]]>=Length[mu]&&AllGreaterEqual[par[[j]],mu],par[[j]]],{j,1,Length[par]}],AllNonNegQ]
]


SChoices[mu_List,nu_List]:=Module[{lambdasize=Apply[Plus,mu]+Apply[Plus,nu]},
Map[Apply[s,#]&,MuFitPartitions[lambdasize,mu]]
]


Pad[mu_,n_]:=PadRight[mu,n]


AllSkewShapeX[lambdasize_Integer,mu_List]:=Module[{tpart=MuFitPartitions[lambdasize,mu]},
Table[SkewShapeX[tpart[[i]],Pad[mu,Length[tpart[[i]]]]],{i,Length[tpart]}]]


SSTQ[tab_] := Module[{rowsQ,colsQ},
rowsQ=Apply[And,Map[Apply[LessEqual,Select[#,Positive]]&,tab]];
colsQ=Apply[And,Map[Apply[Less,Select[#,Positive]]&,tab//Transpose]];
rowsQ&&colsQ
]


AllSkewShapeLattice[mu_,nu_]:=
Module[{lambdasize=Apply[Plus,mu]+Apply[Plus,nu],temp},
temp=AllSkewShapeX[lambdasize,mu];
Table[temp[[i]]/.XLattice[nu],{i,Length[temp]}]]


SelectSSTCases[mu_,nu_]:=
Module[{largelist=AllSkewShapeLattice[mu,nu]},
Table[Select[largelist[[i]],SSTQ],{i,Length[largelist]}]]


CoeffLambdas[mu_,nu_]:= Map[Length,SelectSSTCases[mu,nu]]


LRProduct[mu_,nu_] := CoeffLambdas[mu,nu].SChoices[mu,nu]


s[x__]s[y__]^:=LRProduct[{x},{y}]


Unprotect[Plus];
n_(s[x__]+s[y__])^:=n*s[x]+n*s[y]
Protect[Plus];


s[x__]^n_^:=Apply[Times,Table[s[x],{n}]]//Expand


(* ::Subsection:: *)
(*Pieri*)


(*Helper functions for Pieri*)
incr[lam_,set_] :=Module[{temp=lam}, Map[(temp[[#]]++)&,set];temp]
DecreasingQ[lambda_]:= Apply[GreaterEqual, lambda]
AddByRows[par_,k_] := Module[{pp,sets,raw, temp},
pp =Join[par,Table[0,{k}]];
sets = KSubsets[Range[Length[pp]],k];
raw=Table[incr[pp,sets[[i]]],{i,Length[sets]}];
temp=Select[raw, DecreasingQ];
Map[Select[#,Positive]&,temp]
]


Pieri[lambda_,k_]:=
Map[ConjugateP,AddByRows[ConjugateP[lambda],k]]//Union
SMult[lambda_,n_]:=
Apply[Plus,Map[s,Pieri[lambda,n]]]
