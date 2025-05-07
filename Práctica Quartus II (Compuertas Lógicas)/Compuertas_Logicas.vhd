entity Compuertas_Logicas is
	port(a,b: in bit;
		 f_and,f_nor: inout bit;
		 f_or,f_nand,f_xor,f_xnor: out bit);
end Compuertas_Logicas;
architecture Arch_Compuertas_Logicas of Compuertas_Logicas is
begin
	f_and <= a and b;
	f_or <= a or b;
	f_nand <= a nand b;
	f_nor <= a nor b;
	f_xor <= a xor b;
	f_xnor <= f_nor or f_and;
end Arch_Compuertas_Logicas;