#!"C:\xampp\perl\bin\perl.exe"
use strict;
use warnings;
use CGI;

my $parametro = CGI->new;
my @list;
my $nombre=$parametro->param('nombre');
my $licencia=$parametro->param('licencia');
my $departamento=$parametro->param('departamento');
my $programa=$parametro->param('programa');

#Las volvemmos mayuscula
$nombre=uc($nombre);
$licencia=uc($licencia);
$departamento=uc($departamento);
$programa=uc($programa);

		open(IN,"../licenciadas.csv") or die("Error al abrir el archivo");
		while(my $line = <IN>){
    
			$line=~ tr/áéíóúüñçÁÉÍÓÚÜÑÇÂÊÎÔÛâêîôû'/aeiouuncAEIOUUNCAEIOUaeiou /;
			
			
			my $recolectador=buscador($nombre,$licencia,$departamento,$programa,$line);
			
			if($recolectador eq "1"){
						
				my @lista= split(',',$line);
				my $cadena= $lista[1].",".$lista[4].",".$lista[10].",".$lista[16];
				
				push(@list,$cadena);
			}
			
			
		}
		






sub buscador{
	my($nombre, $licencia, $departamento, $programa, $linea)= @_;
	
	my @ref1;
	my @ref2;
	
	if($nombre ne ""){
		push(@ref1,1);
		push(@ref2,$nombre);
	}
	if($licencia ne ""){
		push(@ref1,4);
		push(@ref2,$licencia);
	}
	if($departamento ne ""){
		push(@ref1,10);
		push(@ref2,$departamento);
	}
	if($programa ne ""){
		push(@ref1,16);
		push(@ref2,$programa);
	}
	my @aux= split(',',$linea);
	my $recolectador=0;
	for(my $i=0;$i<@ref1;$i++){
		
		my $num=$ref1[$i];
		my $cadena=$ref2[$i];
		
		if($aux[$num]=~ /$cadena/){
			$recolectador+=1;
		}
		else{
			$recolectador-=1;
		}
	}
	if($recolectador==@ref2){
		return "1";
	}
	else{
		return "0";
	}
}