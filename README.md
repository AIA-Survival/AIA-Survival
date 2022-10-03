# AIA 生存指南

## 为什么需要生存指南

## 如何编译

首先运行 `helper.py` 文件，然后编译 `main.tex` 即可。

```shell
python3 ./helper.py
latexmk main.tex -outdir=out -interaction=nonstopmode -xelatex -jobname=AIA-Survival
```

## 参与贡献

在 `src` 目录下找到的一个合适位置，再给你的文章选取一个合适的名字。创建一个名为 `yyyymmdd-文章名.tex` 的文件（`yyyymmdd` 是你创建文章时的年月日信息，日期信息会帮助于文章的排版），如 `20220928-保研填系统.tex`。在你创建的 tex 文件中用 tex 的语法写下你的故事。这是一个案例：

```tex
\subsubsection{保研填系统}

哈哈哈哈哈哈哈哈哈哈哈

\begin{itemize}
	\item item1
	\item item2
\end{itemize}

\includegraphicx{res/haha}
```

==注意：==

- 不需要写 `\begin{document}` 等等，直接写正文即可
- 将图片等需要引用的资源统一放至 `res` 目录下，并相对该仓库的根目录进行引用，如 `res/pic.png`

