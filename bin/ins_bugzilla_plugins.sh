# cat test.txt|tr '\t' '\n'|grep ":" | sed 's|^|perl -MCPAN -e install |g'
perl -MCPAN -e install Chart::Lines
perl -MCPAN -e install Template::Plugin::GD::Image
perl -MCPAN -e install GD::Text
perl -MCPAN -e install GD::Graph
perl -MCPAN -e install MIME::Parser
perl -MCPAN -e install LWP::UserAgent
perl -MCPAN -e install XML::Twig
perl -MCPAN -e install Net::LDAP
perl -MCPAN -e install Authen::SASL
perl -MCPAN -e install Authen::Radius
perl -MCPAN -e install SOAP::Lite
perl -MCPAN -e install JSON::RPC
perl -MCPAN -e install JSON::XS
perl -MCPAN -e install Test::Taint
perl -MCPAN -e install HTML::Parser
perl -MCPAN -e install HTML::Scrubber
perl -MCPAN -e install Email::MIME::Attachment::Stripper
perl -MCPAN -e install Email::Reply
perl -MCPAN -e install Daemon::Generic
perl -MCPAN -e install Apache2::SizeLimit
perl -MCPAN -e install Math::Random::Secure


