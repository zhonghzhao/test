(*Startup*)


Off[General::spell]
Off[General::spell1]

BeginPackage["Posets`"];


(* ::Subsection:: *)
(*Usage / Help Commands*)


(* Usage:: Standard poset definitions *)

Sets::usage = "Sets[n_] defines the poset of subsets
of an n-element set, ordered by containment.";

Subwords::usage = "Subwords[w_] defines the poset of 
subwords of a word w.";

SetP::usage = "SetP[n_] defines the poset of partitions of 
an n-element set, ordered by refinement. Notation: partitions
are represented by listing, for each element, the smallest
element in its block.";

NonXP::usage = "NonXP[n_] defines the poset of non-crossing
partitions of an n-element set, ordered by refinement.";

WeakS::usage = "WeakS[n_] defines the left weak order on the
symmetric group on n elements.  Coverings correspond to
transpositions of adjacent increasing pairs.";

RWeakS::usage = "RWeakS[n_] defines the right weak order on the
symmetric group on n elements.  Coverings correspond to
transpositions of pairs i and i+1.";

StrongS::usage = "StrongS[n_] defines strong (Bruhat) order
on the symmetric group of n elements."; 

Divv::usage="Divv[N] defines the poset of divisors of
the integer N.";    (*加了v*)

NumP::usage = "NumP[N_] defines the poset of partitions of the 
integer N, ordered by refinement.";

YoungsLattice::usage = "YoungsLattice[lambda] defines 
Young's Lattice for the partition lambda, i.e., the poset of 
partitions whose Ferrers diagram fits into that of lambda."; 

Ferrers::usage = "Ferrers[lambda] defines a Ferrers diagram
poset of shape lambda."; 

MajP::usage = "MajP[N] defines the poset
of partitions of an integer N, ordered by majorization.";

SPM::usage = "SPM[N] defines the poset
of sandpiles generated from a sandpile with inital height n.
It is the majorization ordering without the horizontal rule";

L::usage = "L[N,\[Theta]] defines the poset created with the following
rule- A grain can  move from column i to the column i + 1 if
the height difference between the two columns is at least equal to \[Theta].";

Chain::usage = "Chain[N] defines a chain with N elements";

Antichain::usage="Antichain[N] defines an antichain with
N elements";

ZigZag::usage="ZigZag[N] defines a zigzag poset with 
N elements";

RandomP::usage="RandomP[N,p] defines a random poset with
N elements, generating related pairs with probability p 
and taking the transitive closure.";

ContractionLattice::usage = "ContractionLattice[{list of edges},N] 
defines the lattice of contractions of a graph G with N
vertices.";

PosetP::usage = "PosetPp[name] defines the poset whose 
elements are partitions of Pp[name] into a chains.
The partitions are ordered by refinement. Build should be 
applied next. Input may be in any of the three standard forms." ; (*加了p*)

JofP::usage = "JofPp[name] returns the poset of order ideals
of Pp[name]. Output is in {f,minlist,H} form, and Build should be 
applied next. Input may be in any of the three standard forms." ;

(* Usage:: Commands *)

Build::usage = "Build[{coverfunction,min,height},name],
Build[matrix,name], or Build[{relations,card},name}] 
generate the fundamental objects P, Rank, and CoverRelations 
for the poset 'name'.  If <name> is omitted, a unique name of 
the form Poset1, Poset2, etc is generated.";

Pp::usage = "Pp[name] is a list of the elements in poset 'name'.";

Rank::usage = "Rank[name][[x]] is the rank of Pp[name][[x]].";

CoverRelations::usage = "CoverRelations[name] is a list of 
the cover relations in Pp[name].  Pair {a,b} is present 
if the bth element of Pp[name] covers the ath element.";

PGraded::usage = "PGraded[name][[k]] is a list of the elements 
at rank k in Pp[name].";

PGradedIndices::usage = "PGradedIndices[name][[k]] is a list of the indices
of elements at rank k in Pp[name].";

Card::usage = "Card[name] is the cardinality of Pp[name].";

NK::usage = "NK[name][[k]] is the number of elements 
at rank k in Pp[name].";

Hh::usage = "Hh[name] is the height of Pp[name]."; (*加了h*)

RankedQ::usage = "RankedQ[name] tests to see if a poset has a 
rank function (r(x)=r(y)+1 if x covers y). If unranked, it 
defines (or redefines) the objects Rank, P, PGraded, NK, and 
H using length of longest descending chain as rank.";

StrongRankedQ::usage = "StrongRankedQ[name] tests to see if a ranked
poset is strongly ranked, i.e. all minimal elements have rank zero.";

RGF::usage = "RGF[name] is the rank generating function
for Pp[name], represented as a polynomial in q.";

SortByRanks::usage = "SortByRanks[name] reorders the elements 
at each rank of Pp[name] in lexicographic order.";

ChangeLabel::usage = "ChangeLabel[name,lab,num] will set Labels[name][[num]] to lab.
If lab is set as Original, the label will be returned to its orginal form.
ChangeLabel[name, function, i] will map the given function onto Labels[name][[i]].";

ResetLabel::usage = "ResetLabel[name, num] with return the num-th label 
to its original form. ";

Compact::usage="Compact[w] returns a string corresponding to the 
list w.  ChangeLabel[name,Compact] is used to produce a more readable
display.";

(*Diagram2::usage = "Diagram2[name, y, opts, stretchv, movereg, stretchh, \
ptthickness, linethickness, jigbool, specialright, specialup, \
labelleft, labelup] is an internal function that is called by Diagram.";*)

Diagram::usage = "Diagram[name] draws the Hasse diagram of 
Pp[name].  Diagram[name,points,links,options] shows the diagram 
with special points and links highlighted. Options include 
ShowLabels, and Manipulate.";

SavedSettings::usage="SavedSettings[name] returns the saved settings
of the manipulate command from the last time they were saved";  

SaveOne::usage="SaveOne[name,i,x] saves the item x in position i of
SavedSettings. Need to make it public for technical reasons (use in Button).";  

ShowLabels::usage = "ShowLabels -> False (default) causes 
element labels to be suppressed  in the diagram.";

Background1::usage = "Option for Diagram.";

Background2::usage = "Option for Diagram.";

CleanRank::usage = "CleanRank -> True (default) causes 
ranks to be cleaned up during execution of Diagram.";

Labels::usage = "Labels[name] returns the list of labels assigned to poset; name";

MaxAntichain::usage =  "MaxAntichain[name] is a list of the 
indices of elements in a maximum-sized antichain in Pp[name]";

DilworthCover::usage = "DilworthCover[name] is a list of 
links in a minimum-sized chain covering of Pp[name]."; 

Fuse::usage = "Fuse[links] assembles links into chains (if 
possible)";

ZetaP::usage = "ZetaPp[name] is the incidence matrix of Pp[name].";

Mu::usage = "Mu[name] is the Mobius matrix of Pp[name]
(i.e., the inverse of ZetaP).";

Ups::usage = "Ups[name][[x]] is a list of the elements 
greater than or equal to Pp[name][[x]].";

Downs::usage = "Downs[name][[x]] is a list of the elements 
less than or equal to Pp[name][[x]].";

StrictUps::usage = "StrictUps[name][[x]] is a list of the elements 
strictly greater than or equal to Pp[name][[x]].";

StrictDowns::usage = "StrictDowns[name][[x]] is a list of the 
elements strictly less than or equal to Pp[name][[x]].";

Covers::usage="Covers[name][[x]] is a list of
the elements covering Pp[name][[x]].";

CoCovers::usage="CoCovers[name][[x]] is a list
of the elements covered by Pp[name][[x]].";

UpDegree::usage="UpDegree[name][[x]] is the number of 
elements covering Pp[name][[x]].";

DownDegree::usage="DownDegree[name][[x]] is the number of 
elements covered by Pp[name][[x]].";

MaximalChainsDown::usage = "MaximalChainsDown[name][[x]] is the
number of maximal chains descending from Pp[name][[x]].";

MaximalChainsUp::usage = "MaximalChainsUp[name][[x]] is the
number of maximal chains ascending from Pp[name][[x]].";

ChainsBetweenGF::usage = "ChainsBetweenGF[name,a,b] is a 
generating function (in q) which enumerates (by length) the
chains from a to b in Pp[name].";

LongestChain::usage = "LongestChain[links,N] returns a list 
showing the length of the longest chain terminating in each element.
Assumes <links> is an acyclic relation.";

ZetaPoly::usage = "ZetaPoly[name,a,b,n] gives the Zeta polynomial
of the interval [a,b], i.e., the number of multichains
a=x_0 <= x_1 <= ... <= x_n = b with endpoints a and b.  
ZetaPoly[name,n] gives the Zeta polynomial of the poset Pp[name], 
i.e., the number of multichains x_1 <= x_2 <= ... <= x_(n-1)."; 

CharPoly::usage = "CharPoly[name,q] is the characteristic 
polynomial (= generalized chromatic polynomial) of Pp[name], 
using the variable q.";

LatticeQ::usage = "LatticeQ[name] returns True if Pp[name] is 
a lattice, and False otherwise.";

IntervalQ::usage = "Interval[name, indicies] returns True if the list
of indicies define an interval.";

OrderIdealQ::usage = "OrderIdealQ[name_, indices_] returns True if the
list of indicies define an order ideal. i.e. x in S, y<x implies y in S";

DualOrderIdealQ::usage = "DualOrderIdealQ[name_, indices_] returns True if the
list of indicies define a dual order ideal. i.e. x in S, y>x implies y in S";

OrderIdeal::usage = "OrderIdeal[name_, indices_] returns the set of
indices corresponding to the order ideal generated a set";

DualOrderIdeal::usage = "DualOrderIdeal[name_, indices_] returns the set of
indices corresponding to the dual order ideal generated by a set";

OrderIdeals::usage="OrderIdeals[name] returns a list of
all order ideals of Pp[name].";

DualOrderIdeals::usage="DualOrderIdeals[name] returns a list of
all dual order ideals of Pp[name].";

MaxElements::usage="MaxElements[name,indices] returns a list of
indices of maximal elements corresponding to a set of indices .";

MinElements::usage="MaxElements[name,indices] returns a list of
indices of minimal elements corresponding to a set of indices .";

DistributiveLatticeQ::usage = "DistributiveLatticeQ[name] returns 
True if Pp[name] is a distributive lattice, and False otherwise.";  

JoinL::usage="JoinL[name,x,y] returns the lattice-join of x and y.
Input and output are labels, not indices.";

MeetL::usage="MeetL[name,x,y] returns the lattice-meet of x and y.
Input and output are labels, not indices.";

LJoin::usage = "LJoin[name] is the join table for Pp[name], 
i.e., LJoin[name][[a,b]] is the join of Pp[name][[a]] and 
Pp[name][[b]].";

LMeet::usage = "LMeet[name] is the meet table for Pp[name],
i.e., LMeet[name][[a,b]] is the meet of Pp[name][[a]] and 
Pp[name][[b]].";

JoinSubLatticeQ::usage = "JoinSubLatticeQ[name,S] returns 
True if the elements in Pp[name] indexed by S form a join
sublattice.";

MeetSubLatticeQ::usage = "MeetSubLatticeQ[name,S] returns 
True if the elements in Pp[name] indexed by S form a meet
sublattice.";

