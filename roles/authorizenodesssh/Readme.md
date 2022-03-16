# Authorize Nodes for ssh rsync

Will deploy (and generate) ssh keys on each nodes in the given group
## Context
Will allow nodes to connect to each other without going back to the controler node (the one where ansible is launched).

## Prerequisite
ssh and rsync are installed on both nodes

## Variales

|Variable Name|Description|
|---|---|
|group|Group of host exchanging ssh keys|
