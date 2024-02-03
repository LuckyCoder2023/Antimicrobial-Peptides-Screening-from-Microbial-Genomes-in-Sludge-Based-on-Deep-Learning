  #!/usr/bin/perl -w
  use strict;
  # usage perl k_mer_dict.pl mers.fa key_values_01

  my $in = $ARGV[0];
  my $b;
  my %h;
  my $b1;
  open I,"<$in";
  while(defined($b=<I>)){
      $b =~ s/\n//igm;
      $b =~ s/(?<se>.*:)(?<k>.*)//igm;
      $b1 = $+{se};
      my $pp = $+{k};
      my @pr = split /,/, $pp;
      $b1 =~ s/://igm;
      dic1(@pr,$b1);
  }
  close I;

  sub dic1{
      (my @ks) = @_;
      my $va = $b1;
      foreach my $kk (@ks){
          $h{$kk}{$va} = 1;
      }
  }

  foreach my $ke (keys %h){
      my $h2 = $h{$ke};
      my $k2 = join(',',keys %$h2);
      print "$ke: ", $k2,"\n";
  }