SubLatticeQ::usage = "SubLatticeQ[name,S] returns True if 
the elements in Pp[name] indexed by S form a sublattice.";

JI::usage = "JI[name] is a list of the join irreducibles of
Pp[name], assumed to be a lattice.";

MI::usage = "MI[name] is a list of the meet irreducibles of
Pp[name], assumed to be a lattice.";

ZetaJI::usage = "ZetaJI[name] is the zeta-matrix of the poset
of join-irreducibles of Pp[name].";

ZetaMI::usage = "ZetaMI[name] is the zeta-matrix of the poset
of meet-irreducibles of Pp[name].";

JICoverRelations::usage = "JICoverRelations[name] is the list 
of coverings in the poset of join irreducibles of Pp[name].";

MICoverRelations::usage = "MICoverRelations[name] is the list 
of coverings in the poset of meet irreducibles of Pp[name]."; 

LinearExtensions::usage="LinearExtensions[name] is a list
of linear extensions of Pp[name]. (Can take a long time!)";



TopSortings::usage="TopSortings[name] is a list
of linear extensions of Pp[name]. (Can take a long time!)";

ToRelation::usage = "ToRelation[matrix] returns the list of
related pairs defined by a 0-1 matrix.";

ToMatrix::usage = "ToMatrix[relation,n] returns the incidence 
matrix (of order n) corresponding to a set of related pairs.";

G::usage= "G[name,q] is the rational generating 
function (in q) whose nth coefficient equals the number of 
Pp[name]-partitions of n.";

GBar::usage= "GBar[name,q] is the rational generating 
function (in q) whose nth coefficient equals the number of 
strict Pp[name]-partitions of n.";

Omega::usage= "Omega[name,n] is the order polynomial
of Pp[name], i.e., the function (of n) which counts order-
preserving maps from Pp[name] into an n-element chain.";

OmegaBar::usage= "OmegaBar[name,n] is the strict order 
polynomial of Pp[name], i.e., the function (of n) which counts 
strict order-preserving maps from Pp[name] into an n-element 
chain";

OmegaGF::usage= "OmegaGF[name,q] is the rational generating
function (of q) whose coefficients are defined by Omega[name,n].";

OmegaBarGF::usage= "OmegaBarGF[name,q] is the rational 
generating function (of q) whose coefficients are defined by 
OmegaBar[name,n].";

TopSort::usage = "TopSort[name] sorts and renumbers the 
elements of Pp[name] according to height, remaking Rank[name] 
and CoverRelations[name].";

TClosure::usage = "TClosure[relation,n] computes the transitive
closure and transitive reduction of the relation defined by 
{relation,n}. Returns a pair {matrix,relation}, where <matrix> is 
the incidence matrix of the closure and <relation> is a list of
irredundant pairs.";

IsomorphiccQ::usage="IsomorphiccQ[name1,name2] returns False
if posets P[name1] and P[name2] fail certain isomorphism tests,
and 'Probably' if all tests are passed.";

GetIsomorphism::usage="Isomorphism[name1, name2] returns an isomorphism between
the two posets.  This command should only be run after testing if two posets
are isomorphic (by using the IsomorphiccQ command)";

LocateElement::usage = "Locate[name,element] returns
the index in Pp[name] of the given element.";

LocateSet::usage = "LocateSet[name,set] returns
a list of indices corresponding to the positions in Pp[name] 
of the elements in <set>.";

SpecialPoints::usage = "SpecialPoints[name,function] returns
a list of indices corresponding to the positions in Pp[name] 
for which the function returns True.";

Ver::usage= "Returns current version number.";

ListCommands::usage = "ListCommands[] lists all of the commands
defined by the Poset package.  ListCommands[<string>] lists all of 
the commands that contain  <string>.";

NumPosets::usage = "NumPosets[n] returns the number of 
non-isomorphic posets of size n for any n <= 7. This command
assumes that the file allposets1-7 has been read in.";

NumLattices::usage = "NumLattices[n] returns the number of
non-isomorphic lattices of size n for any n <= 9. This command
assumes that the file alllattices1-9 has been read in.";

Zap::usage = "Zap[name] removes all remembered all values
of objects associated with <name>.";

(* Usage:: Operations for combining posets *)

CProduct::usage= "CProduct[name1,name2]
defines the Cartesian product of P[name1] and P[name2]. Output 
is in {relation,card} form, and Build should be applied next.
Input may be in any of the three standard forms.";

DisjointSum::usage= "DisjointSum[name1,name2]
defines the disjoint sum of P[name1] and P[name2]. Output is
in {relation,card} form, and Build should be applied next.
Input may be in any of the three standard forms.";

OrdinalSum::usage= "OrdinalSum[name1,name2]
defines the ordinal sum of P[name1] and P[name2]. Output is
in {relation,card} form, and Build should be applied next.
Input may be in any of the three standard forms.";

BuildSubPoset::usage= "SubPoset[name,points,subposetname]
defines the subposet of Pp[name] induced by <points>. It 
builds the subposet with the given subposetname. If no name is 
given, it creates a unique name. Input may be in any of the three standard forms. 
<points> may be either a list of indices or a Boolean function which defines 
those indices.";

IntervalP::usage= "IntervalP[name,bottom,top] defines the interval 
subposet [bottom,top] in Pp[name]. The two endpoints should be 
labels, not indices. Output is a list of indices. Apply SubPoset 
next, then Build.";

JoinSubLattice::usage = "JoinSubLattice[name,S] returns the join 
sublattice of Pp[name] generated by S. Both input and output
are sets of indices. Apply SubPoset next, then Build.";

MeetSubLattice::usage = "MeetSubLattice[name,S] returns the meet 
sublattice of Pp[name] generated by S. Both input and output
are sets of indices. Apply SubPoset next, then Build.";

SubLattice::usage = "SubLattice[name,S] returns the  
sublattice of Pp[name] generated by S. Both input and output
are sets of indices. Apply SubPoset next, then Build.";

BuildDual::usage= "BuildDual[posetname, dualname] returns the dual 
of Pp[name]. This function will actually build the dual poset 
and relabel it with the original labels in Pp[name]. Input may 
be in any of the three standard forms.";

CP::usage= "Abbreviation for CProduct.";

DS::usage="Abbreviation for DisjointSum.";

OS::usage="Abbreviation for OrdinalSum.";

SP::usage="Abbreviation for SubPoset.";

JSL::usage="Abbreviation for JoinSubLattice.";

MSL::usage="Abbreviation for MeetSubLattice.";

SL::usage="Abbreviation for SubLattice.";

(* Usage:: Miscellaneous combinatorics *)

InversionCode::usage="InversionCode[sigma] returns the 
inversion coding of sigma (ith element = # inversions (i>x) 
in sigma)."; 

ToPermutation::usage="ToPermutation[alpha] returns the
permutation with inversion code alpha.";

TensorProductt::usage= "TensorProductt[M,N] computes the
tensor product of two matrices M and N.";  (*加了t*)

