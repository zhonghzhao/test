BeginPackage["Matelch`"]
    Rcijk::usage="Rcijk[A,i,j,k] 将矩阵A的第i行的k倍加到第j行"
    Rcij::usage="Rcij[A,i,j] 交换矩阵A的第i，j两行"
    Rcik::usage="Rcik[A,i,k] 将矩阵A的第i行乘k"
    Chijk::usage="Chijk[A,i,j,k] 将矩阵A的第i列的k倍加到第j列"
    Chij::usage="Chij[A,i,j] 交换矩阵A的第i，j两列"
    Chik::usage="Chik[A,i,k] 将矩阵A的第i列乘k"
    
    Begin["`Private`"]
    Rcijk[A_List,i_Integer?Positive,j_Integer?Positive,k_ ]:=(d=Dimensions[A];m=d[[1]];
    If[i>m,Print["error: i > ",m];Return[ ]];
    If[j>m,Print["error: j > ",m];Return[ ]];
    If[i==j,Print["error: i = j"];Return[ ]];
    B=IdentityMatrix[m];
    B[[j,i]]=k;
    Simplify[B.A]//MatrixForm)

    Rcij[A_List,i_Integer?Positive,j_Integer?Positive]:=(d=Dimensions[A];m=d[[1]];
    If[i>m,Print["error: i > ",m];Return[ ]];
    If[j>m,Print["error: j > ",m];Return[ ]];
    If[i==j,Print["error: i = j"];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,i]]=0;B[[j,j]]=0;B[[j,i]]=1;B[[i,j]]=1;
    B.A//MatrixForm)

    Rcik[A_List,i_Integer?Positive,k_ ]:=(d=Dimensions[A];m=d[[1]];
    If[i>m,Print[ "error: i > ",m];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,i]]=k;
    Simplify[B.A]//MatrixForm)

    Chijk[A_List,i_Integer?Positive,j_Integer?Positive,k_ ]:=(d=Dimensions[A];m=d[[2]];
    If[i>m,Print["error: i > ",m];Return[ ]];
    If[j>m,Print["error: j > ",m];Return[ ]];
    If[i==j,Print["error: i = j"];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,j]]=k;
    Simplify[A.B]//MatrixForm)

    Chij[A_List,i_Integer?Positive,j_Integer?Positive]:=(d=Dimensions[A];m=d[[2]];
    If[i>m,Print["error: i > ",m];Return[ ]];
    If[j>m,Print["error: j > ",m];Return[ ]];
    If[i==j,Print["error: i = j"];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,i]]=0;B[[j,j]]=0;B[[j,i]]=1;B[[i,j]]=1;
    A.B//MatrixForm)

    Chik[A_List,i_Integer?Positive,k_ ]:=(d=Dimensions[A];m=d[[2]];
    If[i>m,Print[ "error: i > ",m];Return[ ]];
    B=IdentityMatrix[m];
    B[[i,i]]=k;
    Simplify[A.B]//MatrixForm)
End[ ]
Protect[Rcijk,Rcij,Rcik,Chijk,Chij,Chik]
EndPackage[ ]