*vo_readme.txt*   VimOutliner 0.3.3 for Vim 6.1+       *vo* *vimoutliner*

Contents

    LICENSE                                                      |vo-license|
    VERSION                                                      |vo-version|
    INSTALLING AND TESTING VIMOUTLINER                           |vo-install|
        Automatic method                                    |vo-auto-install|
        Updating an existing installation                       |vo-updating|
        Manual method                                     |vo-manual-install|
        Testing                                                  |vo-testing|
    USING VIMOUTLINER ON OTHER FILE TYPES                    |vo-other-files|
    TROUBLESHOOTING                                      |vo-troubleshooting|
    VIMOUTLINER PHILOSOPHY                                    |vo-philosophy|
    RUNNING VIMOUTLINER                                          |vo-running|
        What are the comma comma commands                        |vo-command|
        How do you perform basic VimOutliner activities       |vo-activities|
    CAUTIONS!!!                                                 |vo-cautions|
    ADVANCED                                                    |vo-advanced|                                                
        Executable Lines                                |vo-executable-lines|
    PLUGINS                                                      |vo-plugins|
        Checkboxes                                              |vo-checkbox|
        Hoisting                                                |vo-hoisting|
    SCRIPTS                                                      |vo-scripts|
        vo_maketags.pl                                          |vo-maketags|
        otl2html.py                                                |otl2html|
    OTHER INFORMATION                                         |vo-other-info|

-------------------------------------------------------------------------
LICENSE                                                      *vo-license*

    VimOutliner Copyright (C) 2001, 2003 by Steve Litt
                Copyright (C) 2004 by Noel Henson
    Licensed under the GNU General Public License (GPL), version 2
    Absolutely no warranty, see COPYING file for details.
    
    If your distro doesn't come with this file
        HTML: http://www.gnu.org/copyleft/gpl.html
        Text: http://www.gnu.org/copyleft/gpl.txt 

-------------------------------------------------------------------------
VERSION                                                      *vo-version*

    Version 0.3.3-pre-a
    Released 05/17/2004
   
    Version 0.3.3-pre
    Released 05/17/2004
   
    Additions/changes:
        Child-aware sort
        System-wide Linux installation script
        Modified time and date stamping functions (details: |vo-command|)
        Modify help to reflect the changes
        Simple executable lines
        Cross-platform Compatibility
            Replace the use of '!date' with strftime()
            Replace the use of '!sort' with child-aware function
            Windows installation script (this may be pushed-off until 0.3.4)
	

