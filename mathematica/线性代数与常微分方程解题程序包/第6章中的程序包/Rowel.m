BeginPackage["Rowel`"]
    Rowel::usage="Rowel[A] 求矩阵A的行最简形"
    Begin["`Private`"]
Rowel[A0_]:=(A=A0;d=Dimensions[A];m=d[[1]];n=d[[2]];BZ=Table[0,{i,n}];  (* m 为行数，n 为列数，BZ 存放阶梯角标记。*)
    If[m==1,
    For[i=1,i<=n,i++,
    If[A[[1,i]]=!=0,R=A[[1,i]];
    For[j=i,j<=n,j++,A[[1,j]]=A[[1,j]]/R];
    Return[A]
    ]]];  (*处理只有一行的矩阵。*)
    For[i=1,i<m,i++,
EB=0;EC=0;  (* EB=1时表示找到了阶梯角元素，EC=1时表示进行了一列消元。*)
    If[i<=n, 
    For[s=i,s<=n,s++, 
    For[j=i,j<=m,j++,
    If[A[[j,s]]==1 || A[[j,s]]==-1,
    If[i!=j,
    For[i0=s,i0<=n,i0++,R=A[[j,i0]];A[[j,i0]]=A[[i,i0]];A[[i,i0]]=R];
Print[A//MatrixForm]  (*交换了两行后显示结果。*)
];EB=1;Break[ ]  (*设置标记EB=1，退出寻找阶梯角元素。*)
    ]];  (*选取1或-1作为阶梯角元素，避免分式。*)
    If[EB==0,  (*没有找到1或-1，继续寻找不为0的元素作为阶梯角元素。*)
    For[j=i,j<=m,j++,
If[A[[j,s]]=!=0,  (*注意此处使用“=!=”，寻找不为0的元素，认为含有字母的表达式不为0。*)
    If[i!=j,
    For[i0=s,i0<=n,i0++,R=A[[j,i0]];A[[j,i0]]=A[[i,i0]];A[[i,i0]]=R];
Print[A//MatrixForm]   (*交换了两行后显示结果。*)
];EB=1;Break[ ]   (*设置标记EB=1，退出寻找阶梯角元素。*)
    ]]];
    If[EB==1, BZ[[i]]=s;Break[ ]]   (*当找到阶梯角元素时，存储阶梯角所在列的列号到数组 BZ 中，并退出寻找阶梯角的循环过程，否则到下一列寻找。*) 
    ];
    If[EB==1,  
    For[j=i+1,j<=m,j++,
    If[A[[j,s]]=!=0,
    R=-A[[j,s]]/A[[i,s]];EC=1;
    For[i0=s,i0<=n,i0++,A[[j,i0]]=A[[j,i0]]+R*A[[i,i0]]]
    ]];   (*如果阶梯角下方有不为0的元素，则进行消元，并设置标记EC=1。*)
If[EC==1,A=Simplify[A];Print[A//MatrixForm]]  (*如果进行了消元，则化简并显示消元后的矩阵。*)
    ,Break[ ]  (*如果EB=0，则没有不为0的元素了，中断寻找阶梯角的循环。*)
    ]]];
    If[m<=n,
    For[i=m,i<=n,i++,If[A[[m,i]]=!=0,BZ[[m]]=i;Break[ ]]]
    ];   (*当 m<=n 时，需要处理最后一行。*)
    AR=0;For[i=1,i<=n,i++,If[BZ[[i]]!=0,AR=i,Break[ ]]];  (* 求矩阵的秩 AR 。*)
    If[AR!=0,
    For[i=AR,i>=1,i--,
    EC=0;s=BZ[[i]];
    If[A[[i,s]]=!=1,R=A[[i,s]];
    For[j=s,j<=n,j++,A[[i,j]]=A[[i,j]]/R];
    A=Simplify[A];Print[A//MatrixForm]
    ];  (*如果阶梯角上的元素不等于1，则变成1，化简并显示变换后的矩阵。*)
    If[i>1,  
    For[j=1,j<i,j++,
    If[A[[j,s]]=!=0,
    R=-A[[j,s]]/A[[i,s]];EC=1;
    For[i0=s,i0<=n,i0++,A[[j,i0]]=A[[j,i0]]+R*A[[i,i0]]]
    ]];  (*如果阶梯角上方有不为0的元素，则进行消元，并设置标记EC=1。*) 
    If[EC==1,A=Simplify[A];Print[A//MatrixForm]]
    ]]];
    Return[A];  (*返回计算结果。*)
    )
End[ ]
Protect[Rowel]
EndPackage[ ]
