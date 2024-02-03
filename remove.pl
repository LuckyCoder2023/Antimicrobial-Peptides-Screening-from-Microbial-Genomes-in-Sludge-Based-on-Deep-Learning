   #!/usr/bin/perl -w
   use strict;
   my $in = "all_orf.fa";
   my $a;
   my %h;
   my $name;
   open I,"<$in";
   while(defined($a=<I>)){
       $a =~ s/\n//igm;
       if($a =~ />/){
           $a =~ s/\s/_/igm;
           $name = $a;
       }else{
           $a =~ s/\s//igm;
           $h{$a} = $name."\n".$a;
       }
   }
   close I;

   my $in1 = "AMPs.fa";
   my $b;
   open II,"<$in1";
   while(defined($b=<II>)){
       $b =~ s/\n//igm;
       if($b =~ />/){
       }else{
           $b =~ s/\s//igm;
           if($h{$b}){
               $h{$b} = "AMP";
           }
       }
   }
   close II;

   foreach my $k (keys %h){
       if($h{$k} eq "AMP"){ # Change eq with ne you can get kown AMP sequence as output
       }else{
           print "$h{$k}\n";
       }
   }
