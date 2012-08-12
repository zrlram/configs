" Snort syntax file
" Language:	  Snort Configuration File
" Maintainer:	  Phil Wood, cornett@arpa.net
" Last Change:	  20010119.1132
" Snort Version:  1.7 By Martin Roesch (roesch@clark.net, www.snort.org)
" TODO            include all 1.7 syntax

" Remove old syntax
syn clear

" Lower Priority Comments: after some hog commands...
" =======================
syn match  hogComment	+\s\#[^\-:.%#=*].*$+lc=1	contains=hogTodo,hogCommentString
syn region hogCommentString	contained oneline start='\S\s\+\#+'ms=s+1 end='\#'

syn match   hogJunk "\<\a\+|\s\+$" 
syn match   hogNumber contained	"\<\d\+\>"

" Environment Variables
" =====================
"syn match hogEnvvar contained	"[\!]\=\$\I\i*"
"syn match hogEnvvar contained	"[\!]\=\${\I\i*}"
syn match hogEnvvar contained	"\$\I\i*"
syn match hogEnvvar contained	"[\!]\=\${\I\i*}"


" String handling lifted from vim.vim written by Dr. Charles E. Campbell, Jr.
" <Charles.E.Campbell.1@gsfc.nasa.gov>
" Try to catch strings, if nothing else matches (therefore it must precede the others!)
"  vmEscapeBrace handles ["]  []"] (ie. stays as string)
syn region       hogEscapeBrace   oneline contained transparent     start="[^\\]\(\\\\\)*\[\^\=\]\=" skip="\\\\\|\\\]" end="\]"me=e-1
syn match        hogPatSep        contained        "\\[|()]"
syn match        hogNotPatSep     contained        "\\\\"
syn region       hogString        oneline          start=+[^:a-zA-Z>!\\]"+hs=e+1 skip=+\\\\\|\\"+ end=+"\s*;+he=s-1                contains=hogEscapeBrace,hogPatSep,hogNotPatSep oneline
""syn region       hogString        oneline          start=+[^:a-zA-Z>!\\]'+lc=1 skip=+\\\\\|\\'+ end=+'+                contains=hogEscapeBrace,vimPatSep,hogNotPatSep
"syn region       hogString        oneline          start=+=!+lc=1   skip=+\\\\\|\\!+ end=+!+                           contains=hogEscapeBrace,hogPatSep,hogNotPatSep
"syn region       hogString        oneline          start="=+"lc=1   skip="\\\\\|\\+" end="+"                           contains=hogEscapeBrace,hogPatSep,hogNotPatSep
"syn region       hogString        oneline          start="[^\\]+\s*[^a-zA-Z0-9.]"lc=1 skip="\\\\\|\\+" end="+"         contains=hogEscapeBrace,hogPatSep,hogNotPatSep
"syn region       hogString        oneline          start="\s/\s*\A"lc=1 skip="\\\\\|\\+" end="/"                       contains=hogEscapeBrace,hogPatSep,hogNotPatSep
"syn match        hogString        contained        +"[^"]*\\$+      skipnl nextgroup=hogStringCont
"syn match        hogStringCont    contained        +\(\\\\\|.\)\{-}[^\\]"+


" Beginners - Patterns that involve ^
"
syn match  hogLineComment	+^[ \t]*#.*$+	contains=hogTodo,hogCommentString,hogCommentTitle
syn match  hogCommentTitle	'#\s*\u\a*\(\s\+\u\a*\)*:'ms=s+1 contained
syn keyword hogTodo contained	TODO

" Rule keywords
syn match   hogARPCOpt contained "\d\+,\*,\*"
syn match   hogARPCOpt contained "\d\+,\d\+,\*"
syn match   hogARPCOpt contained "\d\+,\*,\d\+"
syn match   hogARPCOpt contained "\d\+,\d\+,\d"
syn keyword hogARespOpt contained rst_snd rst_rcv rst_all skipwhite
syn keyword hogARespOpt contained icmp_net icmp_host icmp_port icmp_all skipwhite
syn keyword hogAReactOpt contained block warn msg skipwhite
syn match   hogAReactOpt contained "proxy\d\+" skipwhite
syn keyword hogAFOpt contained logto content_list skipwhite
syn keyword hogAIPOptVal contained  eol nop ts sec lsrr lsrre satid ssrr rr skipwhite
syn keyword hogSessionVal contained  printable all skipwhite
syn match   hogAFlagOpt contained "[0FSRPAU21]\+" skipwhite
"
" Output syslog options
" Facilities
syn keyword hogSysFac contained LOG_AUTH LOG_AUTHPRIV LOG_DAEMON LOG_LOCAL0 
syn keyword hogSysFac contained LOG_LOCAL1 LOG_LOCAL2 LOG_LOCAL3 LOG_LOCAL4 
syn keyword hogSysFac contained LOG_LOCAL5 LOG_LOCAL6 LOG_LOCAL7 LOG_USER 
" Priorities
syn keyword hogSysPri contained LOG_EMERG ALERT LOG_CRIT LOG_ERR 
syn keyword hogSysPri contained LOG_WARNING LOG_NOTICE LOG_INFO LOG_DEBUG 
" Options
syn keyword hogSysOpt contained LOG_CONS LOG_NDELAY LOG_PERROR 
syn keyword hogSysOpt contained LOG_PID 

" Output log_database arguments and parameters
" Type of database followed by ,
" syn keyword hogDBSQL contained mysql postgresql unixodbc
" Parameters param=constant
" are just various constants assigned to parameter names

" Output log_database arguments and parameters
" Type of database followed by ,
syn keyword hogDBType contained alert log
syn keyword hogDBSRV contained mysql postgresql unixodbc
" Parameters param=constant
" are just various constants assigned to parameter names
syn keyword hogDBParam contained dbname host port user password sensor_name 

" Output xml arguments and parameters
" xml args
syn keyword hogXMLArg  contained log alert
syn keyword hogXMLParam contained file protocol host port cert key ca server sanitize encoding detail
"
" hog rule handler '(.*)'
syn region  hogAOpt contained oneline start="rpc" end=":"me=e-1 nextgroup=hogARPCOptGrp skipwhite
syn region  hogARPCOptGrp contained oneline start="."hs=s+1 end=";"me=e-1 contains=hogARPCOpt skipwhite
"
syn region  hogAOpt contained oneline start="nocase" end=";"me=e-1 skipwhite oneline keepend
"
syn region  hogAOpt contained start="resp" end=":"me=e-1 nextgroup=hogARespOpts skipwhite
syn region  hogARespOpts contained oneline start="." end="[,;]" contains=hogARespOpt skipwhite nextgroup=hogARespOpts
"
syn region  hogAOpt contained start="react" end=":"me=e-1 nextgroup=hogAReactOpts skipwhite
syn region  hogAReactOpts contained oneline start="." end="[,;]" contains=hogAReactOpt skipwhite nextgroup=hogAReactOpts

syn region  hogAOpt contained oneline start="depth\|seq\|ttl\|ack\|icmp_seq\|activates\|activated_by\|dsize\|icode\|icmp_id\|count\|itype\|tos\|id\|offset" end=":"me=e-1 nextgroup=hogANOptGrp skipwhite
syn region  hogANOptGrp contained oneline start="."hs=s+1 end=";"me=e-1 contains=hogNumber skipwhite oneline keepend

syn region  hogAOpt contained oneline start="regex\|msg\|content" end=":"me=e-1 nextgroup=hogAStrGrp skipwhite
syn region  hogAStrGrp contained oneline start=+:\s*"+hs=e+1 skip="\\;" end=+"\s*;+he=s-1 contains=hogString skipwhite oneline keepend

syn region  hogAOpt contained oneline start="logto\|content_list" end=":"me=e-1 nextgroup=hogAFileGrp skipwhite
syn region  hogAFileGrp contained oneline start="."hs=s+1 end=";"me=e-1 contains=hogFileName skipwhite


syn region  hogAOpt contained oneline start="flags" end=":"he=s-1 nextgroup=hogAFlagOpt skipwhite oneline keepend

syn region  hogAOpt contained oneline start="ipopts" end=":"he=s-1 nextgroup=hogAIPOptVal skipwhite oneline keepend

"syn region  hogAOpt contained oneline start="." end=":"he=s-1 contains=hogAFOpt nextgroup=hogFileName skipwhite

syn region  hogAOpt contained oneline start="session" end=":"he=s-1 nextgroup=hogSessionVal skipwhite

syn match   nothing  "$"
syn region  hogRules oneline  contains=nothing start='$' end="$" 
syn region  hogRules oneline  contains=hogRule start='('ms=s+1 end=")\s*$" skipwhite
syn region  hogRule  contained oneline start="." skip="\\;" end=";"he=s-1 contains=hogAOpts, skipwhite keepend
"syn region  hogAOpts contained oneline start="." end="[;]"he=s-1 contains=hogAOpt skipwhite
syn region  hogAOpts contained oneline start="." end="[;]"me=e-1 contains=hogAOpt skipwhite




" var command
syn keyword hogVarStart skipwhite var nextgroup=hogVarIdent skipwhite 
syn region  hogVarIdent contained  start="."hs=e+1 end="\s\+"he=s-1 contains=hogEnvvar nextgroup=hogVarRegion skipwhite 
syn region  hogVarRegion  contained  oneline  start="." contains=hogIPaddr,hogEnvvar,hogNumber,hogString,hogFilename end="$"he=s-1 keepend skipwhite

" include command
syn keyword hogIncStart	include  skipwhite nextgroup=hogIncRegion
syn region  hogIncRegion  contained  oneline  start="\>" contains=hogFileName end="$" keepend

" preprocessor command
" http_decode, minfrag, portscan[-ignorehosts]
syn keyword hogPPrStart	preprocessor  skipwhite nextgroup=hogPPr
syn match hogPPr   contained  "\<defrag\>" nextgroup=hogPPrRegion skipwhite
syn match hogPPr   contained  "\<stream\>" nextgroup=hogStreamRegion skipwhite
syn match hogPPr   contained  "\<http_decode\>" nextgroup=hogPPrRegion skipwhite
syn match hogPPr   contained  "\<minfrag\>" nextgroup=hogPPrRegion skipwhite
syn match hogPPr     contained "\<portscan[-ignorehosts]*\>" nextgroup=hogPPrRegion skipwhite
syn region  hogPPrRegion contained oneline	start="$" end="$" keepend
syn region  hogPPrRegion contained oneline	start=":" end="$" contains=hogNumber,hogIPaddr,hogEnvvar,hogFilename keepend
syn keyword hogStreamArgs contained timeout ports maxbytes
syn region hogStreamRegion contained oneline start=":" end="$" contains=hogStreamArgs,hogNumber

" output command
syn keyword hogOutStart	output  nextgroup=hogOut skipwhite
"
" alert_syslog
syn match hogOut   contained  "\<alert_syslog\>" nextgroup=hogSyslogRegion skipwhite
syn region hogSyslogRegion  contained start=":" end="$" contains=hogSysFac,hogSysPri,hogSysOpt oneline skipwhite keepend
"
" database
syn match hogOut  contained "\<database\>" nextgroup=hogDBTypes skipwhite
syn region hogDBTypes contained start=":" end="," contains=hogDBType nextgroup=hogDBSRVs skipwhite 
syn region hogDBSRVs contained start="\s\+" end="," contains=hogDBSRV nextgroup=hogDBParams skipwhite 
syn region hogDBParams contained start="." end="="me=e-1 contains=hogDBParam  nextgroup=hogDBValues
syn region hogDBValues contained start="." end="\>" contains=hogNumber,hogEnvvar,hogAscii nextgroup=hogDBParams oneline skipwhite
syn match hogAscii contained "\<\a\+" 
"
" log_tcpdump
syn match hogOut   contained  "\<log_tcpdump\>" nextgroup=hogLogRegion skipwhite
syn region  hogLogRegion  oneline	start=":" skipwhite end="$" contains=hogEnvvar,hogFileName keepend
"
" xml
syn keyword hogXMLTrans contained http https tcp iap
syn match hogOut     contained "\<xml\>" nextgroup=hogXMLRegion skipwhite
syn region hogXMLRegion contained start=":" end="," contains=hogXMLArg nextgroup=hogXMLParams skipwhite 
"syn region hogXMLParams contained start="." end="="me=e-1 contains=hogXMLProto nextgroup=hogXMLProtos 
"syn region hogXMLProtos contained start="." end="\>" contains=hogXMLTrans nextgroup=hogXMLParams
syn region hogXMLParams contained start="." end="="me=e-1 contains=hogXMLParam  nextgroup=hogXMLValue
syn region hogXMLValue contained start="." end="\>" contains=hogNumber,hogIPaddr,hogEnvvar,hogAscii,hogFileName nextgroup=hogXMLParams oneline skipwhite keepend
"
" Filename
syn match   hogFileName  contained "[-./[:alnum:]_~]\+"
syn match   hogFileName  contained "[-./[:alnum:]_~]\+"
" IP address
syn match   hogIPaddr   "\<\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\>"
syn match   hogIPaddr   "\<\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}/\d\{1,2}\>"

syn keyword hogProto	tcp TCP ICMP icmp udp UDP

" hog alert address port pairs
" hog IPaddresses
syn match   hogIPaddrAndPort contained  "\<\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\>" skipwhite                  nextgroup=hogPort
syn match   hogIPaddrAndPort contained  "\<\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}/\d\{1,2}\>" skipwhite         nextgroup=hogPort
syn match   hogIPaddrAndPort contained "\<any\>" skipwhite nextgroup=hogPort
syn match hogIPaddrAndPort contained     "\$\I\i*" nextgroup=hogPort skipwhite
syn match hogIPaddrAndPort contained     "\${\I\i*}" nextgroup=hogPort skipwhite
"syn match   hogPort contained "[\!]\=[\:]\=\d\+L\=\>" skipwhite
syn match   hogPort contained "[\:]\=\d\+\>" 
syn match   hogPort contained "[\!]\=\<any\>" skipwhite
syn match   hogPort contained "[\!]\=\d\+L\=:\d\+L\=\>" skipwhite

" action commands
syn keyword hog7Functions config skipwhite nextgroup=hogActRegion
syn keyword hog7Functions ruletype skipwhite nextgroup=hogActRegion
syn keyword hog7Functions activate skipwhite nextgroup=hogActRegion
syn keyword hog7Functions dynamic skipwhite nextgroup=hogActRegion
syn keyword hogActStart alert skipwhite nextgroup=hogActRegion
syn keyword hogActStart log skipwhite nextgroup=hogActRegion
syn keyword hogActStart pass skipwhite nextgroup=hogActRegion

syn region hogActRegion contained oneline start="tcp\|TCP\|udp\|UDP\|icmp\|ICMP" end="\s\+"me=s-1 nextgroup=hogActSource oneline keepend skipwhite
syn region hogActSource contained oneline contains=hogIPaddrAndPort start="\s\+"ms=e+1 end="->\|<>"me=e-2  oneline keepend skipwhite nextgroup=hogActDest
syn region hogActDest contained oneline contains=hogIPaddrAndPort start="->\|<>" end="$"  oneline keepend
syn region hogActDest contained oneline contains=hogIPaddrAndPort start="->\|<>" end="("me=e-1  oneline keepend skipwhite nextgroup=hogRules


" ====================
if !exists("did_hog_syntax_inits")
  let did_hog_syntax_inits = 1

  " The default methods for highlighting.  Can be overridden later
  hi link hogComment		Comment
  hi link hogLineComment	Comment
  hi link hogAscii		Constant
  hi link hogCommentString	Constant
  hi link hogFileName		Constant
  hi link hogIPaddr		Constant
  hi link hogNotPatSep		Constant
  hi link hogNumber		Constant
  hi link hogString		Constant
  hi link hogSysFac		Constant
  hi link hogSysOpt		Constant
  hi link hogSysPri		Constant
"  hi link hogAStrGrp		Error
  hi link hogJunk		Error
  hi link hogEnvvar		Identifier
  hi link hogIPaddrAndPort	Identifier
  hi link hogVarIdent		Identifier
  hi link hogAIPOptVal		PreProc
  hi link hogARespOpt		PreProc
  hi link hogAReactOpt		PreProc
  hi link hogAFlagOpt		PreProc
  hi link hogCommentTitle	PreProc
  hi link hogDBType		PreProc
  hi link hogDBSRV		PreProc
  hi link hogPort		PreProc
  hi link hogSessionVal		PreProc
  hi link hogXMLArg		PreProc
  hi link hogAFlagOpt		PreProc
  hi link hogARPCOpt		PreProc
  hi link hogPatSep		Special
  hi link hog7Functions		Todo
  hi link hogActStart		Statement
  hi link hogIncStart		Statement
  hi link hogOutStart		Statement
  hi link hogPPrStart		Statement
  hi link hogVarStart		Statement
  hi link hogTodo		Todo
  hi link hogAFOpt		Type
  hi link hogANoVal		Type
  hi link hogAStrOpt		Type
  hi link hogANOpt		Type
  hi link hogAOpt		Type
  hi link hogDBParam		Type
  hi link hogStreamArgs		Type
  hi link hogOut		Type
  hi link hogPPr		Type
  hi link hogActRegion		Type
  hi link hogProto		Type
  hi link hogXMLParam		Type
  hi link resp			Todo
endif

let b:current_syntax = "hog"

" hog: cpw=59
