Requirement
===

* Provide a framework via user[1] could manipulate the graph of filter expressions. (for example could replace any sub-graph with a different subgraph)
* Supply an example algorithm that find and replaces a chain of same type of filters chained with *or* operator with an optimised version of the union of the filters expressions.


# Two possible solution

After some discussion two path was layed down, and explored in more details in order to choose/learn from it.
1. Use the existing *FilterExprNode* that is a graph and owned by *LogFilterPipe*
2. Use the *LogExprNode* to achieve the same (note: the *LogExprNode* currently knows about *LogFilterPipe* which owns *LogFilterPipe* that is the graph of filter expressions)

## 1. Use the existing *FilterExprNode* that is a graph and owned by *LogFilterPipe*

TODO by Szemere Laszlo

## 2. Use the *LogExprNode* to achieve the same (note: the *LogExprNode* currently mows about *LogFilterPipe* which owns *LogFilterPipe* that is the graph of filter expressions)

The idea is to have one IR[2] of the logpaths/logpipes (well it kinda already has with *LogExprNode*), and storing a lot of structural thing (the expression graph) in *FilterExprNode* is make the idea to optimise on the level of IR harder (if not impossible).
This was brought up because providing a way to manipulate a graph of *LogExprNode* is more general, it is almost as general as using *LogPipe* (which I would like to avoid).

The following should be done to have the above:
1. Clean up *LogExprNode* (currently the *content*, *layout* of *LogExprNode* are not really in sync with the real *LogPipe* it holds, see details later)
2. Build *LogExprNode* tree instead of *LogFilterPipe*
3. Create a graph walk framework
4. Create the example algorithm to replace chain of or operators
5. Some after thoughts about this solution take the time factor into account


1. Clean up *LogExprNode* (currently the *content*, *layout* of *LogExprNode* are not really in sync with the real *LogPipe* it holds, see details later)

This would involve to dive into the details of *LogExprNode* and use "correct" content and layout everywhere, by correct layout I mean that let *LogExprNode* holds a reference to a *LogParser* hold a *ENC_PARSER*, same with filter, destination, rewrite, ...
Currently for example a *LogExprNode* which actually owns the *LogFilterPipe* is *ENC_PIPE*.
This kind of misalignment do not have much effect currently, because those properties not really used now. (source, destination is which treated as special)


2. Build *LogExprNode* tree instead of *LogFilterPipe*

As of now (not the suggested change):
The current setup is *LogExprNode* --owns--> *LogFilterPipe* --owns--> *FilterExprNode* 
The *FilterExprNode* is either an or, and operator connecting two *FilterExprNode*, or a single *FilterExpNode* containing a specific filter logic itself (in-list, message, re).
This structure is also kept in run-time and called directly from the *LogFilterPipe*.

As describe before, having the structure (expression graph) in *FilterExprNode* is in the way, so extending the *LogExprNode* with *FilterExprNode* would be the way to go.

How to transform the current *FilterExprNode* into *LogExprNode* (I am not suggest that the code does this, just describing the new scheme based on the current)
* *FilterExprNode* just holds a filter logic(in-list, message, re, ...) in this case it is done, as 1 *LogExprNode* refers to 1 *LogFilterPipe* which contains trivial filter expression
* *FilterExprNode* is a composition of 2 *FilterExprNode* and an operator.
  This should be replaced with 1 *LogExprNode* containing the operator and a reference to 2 *LogExprNode* (which either holds a trivial filter expression as before, or a complex expression that should be replaced according to this rule.)
* Do the above two until there is only *LogExprNode*

After parsing the grammar now we have a *LogExprNode* only, also additionally the *LogExprNode* are compiled (in syslog-ng this means connecting the *LogPipe*s).
The *compilation* phase also has to learn about the new filter type of *LogExprNode*'s and how to transfare them.


3. Create a graph walk framework


Note1: The traverse of any graph is kinda trivial task, does not worth more mentioning here.
Note2: The majority of the filters are not a plugin/module; but because that is a worse case (and a possibility) I bend the reality and assume that much.
Note3: This also assumes that anything that is a context[3] *must be* part of the core library (*libsyslog-ng*)

Now the *LogExprNode* knows that it is either a *parser*, *filter* or whatever, even if it holds a *LogPipe* that is sure not just a simple pipe. Additionally the connection between those type of pipes also known. But in order to act upon those it is not enough information.

For example to implode multiple filters into one (solve the 2nd part) the exact type of filter should be known, and even some details about that filter.
Resolution for this approach would be to further push *LogExprNode* into the IR way, and expend *LogExprNode* to the level where it is possible to create the *LogPipe* from a *LogExprNode* (so it contains all the needed information). (Even that I wanted to avoid stating about a path forward, this is something that WON'T be done now, as that requires ludicrous effort to do.)
As an alternative, the type of context (LogParser, LogFilter, ...) should be able to define a function that recieves a set of LogParser/LogFilter/...; and returns with the fact that it can be optimised or not, and if it can be the optimised version of them.



4. Create the example algorithm to replace chain of or operators

This is kinda not hard if the above steps are done, I do not wish to expand it as of now.

5. Some after thoughts about this solution take the time factor into account

Initially I had a scheme of such thing (not in that detailed), and I said it requires 1 cadence and 2 people (2 month).
Currently I am sure it won't fit into 2 cadence (which amount we do not have).
Also the above was just more implementation effort, but testing is also not small even on the scope of regression. (Complex filter expression must be tested not to break them).


I see two places where it could be cut and do less work:
* The 1. step not to cleanup the whole *LogExprNode* just the currently needed *filter* related ones
* As explained in the 3. step, not to push the IR all the way, just let the context related pipes (LogParser/LogFilter/...) deal with the optimisation.

Still do not think those reduces the effort to fit into 1 cadence, but I believe the "1. Use the existing *FilterExprNode* that is a graph and owned by *LogFilterPipe*" can fit into (possible less than a 1 cadence). 





[1] The programmer, who write the code.
[2] Internal representation
[3] By context I mean *LL_CONTEXT_{SOURCE,DESTINATION,FILTER,PARSER,...}* and their *LogPipe* - at least - abstract part.
