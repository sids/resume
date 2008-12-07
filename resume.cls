% resume class v0.1
% 2008/12/06
% written by Siddhartha Reddy (sids [at] grok [dot] in)
% based on resume.cls by Miklos Csuros csuros@cs.yale.edu
%
% features
% 
% 1	\address[2] command for home and office address
%
% 2	category environment for resume sections
%       
% 

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[1997/02/07 v1.1 resume class]

\newif\if@wideadress\@wideadressfalse
\DeclareOption{wideadress}{\@wideadresstrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}



% -------------------------------------------------------
%  The following definitions can be changed in the LaTeX
%  file for a different look but the same structure. The 
%  rest of this file defines the structure and the 
%  commands.
% -------------------------------------------------------

\newcommand{\titlenamefont}{\bf\Large}	% the font used to print the name
					% on the top of the 1st page
\newcommand{\categoryfont}{\sc}		% font used to print the category
					% names
\reversemarginpar			% so that category names are on the
					% left for one-sided document and
					% left-right-left-... for two-sided

% -------------------------------------------------------
% - changing lengths
% -------------------------------------------------------

\setlength{\topmargin}{-1in}
\setlength{\textheight}{60\baselineskip}
\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-2in}

%%%%%% \setCategoryMargin
\newif{\if@categorymarginset}
\newcommand{\setCategoryMargin}[1][1in]{%
    \if@categorymarginset
        \addtolength{\textwidth}{-\marginparwidth}
        \addtolength{\textwidth}{-\marginparsep}
    \fi
    \setlength{\marginparwidth}{#1}
    \addtolength{\marginparwidth}{-\marginparsep}
    \addtolength{\textwidth}{\marginparwidth}
    \addtolength{\textwidth}{\marginparsep}
    \@categorymarginsettrue
}
\setCategoryMargin

%%%%%% \setSideMargins
\newif{\if@sidemarginsset}
\newcommand{\setSideMargins}[1][1in]{%
    \if@sidemarginsset
        \addtolength{\textwidth}{2\oddsidemargin}
    \fi
    \setlength{\oddsidemargin}{#1}
    \setlength{\evensidemargin}{\oddsidemargin}
    \addtolength{\textwidth}{-2\oddsidemargin}
    \@sidemarginssettrue
}
\setSideMargins

\newlength{\titlewidth}
\newlength{\addresswidth}

% -------------------------------------------------------
% - new commands
% -------------------------------------------------------

%%%%%%% \address                                       
\gdef\@addressA{\ClassWarning{resume}{%
	No address given.\MessageBreak
	Use \protect\address.}}
\newcommand{\address}[2]{\gdef\@addressA{#1}\gdef\@addressB{#2}}

%%%%%%% \author
\gdef\@author{\ClassError{resume}{%
	No author given.}{%
	Use \protect\author\space to specify it.}}


\newcommand{\topic}{\bf}
\newcommand{\hl}{\em}
\newcommand{\period}{\hfill\small\sl}


%%%%%% category environment
\newif{\if@firstitem}
\newenvironment{category}[2]{%
    \@firstitemtrue
    \def\makecategorytitle{%
        \if@firstitem
            \leavevmode\marginpar{\categoryfont\raggedright #1}%
        \fi
        \@firstitemfalse
    }
    \par
    \begin{list}{#2}{%
        \setlength{\leftmargin}{0in}	% no extra left margin before bullets
        \setlength{\parsep}{0in}
        \setlength{\parskip}{0.3em}
        \setlength{\itemsep}{0.6em}
        \let\olditem\item
        \renewcommand{\item}{\olditem\makecategorytitle}
    }
}
{\end{list}}


%%%%%%% \maketitle
\renewcommand{\maketitle}{%
	\setlength{\titlewidth}{\textwidth}
	\setlength{\addresswidth}{.5\textwidth}
  \begingroup
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@makeresumetitle
      \else
        \twocolumn[\@makeresumetitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@makeresumetitle
    \fi
    \thispagestyle{empty}
  \endgroup
  \if@twoside
      \markboth{\@author}{\@author}
  \else
      \markright{\hfill\@author\hfill}
  \fi
  \pagestyle{myheadings}
  \renewcommand{\thepage}{}	% because only the name is 
  				% needed in the heading and no pagenumbers
  
  \setcounter{footnote}{0}%
  \let\thanks\relax
  \let\maketitle\relax\let\@makeresumetitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}}
  
\def\@makeresumetitle{%
  \newpage
  \null
	\def\@moveleft{\hspace*{-\marginparwidth}\hspace*{-\marginparsep}}
  \@moveleft\makebox[\titlewidth]{\titlenamefont\@author}\\
  \@moveleft
  	\parbox[t]{\addresswidth}{\begin{flushleft}\@addressA\end{flushleft}}\hfill%
  \parbox[t]{\addresswidth}{\begin{flushright}\@addressB\end{flushright}}
  \par
  \vskip 0.6em}
  
\endinput

