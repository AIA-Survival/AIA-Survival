\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{survival}[leeziao]
\LoadClass[a4paper,oneside]{ctexbook}


\RequirePackage{chngcntr}
\counterwithin{chapter}{part}
\counterwithout{section}{part}

\RequirePackage{imakeidx}


\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{hyperref}

\hypersetup{
  bookmarksnumbered,
  colorlinks,
  linkcolor={black},
  citecolor={black},
  urlcolor={MidnightBlue}
}

\RequirePackage{graphicx}
\RequirePackage{graphbox}
\RequirePackage{wrapfig}

\RequirePackage{geometry}
\geometry{
  textwidth=138mm,
  textheight=215mm,
  %% left=27mm,
  %% or
  inner=23mm,
  %% right=27mm,
  %% or
  outer=18mm,
  top=25.4mm, bottom=25.4mm,
  headheight=2.17cm,
  headsep=4mm,
  footskip=12mm,
  heightrounded,
}

\RequirePackage[clearempty]{titlesec}
\RequirePackage{zhnumber}

\newcommand\HUGE{\@setfontsize\Huge{48}{60}}

%% part
\titleformat{\part} % command
[display] % shape
{\bfseries} % format
{
  \parbox[t]{7em}{\textcolor{gray}{\HUGE \textit{PART~\thepart}}} \hfill \zihao{4}第{\zhnum{part}}部分
  %\rule[3ex]{\textwidth}{.5pt}
  \vspace{1ex}
  \hrule width \hsize height .5pt
} % label
{1pt} % sep
{\vspace{-7ex}\flushright\zihao{2}} % before-code
[] % after-code

%% chapter
\titleformat{\chapter} % command
[display] % shape
{\bfseries} % format
{
  \flushright\zihao{4}第\zhnum{chapter}章
} % label
{1ex} % sep
{
  \hrule width \hsize height .5pt
  \vspace{-2ex}\flushright\zihao{2}
} % before-code
[
\vspace{5ex}
] % after-code


%% section
\titleformat{\section}
[hang]
{\rmfamily}
{\centering\zihao{-3}\bfseries\thesection\enspace}
{1pt}
{\zihao{-3}\bfseries}

%% subsection
\titleformat{\subsection}
[hang]
{\rmfamily}
{\zihao{-4}\bfseries\thesubsection\enspace}
{1pt}
{\zihao{4}\bfseries\filright}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% head and foot
%% 页眉页脚
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{fancyhdr}
\RequirePackage{zhnumber}

\pagestyle{fancy}
\fancyhf{}
\renewcommand\headrulewidth{0pt}
\renewcommand\footrulewidth{.5pt}
\futurelet\TMPfootrule\def\footrule{{\color{violet}\TMPfootrule}}

\renewcommand{\chaptermark}[1]{\markboth{第\zhnum{chapter}章\hspace{1em}#1}{}}
%\renewcommand{\sectionmark}[1]{\markright{\thesection\hspace{1em}#1}}
\renewcommand{\sectionmark}[1]{\markright{#1}}

\fancyfoot[LE]{\thepage\quad\vrule\quad\leftmark}
\fancyfoot[RO]{\rightmark\quad\vrule\quad\thepage}

\RequirePackage{indentfirst}
\setlength{\parindent}{2em}

%% 代码块
\RequirePackage{listings,verbatim}
\lstset{
	basicstyle={\ttfamily\footnotesize},
	keywordstyle={\bfseries\color{NavyBlue}}, 
	emph={String,main}, 
	emphstyle={\bfseries\color{Rhodamine}}, 
	alsoletter={.},
	commentstyle={\sffamily\color{PineGreen!50!black}}, 
	stringstyle={\rmfamily\color{Maroon}}, 
	frame=shadowbox, 
	framesep=1em, 
	framerule=1.3pt, 
	backgroundcolor={\color{lightgray!20!white}}, 
	rulecolor={\color{CadetBlue}}, 
	rulesep=3pt, 
	rulesepcolor={\color{CadetBlue!40!white}}, 
	numbers=left, 
	numbersep=2em, 
	numberstyle={\scriptsize\color{darkgray}}, 
	showstringspaces=false, 
	showspaces=false, 
	showtabs=false, 
	tabsize=4, 
	breaklines=true, 
}


\RequirePackage[many]{tcolorbox}
\RequirePackage{fontawesome}

%% 带标题的文本框
\newtcolorbox{titledbox}[1]{%
  tikznode boxed title,
  enhanced,
  arc=3pt,
  interior style={white},
  attach boxed title to top center = {yshift=-\tcboxedtitleheight/2},
  fonttitle=\normalfont,
  colbacktitle=white,coltitle=black,
  boxed title style={size=normal,colframe=white,boxrule=0pt},
  boxrule=.5pt,
  left=0pt, right=0pt, top=2pt, bottom=0pt,
  boxsep=10pt,
  colframe=violet,
  title={#1}
}

%% 信息
\newtcolorbox{information}{%
  enhanced,
  arc=3pt,
  interior style={white},
  boxrule=.5pt,
  left=40pt, right=0pt, top=2pt, bottom=0pt,
  boxsep=10pt,
  colframe=violet,
  overlay={
    \node[anchor=north west,outer sep=10pt] at (frame.north west)
    {
      \zihao{4}\faInfoCircle
    };
  }
}

%% 关键点
\newtcolorbox{keypoint}{%
  enhanced,
  arc=3pt,
  interior style={white},
  boxrule=.5pt,
  left=40pt, right=0pt, top=2pt, bottom=0pt,
  boxsep=10pt,
  colframe=violet,
  overlay={
    \node[anchor=north west,outer sep=10pt] at (frame.north west)
    {
      \zihao{4}\faKey
    };
  }
}

%% 警告信息
\newtcolorbox{exclamation}{%
  enhanced,
  arc=3pt,
  interior style={white},
  boxrule=.5pt,
  left=40pt, right=0pt, top=2pt, bottom=0pt,
  boxsep=10pt,
  colframe=violet,
  overlay={
    \node[anchor=north west,outer sep=10pt] at (frame.north west)
    {
      \zihao{4}\faExclamationTriangle
    };
  }
}

%% 问题信息
\newtcolorbox{question}{%
  enhanced,
  arc=3pt,
  interior style={white},
  boxrule=.5pt,
  left=40pt, right=0pt, top=2pt, bottom=0pt,
  boxsep=10pt,
  colframe=violet,
  overlay={
    \node[anchor=north west,outer sep=10pt] at (frame.north west)
    {
      \zihao{4}\faQuestionCircle
    };
  }
}
