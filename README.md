# LaTeX document

The up-to-date version of the paper is built in CI and resides as artifact.

> To view the latest PDF, click on a badge `PDF | view online` at the top of the project page in GitLab.

## How to compile

```bash
bash ./document/build.sh # to compile
bash ./document/build.sh -f # to compile in fast mode
bash ./document/build.sh -d # to compile in draft mode
open ./document/dist/*.pdf # to open
```

*Fast mode* does not remove auxiliary files, so the subsequent recompilations are much faster.

*Draft mode* converts all PDF graphics into low-res PNG (output file is `report-draft.pdf`).
Draft mode requires `imagemagick` to be installed (`brew install` or `apt-get install`).

If using with Overleaf, it suggested to run `git config core.fileMode false`.
