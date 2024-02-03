  #!/usr/bin/perl -w
  use strict;
  # usage perl kmer.pl Sequence.fa > mers.fa

  my $in = $ARGV[0]; # Sequence.fa from "Result integration" section, and remove 2 head line. 
  my $b;
  my %h;
  open I,"<$in";
  while(defined($b=<I>)){
      $b =~ s/\n//igm;
      $b =~ s/\s//igm;
      $b =~ s/\*//igm;
      if($b =~ />/){}else{
          my @pr = &kmer($b);
          my $mers = join(',',@pr);
          print "$b:$mers\n";
      }
  }
  close I;

  sub kmer{
      (my $sequ) = @_;
      my @a = split //, $sequ;
      my $le = @a;
      my $len = int($le/2)-1;
      my $ii = 0;
      my @se;
      while($ii < $le){
         my $leng_set = $len;
         while($leng_set <= $le){
             if($ii+$leng_set < $le){
                 my $temp = join('',@a[$ii..$leng_set+$ii]);
                 push @se, $temp;
             }
             $leng_set++;
         }
         $ii++;
      }
  return @se;
  }
