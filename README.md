# Secure and Efficient Query Processing in Outsourced Databases

## Plan

- Introduction
  - motivation to outsource
  - motivation to secure and consequences of attacks
  - brief explanation of attacks models (snapshot and persistent)
  - query types
  - thesis structure and all published works
- Related Work
  - privacy
    - $`k`$-anonymity
    - $`\ell`$-diversity
    - $`t`$-closeness
    - differential privacy
  - snapshot range query security
    - a sentence to remind of what snapshot model is
    - property preserving encryption, OPE/ORE (without too much detail)
    - searchable symmetric encryption (SSE, Ioannis' work)
    - fully homomorphic encryption (just mention that its expensive)
    - attacks
      - "Inference attacks on property- preserving encrypted databases"
      - "The Tao of Inference in Privacy-Protected Databases"
      - "Why Your Encrypted Database Is Not Secure"
      - maybe more
  - persistent range query security
    - a sentence to remind of what persistent model is and how it's different from snapshot
    - expand $`\mathcal{E}\text{psolute}`$'s related work
      - access pattern
      - result size
      - SGX
    - attacks
      - "Generic Attacks on Outsourced Databases" (and it's followup)
      - maybe more
  - $`k`$NN query security
    - choose some works from [here](https://git.dbogatov.org/groups/bu/private-knn/-/wikis/Related-Work)
    - attacks
      - "Data Recovery on Encrypted Databases with k-Nearest Neighbor Query Leakage"
      - more from [here](https://git.dbogatov.org/groups/bu/private-knn/-/wikis/Related-Work)
- Background
  - symmetric Encryption
    - functionality and security definition
    - standardized instantiations
  - ORAM
    - motivation, definition, bounds and known constructions
    - PathORAM in more detail
  - Differential Privacy
    - motivation, history, definition, explanation of parameters
    - sanitizers
  - Outsourced Database model and its limitations
- Snapshot model range queries
  - motivation and model
  - 5 OPE/ORE schemes (description, performance, security and implementation notes)
  - 5 range query protocols (description, performance, security and implementation notes)
  - experiments and results
- Persistent model range queries
  - remind motivation and model
  - CDP-ODB enhanced model
  - single threaded version
  - parallel version (gamma and no-gamma)
  - experiments and results
- Snapshot model $`k`$NN queries
  - motivation and model
  - futility of non-randomized encryption
  - DCPE and application to $`k`$NN
  - Measuring search accuracy (dataset, experiments, results)
  - Measuring security (attack with and without DCPE)
- Conclusions and future work

## How to compile

The up-to-date version of the paper is built in CI and resides as artifact.

> To view the latest PDF, click on a badge `PDF | view online` at the top of the project page in GitLab.

```bash
bash ./document/build.sh # to compile
bash ./document/build.sh -f # to compile in fast mode
bash ./document/build.sh -d # to compile in draft mode
open ./document/dist/*.pdf # to open
```

*Fast mode* does not remove auxiliary files, so the subsequent recompilations are much faster.

*Draft mode* converts all PDF graphics into low-res PNG (output file is `report-draft.pdf`).
Draft mode requires `imagemagick` to be installed (`brew install` or `apt-get install`).

If using with Overleaf, it is suggested to run `git config core.fileMode false` and then `chmod +x ./document/build.sh ./test.sh`.
