set -o vi
source ~/.alias
if [ -f ~/.local_alias ]  
then
    source ~/.local_alias
fi

export EDITOR=vim
export PS1='\w\$ '
export PATH=/usr/local/graphviz-2.12/bin:$PATH
export COPYFILE_DISABLE=true

#export P4USER=rmarty
#export P4PASSWD=changeme
#export P4CLIENT=rmarty

# Colorize the Terminal
export CLICOLOR=1;
export GREP_OPTIONS='--color=auto'

function digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}

shopt -s cdspell


#lgl() {
#        oldpwd=`pwd`
#        cd /home/ram/software/LGL-1.0/;
#        # ./setup.pl -c conffile;
#        bin/lgl.pl -c conffile $1;
#        cd perls
#        ./genVrml.pl /tmp/lgl/final.mst.lgl /tmp/lgl/final.coords
#        cd $oldpwd
#        freewrl /tmp/lgl/final.coords.wrl
#}

#giftoeps() {
#        giftopnm $1.gif | pnmtops  -noturn -rle -dpi 300 -scale 0.25 > $1.eps
#}
