BeginPackage["Cij`"] 
(*本句中的上下文是 Cij`，通常使它与文件名相同，本例只定义一个函数，也使它与函数名相同。本句将$Context变成 Cij`，并且$ContextPath变成 {Cij`,    System`} 。*)
Cij::usage="Cij[A,i,j] 交换矩阵A的第 i，j 两列"
Cij::err1="列号 `1` > 矩阵的列数 `2`"
(* Cij::usage= 是建立说明语句的标准格式，其中 Cij 是函数名，此句建立了新
函数名 Cij`Cij 。*)
Begin["`Private`"] 
(*注意此处双引号内的上下文前面也有反撇号，执行此句后 $Context 变成子上下文 Cij` Private` ，$ContextPath 仍是 {Cij` , System`} 。*)
(* Mathematica 发现下式中的函数名 Cij 时，通过搜寻当前上下文路径{Cij` , 
System`}找到全名为 Cij`Cij 的已知函数名，因此认为下式中的Cij 就是Cij`Cij 。
同理，下式中的内部函数名都可在System` 中找到，没有新函数名了。但是下式中的变量名 A，B，i，j，d，m 都在当前上下文路径{Cij` , System`}中找不到，
于是建立具有上下文为当前上下文 Cij` Private` 的新变量名，因此 A，B，i，j，d，m 是新建的。*)
    Cij[A_List,i_Integer?Positive,j_Integer?Positive]:=   (*参数加了限制。*)
    (d=Dimensions[A];m=d[[2]];   (* d 是矩阵的行、列数组成的表，m 是列数。*)
    If[i>m,Message[Cij::err1,i,m];Return[ ]];
    If[j>m,Print[j," > ",m];Return[ ]];
    If[i==j,Print["i=j"];Return[ ]]; 
    (*以上3句检查 i ，j 是否合法，不合法时显示提示并返回。*)
    B=IdentityMatrix[m];   (*建立一个 m 阶单位矩阵B *)
    B[[i,i]]=0;B[[j,j]]=0;B[[j,i]]=1;B[[i,j]]=1;
    (*改造 B 成为初等方阵*)
    A.B)  (*返回结果是输入矩阵 A 右边乘 B ，即相当于 A 做了交换两列。*)
    (*到此 Mathematica 记住了新变量和新函数 Cij 的定义式*)
    End[ ]
    (*此句恢复 Begin["`Private`"] 以前的 $Context *)
    Protect[Cij]   (*函数名 Cij 被保护*)
    EndPackage[ ] 
(*此句恢复 BeginPackage["Cij`"] 以前的 $Context 和 $ContextPath ，并将 Cij`放在 $ContextPath 表的最前面。*)