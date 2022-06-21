# Secure and Efficient Query Processing in Outsourced Databases

As organizations struggle with processing vast amounts of information, outsourcing sensitive data to third parties becomes a necessity.
Various cryptographic techniques are used in outsourced database systems to ensure data privacy while allowing for efficient querying.
This thesis proposes a definition and components of a new secure and efficient outsourced database system, which answers various types of queries, with different privacy guarantees in different security models.

This work starts with the survey of five order-preserving and order-revealing encryption schemes that can be used directly in many database indices, such as the B+ tree, and five range query protocols with various tradeoffs in terms of security and efficiency.
The survey systematizes the state-of-the-art range query solutions in a snapshot adversary setting and offers some non-obvious observations regarding the efficiency of the constructions.

The thesis then proceeds with Epsolute - an efficient range query engine in a persistent adversary model.
In Epsolute, security is achieved in a setting with a much stronger adversary where she can continuously observe everything on the server, and leaking even the result size can enable a reconstruction attack.
Epsolute proposes a definition, construction, analysis, and experimental evaluation of a system that provably hides both access pattern and communication volume while remaining efficient.

The dissertation concludes with k-anon - a secure similarity search engine in a snapshot adversary model.
The work presents a construction in which the security of kNN queries is achieved similarly to OPE / ORE solutions - encrypting the input with an approximate Distance Comparison Preserving Encryption scheme so that the inputs, the points in a hyperspace, are perturbed, but the query algorithm still produces accurate results.
Analyzing the solution, we run a series of experiments to observe the tradeoff between search accuracy and attack effectiveness.
We use TREC datasets and queries for the search, and track the rank quality metrics such as MRR and nDCG.
For the attacks, we build an LSTM model that trains on the correlation between a sentence and its embedding and then predicts words from the embedding.
We conclude on viability and practicality of the solution.

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

<!-- `./document/build.sh -f && rm  -rf ./arxiv arxiv.zip && mkdir arxiv && cp -r ./document/* ./arxiv && cp ./document/dist/* ./arxiv && zip -r arxiv.zip arxiv` -->
