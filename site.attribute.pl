open($input,"$ARGV[0]")||die "cannot open the input file.\n";# methylation profile matrix
open($output,">$ARGV[1]")||die "cannot open the output file.\n";

while(<$input>){
	chomp;
	my @line=split(/\t/,$_);
	@UTS=@line[1...46];
	@MTS=@line[56...101];
	@DTS=@line[47...55];
	for($i=0;$i<scalar(@UTS);$i++){$sumleft+=$UTS[$i];}
	for($i=0;$i<scalar(@MTS);$i++){$sumright+=$MTS[$i];}
	for($i=0;$i<scalar(@DTS);$i++){$summiddle+=$DTS[$i];} 
	$sumleft=sprintf("%.5f",$sumleft);
	$sumright=sprintf("%.5f",$sumright);
	$summiddle=sprintf("%.5f",$summiddle);
	print $output "$line[0]\t$sumleft\t$summiddle\t$sumright\t";
	if($sumleft>=1){print $output "UTS";}
	if($sumright>=1){print $output "MTS";}
	if($summiddle>=1){print $output "DTS";}
	print $output "\n";
	$sumleft="";
	$sumright="";
	$summiddle="";
}

close($input);
close($output);