(*InversePermutation::usage= "InversePermutation[p] gives the
inverse permutation of p.";*)

DES::usage= "DES[sigma] returns the number of descents of 
permutation sigma";

ASC::usage= "ASC[sigma] returns the number of ascents of 
permutation sigma";

MAJ::usage= "MAJ[sigma] returns the major index of
permutation sigma";

AMAJ::usage= "AMAJ[sigma] returns the major (ascent) 
index of permutation sigma";

GFToPoly::usage="GFToPoly[w(q),q,d,n] returns the polynomial 
coefficient f(n) of q^n in the rational generating 
function w(q)/(1-q)^(d+1)";

PolyToGF::usage="PolyToGF[f,x,q] returns the rational 
generating function w(q)/(1-q)^(d+1) whose coefficients are 
given by f(x).";

ZeroDiffs::usage="ZeroDiffs[sequence] returns a list whose kth
element is the (k-1)st difference at 0 of the sequence.";

InfiniteProduct::usage="Computes infinite product representation
of an ordinary generating function.";

GenFun::usage="GenFun[L,q] makes a generating function where 
the coefficient of q^k is the number of times k appears in 
list L.";

AllTableaux::usage="AllTableaux[lambda] generates a list of all tableaux
of shape lambda whose entries are a permutation of 1...n .";

STableaux::usage="STableaux[lambda] generates a list of all standard
tableaux of shape lambda. Stableaux[n] generates all tableaux
with n cells.";

Tabify::usage="Tabify[list,lambda] makes a list into a tableaux of shape
lambda.";

NewLabel::usage="NewLabel[name, label] adds a new label to Labels[name]. 
NewLabel[name, function, i] is also valid; it will map the given function onto 
label i and then add the results to Labels[name]. If no i is specified then
it will default to label 1. ";
             
Silent::usage="Silent = False (default) prints occasional comments. True 
suppresses most printing.";


(* ::Subsection::Closed:: *)
(*Begin Private Portion*)


Begin["`Private`"]


(* ::Subsection:: *)
(*Standard Poset Definitions*)


Sets[n_]:= {NextString[#,n]&,{{}},n};
NextString[w_,n_]:= Module[{outlist = {}},
	Map[Union,
		Do[
			If[MemberQ[w,j]==False,
			AppendTo[outlist, Join[w,{j}]]],{j,n}];
		outlist]
	];


Subwords[w_]:= {Substring,{w},Length[w]};
Substring[w_]:= Substring[w]= 
     Union[Table[Drop[w,{j,j}],{j,Length[w]}]]


Divv[n_] := {Divides[#,n]&,{1},n}  ;                    
Divides[d_,n_] := Module[{},
      Select[d Select[Divisors[n],PrimeQ],(Mod[n,#]==0)&]];


SetP[n_]:= {SetRefine, {Range[n]},n-1} ;                     
SetRefine[w_] := Block[
   {outlist={},i,j},
    Do[If[w[[i]]==i,
         Do[If[w[[j]]==j,
             outlist = Append[outlist,
             MapAt[w[[i]]&,w,Position[w,w[[j]]] ] ]              
          ],{j,i+1,Length[w]}
         ]
       ],{i,Length[w]}];
    outlist      
  ]                       


NonXP[n_]:= {NonXPRefine, {Array[#&,n]},n-1}  ;                     
NonXPRefine[w_] := Block[
  {outlist={},i,j,trial},
   Do[If[w[[i]]==i,
       Do[If[w[[j]]==j,
        trial = MapAt[w[[i]]&,w,Position[w,w[[j]]] ];
        If[NonCrossing[trial],
             outlist = Append[outlist,trial]
        ]
        ],{j,i+1,Length[w]}
       ]
      ],{i,Length[w]}];
   outlist      
];                      
NonCrossing[{___,x_,___,y_,___,x_,___,y_,___}] := 
					False /; x!=y
NonCrossing[{___}] := True


WeakS[n_] := {WeakOrder,{Array[#&,n]},Binomial[n,2]}  ;                    
WeakOrder[w_] := Block[
  {outlist={},i,j},
  Do[If[w[[i]]<w[[i+1]],
       AppendTo[outlist,
          Insert[Drop[w,{i}],w[[i]],i+1]]],
  {i,Length[w]-1}];
  outlist      
];


RWeakS[n_] := {RWeakOrder,{Array[#&,n]},Binomial[n,2]}; 
                   
RWeakOrder[w_] := Block[
  {outlist={},i,j},
  Do[If[Position[w,i][[1,1]]<Position[w,i+1][[1,1]],
       AppendTo[outlist,
          w/. {i->i+1,i+1->i}
          ]],
  {i,Length[w]-1}];
  outlist      
];


StrongS[n_] := {StrongOrder,{Array[#&,n]},Binomial[n,2]}  ;                    
StrongOrder[w_] := Block[
     {outlist={},i,j,trial},
     Do[If[w[[i]]<w[[j]],trial=w;
         trial[[i]]=w[[j]];
         trial[[j]]=w[[i]];
         If[okstrong[w,i,j],AppendTo[outlist,trial]]],
     {i,Length[w]-1},{j,i+1,Length[w]}];
     outlist      
];
okstrong[w_,i_,j_] := Block[
  {between=Take[w,{i+1,j-1}]},
   (Intersection[between,Range[w[[i]],w[[j]]]]=={})
   ];


YoungsLattice[partition_List]:= {Young[#, partition]&,{ Table[0,{i,Length[partition]}]}, 
     Apply[Plus,partition]}
                    
Young[w_,part_]:= Module[
{outlist = {}},
	Do[ If[(i==1 || w[[i]]<w[[i-1]])&& w[[i]]<part[[i]],
	AppendTo[outlist, ReplacePart[w,i->w[[i]]+1]]] ,{i, Length[w]}]; 
outlist
]      


Ferrers[shape_] := {UpFerrers[#,shape]&,{{1,1}},Apply[Plus,shape]}
UpFerrers[{a_,b_},shape_] := Module[{out={},len=Length[shape]},
   If[b+1<= shape[[a]],AppendTo[out,{a,b+1}]];
   If[(a<len)&&(b<= shape[[a+1]]),AppendTo[out,{a+1,b}]];
   out];


MajP[n_]:={Majorize,{Table[1,{i, n}]},n^2}   
    
Conj[part_] := Conj[part]=If[Length[part]>0, Join[{Length[part]}, Conj[ Map[#-1&, Select[part,#>1&]]]],{}]

Majorize[w_]:= Map[Conj,Majorize2[Conj[w]]]

Majorize2[w_] :=  Block[
   {i,j,outlist,temp,pp,q},
   outlist = {};
   Do[temp = Append[w,0];
    If[temp[[j+1]]<temp[[j]],
       If[temp[[j+1]]<temp[[j]]-1,
           temp[[j]]=temp[[j]]-1;
           temp[[j+1]]=temp[[j+1]]+1;
           temp=If[Last[temp]==0,
                Drop[temp,-1],temp];
           AppendTo[outlist,temp],
         (*else*)
           pp = Position[temp,temp[[j]]-2];
           If[pp!={},
             q=pp[[1,1]];
             temp[[j]]=temp[[j]]-1;
             temp[[q]]=temp[[q]]+1;
             temp=If[Last[temp]==0,
                  Drop[temp,-1],temp
             ];
             AppendTo[outlist,temp]
           ]   
      ]
    ],
  {j,Length[w]}];
  Union[outlist]      
 ]     
Adjust[j_,w_]:= Module[{t=w},
	 t[[j]]=w[[j]]-1;
        
	t[[j+1]]= w[[j+1]]+1; 
t]


SOrder[w_]:=Module[{outlist={},i},
If[w[[-1]]>=2,
 AppendTo[outlist, Join[Drop[w,-1], Join[{w[[-1]]-1}, {1}]]]];
Do[
If[w[[i]]-w[[i+1]]>1&& w[[i]]>0 ,
AppendTo[outlist,Adjust[i,w]]],
{i,Length[w]-1}];
outlist
]

SPM[n_] := {SOrder,{{n}},n^4}; 


LOrder[w_, \[Theta]_]:=Module[{outlist={},i},Do[
If[w[[i]]-w[[i+1]]>=\[Theta]&& w[[i]]>0 ,
AppendTo[outlist,Adjust[i,w]]],
{i,Length[w]-1}];
outlist]

Llist[n_]:= Prepend[Array[0&,n-1],n];

L[n_, \[Theta]_] := {LOrder[#,\[Theta]]&,{Llist[n]},n^4}; 


Chain[n_] := {Table[{i,i+1},{i,n-1}],n}  ;                 

Antichain[n_] := {{},n}  ;   


ZigZag[n_] := 
 {Table[If[OddQ[i],{i,i+1},{i+1,i}],{i,n-1}],n}  ;                 

RandomP[n_,p_] := 
Table[If[i<j,If[Random[]<p,1,0],0],
    {i,n},{j,n}];               


NumP[n_] := {NumberRefine,{Table[1,{n}]},n-1}  ;                 
NumberRefine[w_] := Block[{out={},i,j,temp,len=Length[w]},
  Do[temp=Append[Drop[Drop[w,{j}],{i}],w[[i]]+w[[j]]]//Sort;
     AppendTo[out,temp],{i,1,len},{j,i+1,len}];
  Union[out]       
]           


ContractionLattice[edges_,n_] := {contract[edges,#]&,{Range[n]},n-1};
contract[edges_,g_] := Block[{outlist={},i,j,k,low,high},
  Do[
  {low,high} = Sort[{g[[edges[[k,1]]]],g[[edges[[k,2]]]]}]; 
		  outlist = Append[outlist,
		     MapAt[low&,g,Position[g,high]]],
   {k,Length[edges]}
 ];
 outlist
]


PosetP[name_] := 
 Block[{},
  (*internal function: can two chains merge? *)
  canmergeQ[namea_,c1_,c2_] := 
   Block[{i,j,check=True},
     For[i=1, check && i<=Length[c1], i++, 
      For[j=1, check && j<=Length[c2], j++, 
          check=MemberQ[Downs[namea][[Max[{c1[[i]],c2[[j]]}]]],
                         Min[{c1[[i]],c2[[j]]}]]
         ]
        ];
     check
    ];                      
  (*covering function*)
  PosRefine[w_] := 
   Block[{outlist={},check=True,i,j},
    Do[If[w[[i]]==i,
          Do[If[w[[j]]==j && canmergeQ[name,Flatten[Position[w,i]],
                                   Flatten[Position[w,j]]],
                AppendTo[outlist,MapAt[w[[i]]&,w,Position[w,w[[j]]]]]
               ],{j,i+1,Length[w]}
            ]
         ],{i,Length[w]}
      ];
     outlist      
    ];
  Return[{PosRefine,{Range[Card[name]]},Card[name]-1}]
 ]    


JofP[namea_] := Block[{in},     
     If[Head[namea]===Symbol,in=Transpose[ZetaP[namea]];
          up=Ups[namea]
     ];
     If[Head[namea]===List,
          If[MatrixQ[namea],
               in=Transpose[TClosure[namea][[1]]];
               up=Map[Flatten[Position[in[[i]],
                     1]],Range[Length[in]]],
               in=Transpose[TClosure[ToMatrix[namea[[1]],
                    namea[[2]] ]][[1]]];
               up=Map[Flatten[Position[in[[i]],
                     1]],Range[Length[in]]]
          ]
     ];
     PosetElements = Table[j, {j, Length[in]}]; 
     NextIdeals[w_] := Block[{i, PrincipalOrderIdeal, 
         NewPosetElements, output},
         PrincipalOrderIdeal[x_] := Complement[up[[x]], w]; 
         NewPosetElements = Complement[PosetElements, w]; 
         output = {}; 
         Do[  If[PrincipalOrderIdeal[
                   NewPosetElements[[i]]] ==
         	           {NewPosetElements[[i]]}, 
                   AppendTo[output,
                       Union[Append[w,
                       NewPosetElements[[i]] ]]
                   ]
              ], 
              {i, Length[NewPosetElements]}
          ]; 
          output
      ]; 

      Return[{NextIdeals,{{}},
          Card[namea]}]	
]	


(* ::Subsection:: *)
(*Constructing the Fundamental Objects (Build, etc.)*)


Build[{scan_, minlist_, hbound_Integer}, name_: automatic] :=
     
Block[{plist = minlist, links, scanned, coversi, i, r, k, pos,
            rank},
           If[name == automatic, name = Unique["Poset"]];
           Zap[name];
    SavedSettings[name]={};
           If[!Silent,Print["Building poset ", name, "  ..."]];
           links = {};
           rank = Map[0 &, plist];
           scanned = Map[False &, plist];
           i = 1; r = 0;
             
   While[(i <= Length[plist]) &&
                       (! 
       scanned[[i]]) && (rank[[i]] < hbound),        
                 If[r != rank[[-1]], 
                    r = rank[[-1]]];
                 coversi = scan[plist[[i]]];
                 scanned[[i]] = true;
                 Do[
                       If[  ! MemberQ[plist, coversi[[k]]],
                             AppendTo[plist, coversi[[k]]];
                             AppendTo[rank, rank[[i]] + 1];
                             AppendTo[scanned, False];
                             AppendTo[links, {i, Length[plist]}],
                         (*else*)
                             
      AppendTo[links,
                                   {i, Position[plist,
                                       coversi[[k]]][[1, 1]]}
                              ]
                         ],
                        {k, Length[coversi]}
                    ];
                   i = i + 1;
            ];
        Rank[name] = rank;
        CoverRelations[name] = links;
        Pp[name] = plist;
  Labels[name] = {plist , Range[Card[name]]}; (*added this for double labels*)
        
   If[! Apply[And, Map[(#[[1]] < #[[2]]) &, links]], 
             TSort1[name]];      
        If[!Silent,Print["Done"]]
   ];


Build[M_List,name_:automatic]:=
Block[{n=Length[M]},
     If[name==automatic,name=Unique["Poset"]];
     Zap[name];
SavedSettings[name]={};
     Card[name]=n;
  If[!Silent, Print["Building poset ",name,"  ..."]];
     CoverRelations[name]=ToRelation[M];
     TSort2[name]; 
     {ZetaPp[name],CoverRelations[name]}=TClosure[CoverRelations[name],n];
     Labels[name] = {Pp[name] , Range[Card[name]]};(*added this for double labels*)
    If[!Silent, Print["Done"]]
]


Build[{links_,card_Integer},name_:automatic]:=
Block[{n=card},
     If[name==automatic,name=Unique["Poset"]];
    If[!Silent, Print["Building poset ",name,"  ..."]];
     Zap[name];
SavedSettings[name]={};
     Card[name]=n;
     CoverRelations[name]=links;
     TSort2[name];
     Labels[name] = {Pp[name] , Range[Card[name]]}; (*added this for double labels*);
     {ZetaPp[name],CoverRelations[name]}=TClosure[CoverRelations[name],n];
    If[!Silent, Print["Done"]]
]


ToRelation[M_] := Position[M,1];


ToMatrix[L_,n_] := Block[{out=Array[0&,{n,n}]},
   Scan[(out[[#[[1]],#[[2]]]]=1)&,L];out];


LongestChain[links_,n_] := Block[
{out=Array[{}&,n],in=hts=Array[0&,n],min={},dlinks,
labeled=0,h=0,k},
update[k_]:= Scan[(in[[#]]--)&,out[[k]]];
dlinks=Select[links,First[#]!=Last[#]&];
Scan[in[[Last[#]]]++&,dlinks];
Scan[AppendTo[out[[First[#]]],Last[#]]&,dlinks];
While[labeled<n,
  Scan[(in[[#]]=-1)&,min];
  min=Flatten[Position[in,0]];
  Scan[
    (hts[[#]]=h;update[#]
     )&,min];
  labeled=labeled+Length[min];
  h=h+1;
  ];
hts
]


TClosure[links_List,n_]:= Block[{covers,a,k,j,
     outmatrix,reducedlinks,redundant={}},
    
     outmatrix=IdentityMatrix[n];
     covers=Array[{}&,n];
     Scan[(AppendTo[covers[[First[#]]],Last[#]])&,
           links];
     covers=Map[Union,covers];      
     
     doit[x_]:= Block[{},
       Scan[
         (If[outmatrix[[a,#]]==1,
             AppendTo[redundant,{a,#}],
             outmatrix[[a,#]]=1];)&,
               Flatten[Position[outmatrix[[x]],1]] 
       ]
     ];
     For[a=n,a>=1,a--,
          Scan[(doit[#])&,covers[[a]] ]
     ];
     reducedlinks=Complement[links,redundant];
     {outmatrix,reducedlinks}
]        


TopSort[links_,n_] := Block[{height},
     height=LongestChain[links,n];
     Return[Map[#[[2]]&,
          Sort[Table[{height[[i]],i},{i,n}]]]]  
    ];       

(* Internal procedure used by first Build command *)
TSort1[name_] := Block[{height,n=Card[name],permute,labelp},
     height=LongestChain[CoverRelations[name],n];
     labelp=Map[#[[2]]&,
          Sort[Table[{height[[i]],i},{i,n}]]];  
     Rank[name]=Sort[height];
     permute=Sort[Table[{labelp[[i]],i},{i,n}]];
     CoverRelations[name]=
          Map[{permute[[First[#],2]],permute[[Last[#],2]]}&,
               CoverRelations[name]
     ];
     Pp[name]=Map[Pp[name][[#]]&,labelp];
];       

(* Internal procedure used by last two Build Commands *)
TSort2[name_] := Block[{height,n=Card[name],permute},
     
     height=LongestChain[CoverRelations[name],n];
     Pp[name]=Map[#[[2]]&,
          Sort[Table[{height[[i]],i},{i,n}]]];  
     Rank[name]=Sort[height];
     permute=Sort[Table[{Pp[name][[i]],i},{i,n}]];
     CoverRelations[name]=
          Map[{permute[[First[#],2]],permute[[Last[#],2]]}&,
               CoverRelations[name]
     ];
];       


PGradedIndices[name_] := PGradedIndices[name] = Block[{},
    Table[
       Flatten[Position[Rank[name],k]],
       {k,0,Max[Rank[name]]}] 
    ];

PGraded[name_] := PGraded[name] = Block[{},
    Table[
       Pp[name][[PGradedIndices[name][[k]]]],
       {k,1,Max[Rank[name]]+1}] 
    ];


Card[name_] := Card[name] = Length[Pp[name]];


NK[name_] := NK[name] = Map[Length,PGraded[name]];


Hh[name_] := Hh[name] = Max[Rank[name]];


RGF[name_]:=RGF[name]=Apply[Plus,Global`q^Rank[name]];


(* ::Subsection:: *)
(*Diagramming Posets*)


(* ::Subsubsection::Closed:: *)
(*Functionality for Multiple Labels*)


ChangeLabel[name_,lab_,num_]:= Module[{newlab= Labels[name]}, 
If[lab === Original && num==1, 
	Labels[name] = {Pp[name], newlab[[2]]}; 
         Return[], (*else*)
If[lab === Original && num ==2, 
	Labels[name] = {newlab[[1]],  Range[Card[name]]};
Return[]]]; 
(*else*) 
If[Head[lab]===List,
If[num==0,
 AppendTo[newlab,lab],(*else*) 
	 newlab=ReplacePart[newlab,num->lab] ],(*else lab is a function*) 
   newlab=ReplacePart[newlab,num->Map[lab,Labels[name][[num]]]];
];
Labels[name] = newlab;
]


NewLabel[name_, lab_]:= Module[{},

If[Head[lab]===List,
ChangeLabel[name,lab,0],
ChangeLabel[name,Map[lab,Labels[name][[1]]],0]
]
];


NewLabel[name_, func_,i_]:= Module[{},
ChangeLabel[name,Map[lab,Labels[name][[i]]],0]
];


(* ::Subsubsection::Closed:: *)
(*SortByRanks*)


Compact[lab_] := Apply[StringJoin,Map[ToString,lab]];


SortByRanks[name_] := Block[{newp},
	PGraded[name] = Map[Sort,PGraded[name]];
	newp = Flatten[PGraded[name],1];
	CoverRelations[name] =
         Map[Position[newp,Pp[name][[#]]][[1,1]]&,CoverRelations[name],{2}];
	Pp[name] = newp;
	ChangeLabel[name, newp,1];
  ]


(* ::Subsubsection:: *)
(*RankedQ*)


Options[RankedQ] = {NoOutput ->False};
RankedQ[name_, opts___Rule]:= RankedQ[name] = 
Block[{vars,eqns,maxels,moreeqns,S,k,l,m,r,arank,
             rank=Rank[name],links=CoverRelations[name], quiet,mm,solvars,
          unsolv},

  quiet=NoOutput/.{opts}/.Options[RankedQ];

	maxrank=Max[rank];
	maxels=Flatten[Position[rank,maxrank]];
	vars=Table[r[l],{l,Card[name]}];
	eqns=Table[r[links[[m,1]]]==r[links[[m,2]]]-1,{m,Length[links]}];
 (* moreeqns = {r[First[maxels]]==maxrank};*)
	
 Off[Solve::svars];
	S=Solve[eqns,vars]; 
 On[Solve::svars];

Off[Unset::norep];
        If[S=={},(*no solutions*)
		PGraded[name]=.;PGradedIndices[name]=.;NK[name]=.;Rank[name]=.;Hh[name]=.;
		Rank[name]=LongestChain[CoverRelations[name],Card[name]];
	If[(Rank[name]!=rank)&&(Length[SavedSettings[name]]!=0),
                             SaveOne[name,7,Range[Length[NK[name]]]*0]];(*update sliderowlist*)
	Return[False],
        (*else solutions exist*) 
         solvars = Flatten[vars/.S];
         unsolv = Variables[solvars];
         If[unsolv!={},
              solvars = solvars /. Table[unsolv[[i]]->0,{i,Length[unsolv]}]];
         minr = Min[solvars];If[minr<0,solvars=solvars+Table[-minr,{Card[name]}]];
	         PGraded[name]=.;PGradedIndices[name]=.;NK[name]=.;Rank[name]=.;RGF[name]=.;Hh[name]=.;
         Rank[name]=solvars;   
	    ];
 On[Unset::norep];

   If[(Rank[name]!=rank)&&(Length[SavedSettings[name]]!=0),
                       SaveOne[name,7,Range[Length[NK[name]]]*0]];(* update sliderowlist*)

 Return[True]	
]

StrongRankedQ[name_] := StrongRankedQ[name] = Module[{templist={}, tranzeta= Transpose[ZetaPp[name]]} ,
 If[RankedQ[name],For[i=1, i<= Length[tranzeta],i++,
If[Count[tranzeta[[i]], 1] ==1, AppendTo[templist, i]]];Pp[name][[templist]] ==PGraded[name][[1]], False]]


(* ::Subsubsection:: *)
(*Diagram*)


SavedSettings[name_]:= {};
greene[x_] := Style[x,FontColor->Blue];
lalign[x_]:= Style[x,TextAlignment->Right]


Options[Diagram]={ShowLabels -> False, Manipulate->False, CleanRank->True,Background1->RGBColor[1,1,.5],Background2->White}; 
Diagram[name_Symbol,y___List,opts___Rule]:=Block[{manipulate,notyetsaved, spoints, slines, showlabels,slab,set,cleanrankq,sliderowlist,mvlab1={0,0},mvlab2={0,0}},

     manipulate = Manipulate/.{opts} /.Options[Diagram];
notyetsaved = SavedSettings[name]=={};
cleanrankq=CleanRank/.{opts}/.Options[Diagram];
showlabels = ShowLabels/.{opts} /.Options[Diagram];
{back1,back2}={Background1,Background2}/. {opts}/. Options[Diagram]; 

If[cleanrankq,RankedQ[name, NoOutput -> True]]; 
 sliderowlist=Range[Length[ NK[name]]]*0;      

 If[{y}=={},
         spoints={};slines={}, (* else *)
        If[Length[{y}] == 1,
                  If[!MatrixQ[y], spoints = {y}[[1]]; slines = {},
                                 spoints = {};  slines = {y}[[1]]], (*else*)
                 spoints = {y}[[1]]; slines = {y}[[2]]
              ]
        ];

(*SavedSettings: {spoints,slines,moveregularpts,pthickness,lthickness,stretchpts,
sliderowlist,movespecialpts,movelabel1,movelabel2,label1index,zoomvalue,cleanrankq,label2index}*)

If[notyetsaved,
 SavedSettings[name] ={spoints, slines,{0,0},.02,.0028,{0,0},
sliderowlist,{0,0},mvlab1,mvlab2,0,0,cleanrankq,0};,(*else*)
SavedSettings[name] = Drop[SavedSettings[name],2]; PrependTo[SavedSettings[name],slines];  
                                                 PrependTo[SavedSettings[name],spoints] ];

 If[manipulate===False, (*call regular diagram function*) 

     set=SavedSettings[name]; 

	   If[showlabels===True ,
			Diagram2[name,showlabels, set[[1]],set[[2]],set[[3]],set[[4]],set[[5]],set[[6]],
                               set[[7]],set[[8]],   set[[9]],set[[10]],set[[11]], set[[12]],cleanrankq,set[[14]]],(*else not True*)
	      If[showlabels===False,
			Diagram2[name,showlabels, set[[1]],set[[2]],set[[3]],set[[4]],set[[5]],set[[6]],
                           set[[7]],set[[8]],set[[9]],set[[10]],0, set[[12]],cleanrankq,0],
   If[Head[showlabels]===List,
      If[Length[showlabels]==2,
			            Diagram2[name,showlabels, set[[1]],set[[2]],set[[3]],set[[4]],set[[5]],set[[6]],
                           set[[7]],set[[8]],set[[9]],set[[10]],showlabels[[1]], set[[12]],cleanrankq,showlabels[[2]]],    
                           (*else only one label*)
    If[Length[showlabels]==1,
                   Diagram2[name,showlabels, set[[1]],set[[2]],set[[3]],set[[4]],set[[5]],set[[6]],
                           set[[7]],set[[8]],set[[9]],set[[10]],showlabels[[1]], set[[12]],cleanrankq,0]]],
    (* else must be a number *)
     Diagram2[name,showlabels, set[[1]],set[[2]],set[[3]],set[[4]],set[[5]],set[[6]],
                              set[[7]],set[[8]],set[[9]],set[[10]],showlabels, set[[12]],cleanrankq,0]]
]],

 (*else manipulate is True; there still might be saved settings*)

Diagram3[name,spoints, slines]
]
]



(* This module will allow for multiple manipulates to be up and running at the same time*)
Diagram3[name_, spoints_,slines_] :=Module[{InternalSettings,temp=1,mvlab1 = {0,0}, mvlab2={0,0}},

InternalSettings=Join[{name,spoints,slines},SavedSettings[name][[3;;14]]];
(*InternalSettings: {name,spoints,slines,moveregularpts,pthickness,lthickness,stretchpts,
sliderowlist,movespecialpts,movelabel1,movelabel2,label1index,zoomvalue,cleanrankq,label2index}*)

Panel[Grid[{{
TabView[{
"Shifts and Stretches"->Grid[{
{"Stretch",Slider2D[Dynamic[InternalSettings[[7]]],{{-.3,-.99},{.8,3}}]},
{"Shift",Slider2D[Dynamic[InternalSettings[[4]]],{{-.50,-4},{.50,4}}]},
{"Zoom", Slider[Dynamic[InternalSettings[[13]]],{-.8,.49}]},
{Button["Reset",{ InternalSettings[[7]]={0,0},InternalSettings[[4]]={0,0},InternalSettings[[13]] =0}, ImageSize->75,Appearance->Tiny],
Grid[{{Button["Save",{ SaveOne[name,6,InternalSettings[[7]]],SaveOne[name,3,InternalSettings[[4]]],SaveOne[name,12,InternalSettings[[13]]]}, ImageSize->75,Appearance->Tiny],
Button["Load",{InternalSettings[[7]]=SavedSettings[name][[6]];InternalSettings[[4]]=SavedSettings[name][[3]],InternalSettings[[13]]=SavedSettings[name][[12]]}, ImageSize->75,Appearance->Tiny]}}]
}
},
Alignment->{{Right,Left}}
],
"Special Points"->Grid[{
{"Special Points",Slider2D[Dynamic[InternalSettings[[9]]],{{-2,-2},{2,5}}]},
{Button["Reset",{ InternalSettings[[9]]={0,0}}, ImageSize->75,Appearance->Tiny],Grid[{{Button["Save",{ SaveOne[name,8,InternalSettings[[9]]]}, ImageSize->75,Appearance->Tiny], Button["Load",{ InternalSettings[[9]]= SavedSettings[name][[8]]}, ImageSize->75,Appearance->Tiny]}}]}
}],
"Points and Lines"->Grid[{
{"Point Thickness",Slider[Dynamic[InternalSettings[[5]]],{0,.04}]},
{"Line Thickness",Slider[Dynamic[InternalSettings[[6]]],{.0008,.008}]},
{"Slide Row",Panel[ Grid[ {
{SetterBar[Dynamic[temp],Range[Length[InternalSettings[[8]]]]]},
{Slider[Dynamic[InternalSettings[[8]][[temp]]],{-1,1}]},
{Button["Reset Row",InternalSettings[[8]][[temp]]=0],Button["Reset All",InternalSettings[[8]]=Range[Length[NK[name]]]*0]}}]]},
{"Recalculate Rank",RadioButton[Dynamic[InternalSettings[[14]]],True]},
{Button["Reset",{InternalSettings[[5]]=0.02,InternalSettings[[6]]=.0028,InternalSettings[[8]]=Range[Length[NK[name]]]*0}, ImageSize->75,Appearance->Tiny],
Grid[{{Button["Save",{ SaveOne[name,4,InternalSettings[[5]]],SaveOne[name,5,InternalSettings[[6]]],SaveOne[name,7,InternalSettings[[8]]],SaveOne[name,13,InternalSettings[[14]]]}, ImageSize->75,Appearance->Tiny], 
Button["Load",{InternalSettings[[5]]=SavedSettings[name][[4]],InternalSettings[[6]]=SavedSettings[name][[5]],InternalSettings[[8]]=SavedSettings[name][[7]],InternalSettings[[14]]=SavedSettings[name][[13]]}, ImageSize->75,Appearance->Tiny]}}]},
{"Note:","Recalculating the Rank might require rerunning the Diagram command afterwards."},
{ "","Remember to save the diagram first!"}},
Alignment->{{Right,Left}}
],
"Label Commands"->Grid[{
{"First Label Position",Slider2D[Dynamic[InternalSettings[[10]]],{{-.25,-1},{.25,1}}]},
{"Second Label Position",Slider2D[Dynamic[InternalSettings[[11]]],{{-.25,-1},{.25,1}}]}, {"First Label",SetterBar[Dynamic[InternalSettings[[12]]],Join[{0->"None"}, Range[Length[Labels[name]]]]]},
{"Second Label",SetterBar[Dynamic[InternalSettings[[15]]],Join[{0->"None"}, Range[Length[Labels[name]]]]]},
{Button["Compact",{ChangeLabel[name,Compact,1];InternalSettings[[6]]+=.00000001;},ImageSize->100, Appearance->Tiny],
Button["Reset",{ InternalSettings[[10]]={-.02,0},InternalSettings[[11]]={.015,0},InternalSettings[[12]]=0,InternalSettings[[15]]=0}, ImageSize->75,Appearance->Tiny],
Button["Save",{ SaveOne[name,9,InternalSettings[[10]]],SaveOne[name,10,InternalSettings[[11]]],SaveOne[name,11,InternalSettings[[12]]],SaveOne[name,14,InternalSettings[[15]]]}, ImageSize->75,Appearance->Tiny],
Button["Load",{InternalSettings[[10]]=SavedSettings[name][[9]],InternalSettings[[11]]=SavedSettings[name][[10]],InternalSettings[[12]]=SavedSettings[name][[11]],InternalSettings[[15]]=SavedSettings[name][[14]]}, ImageSize->75,Appearance->Tiny]}
}, Alignment ->{{Right,Left}}],
"Save and Reset"-> Grid[{
{Button["Save All",{ SavedSettings[name]= Delete[InternalSettings,1]}, ImageSize->100,Appearance->Tiny]},
{Button["Load All",{ InternalSettings=Join[{name,spoints,slines},SavedSettings[name][[3;;14]]]}, ImageSize->100,Appearance->Tiny]},
{Button["Reset All",{ InternalSettings=Join[{name,spoints,slines},{spoints, slines,{0,0},.02,.0028,{0,0},Range[Length[NK[name]]]*0,{0,0},mvlab1,mvlab2,0,0,False,0}[[3;;14]]];}, ImageSize->100,Appearance->Tiny]}
}]
}]
}
,{Panel[Dynamic[Diagram2[name,True,spoints,slines,InternalSettings[[4]],InternalSettings[[5]],InternalSettings[[6]],InternalSettings[[7]],InternalSettings[[8]],InternalSettings[[9]],InternalSettings[[10]],InternalSettings[[11]],InternalSettings[[12]],InternalSettings[[13]],InternalSettings[[14]],InternalSettings[[15]]]]]}}]]];


SaveOne[name_,i_,n_] := Module[{},
SavedSettings[name]= If[i!= 1 ,
If[i!=Length[SavedSettings[name]],SavedSettings[name]=Join[Append[SavedSettings[name][[1;;(i-1)]],n],SavedSettings[name][[(i+1);;Length[SavedSettings[name]]]]],
SavedSettings[name]=Append[SavedSettings[name][[1;;(i-1)]],n]],
SavedSettings[name]=Prepend[SavedSettings[name][[2;;Length[SavedSettings[name]]]],n]
];
]


OrderPoints[name_, list_] := OrderPoints[name] =
Module[{templist=Range[Card[name]], countlist=PGradedIndices[name]//Flatten,i}, 
For[i=1,i<= Card[name], i++,
templist[[countlist[[i]]]] = list[[i]]
]; templist]


Diagram2[name_Symbol,showlabels_, spoints_, slines_, movereg_List,ptthickness_,linethickness_,stretchreg_List,sliderowlist_,specialpts_,movelabelone_List, movelabeltwo_List,labelnumberone_, zoom_,cleanrankq_,labelnumbertwo_]:=Block[{
     r,i,covline,xy,dotobj,lineobj,labelobj,linethick,pointthick,templist,counter,
	 p=Pp[name],
	 nk=NK[name],
   cardp=Card[name],
	 links=CoverRelations[name],transform},

xy=Flatten[Table[Table[{(i+sliderowlist[[r]])/(nk[[r]]+1),r},{i,nk[[r]]}  ],{r,Hh[name]+1}],1];

    counter = 0; 

transform=  Flatten[
      Table[
	Table[
		counter += 1;
		 (*i is the the index of the element on a certain rank          *)
		(*k is the height*)
		If[spoints!= {} &&  MemberQ[spoints ,counter],
		(*if special pt, then...*) 
			{(((i-nk[[k]]/2-1/2)*stretchreg[[1]])+movereg[[1]]+specialpts[[1]]), (((k-Hh[name]/2-1)*stretchreg[[2]])+movereg[[2]]+specialpts[[2]])},    
		(*not special pt, else..*)
			{(((i-nk[[k]]/2-1/2)*stretchreg[[1]])+movereg[[1]]),(((k-Hh[name]/2-1)*stretchreg[[2]])+movereg[[2]])}],       
		{i,nk[[k]] }],
	{k, Hh[name]+1}
     ],1];

xy = xy +transform;   (*transform = Table[{right,up},{Length[xy]}];*)

If[cleanrankq&& RankedQ[name] &&!StrongRankedQ[name],
                                 templist = OrderPoints[name, xy];xy=templist];

     dotobj=Map[Point,xy];
	 covline[{$p1_,$p2_}]:= 
	      Line[{xy[[$p1]],xy[[$p2]]}];
	 lineobj=Map[covline,links]; 
	
labelobj=
If[labelnumberone !=0 &&labelnumbertwo==0,(*one label, #1*)
		        
  {Table[Text[Labels[name][[labelnumberone]][[i]],{xy[[i]][[1]]+movelabelone[[1]],xy[[i]][[2]]+movelabelone[[2]]}, 
                    {1.7,-1.5},Background->White],{i,cardp}]}, (*else*)

If[labelnumberone ==0 &&labelnumbertwo!=0, (*one label, #2*)

{Table[greene[Text[Labels[name][[labelnumbertwo]][[i]],{xy[[i]][[1]]+movelabeltwo[[1]],xy[[i]][[2]]+movelabeltwo[[2]]},
                {-1.7,-1.5},Background->White]],{i,cardp}]}, (*else*)

If[labelnumberone !=0 &&labelnumbertwo!=0, (*two labels*)
				(*first label*)
				 {Table[lalign[Text[Labels[name][[labelnumberone]][[i]],
							{xy[[i]][[1]]+movelabelone[[1]],xy[[i]][[2]]+movelabelone[[2]]},
								{1.7,-1.5},Background->back1]],{i,cardp}],
								(*second label*)
									Table[lalign[greene[Text[Labels[name][[labelnumbertwo]][[i]],
										{xy[[i]][[1]]+movelabeltwo[[1]],xy[[i]][[2]]+movelabeltwo[[2]]},
											{-2.7,-1.5},Background->back2]]],{i,cardp}]}, 
                       (*else default to label 1 and label 2*)
                       (*first label*)
				 {Table[lalign[Text[Labels[name][[1]][[i]],
							{xy[[i]][[1]]+movelabelone[[1]],xy[[i]][[2]]+movelabelone[[2]]},
								{1.7,-1.5},Background->back1]],{i,cardp}],
								(*second label*)
									Table[lalign[greene[Text[Labels[name][[2]][[i]],
										{xy[[i]][[1]]+movelabeltwo[[1]],xy[[i]][[2]]+movelabeltwo[[2]]},
											{-2.7,-1.5},Background->back2]]],{i,cardp}]}]
]
     ];

     specialps = Map[Point[xy[[#]]]&,spoints];
     specialels = Map[Line[{xy[[#[[1]] ]],xy[[#[[2]] ]]}]&,
          slines];
          
      linethick = (linethickness);  (*???*)
      pointthick =  (ptthickness);   (*???*)

If[labelnumberone + labelnumbertwo != 0,
Show[
Graphics[
{
    Thickness[linethick],
	PointSize[pointthick],
	lineobj,
	dotobj,
	PointSize[pointthick*1.5],
	RGBColor[0,0,1], 
	specialps,
	Thickness[linethick*4],
	RGBColor[.7,0,.5],
	specialels,
If[Length[labelobj]==1 , labelobj[[1]], {}],
If[Length[labelobj]==2 , {labelobj[[1]],labelobj[[2]]},{}]
	
}
],Background->White,
     PlotRange->{{0+zoom,1-zoom},
{0+zoom*(Hh[name]+2),Hh[name]+2-zoom*(Hh[name]+2)}},
     Frame->True,
     FrameTicks->None,
     ColorOutput->Automatic,
     AspectRatio->1/GoldenRatio,
ImageSize-> {500,309}],  (*else no labels *)

Show[
Graphics[
{Thickness[linethick],
PointSize[pointthick],
lineobj,
dotobj,
PointSize[pointthick*(1.5)],
RGBColor[0,0,1],
specialps,
Thickness[linethick*(4)],
RGBColor[.7,0,.5],
specialels}],
Background->White,
    PlotRange->{{0+zoom,1-zoom},
{0+zoom*(Hh[name]+2),Hh[name]+2-zoom*(Hh[name]+2)}},
    Frame->True,
    FrameTicks->None,
    ColorOutput->Automatic,
    AspectRatio->1/GoldenRatio,
ImageSize-> {500,309}]
]
]


(* ::Subsection:: *)
(*ZetaP, Mu, Ups, Downs, and Covers:*)


ZetaP[name_]:= ZetaPp[name] = Block[{covers,a,k,j,zetap,
     cardp,links},
     cardp=Card[name];
     links=CoverRelations[name];
     zetap=IdentityMatrix[cardp];
     covers=Array[{}&,cardp];
     Scan[(AppendTo[covers[[First[#]]],Last[#]])&,
           links];
     
     doit[x_]:= Block[{},
          Scan[(zetap[[a,#]]=1)&,
               Flatten[Position[zetap[[x]],1]] 
          ]
     ];
     For[a=cardp,a>=1,a--,
          Scan[(doit[#])&,covers[[a]] ]
     ];
     zetap
]        


Ups[name_]:= Ups[name] = Block[{j},
     Table[Flatten[Position[ZetaPp[name][[j]],1]],
          {j,Card[name]}
     ]
]

StrictUps[name_] := Map[Drop[#,1]&,Ups[name]]


Downs[name_] := Downs[name] = Block[{j,transpzeta=
     Transpose[ZetaPp[name]]},
     Table[Flatten[Position[transpzeta[[j]],1]],
          {j,Card[name]}
     ]
]

StrictDowns[name_] := Map[Drop[#,-1]&,Downs[name]]


Covers[name_] := Covers[name] = Block[{out},
  out=Array[{}&,Card[name]];
  Scan[(AppendTo[out[[First[#]]],Last[#]])&,
         CoverRelations[name]];
  out];


CoCovers[name_] := CoCovers[name] = Block[{out},
  out=Array[{}&,Card[name]];
  Scan[(AppendTo[out[[Last[#]]],First[#]])&,
         CoverRelations[name]];
  out];


UpDegree[poset_]:=Table[Count[CoverRelations[poset],{i,_}],
     {i,Card[poset]}]


DownDegree[poset_]:=Table[Count[CoverRelations[poset],{_,i}],
     {i,Card[poset]}]


Mu[name_] := Mu[name] = Inverse[ZetaPp[name]]


(* ::Subsection:: *)
(*Counting chains, Zeta polynomial, Order Polynomial, Linear Extensions, Order Ideals*)


MaximalChainsDown[name_] := MaximalChainsDown[name] =
Block[{a,num=Table[0,{Card[name]}], minlist, card=Card[name],
       links=CoverRelations[name]},
minlist=Complement[Range[card],Map[#[[2]]&,links]];
Do[If[MemberQ[minlist,a],num[[a]]=1],
  {a,card}];
Do[num[[links[[a,2]]]]=num[[links[[a,2]]]]+num[[links[[a,1]]]],
  {a,Length[links]}];
num
]


MaximalChainsUp[name_] := MaximalChainsUp[name] =
Block[{a,num=Table[0,{Card[name]}],maxlist, card=Card[name],
       links=CoverRelations[name]},
maxlist=Complement[Range[card],Map[#[[1]]&,links]];
Do[If[MemberQ[maxlist,a],num[[a]]=1],
  {a,card}];
For[a=Length[links],a>=1,a--,
num[[links[[a,1]]]]=num[[links[[a,1]]]]+num[[links[[a,2]]]] ];
num
]


ChainsBetweenGF[name_,a_,b_,q_:Global`q] := ChainsBetweenGF[name,a,b,q]=
 Block[{x,above=Ups[name][[a]],chains,interval,intsize},
  between[namea_,top_]:= 
   Intersection[above,Downs[namea][[top]]];
  interval=between[name,b];
  intsize=Length[interval];
  chains=Map[0&,interval];
  Do[chains[[x]]=q + q *
   Apply[Plus,Map[chains[[Position[interval,#][[1,1]]]]&,
      Select[interval,
             MemberQ[between[name,interval[[x]]],#]&]
            ]
        ],
  {x,2,intsize}];
  If[intsize==0,Return[0],
   (* else *)
   If[intsize==1,Return[1],
    Return[chains[[intsize]] // Expand]
     ]
    ]
 ];


ZetaPoly[name_,a_,b_,n_:Global`n] := ZetaPoly[name,a,b,n] =
 Block[{lengths},
  lengths=CoefficientList[
         Expand[ChainsBetweenGF[name,a,b,q]],q];
  Do[lengths[[i]]={lengths[[i]],i-1},{i,Length[lengths]}];
  Apply[Plus,
   Map[(Binomial[n,#[[2]]] #[[1]])&, lengths]]//Expand
  ]


ZetaPoly[name_,n_:Global`n] := ZetaPoly[name,n] =
 Block[{chains=Array[0&,Card[name]],lengths,numchainsgf},
  Do[chains[[x]]=Expand[q+
    q Sum[chains[[Downs[name][[x,i]]]],
        {i,Length[Downs[name][[x]]]-1}]],
    {x,Card[name]}];
  numchainsgf=Apply[Plus,Map[Expand[(1/q) #]&,chains]];
  lengths=CoefficientList[numchainsgf,q];
  Do[lengths[[i]]={lengths[[i]],i-1},{i,Length[lengths]}];
  Apply[Plus,
   Map[(Binomial[n-2,#[[2]]] #[[1]])&, lengths]]//Expand
  ];


DES[s_] := Sum[If[s[[i]]>s[[i+1]],1,0],{i,Length[s]-1}];


ASC[s_] := Sum[If[s[[i]]<s[[i+1]],1,0],{i,Length[s]-1}];


MAJ[s_] := Sum[If[s[[i]]>s[[i+1]],i,0],{i,Length[s]-1}];


AMAJ[s_] := Sum[If[s[[i]]<s[[i+1]],i,0],{i,Length[s]-1}];


TopSortings[name_] := TopSortings[name] = 
  Block[{out={{}},k,scan},
  scan[L_,k_] := Block[{max,i},
    max=1;
    Do[If[MemberQ[Downs[name][[k]],L[[i]]],max=i+1],{i,k-1}];
    Table[Insert[L,k,i],{i,max,Length[L]+1}]
    ];
  Do[out=Map[scan[#,k]&,out];
     out=Flatten[out,1], {k,1,Card[name]}];
  out
  ];


LinearExtensions[name_] := LinearExtensions[name]=Map[InversePermutation,TopSortings[name]];


G[poset_,q_] := Block[{i},
   (Plus @@ (q^Map[MAJ,TopSortings[poset]]))/
   Product[(1-q^i),{i,Card[poset]}]
   ];


GBar[poset_,q_] := Block[{i},
   (Plus @@ (q^Map[AMAJ,TopSortings[poset]]))/
   Product[(1-q^i),{i,Card[poset]}]
   ];


Omega[poset_,n_] := Block[{w},
  w=(Plus @@ (q^Map[DES,TopSortings[poset]]));
  GFToPoly[q w,q,Card[poset],n]
  ];


OmegaBar[poset_,n_] := Block[{w},
  w=(Plus @@ (q^Map[ASC,TopSortings[poset]]));
  GFToPoly[q w,q,Card[poset],n]
  ];


OmegaGF[poset_,q_] := Block[{w},
  (Plus @@ (q^(Map[DES,TopSortings[poset]]+1)))/
   (1-q)^(Card[poset]+1)
  ];


OmegaBarGF[poset_,q_] := Block[{w},
  (Plus @@ (q^(Map[ASC,TopSortings[poset]]+1)))/
   (1-q)^(Card[poset]+1)
  ];


DualOrderIdeals[name_]:=DualOrderIdeals[name]=Block[{in,list,counter},
in=Transpose[ZetaPp[name]];
          up=Ups[name];
 PosetElements = Table[j, {j, Length[in]}]; 
     NextIdeals[w_] := Block[{i, PrincipalOrderIdeal, 
         NewPosetElements, output},
         PrincipalOrderIdeal[x_] := Complement[up[[x]], w]; 
         NewPosetElements = Complement[PosetElements, w]; 
         output = {}; 
         Do[  If[PrincipalOrderIdeal[
                   NewPosetElements[[i]]] ==
         	           {NewPosetElements[[i]]}, 
                   AppendTo[output,
                       Union[Append[w,
                       NewPosetElements[[i]] ]]
                   ]
              ], 
              {i, Length[NewPosetElements]}
          ]; 
          output
      ]; 
counter=1;
list={{}};
While[NextIdeals[list[[counter]]//Flatten]!={},
list=Union[list,NextIdeals[list[[counter]]//Flatten]];
counter=counter+1;
];
list
];

OrderIdeals[name_] := OrderIdeals[name]=Map[Complement[Range[Card[name]],#]&,DualOrderIdeals[name]];


(* ::Subsection:: *)
(*Maximum Antichain and Dilworth Covering*)


MaxAntichain[name_] := MaxAntichain[name] = Block[
   {m=n=Card[name],Amatch,Bmatch,Blabel,
         queue,a,b,moretodo=True,success,scan,augment},
   Amatch=Array[0&,m]; Bmatch=Array[0&,n];
   
   scan[a_] := Block[{nbrs=Drop[Ups[name][[a]],1]},
    success=False;
    Scan[
     (If[Bmatch[[#]]==0,success=True;b=#;Return[],
      If[Blabel[[#]]==0,
             Blabel[[#]]=a;
             PrependTo[queue,Bmatch[[#]]]
             ]] )&,nbrs];
    ];
   
    augment := Block[{$a=a,$b=b},
      While[Amatch[[$a]]!=0,
        $b=Amatch[[$a]];
        Bmatch[[b]]=$a;Amatch[[$a]]=b;
        b=$b;$a=Blabel[[b]];
        ];
      Bmatch[[$b]]=$a;Amatch[[$a]]=b;
      ];
     
  While[moretodo,
    Blabel=Array[0&,n];      
    queue=Complement[Range[m],Bmatch];   
    success=False;
    While[queue!={}, 
      a=Last[queue];queue=Drop[queue,-1];
      scan[a];
      If[success,augment;queue={}];
       ];
    moretodo=success;
    ]; 
  DilworthCover[name]=
    Cases[Table[{i,Amatch[[i]]},{i,m}],{_,_?Positive}] ;
  Complement[Range[m],Bmatch[[Flatten[Position[Blabel,0]]]],
     Flatten[Position[Blabel,_?Positive]]]   
  ]   


ff[{u___,{a__,x_},v___,{x_,b__},w___}] := 
       {u,{a,x,b},v,w};
ff[{u___,{x_,b__},v___,{a__,x_},w___}] := 
       {u,{a,x,b},v,w};
ff[{u___}] := {u};
Fuse[L_] := FixedPoint[ff,L];


OrderIdealQ[name_, indices_]:=Module[{x=1},
While[x<= Length[indices],
If[MemberQ[Map[MemberQ[indices,#]&, Downs[name][[indices[[x]]]]],False],
 Return[False]];
x=x+1;];
Return[True]];

DualOrderIdealQ[name_, indices_] :=OrderIdealQ[name,Complement[Range[Card[name]],indices]]


OrderIdeal[name_,indices_] := Module[{},
Downs[name][[indices]]//Flatten//Union]

DualOrderIdeal[name_,indices_] := Module[{},
Ups[name][[indices]]//Flatten//Union]


MaxElements[name_,indices_] := Complement[Downs[name][[indices]]//Flatten//Union,StrictDowns[name][[indices]]//Flatten//Union]

MinElements[name_,indices_] := Complement[Ups[name][[indices]]//Flatten//Union,StrictUps[name][[indices]]//Flatten//Union]


IntervalQ[name_, points_]:= Module[{down = Downs[name], up= Ups[name], max=Max[points], min= Min[points]},
If[points=={}, Return[True]];
If[Union[Intersection[Ups[name][[min]], Downs[name][[max]]]]== Union[points], True, False]
]


(* ::Subsection::Closed:: *)
(*Characteristic Polynomial*)


CharPoly[poset_,q_] := CharPoly[poset,q] = Block[{k},
	Sum[Mu[poset][[1,k]]*
	q^(Rank[poset][[Length[P[poset]]]]-
	Rank[poset][[k]]),
	{k,1,Length[P[poset]]}]]


(* ::Subsection:: *)
(*Lattice Operations*)


LatticeQ[name_]:= LatticeQ[name] =
    Block[{$a,$b,up=Ups[name],ubounds},
    If[up[[1]]!=Range[Card[name]],
       If[!Silent,Print["Not a lattice: no 0"]];Return[False]];
    For[$a=1,$a<=Card[name],$a++,
    For[$b=1,$b<$a,$b++,
    ubounds = Intersection[up[[$a]],up[[$b]]];
    If[ubounds=={},
      If[!Silent,Print["Not a lattice: P[",$a,"] and P[",$b,"] have no upper bounds."]];
      Return[False]];
    If[ubounds!=up[[First[ubounds]]],
      If[!Silent,Print["Not a lattice: P[",$a,"] and P[",$b,"] have no LUB."]];
      Return[False]]
    ]];
    True
    ]    


DistributiveLatticeQ[name_] := 
  (RankedQ[name])&&(LatticeQ[name])&&
    (Length[JI[name]]==Length[MI[name]]==Max[Rank[name]])



JoinL[name_,x_,y_] :=  Pp[name][[
   First[Intersection[
      Ups[name][[LocateElement[name,x]]],Ups[name][[LocateElement[name,y]]]
      ]]
      ]];


MeetL[name_,x_,y_] :=  Pp[name][[
   Last[Intersection[
      Downs[name][[LocateElement[name,x]]],Downs[name][[LocateElement[name,y]]]
      ]]
      ]];


LJoin[name_]:= LJoin[name]=
    Block[{a,b,cup,up=Ups[name]},
    If[!LatticeQ[name],Print["Not a lattice."],
    cup[a_,b_] :=  First[Intersection[up[[a]],up[[b]]]];
    Table[cup[a,b],
           {a,Card[name]},{b,Card[name]}]
    ]]
    
    
LMeet[name_]:= LMeet[name]=
    Block[{a,b,cap,down=Downs[name]},
    If[!LatticeQ[name],Print["Not a lattice."],
    cap[a_,b_] :=  Last[Intersection[down[[a]],down[[b]]]];
    Table[cap[a,b],
           {a,Card[name]},{b,Card[name]}]
    ]]


(* ::Subsubsection:: *)
(*Meet and Join Sublattices; Sublattices:*)


JoinSubLatticeQ[tag_,points_]:= 
	Complement[LJoin[tag][[points,points]]//Flatten,points]=={}


MeetSubLatticeQ[tag_,points_]:= 
	Complement[LMeet[tag][[points,points]]//Flatten,points]=={}


SubLatticeQ[tag_,points_]:= 
	JoinSubLatticeQ[tag,points]&&MeetSubLatticeQ[tag,points]


(* ::Subsubsection:: *)
(*Meet and Join Irreducibles:*)


JI[name_]:=JI[name] = Block[{down=Downs[name]},
   ji[x_] := Complement[down[[x]],
      down[[down[[x,Length[down[[x]]]-1]]]]
      ];
   Flatten[Position[
       Map[Length,Map[ji,Range[2,Card[name]]]],1]]+1
   ]


ZetaJI[name_] := ZetaJI[name] =
            ZetaPp[name][[JI[name],JI[name]]] 


MI[name_]:=MI[name] = Block[{up=Ups[name]},
   mi[x_] := Complement[up[[x]], up[[up[[x,2]]]]];
   Flatten[Position[
       Map[Length,Map[mi,Range[1,Card[name]-1]]],1]]
   ]


ZetaMI[name_] := ZetaMI[name] =
            ZetaPp[name][[MI[name],MI[name]]] 


JICoverRelations[name_] := JICoverRelations[name] = Block[
     {StrictJiP,TwoStepJiP,CoversJiP,links,ji=JI[name]},
     StrictJiP =
          ZetaJI[name]-IdentityMatrix[Length[ji]];
     TwoStepJiP = StrictJiP.StrictJiP;
     CoversJiP = StrictJiP-Map[If[#>0,1,0]&,TwoStepJiP,{2}];
     links = Map[ji[[#]]&,Position[CoversJiP,1],{2}]
]


MICoverRelations[name_] := MICoverRelations[name] = Block[
     {StrictMiP,TwoStepMiP,CoversMiP,links,mi=MI[name]},
     StrictMiP =
          ZetaMI[name]-IdentityMatrix[Length[mi]];
     TwoStepMiP = StrictMiP.StrictMiP;
     CoversMiP = StrictMiP-Map[If[#>0,1,0]&,
          TwoStepMiP,{2}
     ];
     links = Map[mi[[#]]&,Position[CoversMiP,1],{2}]
]


(* ::Subsection:: *)
(*Operations for combining Posets*)


TensorProductt[M_,N_] :=  Map[Flatten,
    Flatten[Transpose[
      Outer[Times,M,N],{1,3,2,4}],1]]


CProduct[poset1_,poset2_] := 
  Block[{mat1,mat2,mat3,card1,card2},
  If[Head[poset1]===Symbol,
     {mat1,card1}={ZetaP[poset1],Card[poset1]},(*else*)
     If[MatrixQ[poset1],
       {mat1,card1}={poset1,Length[poset1]},(*else*)
       {mat1,card1}=
           {ToMatrix[poset1[[1]],poset1[[2]]],poset1[[2]]}
     ]
   ];
  If[Head[poset2]===Symbol,
     {mat2,card2}={ZetaP[poset2],Card[poset2]},(*else*)
     If[MatrixQ[poset1],
       {mat2,card2}={poset2,Length[poset2]},(*else*)
       {mat2,card2}=
           {ToMatrix[poset2[[1]],poset2[[2]]],poset2[[2]]}
     ]
   ];   
  card=card1 card2;
  Do[mat1[[i,i]]=1,{i,card1}];
  Do[mat2[[i,i]]=1,{i,card2}];
  mat3=TensorProductt[mat1,mat2];
  {ToRelation[mat3-IdentityMatrix[card]],card}
  ];


DisjointSum[poset1_,poset2_] := Block[
{card1,links1,card2,links2,links,card},
  If[Head[poset1]===Symbol,
     {links1,card1}={CoverRelations[poset1],Card[poset1]},(*else*)
     If[MatrixQ[poset1],
       {links1,card1}=
            {ToRelation[poset1],Length[poset1]},(*else*)
       {links1,card1}={poset1[[1]],poset1[[2]]}
     ]
   ];
  If[Head[poset2]===Symbol,
     {links2,card2}={CoverRelations[poset2],Card[poset2]},(*else*)
     If[MatrixQ[poset2],
       {links2,card2}=
            {ToRelation[poset2],Length[poset2]},(*else*)
       {links2,card2}={poset2[[1]],poset2[[2]]}
     ]
   ];
  card=card1+card2;
  links=Join[links1,links2+card1];
  {links,card}
  ];


OrdinalSum[poset1_,poset2_] := Block[
{card1,links1,card2,links2,links,card},
  If[Head[poset1]===Symbol,
     {links1,card1}={CoverRelations[poset1],Card[poset1]},(*else*)
     If[MatrixQ[poset1],
       {links1,card1}=
            {ToRelation[poset1],Length[poset1]},(*else*)
       {links1,card1}={poset1[[1]],poset1[[2]]}
     ]
   ];
  If[Head[poset2]===Symbol,
     {links2,card2}={CoverRelations[poset2],Card[poset2]},(*else*)
     If[MatrixQ[poset2],
       {links2,card2}=
            {ToRelation[poset2],Length[poset2]},(*else*)
       {links2,card2}={poset2[[1]],poset2[[2]]}
     ]
   ];
  card=card1+card2;
  links=Join[links1,links2+card1,
       Flatten[Outer[List,
         Range[card1],Range[card2]+card1],1]
       ];
  {links,card}
  ];



IntervalP[name_,bottom_,top_] := Block[{bpos,tpos},
  {bpos,tpos} = 
    {Position[Pp[name],bottom],Position[Pp[name],top]}//Flatten;
  Intersection[Ups[name][[bpos]],Downs[name][[tpos]]]
  ]


JoinSubLattice[tag_,points_]:= JoinSubLattice[tag,points] =
  	FixedPoint[fjoinsublattice[tag,#]&,points];


fjoinsublattice[tag_,points_]:= 
	LJoin[tag][[points,points]]//Flatten//Union;


MeetSubLattice[tag_,points_]:= MeetSubLattice[tag,points] =
  	FixedPoint[fmeetsublattice[tag,#]&,points];


fmeetsublattice[tag_,points_]:= 
	LMeet[tag][[points,points]]//Flatten//Union;


SubLattice[tag_,points_]:= SubLattice[tag,points] =
  	FixedPoint[fsublattice[tag,#]&,points];


fsublattice[tag_,points_]:= 
	Union[
	   (LMeet[tag][[points,points]]//Flatten),
	   (LJoin[tag][[points,points]]//Flatten)]


(* ::Subsubsection:: *)
(*Abbreviations*)


CP[poset1_,poset2_] := CProduct[poset1,poset2];

DS[poset1_,poset2_] := DisjointSum[poset1,poset2];

OS[poset1_,poset2_] := OrdinalSum[poset1,poset2];

SP[poset1_,points_] := SubPoset[poset1,points];

JSL[poset1_,points_] := JoinSubLattice[poset1,points];

MSL[poset1_,points_] := MeetSubLattice[poset1,points];

SL[poset1_,points_] := SubLattice[poset1,points];


(* ::Subsubsection:: *)
(*Building Duals and Subposets:*)


BuildDual[poset_, dualname_:automatic]:= Block[
{links1,card,links, size = Card[poset]},
  If[dualname == automatic, dualname = Unique["Dual"]];
  Zap[dualname];
  If[Head[poset]===Symbol,
     {links1,card}={CoverRelations[poset],Card[poset]},(*else*)
     If[MatrixQ[poset],
       {links1,card}=
            {ToRelation[poset],Length[poset]},(*else*)
       {links1,card}={poset[[1]],poset[[2]]}
     ]
   ];
  links=Map[Reverse,Map[(card+1-#)&,links1,{2}]];
  Build[{links,card},dualname];
P[dualname] = Map[P[poset][[card+1 - #]]&,P[dualname]];
 Labels[dualname] = {P[dualname] , Range[Card[dualname]]};
  ]


BuildSubPoset[poset_,points_, name_:automatic] := Block[
{mat,links,card,pointlist},If[name == automatic, name = Unique["SubPoset"]];
  If[!Silent,Print["Building Subposet ", name, "  ..."]];
  Zap[name];
  If[Head[poset]===Symbol,
     {mat,card}={ZetaP[poset],Card[poset]},(*else*)
     If[MatrixQ[poset],
       {mat,card}={poset,Length[poset]},(*else*)
       {mat,card}=
           {ToMatrix[poset[[1]],poset[[2]]],poset[[2]]}
     ]
   ];
  If[Head[points]===List,pointlist=points,(*else*)
     pointlist=Position[Map[points,P[poset]],True]//Flatten];
  card=Length[pointlist];
  links=ToRelation[mat[[pointlist,pointlist]]];
  Build[ {links,card} ,name];

  If[Head[points]===List,pointlist=points,(*else*)
     pointlist=Position[Map[points,P[poset]],True]//Flatten];
  Pp[name]=Map[P[poset][[pointlist[[#]]]]&,Pp[name]];
Labels[name] ={Pp[name],Range[Card[name]]};
  ];


(* ::Subsection:: *)
(*Miscellaneous Commands: Posets*)


ListCommands[string__] := 
  Block[{result},
    result = Names[StringJoin["Posets`*",string,"*"]];
    If[result == {}, Print["No Match."],
      If[OddQ[Length[result]],AppendTo[result,"---"]];
      result = Partition[result,Quotient[Length[result],2]];
      result = result//Transpose//MatrixForm]
  ];


  ListCommands[] := 
  Block[{result,search},
    result = Names["Posets`*"];
    If[OddQ[Length[result]],AppendTo[result,"---"]];
    result = Partition[result,Quotient[Length[result],2]];
    result = result//Transpose//MatrixForm

  ];


Zap[name_] := Block[{},
    Off[Unset::norep];
    Pp[name] =. ;
    PGraded[name] =. ;
 PGradedIndices[name] =. ;
    CoverRelations[name] =. ;
    Rank[name] =. ;
    RankedQ[name] =. ;
StrongRankedQ[name]=.;
    NK[name] =. ;
    RGF[name] =. ;
    Hh[name] =. ;
    Card[name] =. ;
    ZetaPp[name] =. ;
    Mu[name] =. ;
    Ups[name] =. ;
    Downs[name] =. ;
    Covers[name] =. ;
    CoCovers[name] =. ;
    MaxAntichain[name]=. ;
    DilworthCover[name]=. ;
    JI[name]=.;
    MI[name]=. ;
    JICoverRelations[name]=.;
    MICoverRelations[name]=. ;
    G[name]=. ;
    GBar[name]=.;
    Omega[name]=.;
    OmegaBar[name]=.;
    OmegaGF[name]=.;
    OmegaBarGF[name]=.;
    LinearExtensions[name]=. ;
    MaximalChainsUp[name]=. ;
    MaximalChainsDown[name]=. ;
    ChainsBetweenGF[name]=. ;
    LatticeQ[name]=. ;
	Labels[name]=.;
SavedSettings[name]=.;
    On[Unset::norep];
(* because OrderIdeals are not automatically calculated
 for every poset we set them to 1 before we clear them
otherwise Mathematica will throw an error.*)
OrderIdeals[name]=1;
DualOrderIdeals[name]=1;

OrderIdeals[name]=.;
DualOrderIdeals[name]=.;
    ]


LocateElement[name_,element_] := 
    Position[Pp[name],element][[1,1]]


LocateSet[name_,set_] := 
     Map[Position[Pp[name],#]&,set] //Flatten//Sort


SpecialPoints[name_,function_] := Position[Map[function,Pp[name]],True]//Flatten;


IsoQ[name1_, name2_]:=Search[{},Length[P[name1]],name1,name2];


Search[list_List, n_, name1_, name2_]:=Search[list,n,name1, name2]=
 Module[{options, options2,fof, x=1, ans},

If[ Length[list]==n,
	GetIsomorphism[name1, name2]= list;
	GetIsomorphism[name2, name1]= list;
	Return[True], 
(*else*) 
If[list=={},
	options2 = Flatten[Position[DownDegree[name1],0]], 
(*else*)
	fof=Sort[list[[CoCovers[name1][[ Length[list]+1]]]]];
	options = Flatten[Covers[name2][[fof]]];
	options2 =Select[Union[Select[options,CoCovers[name2][[#]]==fof&]], MemberQ[list,#]==False & ]];

	While[x<=Length[options2], 
	ans=Search[Join[list, {options2[[x]]}],n,name1, name2];
	If[ans==True, 
		Return[ans],(*else*)
		 x=x+1]]];
	Return[False]
]


GetIsomorphism[name1_, name2_] := {};


IsomorphiccQ[poset1_,poset2_]:=Block[{},     (*添加c*)
     If[GetIsomorphism[poset1,poset2]!= {}, Return[True],
	GetIsomorphism[poset1, poset2] = {};
	GetIsomorphism[poset2, poset1] = {};
     If[Length[CoverRelations[poset1]]!=Length[CoverRelations[poset2]],
          If[!Silent,Print["Different number of CoverRelations."]];
          Return[False]
     ];
     If[Card[poset1]!=Card[poset2],
          If[!Silent,Print["Cardinalities not equal."]];
          Return[False]
     ];
     If[Sort[UpDegree[poset1]]!=Sort[UpDegree[poset2]],
          If[!Silent,Print["UpDegree distribution is different."]];
          Return[False]
     ];
     If[Sort[DownDegree[poset1]]!=Sort[DownDegree[poset2]],
          If[!Silent,Print["DownDegree distribution is different."]];
          Return[False]
     ];
     If[Count[Flatten[ZetaP[poset1]],1]!=
          Count[Flatten[ZetaP[poset2]],1],
          If[!Silent,Print["Number of ones in Zeta matrix is different."]];
          Return[False]
     ];
     If[Sort[Flatten[Mu[poset1]]]!=
          Sort[Flatten[Mu[poset2]]],
         If[!Silent, Print["Some Mobius function values are different."]];
          Return[False]
     ];
     If[RankedQ[poset1]!=RankedQ[poset2],
         If[!Silent, Print["One is ranked; the other is not."]];
          Return[False]
     ];     
     If[Rank[poset1]!=Rank[poset2],
          If[!Silent,Print["Rank distribution is different."]];
           Return[False]
     ];     
Return[IsoQ[poset1, poset2]]
]
]


NumPosets[n_] := Length[Global`AllPosets[n]];
NumLattices[n_] := Length[Global`AllLattices[n]];


(* ::Subsection::Closed:: *)
(*Miscellaneous Commands: Combinatorics*)


InfiniteProduct[F_,n_] := Block[{p=F-1,log,loglist,k,a,m,d},
    log = Expand[Sum[(-1)^(k-1) p^k /k,{k,1,n}]];
    loglist =CoefficientList[log,q];
    a[m_]:=Sum[d loglist[[d+1]] MoebiusMu[m/d]If[IntegerQ[m/d],1,0],
                         {d,1,n}] /m ;
    Array[a,n]
    ]


InversionCode[s_] := Table[Count[
    Drop[s,Position[s,i][[1,1]]],
    x_Integer?(i>#&)],{i,Length[s]}];


ToPermutation[code_] := Block[{out={},k},
  For[k=1,k<=Length[code],k++,
    out=Insert[out,k,k-code[[k]]]
    ];out]  


(*InversePermutation[p_]:=
     ({p,Range[Length[p]]}//Transpose//Sort//Transpose)[[2]]*)


ZeroDiffs[seq_]:=Block[{current=seq,zerodiffs={seq[[1]]}},
  While[Length[current]!=1 && current*0 !=current,
  current=Drop[current,1]- Drop[current,-1];
  AppendTo[zerodiffs,current[[1]] ]];
  zerodiffs
]


PolyToGF[f_,x_,q_] := Block[{values,d,zerodiffs,i},
  d = Exponent[f,x];
  zerodiffs = ZeroDiffs[Table[f,{x,0,d}]];
  Sum[zerodiffs[[i+1]]*q^i * (1-q)^(d-i),
            {i,0,d}]/(1-q)^(d+1)      
  ] 


GFToPoly[w_,q_,d_,n_] := Block[
   {r,a=CoefficientList[w /. q->1-r,r]},
   Sum[a[[i]]Binomial[n+d-(i-1),d-(i-1)],{i,1,Length[a]}] ];


GenFun[L_,q_] := Block[{},
    L.Table[q^(i-1),{i,Length[L]}]];


Tabify[list_,partition_] := Module[{in=list,pp=partition,chunk,i,out={},len=Length[partition]},
    Do[chunk = Take[in,pp[[i]]];AppendTo[out,chunk];in = Drop[in,pp[[i]]],{i,1,Length[pp]}];
    out];


AllTableaux[lam_] := Module[{n=Apply[Plus,lam],perms},
     perms = Permutations[Range[n]];
     Map[Tabify[#,lam]&,perms]
];


Shape[tab_] := Map[Length,tab];


MonotoneShapeQ[tab_] := Shape[tab]==Reverse[Sort[Shape[tab]]];


AddBox[tab_,n_,k_] :=If[k==Length[tab]+1,Append[tab,{n}],
      Table[If[i==k,Append[tab[[i]],n],tab[[i]]],{i,Length[tab]}]];


STableaux[lam_List] := Module[{n},
      n=Apply[Plus,lam];
      Select[STableaux[n],(Shape[#]==lam)&]];
      STableaux[1] = {{{1}}};
      STableaux[n_] := Module[{smaller,k,i,out={},temp},
      smaller=STableaux[n-1];
      Do[temp = Table[AddBox[smaller[[k]],n,i],{i,Length[smaller[[k]]]+1}];
          out=Join[out,temp],{k,Length[smaller]}];
      Select[out,MonotoneShapeQ]
];


(* ::Subsection:: *)
(*End*)


Ver="3.00dz4";
Silent=False;
End[];
EndPackage[];
