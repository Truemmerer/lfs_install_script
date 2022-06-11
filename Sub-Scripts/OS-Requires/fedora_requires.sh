#!bin/bash

# Installing Fedora Dependencies

# gcc-c++ > libstdc++-devel
# texinfo > perl-Class-Inspector perl-Exporter-Tiny perl-File-ShareDir perl-I18N-Langinfo perl-List-MoreUtils perl-List-MoreUtils perl-Params-Util perl-Unicode-EastAsianWidth perl-Unicode-Normalize perl-libintl-perl perl-locale 
# byacc

echo Installing Fedora Dependencies 
echo "$PASS" | sudo -S dnf install -y gcc-c++ libstdc++-devel texinfo perl-Class-Inspector perl-Exporter-Tiny perl-File-ShareDir perl-I18N-Langinfo perl-List-MoreUtils perl-List-MoreUtils perl-Params-Util perl-Unicode-EastAsianWidth perl-Unicode-Normalize perl-libintl-perl perl-locale byacc && return 1;
    