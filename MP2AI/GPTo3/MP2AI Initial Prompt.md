# MP2AI Initial Prompt
I am stuck in a quandary that I am hoping you can help me with.

As you know, I have a church management system we use called Ministry Platform (MP).

MP has a knowledge base (KB) located here: [https://help.acst.com/en/ministryplatform](https://help.acst.com/en/ministryplatform)

ACST also has a learning academy here: [https://academy.ministrysmart.com/pages/ministryplatform](https://academy.ministrysmart.com/pages/ministryplatform)

My users have indicated that they are having a hard time onboarding and developing their skills within MP, despite the availability of all of this documentation and help. Time constraints for learning are one of their primary obstacles. Not knowing where to start or how to level up their skills has also been an issue.

One of the conclusions I have come up with is that the online learning is too broad (mastery of the entire platform) and ACST relies too heavily on human-to-human onboarding post-contract and then followup with success managers. 

I have spoken to ACST leadership ad nauseam about changing their learning and documentation systems into a user persona-based system where everyday church roles and responsibilities align with the training they need to use MP right away and then paths forward to more advanced skills that help them master the entire platform. ACST recognizes this need but hasn't had the time or resources to seek this goal.

Therefore, I have a desire to change the system for them in order for my users to succeed and for their company to succeed.

The ideas I have have been operating on the following flow:
1. Scrape the KB and Academy for content
2. Place scraped content in appropriate storage
3. Create middleware surrounding an LLM that is trained on the content
4. Creating numerous interfaces for users based on how they desire to learn. These may include one or more of the following:
a. A persona-based knowledge base. For example, content for pastors, content for bookkeepers, content for event organizers, etc
b. An IT knowledge base within FreshService that can be utilized by techs and Freddy AI to quickly help close tickets from the parish users
c. A chat interface that can provide user support
d. An LMS first focused on onboarding any persona to the basics of MP and then training paths based on users personas to accomplish their daily tasks. After persona-based mastery the LMS should then cross-train those personas into paths of MP mastery.

There are tools such as the ones we already use like Scribe ([https://scribehow.com/](https://scribehow.com/)) and tools we are curious about using such as Tango AI ([https://www.tango.ai/](https://www.tango.ai/)) in order to assist our users with MP training. However, I don't see any APIs for interacting with these platforms in order to automate the creation of training content (unless I'm missing something). This would mean IT would have to do a bit a manual work to accomplish that task. If there are alternative solutions/platforms, I am more than happy to learn about them.

I believe that ACST's KB and Academy are just a microcosm of hundreds or even thousands of other companies who struggle with the same issue of having learning content aligned with the product and not the end user. This means my idea of a solution for my current problem could theoretically be applied broadly to other companies and, thus, the creation of a middleware solution could benefit those companies, too.

These are my initial ideas. However, the world of AI quickly changes, especially on the advent of Model Context Protocol (MCP) and Agent-to-Agent (A2A). 

I have had thoughts about how my middleware could be just the first step towards a completely AI agentic product that replaces systems like MP as it stands now. Additional AI-based user behavior analytics systems could shadow how our users learn from the new learning system we build out and then study their user behavior within MP. With this data, agentic AI could then start seeing automations that could be implemented to aid the users in their every day tasks and to free them up from those tasks. Naturally, as we move beyond the middleware and into a new product (NP) I can foresee RAG, MCP, and A2A eliminate almost every task within MP eventually. The end product would be one that interacts with the parishioner directly (who they are, their address, their donations, their sacraments and milestones, their group participation, etc) and their own data. This would produce the benefit of less man hours needed by staff to update the data and also prevent mistakes. Fewer employees would be needed and this would mean better stewardship of donor contributions to the parish, freeing the church to spend on higher order callings like the corporal works of mercy such as feeding the poor. 

The very system MP could even be replaced by an entirely new system (NP) that's as automated and agentic as possible once the NP has learned enough about the tasks that need to be accomplished.

This brings me to my quandary.

Do I actually need to build everything out as explained or is the better use of time and money resources building out the NP with the help of AI?

Please think this through and ask me any questions needed to help me explain anything or if you have insights I might not have thought of then prompt me for feedback.
#MP2AI/GPTo3