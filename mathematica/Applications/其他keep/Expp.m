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