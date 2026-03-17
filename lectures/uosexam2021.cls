%%
%% This is file `uosexam2021.cls'.
%% The original version was developed by Steve Gunn using the docstrip utility and extended.
%%
%%
%% This file is part of the uosexam class distribution
%%
%%


\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uosexam2021}[30/10/2015 v2.0 LaTeX document class]
\def\baseclass{book}

\usepackage[scaled]{helvet}
\renewcommand*\familydefault{\sfdefault} %% Only if the base font of the document is to be sans serif 

\usepackage{etoolbox} % Logic package replaces obsolete "ifthen"'
\usepackage{xstring} % String handling package
\RequirePackage{totcount}
%%
\newbool{withAnswers} % Determines if the answer(true) or camera read version is generated (false)
\newbool{withSections} % Determines if there are sections(true)
\DeclareOption{answers}{\booltrue{withAnswers}}
%%
%% Determines the style of the examination paper.
%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}
\def\@checkoptions#1#2{
  \edef\@curroptions{\@ptionlist{\@currname.\@currext}}
  \@tempswafalse
  \@tfor\@this:=#2\do{
    \@expandtwoargs\in@{,\@this,}{,\@curroptions,}
    \ifin@ \@tempswatrue \@break@tfor \fi}
  \let\@this\@empty
  \if@tempswa \else \PassOptionsToClass{#1}{\baseclass}\fi
}
\@checkoptions{10pt}{{10pt}{11pt}{12pt}}
\PassOptionsToClass{a4paper}{\baseclass}
\ProcessOptions\relax
\LoadClass{\baseclass}
\usepackage{version}
\usepackage{lastpage}
\usepackage{fancyhdr}
\renewcommand{\headrulewidth}{0.0pt}



%----------------------------------------------------------------------------------

% Sorts out the headers and footers
% Fiest Page
\fancypagestyle{first}{
    \fancyhf{}
    \fancyfoot[L]{\large  Copyright~{\arabic{yearplus1}}~\copyright~\univname}
    \fancyfoot[R]{\large  Page~\thepage~of~\pageref{LastPage}}
}
\fancypagestyle{body}{
    \fancyhf{}
    %\fancyhead[C]{\Large \thepage}
    \fancyhead[R]{\Large \ucode W1}
    \fancyfoot[RE]{\phantom{\LARGE{Z}} \hspace*{\fill} \\  \large Page~\thepage~of~\pageref{LastPage}}
    \fancyfoot[RO]{\LARGE \textbf{TURN OVER} \\ \vspace{10pt} \large  Page~\thepage~of~\pageref{LastPage}}
    \fancyfoot[L]{\phantom{\LARGE{Z}} \hspace*{\fill} \\ \large  Copyright~{\arabic{yearplus1}}~\copyright~\univname}
}
\fancypagestyle{last}{
    \fancyfoot{}
    \fancyfoot[C]{\LARGE \textbf{END OF PAPER}}
    \fancyfoot[L]{\phantom{\LARGE{Z}} \hspace*{\fill} \\ \large  Copyright~{\arabic{yearplus1}}~\copyright~\univname}
    \fancyfoot[R]{\phantom{\LARGE{Z}} \hspace*{\fill} \\ \large  Page~\thepage~of~\pageref{LastPage}}
}

%----------------------------------------------------------------------------------

\usepackage{setspace}
\singlespacing
\setlength{\parindent}{0pt}
\setlength{\parskip}{2.0ex plus0.5ex minus0.2ex}
\usepackage{amsmath,amsfonts,amssymb,amscd,amsthm,xspace}
\theoremstyle{plain}
\newtheorem{example}{Example}[section]
\newtheorem{theorem}{Theorem}[section]
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{axiom}[theorem]{Axiom}
\theoremstyle{definition}
\newtheorem{definition}[theorem]{Definition}
\theoremstyle{remark}
\newtheorem{remark}[theorem]{Remark}
\usepackage{vmargin}
\usepackage{keyval}
\setmarginsrb           { 2.5cm}  % left margin
                        { 2.0cm}  % top margin
                        { 2.5cm}  % right margin
                        { 2.0cm}  % bottom margin
                        {  20pt}  % head height
                        {  25pt}  % head sep
                        {  17pt}  % foot height
                        {  25pt}  % foot sep

\usepackage{graphicx}
\usepackage{color}
\usepackage{epstopdf}
\usepackage{eso-pic}
\usepackage{type1cm}
\usepackage{colortbl}
\newcounter{year}
\newcounter{yearplus1}
\newcounter{semnumber}
\newcounter{sec}
\newcounter{question}
\newcounter{totalquestions}
\newcounter{lastquestion}
\newcounter{subquestion}[question]
\newcounter{marks}[question]
\newcounter{submarks}[question]

\usepackage{refcount}

\renewcommand{\labelenumi}{(\alph{enumi})}
\renewcommand{\labelenumii}{(\roman{enumii})}

\renewcommand{\marks}[1]
{
    \hspace*{\fill}
    \nolinebreak[1]
    \hspace*{\fill}
    {[#1~marks]}\par
}

\renewcommand{\section}{
		 \booltrue{withSections}
     \stepcounter{sec}%
     \setcounter{question}{0} % resets question counter at the start of each section
     \begin{center}\textbf{\LARGE Section \Alph{sec}}\end{center}%
}

\renewcommand{\part}[1][0]{
    \ifnumgreater{\value{submarks}}{0}{\marks{\thesubmarks}\setcounter{submarks}{0}}{}
    \addtocounter{submarks}{#1}
    \addtocounter{marks}{#1}
    \item %
}

\newenvironment{parts}{
\begin{enumerate}}
{\ifnumgreater{\value{submarks}}{0}{\marks{\thesubmarks}\setcounter{submarks}{0}}{}\end{enumerate}}


\newenvironment{question}[1]{
    \stepcounter{question}
    \stepcounter{totalquestions}
    \newcommand{\totalmark}{#1}
    \ifbool{withSections}{\textbf{Question~\Alph{sec}\thequestion.}}{\textbf{Question~\thequestion.}}
   
}
{
    \ifnumequal{\value{marks}}{0}{\marks{\totalmark}}{
        \ifnumequal{\value{marks}}{\totalmark}{}{
            \ClassWarningNoLine{UoSExam}{Marks don't add up! (Question \thequestion)}
        }
    }
    
    %------------Determines last page style in camera ready  mode-------------------------------
    
   \ifnumequal{\thepage}{\getpagerefnumber{LastPage}}
   {
        \thispagestyle{last}
    }{}
    
    %-------------------------------------------------------------------
    \clearpage
}



\ifbool{withAnswers}{
    \renewcommand{\arrayrulewidth}{1pt}
    \newenvironment{answer}%
    {
        \begin{flushleft}
        Indicative Solution for Question~
        \ifbool{withSections}{\Alph{sec}\thequestion\labelenumi.}{~\thequestion\thepart.} %Add answer to the top of the answer section
        {\vskip 5pt \hrule height 1pt \vskip 0pt\relax}%
        \normalsize\bfseries%
    }
    {%
        {\vskip 3.4pt \hrule height 1pt \vskip -5.4pt\relax}% 
        
   %---------------Determines last page in answer mode, required due to answers being on seperate pages-----------------------------
    
   \ifnumequal{\thepage}{\getpagerefnumber{LastPage}}
   {
        \thispagestyle{last}
    }{}
    
    %-------------------------------------------------------------------
      %  \clearpage % forces questions and answers onto seperate pages
    
        \end{flushleft}
    }
    \makeatletter
    \ifnumequal{\thepage}{1}{
        \AddToShipoutPicture{%
            \put(370,350){%
            \makebox(0,0){\rotatebox{55}{\textcolor[gray]{0.9}{\fontsize{5cm}{5cm}\fontseries{m}\selectfont{Answers}}}}
            }
        }
    }{}
    
    \makeatother
    
}
{\excludeversion{answer}} % on false exclude the "answer" envoronment

\usepackage[centerlast,small,sc]{caption}
\setlength{\captionmargin}{20pt}
\newcommand{\fref}[1]{Figure~\ref{#1}}
\newcommand{\tref}[1]{Table~\ref{#1}}
\newcommand{\eref}[1]{Equation~\ref{#1}}
\newcommand{\cref}[1]{Chapter~\ref{#1}}
\newcommand{\sref}[1]{Section~\ref{#1}}
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}
\usepackage[scriptsize]{subfigure}
\usepackage{booktabs}
\usepackage{rotating}
\def\thebibliography#1{
      \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\reversemarginpar
\usepackage[pdfpagemode={None},bookmarks=true,bookmarksopen=false,
   bookmarksopenlevel=0,bookmarksnumbered=true,hypertexnames=false,
   colorlinks,linkcolor={blue},citecolor={blue},urlcolor={red},
   pdfstartview={FitV}, pdfpagelayout={TwoColumnLeft}, colorlinks=false]{hyperref}
\pdfstringdefDisableCommands{
   \let\\\space
   \let\spacefactor\space
   \let\@m\space
}


\newcommand*{\durationhours}[1]{\def\durationinhours{#1}}
\newcommand*{\addition}[1]{\def\additionalmaterail{#1}}
\newcommand*{\university}[1]{\def\univname{#1}}
\newcommand*{\UNIVERSITY}[1]{\def\UNIVNAME{#1}}
\newcommand*{\semester}[1]{\setcounter{semnumber}{#1}}
\newcommand*{\duration}[1]{\def\durationmins{#1}}
\newcommand*{\unitcode}[1]{\def\ucode{#1}}
\newcommand*{\unitTitle}[1]{\def\utit{#1}}
\newcommand*{\calculator}[1]{\def\calcoption{#1}}
\renewcommand*{\year}[1]{\setcounter{year}{#1}\setcounter{yearplus1}{#1}\stepcounter{yearplus1}}
\newcommand*{\QtoBeAnswered}[1]{\def\qtba{#1}}
\newcommand*{\NumberofQuestions}[1]{\def\noq{#1}}
\newcommand*{\specialInstructions}[1]{\def\sinstr{#1}}
\newcommand*{\specialInstructionsBox}[1]{\def\sinstrbox{#1}}
\newcommand*{\authors}[1]{\def\auths{#1}}
\university  {\texorpdfstring{\href{http://www.soton.ac.uk}
                {University of Southampton}}
                {University of Southampton}}
\UNIVERSITY  {\texorpdfstring{\href{http://www.soton.ac.uk}
                {UNIVERSITY OF SOUTHAMPTON}}
                {UNIVERSITY OF SOUTHAMPTON}}
 
%Command to print semester text

  \newcommand{\printsemestertext}[1]
  {
  \ifnumequal{#1}{1}{SEMESTER~\arabic{semnumber}~EXAMINATION~\arabic{year}~-~\arabic{yearplus1} \\[0.2cm]}{}
  \ifnumequal{#1}{2}{SEMESTER~\arabic{semnumber}~EXAMINATION~\arabic{year}~-~\arabic{yearplus1} \\[0.2cm]}{}
  \ifnumequal{#1}{3}{SUPPLEMENTARY~EXAMINATION~\arabic{year}~-~\arabic{yearplus1} \\[0.2cm]}{}
	}
	
%----------------------------------------------------------------------------------------------------	
%New command to print help box - if no text no box
%
\newcommand*{\printinstructiontextbox}[1]{%
 \StrLen{#1}[\mylen]
 \setlength{\fboxsep}{5pt}%
 \setlength{\fboxrule}{2pt}%
 %\StrSubstitute [0]{#1}{***}{\\}[\newstring]
 %\ifnumequal{\mylen}{0}{\par}{\parbox[\textwidth]{#1} \par}%
 \ifnumequal{\mylen}{0}{\par}{
 \fbox{\begin{minipage}[h]{\textwidth}
 #1 
 \end{minipage}
 }}
 
}
%------------------------------------------------------------------------------------------------------ 

\newcommand*{\printpagenumberandref}[1]{%
 \StrLen{#1}[\mylen]

%\ifnumequal{\mylen}{0}{Page~\thepage~of~\pageref{LastPage}}

\ifnumequal{#1}{0}{\pageref{LastPage} page examination paper.}

\ifnumequal{#1}{1}{\pageref{LastPage} page examination paper~+~#1~supplementary~sheet.}

\ifnumgreater{#1}{1}{\pageref{LastPage} page examination paper~+~#1~supplementary~sheets.}

}
%------------------------------------------------------------------------------------------------------
 %To count the total number of questions
 
 \regtotcounter{totalquestions}
 
 %----------------------------------------------------------------------------------------------------
 
 %% Defines the front page of the examination
 
  \renewcommand{\maketitle}{
    \hypersetup{pdftitle={\utit}}
    \hypersetup{pdfsubject={}}
    \hypersetup{pdfauthor={\auths}}
    \hypersetup{pdfkeywords={}}
    \Large
    \thispagestyle{first}
    \UNIVNAME \hfill \ucode W1
    \bigskip
    \rule{\textwidth}{1pt}
    \bigskip
		\printsemestertext{\arabic{semnumber}}
    {\MakeUppercase{\utit} \\[0.5cm]}
    {DURATION~\durationmins~MINS~(\durationinhours~Hours)\\}
    \bigskip
    \rule{\textwidth}{1pt}
    {This paper contains~\total{totalquestions}~questions\par}
    \vfill
 			\vspace{0.25cm}
       {\qtba\par}
       \vfill
       {An outline marking scheme is shown in brackets to the right of each question.\par}
     \vfill
       \sinstr \par
       \vfill
      \printinstructiontextbox{\sinstrbox}
      \par 
     \vfill
        {\calcoption\par}
        
        \vspace{0.25cm}
        
        {A foreign language dictionary is permitted ONLY IF it is a paper version of a direct ‘Word to Word’ translation dictionary AND it contains no notes, additions or annotations.\par}
        
        \vspace{0.25cm}
        
        \printpagenumberandref{\additionalmaterail}
    \vfill
    \newpage
    \pagestyle{body}
  }
  
\endinput
%%
%% End of file `uosexam2021.cls'.
