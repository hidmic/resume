% Copyright [2022] Michel Hidalgo <hid.michel@gmail.com>
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%     http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.

% Local Variables:
% coding: utf-8
% mode: latex
% TeX-engine: xetex
% End:

\ProvidesClass{resume}
\NeedsTeXFormat{LaTeX2e}

\DeclareOption*{
  \PassOptionsToClass{
    \CurrentOption%
  }{article}
}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage[none]{hyphenat}

\RequirePackage{graphicx}
\RequirePackage{graphbox}
\newcommand{\icon}[1]{%
  \includegraphics[%
    keepaspectratio, align=c,%
    height=0.8\baselineskip]{#1}}

\RequirePackage{xcolor}
\definecolor{rhombus-black}{HTML}{130b08}
\definecolor{rhombus-gray}{HTML}{484743}
\definecolor{rhombus-lightgray}{HTML}{f5f5f7}
\definecolor{rhombus-copper}{HTML}{b06736}
\definecolor{rhombus-brown}{HTML}{765532}

\RequirePackage{fontspec}
\RequirePackage{fontawesome}
\defaultfontfeatures{Ligatures=TeX}
\setmainfont[
  Path=./fonts/Montserrat/,
  Extension=.otf,
  BoldFont=*-Bold,
  ItalicFont=*-Italic,
  BoldItalicFont=*-BoldItalic,
  UprightFont=*-Regular,
  Scale=0.85
]{Montserrat}

\RequirePackage[
  paper=a4paper,
  left=2cm,
  right=1.5cm,
  top=1cm,
  bottom=1cm
]{geometry}

\pagestyle{empty}
\pagecolor{rhombus-lightgray}
\color{rhombus-black}

\RequirePackage[
  pdfstartview=FitH,
  pdfpagelayout=OneColumn,
  pdfpagemode=UseOutlines,
  colorlinks=true,
  urlbordercolor=rhombus-brown,
  urlcolor=rhombus-brown,
]{hyperref}

\makeatletter
\Hy@AtBeginDocument{%
  \def\@pdfborder{0 0 1}% Overrides border definition set
  \def\@pdfborderstyle{/S/U/W 0.5}% Overrides border style set
  % Hyperlink border style will be underline of width 0.5pt
}
\makeatother

\RequirePackage{xstring}

\makeatletter
\newcommand*{\address}[2]{
  \StrSubstitute{#1}{ }{+}[\encoded@address]
  \StrSubstitute{\encoded@address}{\textdegree}{\%C2\%B0}[\encoded@address]
  \StrSubstitute{\encoded@address}{''}{\%22}[\encoded@address]
  \href{https://www.google.com/maps/place/\encoded@address}{\faCompass\ #2}}
\makeatother
\newcommand*{\mobile}[1]{\faMobile\ #1}
\newcommand*{\email}[1]{\href{mailto:#1}{\faEnvelope\ #1}}
\newcommand*{\github}[1]{\href{https://github.com/#1}{\faGithub\ #1}}
\newcommand*{\githubproject}[2]{\href{https://github.com/#2}{\faGithub\ #1}}
\newcommand*{\linkedin}[1]{\href{https://linkedin.com/in/#1}{\faLinkedin\ #1}}

\RequirePackage{pgf}
\newcommand{\texttransparent}[2][0]{%
  \pgfsetfillopacity{#1}#2\pgfsetfillopacity{1}}

\newcommand{\newbullet}[2]{%
  \newcommand{#1}{%
    \makebox[0pt][c]{#2}\texttransparent{-}}}

\RequirePackage{tikz}
\newbullet{\rhombus}{%
  \begin{tikzpicture}
    \filldraw[draw=rhombus-copper,fill=rhombus-copper]%
        (-0.1, 0) -- (0, 0.1) -- (0, -0.1) -- cycle;
    \filldraw[draw=rhombus-gray,fill=rhombus-gray]%
        (0, 0.1) -- (0.1, 0) -- (0, -0.1) -- cycle;
  \end{tikzpicture}%
}

\RequirePackage[inline]{enumitem}
\RequirePackage{keyval}

\makeatletter
\define@key{keys@inlined}{sep}{\def\sep@inlined{#1}}%%
\newenvironment{inlined}[1][]{%
  \setkeys{keys@inlined}{sep=\textbullet,#1}%
  \begin{itemize*}[label=,itemjoin={{ \sep@inlined{} }}]%
}{\end{itemize*}}%
\makeatother

\newcommand*{\desclabel}[1]{\rhombus\ #1\texttransparent{:}}

\setlist[description]{
  format=\desclabel,
  labelsep=2pt,
  itemsep=4pt,
  parsep=0pt,
  partopsep=0pt,
  topsep=0pt,
}

\setlist[itemize]{
  label=\rhombus,
  leftmargin=14pt,
  labelsep=4pt,
  itemsep=2pt,
  parsep=0pt,
  partopsep=0pt,
  topsep=0pt,
}


\RequirePackage[compact]{titlesec}
\RequirePackage{pgffor}
\newcommand*{\h}[1]{%
  \texttransparent{\makebox[0pt][c]{%
    % Do not lint ellipsis, necessary in \foreach expressions
    \hspace*{-#1 em}\foreach\n in {1,...,#1}{\#}\ % chktex 11
  }}%
}

\renewcommand*{\title}[1]{%
  \begingroup\normalfont\Huge%
  \StrCut{#1}{ }\csA\csB%
  \h1\textcolor{rhombus-gray}{\csA}
  \textcolor{rhombus-black}{\textbf{\csB}}
  \endgroup
}

\newcommand{\sectiontitle}[1]{%
  \h2\textcolor{rhombus-brown}#1~%
  \leavevmode\leaders\hrule height 0.5pt\hfill\kern0pt}
\titleformat{name=\section}
  {\normalfont\Large\bfseries}
  {\thesection}{1em}{\sectiontitle}

\makeatletter
\let\@subsection\subsection%
\newcommand{\@@subsection}[2][]{%
  \@subsection*{#1\ \h3#2}}
\renewcommand{\subsection}{%
  \@ifstar\@@subsection\@subsection}
\makeatother
\titleformat{name=\subsection}
  {\normalfont\large\bfseries}
  {\thesubsection}{2em}{}
\newcommand{\subsubsectiontitle}[1]{\h4#1}
\titleformat{name=\subsubsection}
  {\normalfont\normalsize\bfseries\color{rhombus-gray}}
  {\thesubsubsection}{1em}{\subsubsectiontitle}

\newcommand*{\at}[1]{\hfill{\small #1}}
\newcommand*{\thru}[2]{\hfill{\small #1-#2}}

\endinput
