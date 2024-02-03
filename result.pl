   #!/usr/bin/perl -w
   use strict;
   my $att = "att_amp.txt"; # result from attention model prediction
   my $lstm = "lstm_amp.txt"; # result from LSTM model prediction
   #my $bert = "bert_bact.txt"; # result from BERT model prediction
   my $seq = "amp.fa";
   my $a;
   my $l;
   #my $b;
   my $i = 1;
   my %h;
   open ATT, "<$att";
   while(defined($a=<ATT>)){
     $a =~ s/\s//igm;
     my $tmp;
     if($a > 0.9){
       $tmp = 1;
     }else{
       $tmp = 0;
     }
     $h{$i} = $tmp;
     $i++;
   }
   close ATT;

   $i = 1;
   open LSTM, "<$lstm";
   while(defined($l=<LSTM>)){
     $l =~ s/\s//igm;
     my $tmp;
     if($l > 0.9){
       $tmp = 1;
     }else{
       $tmp = 0;
     }
     $h{$i} = $h{$i} + $tmp;
     $i++;
   }
   close LSTM;

   #$i = 1;
   #open BERT, "<$bert";
   #while(defined($b=<BERT>)){
     #$b =~ s/\s//igm;
     #my $tmp;
     #if($b > 0.5){
      # $tmp = 1;
     #}else{
      # $tmp = 0;
    # }
     #$h{$i} = $h{$i} + $tmp;
    # $i++;
   #}
   #close BERT;

   print "There are $i sequences need to predictive.\n";
   print "name;size;AMP_prediction(1/0);\n";
   my $se;
   my %sequence;
   my $seq_name;
   my $j = 1;
   open SEQ, "<$seq";
   while(defined($se=<SEQ>)){
     $se =~ s/\s//igm;
     if($se =~ />/){
       my $pr;
       if($h{$j} == 2){
         $pr = 1;
       }else{
         $pr = 0;
       }
       $se = $se."|".$pr;
       $seq_name = $se;
       $j++;
     }else{
       $sequence{$seq_name} = $se;
     }
   }
   close SEQ;

   foreach my $k (keys %sequence){
       if($k =~ /\|1/){ # 1 means sequences with AMP activate，change $k =~ /\|1/ to $k =~ /\|/ will output all sequences with prediction values.
           print "$k\n$sequence{$k}\n";
       }
   }

