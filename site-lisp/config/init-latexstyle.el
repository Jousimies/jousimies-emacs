;;org-export latex
;;(setq org-latex-create-formula-image-program 'dvisvgm)
(setq org-alphabetical-lists t)
(setq org-latex-pdf-process
	'("xelatex -interaction nonstopmode %f"
	  "bibtex %b"
	  "xelatex -interaction nonstopmode %f"
	  "xelatex -interaction nonstopmode %f"
	  "rm -fr %b.out %b.log %b.tex %b.brf %b.bbl"
	  ))
(setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl")))
(setq org-latex-compiler "xelatex")
(require 'ox-latex)
(add-to-list 'org-latex-classes
	       '("org-dissertation"
		 "\\documentclass[UTF8,twoside,a4paper,12pt,openright]{ctexrep}
                \\setcounter{secnumdepth}{4}
                \\usepackage[linkcolor=blue,citecolor=blue,backref=page]{hyperref}
                \\hypersetup{hidelinks}
                \\usepackage{xeCJK}
                \\usepackage{fontspec}
                \\setCJKmainfont{SimSun}
                \\setCJKmonofont{SimSun}
                \\setCJKfamilyfont{kaiti}{KaiTi}
                \\newcommand{\\KaiTi}{\\CJKfamily{kaiti}}
                \\setmainfont{Times New Roman}
                \\usepackage[namelimits]{amsmath}
                \\usepackage{amssymb}
                \\usepackage{mathrsfs}
                \\newcommand{\\chuhao}{\\fontsize{42.2pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaochu}{\\fontsize{36.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\yihao}{\\fontsize{26.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaoyi}{\\fontsize{24.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\erhao}{\\fontsize{22.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaoer}{\\fontsize{18.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\sanhao}{\\fontsize{16.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaosan}{\\fontsize{15.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\sihao}{\\fontsize{14.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaosi}{\\fontsize{12.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\wuhao}{\\fontsize{10.5pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaowu}{\\fontsize{9.0pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\liuhao}{\\fontsize{7.5pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaoliu}{\\fontsize{6.5pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\qihao}{\\fontsize{5.5pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\bahao}{\\fontsize{5.0pt}{\\baselineskip}\\selectfont}
                \\usepackage{color}
                \\usepackage{geometry}
                \\geometry{top=2cm,bottom=2cm,right=2cm,left=2.5cm}
                \\geometry{headsep=0.5cm}
                \\usepackage{setspace}
                \\setlength{\\baselineskip}{22pt}
                \\setlength{\\parskip}{0pt}
                \\usepackage{enumerate}
                \\usepackage{enumitem}
                \\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\\parskip,topsep=5pt}
                \\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\\parskip,topsep=5pt}
                \\setdescription{itemsep=0pt,partopsep=0pt,parsep=\\parskip,topsep=5pt}
                \\usepackage{fancyhdr}
	              \\pagestyle{fancy}
	              \\fancyhead{}
	              \\fancyhead[CE]{\\KaiTi \\wuhao 东南大学}
	              \\fancyhead[CO]{\\KaiTi \\wuhao CFRP网格筋混凝土双向板冲切性能研究}
	              \\fancypagestyle{plain}{\\pagestyle{fancy}}
                \\ctexset{contentsname=\\heiti{目{\\quad}录}}
                \\ctexset{section={format=\\raggedright}}
                \\usepackage{titlesec}
	              \\titleformat{\\chapter}[block]{\\normalfont\\xiaoer\\bfseries\\centering\\heiti}{第{\\zhnumber{\\thechapter}}章}{10pt}{\\xiaoer}
	              \\titleformat{\\section}[block]{\\normalfont\\xiaosan\\bfseries\\heiti}{\\thesection}{10pt}{\\xiaosan}
	              \\titleformat{\\subsection}[block]{\\normalfont\\sihao\\bfseries\\heiti}{\\thesubsection}{10pt}{\\sihao}
	              \\titleformat{\\subsubsection}[block]{\\normalfont\\sihao\\bfseries\\heiti}{\\thesubsubsection}{10pt}{\\sihao}
	              \\titlespacing{\\chapter} {0pt}{-22pt}{0pt}{}
	              \\titlespacing{\\section} {0pt}{0pt}{0pt}
	              \\titlespacing{\\subsection} {0pt}{0pt}{0pt}
	              \\titlespacing{\\subsubsection} {0pt}{0pt}{0pt}
                \\usepackage[super,square,numbers,sort&compress]{natbib}
                \\usepackage{graphicx}
                \\usepackage{subfigure}
                \\usepackage{caption}
                \\captionsetup{font={small}}
                [NO-DEFAULT-PACKAGES]
                [NO-PACKAGES]
                [EXTRA]"
                ("\\chapter{%s}" . "\\chapter*{%s}")
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
	       '("org-article"
		 "\\documentclass[UTF8,twoside,a4paper,12pt,openright]{ctexart}
                \\usepackage[linkcolor=blue,citecolor=blue,backref=page]{hyperref}
                \\hypersetup{hidelinks}
                \\usepackage{xeCJK}
                \\usepackage{fontspec}
                \\setCJKmainfont{SimSun}
                \\setCJKmonofont{SimSun}
                \\setCJKfamilyfont{kaiti}{KaiTi}
                \\newcommand{\\KaiTi}{\\CJKfamily{kaiti}}
                \\setmainfont{Times New Roman}
                \\usepackage[namelimits]{amsmath}
                \\usepackage{bibspacing}
                \\usepackage{doi}
                \\usepackage{amssymb}
                \\usepackage{mathrsfs}
                \\newcommand{\\chuhao}{\\fontsize{42.2pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaochu}{\\fontsize{36.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\yihao}{\\fontsize{26.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaoyi}{\\fontsize{24.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\erhao}{\\fontsize{22.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaoer}{\\fontsize{18.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\sanhao}{\\fontsize{16.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaosan}{\\fontsize{15.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\sihao}{\\fontsize{14.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaosi}{\\fontsize{12.1pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\wuhao}{\\fontsize{10.5pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaowu}{\\fontsize{9.0pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\liuhao}{\\fontsize{7.5pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\xiaoliu}{\\fontsize{6.5pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\qihao}{\\fontsize{5.5pt}{\\baselineskip}\\selectfont}
                \\newcommand{\\bahao}{\\fontsize{5.0pt}{\\baselineskip}\\selectfont}
                \\usepackage{color}
                \\usepackage{geometry}
                \\geometry{top=2cm,bottom=2cm,right=2cm,left=2.5cm}
                \\geometry{headsep=0.5cm}
                \\usepackage{setspace}
                \\setlength{\\baselineskip}{22pt}
                \\setlength{\\parskip}{0pt}
                \\usepackage{enumerate}
                \\usepackage{enumitem}
                \\setenumerate[1]{itemsep=0pt,partopsep=0pt,parsep=\\parskip,topsep=5pt}
                \\setitemize[1]{itemsep=0pt,partopsep=0pt,parsep=\\parskip,topsep=5pt}
                \\setdescription{itemsep=0pt,partopsep=0pt,parsep=\\parskip,topsep=5pt}
                \\ctexset{contentsname=\\heiti{目{\\quad}录}}
                \\ctexset{section={format=\\raggedright}}
                \\usepackage{titlesec}
	              \\titleformat{\\section}[block]{\\normalfont\\xiaosan\\bfseries\\heiti}{\\thesection}{10pt}{\\xiaosan}
	              \\titleformat{\\subsection}[block]{\\normalfont\\sihao\\bfseries\\heiti}{\\thesubsection}{10pt}{\\sihao}
	              \\titleformat{\\subsubsection}[block]{\\normalfont\\sihao\\bfseries\\heiti}{\\thesubsubsection}{10pt}{\\sihao}
	              \\titleformat{\\subsubsubsection}[block]{\\normalfont\\sihao\\bfseries\\heiti}{\\thesubsubsubsection}{10pt}{\\sihao}
	              \\titlespacing{\\section} {0pt}{0pt}{0pt}
	              \\titlespacing{\\subsection} {0pt}{0pt}{0pt}
	              \\titlespacing{\\subsubsection} {0pt}{0pt}{0pt}
	              \\titlespacing{\\subsubsubsection} {0pt}{0pt}{0pt}
                \\usepackage[super,square,numbers,sort&compress]{natbib}
                \\usepackage{natbibspacing}
                \\usepackage{graphicx}
                \\usepackage{subfigure}
                \\usepackage{caption}
                \\captionsetup{font={small}}
                [NO-DEFAULT-PACKAGES]
                [NO-PACKAGES]
                [EXTRA]"
		 ("\\section{%s}" . "\\section*{%s}")
		 ("\\subsection{%s}" . "\\subsection*{%s}")
		 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}" . "\\paragraph*{%s}")
		 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
	       '("dn-article"
		 "\\documentclass[UTF8,twoside,a4paper,12pt,openright]{ctexart}
                [NO-DEFAULT-PACKAGES]
                [NO-PACKAGES]
                [EXTRA]"
		 ("\\section{%s}"         . "\\section*{%s}")
		 ("\\subsection{%s}"      . "\\subsection*{%s}")
		 ("\\subsubsection{%s}"   . "\\subsubsection*{%s}")
		 ("\\paragraph{%s}"       . "\\paragraph*{%s}")
		 ("\\subparagraph{%s}"    . "\\subparagraph*{%s}")
		))

(provide 'init-latexstyle)
