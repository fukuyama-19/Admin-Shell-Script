print "Shell>";
        my $shell = <STDIN>;
        chop $shell;

        print "Username>";
        my $username = <STDIN>;
        chop $username;

        print "Password>";
        my $password = <STDIN>;
        chop $password;
        
        use WWW:Mechanize;
        use LWP::UserAgent;
        use HTTP::Request;
        
        $mech = WWW::Mechanize->new();
        $mech->get($shell);
        $mech->follow_link( n => 3 );
        $mech->follow_link( text_regex => qr/download this/i );
        $link = $mech->follow_link(url => "$url");
        $user = $mech->submit_form(
            form_number => 3,
            fields => {
                username => "$username",
                password => "$password",
            },
        );

        $request = HTTP::Request->new(GET=>$user);
        $ua = LWP::UserAgent->new();
        $req = $ua->request($request);

        if ($req->is_success) {
            print "[+] Scanning the target shell \n";
            sleep (3);
            print "[+] Scanning succesed \n";
            print "[+] Username : $username \n";
            print "[+] Password : $password \n";
        } 

        if ($req->content =~ /Access Dinied/) {
            print "[+] Scanning the target shell \n";
            sleep (3);
            print "[+] Failed scanning \n";
        } else {
            print "[+] Scanning the target shell \n";
            sleep (3);
            print "[+] Failed scanning \n";
        }
