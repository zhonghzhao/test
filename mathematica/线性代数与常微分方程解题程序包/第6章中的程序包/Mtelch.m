BeginPackage["Mtelch`"]
    Rijk::usage="Rijk[A,i,j,k] 将矩阵A的第i行的k倍加到第j行"
    Rij::usage="Rij[A,i,j] 交换矩阵A的第i，j两行"
    Rik::usage="Rik[A,i,k] 将矩阵A的第i行乘k"
    Cijk::usage="Cijk[A,i,j,k] 将矩阵A的第i列的k倍加到第j列"
    Cij::usage="Cij[A,i,j] 交换矩阵A的第i，j两列"
    Cik::usage="Cik[A,i,k] 将矩阵A的第i列乘k"
    Begin["`Private`"]
    Rijk[A_List,i_Integer?Positive,j_Integer?Positive,k_ ]:=(d=Dimensions[A];m=d[[1]];
    If[i>m,Print["error: i > ",m];Return[ ]];
    If[j>m,Print["error: j > ",m];Return[ ]];
    If[i==j,Print["error: i = j"];Return[ ]];
    B=IdentityMatrix[m];
    B[[j,i]]=k;
    Simplify[B.A])
    Rij[A_List,i_Integer?Positive,j_Integer?Positive]:=(d=Dimensions[A];m=d[[1]];
    If[i>m,Print["error: i > ",m];Return[ ]];
    If[j>m,Print["error: j > ",m];Return[ ]];
    If[i==j,Print["error: i = j"];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,i]]=0;B[[j,j]]=0;B[[j,i]]=1;B[[i,j]]=1;
    B.A)
    Rik[A_List,i_Integer?Positive,k_ ]:=(d=Dimensions[A];m=d[[1]];
    If[i>m,Print[ "error: i > ",m];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,i]]=k;
    Simplify[B.A])
    Cijk[A_List,i_Integer?Positive,j_Integer?Positive,k_ ]:=(d=Dimensions[A];m=d[[2]];
    If[i>m,Print["error: i > ",m];Return[ ]];
    If[j>m,Print["error: j > ",m];Return[ ]];
    If[i==j,Print["error: i = j"];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,j]]=k;
    Simplify[A.B])
    Cij[A_List,i_Integer?Positive,j_Integer?Positive]:=(d=Dimensions[A];m=d[[2]];
    If[i>m,Print["error: i > ",m];Return[ ]];
    If[j>m,Print["error: j > ",m];Return[ ]];
    If[i==j,Print["error: i = j"];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,i]]=0;B[[j,j]]=0;B[[j,i]]=1;B[[i,j]]=1;
    A.B)
    Cik[A_List,i_Integer?Positive,k_ ]:=(d=Dimensions[A];m=d[[2]];
    If[i>m,Print[ "error: i > ",m];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,i]]=k;
    Simplify[A.B])
End[ ]
Protect[Rijk , Rij , Rik ,Cijk , Cij , Cik]
EndPackage[ ]