-------------------------------------------------------------------------
INSTALLING AND TESTING VIMOUTLINER                           *vo-install*

    How do I install VimOutliner?
        Automatic Method		|vo-auto-install|
        Updating        		|vo-updating|
    	Manual Method			|vo-manual-install|
        Testing                         |vo-testing|

        Automatic method                            *vo-auto-install*

	     The new automatic installation targets Unix-compatible
             platforms. 
             $ tar xzvf vimoutliner-0.3.x.tar.gz
             $ cd vimoutliner
             $ sh install.sh

             First you can decide whether to install the VimOutliner
             files or abort the process leaving everything unchanged.
             Assuming you confirmed the installation, the script
             creates the necessary directory tree and copies the files
             which provide the core functionality and documentation.

             With the second question you decide whether you want to
             install some brand new add-ons, currently implementing
             hoisting and checkboxes.

        Updating an existing installation                   *vo-updating*

             Updating an existing installation might require some
             manual work.

             If you are already working with a previous VimOutliner
             release, there is a slight chance that the current directory
             tree is different from your current one. In this case, you
             will have to manually migrate your files to the new locations.

             The installation script creates unique backups of files
             being replaced with newer versions. So if you put some
             local customisations into, say $HOME/.vimoutlinerrc, you'll
             probably have to merge the backup with the new file by hand.
            

        Manual method                                 *vo-manual-install*

            You can also copy the files from the unpacked distribution
            tarball into their destination folders by yourself. The
            following steps are a description of what has to go where
            and assume some knowledge of your vim setup.
            
            If you encounter problems, please contact the mailinglist
            for an immediate solution and more complete future
            documentation. www.lists.vimoutliner.org
            
            If you want to setup VimOutliner on a system running Microsoft
            Windows, the directory $HOME denotes the base folder of the
            vim installation.  If you're on Unix based system, $HOME
            is as usual.

            You need the following subtrees in your $HOME directory:
              $HOME/.vim/
                  doc/  ftdetect/  ftplugin/  syntax/
              $HOME/.vimoutliner/
                  plugins/  scripts/

            The distribution tarball unpacks into a directory vimoutliner
            with the following contents
              add-ons/
                plugins/               (2)
                scripts/               (2)
              doc/                     (1)
              ftdetect/                (1)
              ftplugin/                (1)
              install.sh*
              scripts/                 (2)
              syntax/                  (1)
              vimoutlinerrc            (3)

            (1) The content of these folders should be copied to their
                namesakes in the $HOME/.vim folder
            (2) The content of these folders should be copied to their
                namesakes in the $HOME/.vimoutliner folder
            (3) This file needs to be moved to $HOME/.vimoutlinerrc

            Your $HOME/.vimrc file should contain the lines
                 filetype plugin indent on
                 syntax on

            Your $HOME/.vim/ftplugin/vo_base.vim file should contain
            the lines
                 runtime! ftdetect/*.vim
                
            Finally, you need to integrate the online help provided
            with VimOutliner into the vim help system.  Start vim
            and execute the following command:
	        :helptags $HOME/.vim/doc

            At this point, VimOutliner should be functional.
	    Type "help vo" to get started.
            
    Testing base functionality                               *vo-testing*

        rm $HOME/vo_test.otl
        gvim $HOME/vo_test.otl
            or vim $HOME/vo_test.otl
        Verify the following:
            Tabs indent the text
            Different indent levels are different colors
            Lines starting with a colon and space word-wrap
		 Lines starting with colons are body text. They should
		 word wrap and should be a special color (typically
		 green, but it can vary). Verify that paragraphs of body
		 text can be reformatted with the Vim gq commands.

    Verify interoutline linking

        Interoutline linking currently requires a working perl installation
        to generate the necessary tag file. We are looking into porting
        this to vim's own scripting language.

        Place the following two lines in $HOME/vo_test.otl:
            _tag_newfile
                $HOME/vo_newfile.otl
        Note that in the preceding, the 2nd line should be indented
        from the first.

        To create VimOutliner's tag file $HOME/.vimoutliner/vo_tags.tag,
        run vo_maketags.pl, which resides in $HOME/.vimoutliner/scripts/:
            $ $HOME/.vimoutliner/scripts/vo_maketags.pl $HOME/vo_test.otl

        In $HOME/vo_test.otl
            Cursor to the _tag_newfile marker
            Press Ctrl+K
                You should be brought to $HOME/vo_newfile.otl 
            Press Ctrl+N
                You should be brought back to $HOME/vo_test.otl 
            Note:
                Ctrl+K is a VimOutliner synonym for Ctrl+]
                Ctrl+N is a VimOutliner synonym for Ctrl+T

-------------------------------------------------------------------------
USING VIMOUTLINER ON OTHER FILE TYPES                    *vo-other-files*

    How do I use VimOutliner on non .otl files

        Overview
	     Previous VimOutliner versions used the ol script to invoke
	     VimOutliner. As of VimOutliner 0.3.0, the ol script is no
	     longer necessary nor provided. Instead, VimOutliner is now a
	     Vim plugin, so Vim does all the work.
            
	     This makes VimOutliner much simpler to use in most cases,
	     but Vim plugins are file extension based, meaning that if
	     you want to use VimOutliner on a file extension other than
	     .otl, you must declare that file extension in
	     $HOME/.vim/ftdetect/vo_base.vim. In this section we'll
             use the .emdl extension (Easy Menu Definition Language)
             as an example.

        To enable VimOutliner work with .emdl files, do this:
            vim $HOME/.vim/ftdetect/vo_base.vim
            Right below the line reading:
                au! BufRead,BufNewFile *.otl        setfiletype vo_base
            Insert the following line:
                au! BufRead,BufNewFile *.emdl        setfiletype vo_base
            Save and exit
            Test with the following:
                gvim $HOME/vo_test.emdl
            You should get
                level colors,
                body text (lines starting with colon)
                comma comma commands (try ,,2 and ,,1)

-------------------------------------------------------------------------
TROUBLESHOOTING                                      *vo-troubleshooting*

    Troubleshooting

        I can't switch between colon based and space based body text
            See next question

        My ,,b and ,,B don't do anything. How do I fix it?
            vim $HOME/.vim/ftplugin/vo_base.vim
            Search for use_space_colon
            Make sure it is set to 0, not 1
            Rerun Vim, and ,,b and ,,B should work

        I don't get VimOutliner features on files of extension .whatever
            vim $HOME/.vim/ftdetect/vo_base.vim
            Right below the line reading:
                au! BufRead,BufNewFile *.otl          setfiletype vo_base
            Insert the following line:
                au! BufRead,BufNewFile *.whatever     setfiletype vo_base
            Save and exit

-------------------------------------------------------------------------
VIMOUTLINER PHILOSOPHY                                    *vo-philosophy*

    Authoring Speed
	VimOutliner is an outline processor with many of the same
	features as Grandview, More, Thinktank, Ecco, etc. Features
	include tree expand/collapse, tree promotion/demotion, level
	sensitive colors, interoutline linking, and body text.
        
	What sets VimOutliner apart from the rest is that it's been
	constructed from the ground up for fast and easy authoring.
	Keystrokes are quick and easy, especially for someone knowing the
	Vim editor. The mouse is completely unnecessary (but is supported
	to the extent that Vim supports the mouse). Many of the
	VimOutliner commands start with a double comma because that's
	very quick to type.
        
	Many outliners are prettier than VimOutliner. Most other
	outliners are more intuitive for the newbie not knowing Vim. Many
	outliners are more featureful than VimOutliner (although
	VimOutliner gains features monthly and is already very powerful).
	Some outliners are faster on lookup than VimOutliner. But as far
	as we know, NO outliner is faster at getting information out of
	your mind and into an outline than VimOutliner.
        
	VimOutliner will always give you lightning fast authoring. That's
	our basic, underlying philosophy, and will never change, no
	matter what features are added.

    Vim integration
	Earlier VimOutliner versions prided themselves on being
	standalone applications, self-contained in a single directory
	with a special script to run everything.
        
	As of 0.3.0, VimOutliner is packaged as a Vim Plugin, eliminating
	the need for the ol script, which many saw as clumsy. Given that
	all VimOutliner features are produced by the Vim engine, it makes
	perfect sense to admit that VimOutliner is an add-on to Vim.
        
	Therefore VimOutliner now prides itself in being a Vim plugin.
	With the VimOutliner package installed, the Vim editor yields the
	VimOutliner feature set for files whose extensions are listed as
	vo_base types in $HOME/.vim/ftplugin/vo_base.vim.
        
        The Vim Plugin philosophy yields several benefits:
            Less reliance on Perl, bash and environment vars
            (upcoming) Portability between Linux, Windows and Mac
            (upcoming) Installation via Vim script

-------------------------------------------------------------------------
RUNNING VIMOUTLINER                                          *vo-running*

    Vim knowledge is a prerequisite
        Overview
	    You needn't be a Vim expert to use VimOutliner. If you know
	    the basics -- inserting and deleting linewise and
	    characterwise, moving between command and insert modes, use
	    of Visual Mode selections,and reformatting, you should be
	    well equipped to use VimOutliner.
            
	    VimOutliner is a set of Vim scripts and configurations. Its
	    features all come from the Vim editor's engine. If you do not
	    know Vim, you'll need to learn the Vim basics before using
	    VimOutliner. Start by taking the Vim tutorial. The tutorial
	    should take about 2 hours.
            
	    VimOutliner is so fast, that if you often use outlining,
	    you'll make up that time within a week.

        Taking the Vim tutorial
            Run vim or gvim
            Type the command, :help tutor
            Follow the instructions

    What are the comma comma commands                        *vo-command*
        Overview
	    For maximum authoring speed, VimOutliner features are
	    accessed through keyboard commands starting with 2 commas.
	    The double comma followed by a character is incredibly fast
	    to type.
            
	    We expect to create more comma comma commands, so try not to
	    create your own, as they may clash with later comma comma
	    commands. If you have an exceptionally handy command, please
	    report it to the VimOutliner list. Perhaps others could
	    benefit from it.

        Command list
            ,,D   all      VimOutliner reserved command
            ,,H   all      reserved for manual de-hoisting (add-on)
            ,,h   all      reserved for hoisting (add-on)
            ,,1   all      set foldlevel=0
            ,,2   all      set foldlevel=1
            ,,3   all      set foldlevel=2
            ,,4   all      set foldlevel=3
            ,,5   all      set foldlevel=4
            ,,6   all      set foldlevel=5
            ,,7   all      set foldlevel=6
            ,,8   all      set foldlevel=7
            ,,9   all      set foldlevel=8
            ,,0   all      set foldlevel=99999
            ,,-   all      Draw dashed line
            ,,f   normal   Directory listing of the current directory
            ,,s   normal   Sort sub-tree under cursor ascending
            ,,S   normal   Sort sub-tree under cursor descending
            ,,t   normal   Append timestamp (HH:MM:SS) to heading
            ,,T  normal   Pre-pend timestamp (HH:MM:SS) to heading
            ,,T   normal   Pre-pend timestamp (HH:MM:SS) to heading
            ,,t   insert   Insert timestamp (HH:MM:SS) at cursor
            ,,d   normal   Append datestamp  (YYYY-MM-DD) to heading
            ,,d   insert   Insert datestamp  (YYYY-MM-DD) at cursor
            ,,D   normal   Pre-pend datestamp  (YYYY-MM-DD) to heading
            ,,B   normal   Make body text start with a space
            ,,b   normal   Make body text start with a colon and space
            ,,w   insert   Save changes and return to insert mode
            ,,e   normal   Execute the executable tag line under cursor

    What are some other VimOutliner Commands

        Overview
	    Naturally, almost all Vim commands work in VimOutliner.
	    Additionally, VimOutliner adds a few extra commands besides
	    the comma comma commands discussed previously.

        Command list:
            Ctrl+K        Follow tag (Synonym for Ctrl+])
            Ctrl+N        Return from tag (Synonym for Ctrl+T)
            Q             Reformat (Synonym for gq)

    How do you perform basic VimOutliner activities       *vo-activities*

        How do I collapse a tree within command mode?
            zc
            (note: a full list of folding commands |fold-commands|)

        How do I expand a tree within command mode?
            To expand one level:
                zo
            To expand all the way down
                zO

        How do I demote a headline?
            In command mode, >>
            In insert mode at start of the line, press the Tab key
            In insert mode within the headline, Ctrl+T

        How do I promote a headline?
            In command mode, <<
            In insert mode at start of the line, press the Backspace key
            In insert mode within the headline, Ctrl+D

        How do I promote or demote several consecutive headlines?
            Highlight the lines with the V command
            Press < to promote or > to demote. You can precede
            the < or > with a count to promote or demote several levels

        How do I promote or demote an entire tree?
            Collapse the tree
            Use << or >> as appropriate

        How do I collapse an entire outline?
            ,,1

        How do I maximally expand an entire outline?
            ,,0

        How do I expand an outline down to the third level?
            ,,3

        How do I move a tree?
            Use Vim's visual cut and paste

        How do I create body text?
            Open a blank line below a headline
            Start the line with a colon followed by a space
            Continue to type. Your text will wrap

        How do I reformat body text?
            Highlight (Shift+V) the body text to be reformatted
            Use the gq command to reformat

        How do I reformat one paragraph of body text?
            The safest way is highlighting.
                DANGER! Other methods can reformat genuine headlines.

        How do I switch between colon based and space based body text?
            ,,b for colon based, ,,B for space based

        What if ,,b and ,,B don't work
            Change variable use_space_colon from 1 to 0
                in $HOME/.vim/ftplugin/vo_base.vim

        How do I perform a wordcount?
            Use the command :w !wc
                The space before the exclamation point is a MUST.
            
-------------------------------------------------------------------------
CAUTIONS!!!                                                 *vo-cautions*


-------------------------------------------------------------------------
ADVANCED VIMOUTLINER                                        *vo-advanced*

    Executable Lines                                *vo-executable-lines*

    Executable lines enable you to launch any command from a specially 
    constructed headline within VimOutliner. The line must be constructed 
    like this:
 
        Description _exe_ command

    Here's an example to pull up Troubleshooters.Com:
 
        Troubleshooters.Com _exe_ mozilla http://www.troubleshooters.com

    Executable lines offer the huge benefit of a single-source knowledge 
    tree, where all your knowledge, no matter what its format, exists 
    within a single tree of outlines connected with inter-outline links and 
    executable lines.
 
 To enable this behavior, insert the following code into your $HOME/.vimoutlinerrc file:
-------------------------------------------------------------------------
PLUGINS                                                      *vo-plugins*

    The VimOutliner distribution currently includes two plugins
    for easy handling of checkboxes and to enable hoisting (see below).

    If you want to check out other plugins or experimental stuff,
    take a look at VimOutliner's home page http://www.vimoutliner.org

    You can find more complete descriptions in your $HOME/.vimoutliner/doc
    folder, what follows here are the "just the facts".

        Checkboxes                                          *vo-checkbox*

            Checkboxes enable VimOutliner to understand tasks and calculate
            the current status of todo-lists etc. Three special notations
            are used:

            [_]     an unchecked item or incomplete task
            [X]     a checked item or complete task
            %       a placeholder for percentage of completion

            Several ,,-commands make up the user interface:

            ,,cb  Insert a check box on the current line or each line
                  of the currently selected range (including lines in
                  selected but closed folds). This command is currently
                  not aware of body text. Automatic recalculation of
                  is performed for the entire root-parent branch that
                  contains the updated child. (see ,,cz)
            ,,cx  Toggle check box state (percentage aware)
            ,,cd  Delete check boxes
            ,,c%  Create a check box with percentage placeholder
            ,,cz  Compute completion for the tree below the current
                  heading.

           How do I use it?

               Start with a simple example.

               Let's start with planning a small party; say a barbeque.

               1. Make the initial outline

                   Barbeque
                       Guests
                           Bill and Barb
                           Larry and Louise
                           Marty and Mary
                           Chris and Christine
                           David and Darla
                           Noel and Susan
                       Food
                           Chicken
                           Ribs
                           Corn on the cob
                           Salad
                           Desert
                       Beverages
                           Soda
                           Iced Tea
                           Beer
                       Party Favors
                           Squirt guns
                           Hats
                           Name tags
                       Materials
                           Paper Plates
                           Napkins
                           Trash Containers
               2. Add the check boxes
		  This can be done by visually selecting them and typing 
                  ,,cb.  When done, you should see this:

                   [_] Barbeque
                       [_] Guests
                           [_] Bill and Barb
                           [_] Larry and Louise
                           [_] Marty and Mary
                           [_] Chris and Christine
                           [_] David and Darla
                           [_] Noel and Susan
                       [_] Food
                           [_] Chicken
                           [_] Ribs
                           [_] Corn on the cob
                           [_] Salad
                           [_] Desert
                       [_] Beverages
                           [_] Soda
                           [_] Iced Tea
                           [_] Beer
                       [_] Party Favors
                           [_] Squirt guns
                           [_] Hats
                           [_] Name tags
                       [_] Materials
                           [_] Paper Plates
                           [_] Napkins
                           [_] Trash Containers

               3. Now check off what's done
		  Checking off what is complete is easy with the ,,cx 
		  command.  Just place the cursor on a heading and ,,cx 
                  it. Now you can see what's done as long as the outline 
                  is fully expanded.

                   [_] Barbeque
                       [_] Guests
                           [X] Bill and Barb
                           [X] Larry and Louise
                           [X] Marty and Mary
                           [X] Chris and Christine
                           [X] David and Darla
                           [X] Noel and Susan
                       [_] Food
                           [X] Chicken
                           [X] Ribs
                           [_] Corn on the cob
                           [_] Salad
                           [X] Desert
                       [_] Beverages
                           [_] Soda
                           [X] Iced Tea
                           [X] Beer
                       [_] Party Favors
                           [_] Squirt guns
                           [_] Hats
                           [_] Name tags
                       [_] Materials
                           [X] Paper Plates
                           [_] Napkins
                           [X] Trash Containers

           4. Getting more advanced
               Now summarize what's done.

		You can summarize what is done with the ,,cz command. 
		Place the cursor on the 'Barbeque' heading and ,,cz it. 
		The command will recursively process the outline and 
		update the check boxes of the parent headlines. You 
		should see: 
		   (Note: the only change is on the 'Guests' heading. It 
                   changed because all of its children are complete.)

                   [_] Barbeque
                       [X] Guests
                           [X] Bill and Barb
                           [X] Larry and Louise
                           [X] Marty and Mary
                           [X] Chris and Christine
                           [X] David and Darla
                           [X] Noel and Susan
                       [_] Food
                           [X] Chicken
                           [X] Ribs
                           [_] Corn on the cob
                           [_] Salad
                           [X] Desert
                       [_] Beverages
                           [_] Soda
                           [X] Iced Tea
                           [X] Beer
                       [_] Party Favors
                           [_] Squirt guns
                           [_] Hats
                           [_] Name tags
                       [_] Materials
                           [X] Paper Plates
                           [_] Napkins
                           [X] Trash Containers

               Add percentages for a better view
		   You can get a much better view of what's going on, 
		   especially with collapsed headings, if you add 
		   percentages. Place a % on each heading that has children 
                   like this:

                   [_] % Barbeque
                       [X] % Guests
                           [X] Bill and Barb
                           [X] Larry and Louise
                           [X] Marty and Mary
                           [X] Chris and Christine
                           [X] David and Darla
                           [X] Noel and Susan
                       [_] % Food
                           [X] Chicken
                           [X] Ribs
                           [_] Corn on the cob
                           [_] Salad
                           [X] Desert
                       [_] % Beverages
                           [_] Soda
                           [X] Iced Tea
                           [X] Beer
                       [_] % Party Favors
                           [_] Squirt guns
                           [_] Hats
                           [_] Name tags
                       [_] % Materials
                           [X] Paper Plates
                           [_] Napkins
                           [X] Trash Containers

               Now compute the percentage of completion
		   After adding the % symbols, place the cursor on the 
		   'Barbeque' heading and execute ,,cz as before. Keep in 
		   mind that the recursive percentages are weighted. You 
                   should see:

                   [_] 58% Barbeque
                       [X] 100% Guests
                           [X] Bill and Barb
                           [X] Larry and Louise
                           [X] Marty and Mary
                           [X] Chris and Christine
                           [X] David and Darla
                           [X] Noel and Susan
                       [_] 60% Food
                           [X] Chicken
                           [X] Ribs
                           [_] Corn on the cob
                           [_] Salad
                           [X] Desert
                       [_] 66% Beverages
                           [_] Soda
                           [X] Iced Tea
                           [X] Beer
                       [_] 0% Party Favors
                           [_] Squirt guns
                           [_] Hats
                           [_] Name tags
                       [_] 66% Materials
                           [X] Paper Plates
                           [_] Napkins
                           [X] Trash Containers

               Complete a few more just for fun

                   Mark Salad and Soda and you should see the ouline below.
                  
		   Try plaing around with zc and zo to see the effects of 
		   opening and closing folds. Even if you place the cursor 
		   on 'Barbeque' and zo it, you still have a good 
                   understanding of how complete the project is.

                   [_] 69% Barbeque
                       [X] 100% Guests
                           [X] Bill and Barb
                           [X] Larry and Louise
                           [X] Marty and Mary
                           [X] Chris and Christine
                           [X] David and Darla
                           [X] Noel and Susan
                       [_] 80% Food
                           [X] Chicken
                           [X] Ribs
                           [_] Corn on the cob
                           [X] Salad
                           [X] Desert
                       [X] 100% Beverages
                           [X] Soda
                           [X] Iced Tea
                           [X] Beer
                       [_] 0% Party Favors
                           [_] Squirt guns
                           [_] Hats
                           [_] Name tags
                       [_] 66% Materials
                           [X] Paper Plates
                           [_] Napkins
                           [X] Trash Containers
           Limitations
               Body text is not yet supported
                   : ,,cb will falsely add a check box to body text.

        Hoisting                                            *vo-hoisting*

            Hoisting is a way to focus on the offspring of the currently
            selected outline item. The subitems will be presented as top
            level items in the automatically extracted hoist-file located
            in the same directory as the main outline file. You cannot
            hoist parts of an already hoisted file again.

            If you installed the add-on, you hoist the subtopics of
            the currently selected item with

            ,,h   Hoist the subtopics into a temporary file

            The changes are merged back into the original file by closing
            the temporary hoist file with

            :q  :wq  :x  ZZ

            If something went wrong, you can perform a manual de-hoisting
            with the following procedure:

            Open the main file in VimOutliner
            Search for the line containing the __hoist tag
            On this line, do

            ,,H    Manual de-hoisting

-------------------------------------------------------------------------
SCRIPTS                                                      *vo-scripts*

    The VimOutliner distribution currently includes two external scripts
    to support interoutline links and HTML export.

    If you want to check out other scripts or experimental stuff,
    take a look at VimOutliner's home page, http://www.vimoutliner.org

        vo_maketags.pl                                      *vo-maketags*

        A basic description of how to use this Perl script is given in
        section |vo-testing|, subsection "Verify interoutline linking".

        otl2html.py                                            *otl2html*

        This Python script transforms an outline into an HTML file where
        outline items appear in <Hn> (n=1,...,6) tags and body text
        is wrapped in <P>'s. It supports stylesheets and has a very
        helpful usage message

        $ otl2html.py --help

	This script does not adhere to the VimOutliner naming convention
	with the 'vo_' prefix because it is not necessary for any
	VimOutliner functionality. It is provided both as a useful tool
	for creating HTML pages and HTML slides from outlines and as
	a working demonstration of how to convert .otl files to other
	formats.

-------------------------------------------------------------------------
OTHER INFORMATION                                         *vo-other-info*

    The Vimoutliner Project

        How do I add my own features?
	    Two ways -- by changing VimOutliner source code, or by
	    inserting your own code in $HOME/.vimoutlinerrc, which runs
	    at the end of the VimOutliner startup scripts. You might have
            to merge your personal .vimoutlinerrc with future versions
            to take advantage of new features.

        How is VimOutliner licensed?
            VimOutliner is licensed under the GNU General Public License.

        How do I contribute to VimOutliner
	    Step 1 is to subscribe to our mailing list. Join up at
	    http://www.lists.vimoutliner.org/. Lurk for a few days or so 
            to get the feel, then submit your idea/suggestion. A lively 
            discussion will ensue, after which your idea, probably in 
            some modified form, will be considered. The more of the actual 
            work you have done, the more likely your feature will go in 
            the distribution in a
	    timely manner.

        VimOutliner Naming Convention
	    All VimOutliner files must begin with vo_ unless Vim itself
	    requires them to have a different name. A few older files
	    from previous versions break this rule, but over time these
	    will be changed to our naming convention.
            
	    In the old days, with the "self contained" philosophy, there
	    was no naming convention, because VimOutliner files were
	    segregated into their own tree. With the coming of the "vim
	    plugin" philosophy, there's a need to identify VimOutliner
	    files for purposes of modification, upgrade and
	    de-installation. Hence our naming convention.

        What if my feature doesn't make it into the VimOutliner distribution?
	    You can offer it Extra-Distro, either on your own website, or
	    very possibly on the VimOutliner home page, www.vimoutliner.org.  
	    VimOutliner ships with its core features, but many additional 
	    functionalities, especially those that operate from Perl scripts 
	    (or bash or python) are available outside the distro. For 
	    instance, right now there's an Executable Line feature that turns 
	    VimOutliner into a true single tree information reservoir. The 
	    Executable Line feature is available extra-distro on the 
	    VimOutliner home page.

    Anticipated improvements in later versions
        Command-invoking headlines
            Already prototyped
            Probably coming next version
            Allows you to press a key and get an html command in a browser
            Enables a true single tree knowledge collection
            Enables use of VimOutliner as a shell
        Groupware
            Not yet well defined
            Enables collaborative work on an outline
            A pipedream, but VimOutliner itself was once a pipedream
        Easy mode
            Let's Windows users operate VO like a common insert-only
            editor. This will remove a great deal of VO's keyboarder-
            friendly features. But then, they're Windows users: let them
            use the mouse.
        Headline to headline links
	    Not yet sanctioned, might never be implemented 
	    If implemented, this would presumably create links not just
	    between outlines, but between headlines, either in the same
	    outline or in a different one. This would be a start on
	    "neural networking".
        Headline numbering
            Under feasability investigation
	Menus in gvim
	    Prototyped but not well defined
	Toolbar in gvim
            Under feasability investigation
    Further information on outlines, outline processing and outliners
        http://www.vimoutliner.org
            Main distribution website
        http://www.troubleshooters.com/tpromag/199911/199911.htm
            Outlining discussion, not product specific
        http://www.troubleshooters.com/linux/olvim.htm 
            Discussion on how to use Vim for outlining
        http://www.troubleshooters.com/projects/vimoutliner.htm
            Former Webpage for the VimOutliner distro
        http://www.outliners.com
            Discussion of (proprietary) outliners from days gone by
            Downloads for ancient versions of such outliners
                Unfortunately, all are dos, windows and mac
        http://members.ozemail.com.au/~caveman/Creative/Software/Inspiration/index.html
            Discussion of (proprietary,Mac) Inspiration software
            This page discusses many methods of thought/computer interaction
                Visual Outlining
                Textual Outlining
                Idea mapping
                Mind Mapping
                Brainstorming with Rapid Fire Entry
                Concept Mapping
                Storyboarding
                Diagrams (using rich symbol library)
        http://members.ozemail.com.au/~caveman/Creative/index.html
            Not about outlines, but instead about how to use your brain
            The whole purpose of outlines is to use your brain
            New ways of using your brain produce new ways to use outlines
