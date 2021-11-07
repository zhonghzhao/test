BeginPackage["Cadd`","Mtelch`"]
Cadd::usage="Cadd[A] 将矩阵A的各列都加到第1列上。"
Begin["`Private`"]
Cadd[A0_List]:=(
A=A0;d=Dimensions[A];m=d[[2]];Do[A=Cijk[A,i,1,1],{i,2,m}];
Return[A]
)
End[]
Protect[Cadd]
EndPackage[]