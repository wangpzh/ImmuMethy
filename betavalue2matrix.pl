opendir($file,"./");
@betavaluefiles=grep/\.idatbeta\.txt$/,readdir($file); closedir($file);
$GSMcount=scalar(@betavaluefiles);

foreach my $var (@betavaluefiles){
	open($file1,"./$var") || die "can not open1:$!\n";
		chomp;
		<$file1>;
		while(<$file1>){
			chomp;
			my @betavalues=split(/\t/,$_);
			@betavalues[3]=sprintf("%.5f",@betavalues[3]);
			push @{$hash{@betavalues[0]}},@betavalues[3];
		}
	close($file1);
}

open($outfile,">beta_value_matrix.txt");
foreach my $var (sort keys %hash){
	print $outfile "$var\t";
	@value=@{$hash{$var}};
	print $outfile join("\t",@value),"\n";
}
close($outfile);
