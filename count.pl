  #!/usr/bin/perl -w
  # perl count.pl all_seq.fa > less_50_data.fa
  use strict;
  my $in = $ARGV[0];
  my $a;
  my $temp = "";
  open I,"<$in";
  while(defined($a=<I>)){
    $a =~ s/\n//gm;
    $a =~ s/\s/_/gm;
    if($a =~ />/){
      $temp = $a;    
    }else{
      my @len = split //, $a;
      my $le = @len;
      if(4 < $le && $le < 51){
        if($temp){
          print"$temp\n$a\n";
        }else{
          print "$a\n";
        }
      }
    }
  }
  close I; 
