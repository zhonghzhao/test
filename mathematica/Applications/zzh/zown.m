BeginPackage["Expp`"]
Expp::usage="Expp[A,t,t0,c,f] 一阶常系数微分方程组的公式解"
Begin["`Private`"] 
    Expp[A_List,t_,t0_?NumberQ,c_List,f_List]:=      (* c,f要写成列向量的形式才能计算, 此处不太完善 *)
	(d=Dimensions[A];m=d[[1]];n=d[[2]]; If[m!=n,Print["不是方阵"];Return[ ]];
	k=Dimensions[c]; p=k[[1]];q=k[[2]]; If[p!=n||q!=1,Print["无法计算"];Return[ ]]; 
	l=Dimensions[f]; x=l[[1]];y=l[[2]]; If[x!=n||y!=1,Print["无法计算"];Return[]]; 
	Print["矩阵函数 "]&&Print[Simplify[MatrixExp[t A]]//MatrixForm];
	Print["乘以初值得第一项为 "]&&Print[Simplify[MatrixExp[(t-t0) A].c]//MatrixForm];
	Print["积分项 "]&&Print[FullSimplify[Integrate[MatrixExp[-t A].f,{t,t0,t}]]//TrigToExp//MatrixForm];
    Print["乘以矩阵函数得第二项为 "]&&Print[FullSimplify[MatrixExp[t A].Integrate[MatrixExp[-t A].f,{t,t0,t}]]//TrigToExp//MatrixForm];
	Print["通解为 "]&&Print[FullSimplify[MatrixExp[(t-t0) A].c+ MatrixExp[t A].Integrate[MatrixExp[-t A].f,{t,t0,t}]]//MatrixForm];
	FullSimplify[MatrixExp[(t-t0) A].c+ MatrixExp[t A].Integrate[MatrixExp[-t A].f,{t,t0,t}]]//MatrixForm
	)
End[ ]
Protect[Expp]
EndPackage[ ]

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

BeginPackage["Rowelt`"]
    Rowelt::usage="Rowelt[A] 求矩阵A的行最简形"
    Begin["`Private`"]
Rowelt[A0_]:=(A=A0;d=Dimensions[A];m=d[[1]];n=d[[2]];BZ=Table[0,{i,n}];  (* m 为行数，n 为列数，BZ 存放阶梯角标记。*)
    If[m==1, For[i=1, i<=n, i++, If[A[[1,i]]=!=0, R=A[[1,i]]; 
      Print["将矩阵第 ", m, " 行元素乘以 ", 1/R, " 得到: "]&&For[j=i, j<=n, j++, A[[1,j]]=A[[1,j]]/R]&&Print[A//MatrixForm]; Return[A]]]];  (*处理只有一行的矩阵。 *)

    For[i=1, i<m, i++, EB=0; EC=0;  (* EB=1时表示找到了阶梯角元素，EC=1时表示进行了一列消元。*)
      If[i<=n, For[s=i, s<=n, s++, For[j=i,j<=m,j++, If[A[[j,s]]==1 || A[[j,s]]==-1,
            If[i!=j, For[i0=s, i0<=n, i0++, R=A[[j,i0]]; A[[j,i0]]=A[[i,i0]]; A[[i,i0]]=R]; 
      Print["交换第 ", i," , ", j" 行得到: "]&&Print[A//MatrixForm]  (*交换了两行后显示结果。*)
    ];EB=1;Break[ ]  (*设置标记EB=1，退出寻找阶梯角元素。*)
    ]];  (*选取1或-1作为阶梯角元素，避免分式。*)

    If[EB==0,  (*没有找到1或-1，继续寻找不为0的元素作为阶梯角元素。*)
    For[j=i, j<=m, j++, If[A[[j,s]]=!=0,  (*注意此处使用“=!=”，寻找不为0的元素，认为含有字母的表达式不为0。*)
      If[i!=j, For[i0=s, i0<=n, i0++, R=A[[j,i0]]; A[[j,i0]]=A[[i,i0]]; A[[i,i0]]=R]; 
      Print["交换第 ", i," , ", j" 行得到: "]&&Print[A//MatrixForm]   (*交换了两行后显示结果。*)
    ];EB=1;Break[ ]   (*设置标记EB=1，退出寻找阶梯角元素。*)
    ]]];

    If[EB==1, BZ[[i]]=s; Break[ ]]   (*当找到阶梯角元素时，存储阶梯角所在列的列号到数组 BZ 中，并退出寻找阶梯角的循环过程，否则到下一列寻找。*) 
    ];
    If[EB==1, For[j=i+1, j<=m,j++, If[A[[j,s]]=!=0, R=-A[[j,s]]/A[[i,s]];EC=1;
    For[i0=s, i0<=n, i0++, A[[j,i0]]=A[[j,i0]]+R*A[[i,i0]]]]];   (*如果阶梯角下方有不为0的元素，则进行消元，并设置标记EC=1。*)
    If[EC==1,A=Simplify[A];
      Print["将第 ", i," 列的第 ", i, " 行下方的元素消成 0 得: "]&&Print[A//MatrixForm]]  (*如果进行了消元，则化简并显示消元后的矩阵。*)
       ,Break[ ]  (*如果EB=0，则没有不为0的元素了，中断寻找阶梯角的循环。*)
    ]]];
    If[m<=n, For[i=m, i<=n, i++, If[A[[m,i]]=!=0, BZ[[m]]=i; Break[ ]]]];   (*当 m<=n 时，需要处理最后一行。*)
    AR=0; For[i=1, i<=n, i++, If[BZ[[i]]!=0,AR=i,Break[ ]]];  (* 求矩阵的秩 AR 。*)
    If[AR!=0, For[i=AR,i>=1,i--, EC=0;s=BZ[[i]];
    If[A[[i,s]]=!=1,R=A[[i,s]]; For[j=s,j<=n,j++,A[[i,j]]=A[[i,j]]/R]; A=Simplify[A]; 
      Print["将第 ", i," 行的元素乘以 ", 1/R, " 得到: "]&&Print[A//MatrixForm]];  (*如果阶梯角上的元素不等于1，则变成1，化简并显示变换后的矩阵。*)

    If[i>1, For[j=1,j<i,j++, If[A[[j,s]]=!=0, R=-A[[j,s]]/A[[i,s]];EC=1;
    For[i0=s,i0<=n,i0++,A[[j,i0]]=A[[j,i0]]+R*A[[i,i0]]]]];  (*如果阶梯角上方有不为0的元素，则进行消元，并设置标记EC=1。*) 
    If[EC==1,A=Simplify[A]; 
      Print["将第 ", j," 列的第 ", j, " 行上方的元素消成 0 得: "]&&Print[A//MatrixForm]]
    ]]];Return[A//MatrixForm];  (*返回计算结果。*)
    )
End[ ]
Protect[Rowelt]
EndPackage[ ]



Clear[f,x] (*计算函数极值*)
max[f_, x_]:=Module[{df, ddf, s, sl, i, x0, y, y2}, df = D[f, x] // Simplify;
  Print["f'=", df]; s = x /. Solve[df == 0, x, Reals];
  If[s == x, Print["极值不存在或函数是奇异的"]; Return[]];
  s = Union[s] // FullSimplify;
  sl = Length[s]; If[sl == 0, Print["极值不存在或函数是奇异的"]; Return[]];
  ddf = D[df, x] // Simplify; Print["f''=", ddf]; 
  For[i = 1, i <= sl, i++, x0 = s[[i]];
   y = f /. x -> x0; y2 = ddf /. x -> x0; p1 = y2 > 0; p2 = y2 < 0;
   If[Head[y] == ConditionalExpression, y = Apply[FullSimplify, y]];
   If[Head[p1] == ConditionalExpression, p1 = Apply[FullSimplify, p1];
     p2 = Apply[FullSimplify, p2]];
   If[p1, Print["在 ", x, "=", x0, " 处有极小值 ", y], 
    If[p2, Print["在 ", x, "=", x0, " 处有极大值 ", y], 
     Print["在 ", x, "=", x0, " 处判定失败 "]], 
    Print["在 ", x, "=", x0, " 处判定失败 "]]]]


Clear[x,y]  (*重新定义内积,适用复数的情况*)
innpd[x_,y_]:=Dot[Conjugate[y],x]

Clear[v]    (*下面是用householder将向量化为和e1共线,不能处理任意单位向量的共线*)
hhd[v_?VectorQ]:=If[Norm[v,2]==0||Norm[Drop[v,1]]==0,IdentityMatrix[Length[v]]-2Transpose[{UnitVector[Length[v],1]}].{UnitVector[Length[v],1]},

If[Im[v[[1]]]==0,

IdentityMatrix[Length[v]]-2Transpose[{v-Norm[v,2]UnitVector[Length[v],1]}].{v-Norm[v,2]UnitVector[Length[v],1]}/innpd[v-Norm[v,2]UnitVector[Length[v],1],v-Norm[v,2]UnitVector[Length[v],1]],

IdentityMatrix[Length[v]]-2Transpose[{v-ReplacePart[UnitVector[Length[v],1],Norm[v,2]I,1]}].Conjugate[{v-ReplacePart[UnitVector[Length[v],1],Norm[v,2]I,1]}]/innpd[v-ReplacePart[UnitVector[Length[v],1],Norm[v,2]I,1],v-ReplacePart[UnitVector[Length[v],1],Norm[v,2]I,1]]]]//Simplify