opendir($file,"./");
@betavalue=grep/\.idatbeta\.txt$/,readdir($file); closedir($file); # each uniformly processed file, such as GSM3398166.idatbeta.txt, comprises four columns: ID, beta value, detection p-value, normalized beta value.

$GSMcount=scalar(@betavalue);
foreach my $var (@betavalue){
	open($betafile,"./$var") || die "can not open1:$!\n";
	while(<$betafile>){
		chomp;
		if(/^ID/){next;}
		my @line=split(/\t/,$_);
		$rbeta=sprintf("%.2f",$line[3]); # normalized beta values in a specific study dataset are rounded to two decimal points.
		$hash{$line[0]}{$rbeta}++;
	}
	close($betafile);
}

open($output,">profile_curve.txt");
foreach my $var (sort keys %hash){
	print $output "$var\t";
	for($i=0;$i<=1;$i=$i+0.01){
		$i=sprintf("%.2f",$i);
		if(!exists $hash{$var}{$i}){
			$hash{$var}{$i}=0;
		}
		my $ratio=$hash{$var}{$i}/$GSMcount;
		$ratio=sprintf("%.5f",$ratio);
		print $output "$ratio\t";
	}
	print $output "\n";
}
close($output);
