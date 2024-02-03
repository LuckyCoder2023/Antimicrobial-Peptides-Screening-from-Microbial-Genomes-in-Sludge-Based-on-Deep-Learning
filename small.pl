   #!/usr/bin/perl -w
   use strict;
   my $in = "fasta_sequence_name.txt";
   my ($a, $cmd);
   open I, "<$in";
   while(defined($a=<I>)){
       $a =~ s/\n//igm;
       my $out_name = $a.".orf.fa"; 
       $cmd = "getorf -sequence /home/lyx/".$a." -find 0 -table 11 -minsize 15 -maxsize 150 -outseq /home/lyx/".$out_name;
       system("$cmd");
       #print "$cmd\n"; # print command to screen before real execute
   }
   close I;
