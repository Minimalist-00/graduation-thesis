%
% tpu-sotu.cls
%
% sotsuron.sty 20-Jan-92 by Yasuharu DEN
% revised      11-Jan-94 by Y. USUI                             
% revised       6-Jan-99 by Toru Nakazawa(In Marsh)
% revised       4-Feb-2022 by Dr. K

% クラス情報の宣言
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{tpu-sotu}[1999/01/06 v1.0 Standard pLaTeX class]

% ローカル設定ファイルの読み込み
\InputIfFileExists{tpu-sotu.cfg}%
  {\ClassInfo{tpu-sotu}{Using local configuration file}}%
  {\ClassInfo{tpu-sotu}{No local configuration file}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tpu-sotu}}

% サイズオプションの設定
\newcommand{\@tpuptsize}{}
\DeclareOption{10pt}{\renewcommand{\@tpuptsize}{10pt}
		     \def\@tputextheight{45.5}}
\DeclareOption{11pt}{\renewcommand{\@tpuptsize}{11pt}
		     \def\@tputextheight{44}}
\DeclareOption{12pt}{\renewcommand{\@tpuptsize}{12pt}
		     \def\@tputextheight{41.5}}

% ドラフト/最終版の設定
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}

% 既定値の設定
\ExecuteOptions{11pt,final}
\ProcessOptions
\LoadClass[a4j,\@tpuptsize]{jreport}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Chapter の前後のスペースを小さくする
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@makechapterhead#1{\hbox{}%
  \vskip\Cvs
  {\parindent\z@
   \raggedright
   \reset@font\huge\bfseries
   \ifnum \c@secnumdepth >\m@ne
     \setlength\@tempdima{\linewidth}%
     \setbox\z@\hbox{\@chapapp\thechapter\@chappos\hskip1zw}%
     \addtolength\@tempdima{-\wd\z@}%
     \unhbox\z@\nobreak
     \vtop{\hsize\@tempdima#1}%
   \fi}\vskip1.5\Cvs}
\def\@makeschapterhead#1{\hbox{}%
  \vskip\Cvs
  {\parindent\z@
   \raggedright
   \reset@font\huge\bfseries
   \setlength\@tempdima{\linewidth}%
   \vtop{\hsize\@tempdima#1}}\vskip1.5\Cvs}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \maketitle parameters.   revised Feb. 4 2022
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\newcommand{\eauthor}{\renewcommand{\@eauthor}}
%\newcommand{\@eauthor}{\ClassError{tpu-syuron}
%   {No \protect\eauthor~given}\@eha}

\newcommand{\etitle}{\renewcommand{\@etitle}}
\newcommand{\@etitle}{\ClassError{tpu-syuron}
   {No \protect\etitle~given}\@eha}

\newcommand{\department}{\renewcommand{\@department}}
\newcommand{\@department}{\ClassError{tpu-syuron}
   {No \protect\department~given}\@eha}

\newcommand{\gakusekibangou}{\renewcommand{\@gakusekibangou}}
\newcommand{\@gakusekibangou}{\ClassError{tpu-syuron}
   {No \protect\gakusekibangou~given}\@eha}

\newcommand{\professor}{\renewcommand{\@professor}}
\newcommand{\@professor}{\ClassError{tpu-syuron}
   {No \protect\professor~given}\@eha}

\def\@maintitle{卒 \ 業 \ 論 \ 文}
\def\@course{富山県立大学工学部}

\def\offset{0.5}

\def\maketitle{
    \begin{titlepage}
       \let\footnoterule\relax \setcounter{page}{0}
       \thispagestyle{empty}
       \begin{figure}\center
       \unitlength = 1cm
       \leavevmode
       \begin{picture}(1,1)(\offset,0)
       \put(1.0,9.5){\makebox(0,0){\makebox[8cm]{\LARGE \@maintitle}}}
       \put(1.0,6.5){\makebox(0,0){\parbox{12.7cm}{\center\LARGE \@title}}}
       \put(1.0, 4.5){\makebox(0,0){\parbox{15.7cm}{\center\LARGE \@etitle}}}
       \put(1.0,1.55){\makebox(0,0){\parbox{8cm}{\center\LARGE 指導教員 \@professor}}}
       \put(1.0,-7){\makebox(0,0){\parbox{\textwidth}{\center\large \@course\@department}}}
       \put(1.05,-8){\makebox(0,0){\parbox{\textwidth}{\center\large 学籍番号：\@gakusekibangou}}}
       \put(1.05,-9){\makebox(0,0){\parbox{\textwidth}{\center\LARGE \@author}}}
       \put(1.05,-10){\makebox(0,0){\parbox{\textwidth}{\center\large 提出年月：\@date}}}
       \end{picture}
       \end{figure}
       \setcounter{footnote}{0}
       \let\thanks\relax
       \def\@thanks{}\def\@author{}\def\@title{}%
       \def\@professor{}\def\@course{}\def\department{}%
       \let\maketitle\relax
    \end{titlepage}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 謝辞を目次に載せる
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\acknowledgements{%
  \c@secnumdepth = \m@ne
  \chapter*{\ackname\@mkboth{\ackname}{\ackname}\thispagestyle{plain}
  \addcontentsline{toc}{chapter}{\ackname}}
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \hspace{\parindent}%
}
\def\ackname{謝辞}

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 参考文献を目次に出してラベルを丸括弧でくくる
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\bibname{参考文献}
% \def\@biblabel#1{(#1)}
% \def\@cite#1#2{{$^{\mbox{\scriptsize $#1$}}$%
%     \if@tempswa , #2\fi}$^{\mbox{\scriptsize $)$}}$ }
% \renewenvironment{thebibliography}[1]
% {\chapter*{\bibname\@mkboth{\bibname}{\bibname}}%
%    \list{\@biblabel{\@arabic\c@enumiv}}%
% 	{\settowidth\labelwidth{\@biblabel{#1}}%
% 	 \leftmargin\labelwidth
% 	 \advance\leftmargin\labelsep
% 	 \@openbib@code
% 	 \usecounter{enumiv}%
% 	 \let\p@enumiv\@empty
% 	 \renewcommand\theenumiv{\@arabic\c@enumiv}}%
%    \sloppy
%    \clubpenalty4000
%    \@clubpenalty\clubpenalty
%    \widowpenalty4000%
%    \sfcode`\.\@m
%    \addcontentsline{toc}{chapter}{\protect\numberline{\bibname}}
%    }
%   {\def\@noitemerr
%     {\@latex@warning{Empty `thebibliography' environment}}%
%    \endlist}
% \endinput