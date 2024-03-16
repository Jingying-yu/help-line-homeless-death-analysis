# Starter folder

## Overview

This repo contains a revision of the paper: [Efforts to Code Calls created a Positive Impact
in Reducing Toronto’s Homeless Death Counts](other/literature/Sandy_Yu_old_paper.pdf) written in January 2024. Codes written are completed on the Integrated Development Environment Rstudio, using the statistical programming language R.

New version of the paper focuses on implementing linear regression models on analysis of the relationship between homeless death counts in Toronto and three observed efforts from Toronto's Central Intake Line: the number of calls coded, the number of referral to shelter, and the number of information for homelessness prevention.

Final pdf can be accessed [here](paper/paper.pdf).


## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from X.
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of the code and paper are completed with the help of OpenAI's large language model: ChatGPT. Chat history can be found in the folder `other/llm`.