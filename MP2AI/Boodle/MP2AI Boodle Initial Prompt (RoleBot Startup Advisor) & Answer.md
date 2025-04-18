# MP2AI Boodle Initial Prompt (RoleBot Startup Advisor) & Answer

**USING BOODLE RoleBot Startup Advisor**

I am stuck in a quandary that I am hoping you can help me with.



As you know, I have a church management system we use called Ministry Platform (MP).



MP has a knowledge base (KB) located here: https://help.acst.com/en/ministryplatform



ACST also has a learning academy here: https://academy.ministrysmart.com/pages/ministryplatform



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



There are tools such as the ones we already use like Scribe (https://scribehow.com/) and tools we are curious about using such as Tango AI (https://www.tango.ai/) in order to assist our users with MP training. However, I don't see any APIs for interacting with these platforms in order to automate the creation of training content (unless I'm missing something). This would mean IT would have to do a bit a manual work to accomplish that task. If there are alternative solutions/platforms, I am more than happy to learn about them.



I believe that ACST's KB and Academy are just a microcosm of hundreds or even thousands of other companies who struggle with the same issue of having learning content aligned with the product and not the end user. This means my idea of a solution for my current problem could theoretically be applied broadly to other companies and, thus, the creation of a middleware solution could benefit those companies, too.

## Answer

# Startup Advisor Response: Transforming Ministry Platform Learning

Thank you for sharing this detailed challenge, Chuck. You've identified a significant pain point that extends beyond just your organization - the misalignment between product-focused documentation and user-centric learning needs. This is indeed a common problem across many enterprise software platforms.

## Your Vision Analysis

Your proposed solution flow is well-structured and addresses the core issues. Let me provide some strategic insights on each component:

### 1. Content Acquisition Strategy

Scraping content from the KB and Academy is a logical first step, but consider these enhancements:

- **Permission considerations**: Ensure you have proper authorization from ACST to repurpose their content
- **Content enrichment**: Plan to supplement their materials with your own contextual knowledge about how your specific church implements MP
- **Maintenance strategy**: Consider how you'll keep your knowledge base updated when ACST updates their documentation

### 2. Storage Architecture

For the storage layer, consider:

- **Vector database**: For semantic search capabilities (Pinecone, Weaviate, etc.)
- **Metadata tagging**: Implement a robust tagging system to categorize content by persona, task type, and complexity level
- **Version control**: Track content changes over time, especially as MP evolves

### 3. LLM Integration

Your middleware concept is sound. Some considerations:

- **Fine-tuning vs. RAG**: Rather than "training" an LLM on the content, a Retrieval-Augmented Generation (RAG) approach might be more efficient and maintainable
- **Context window management**: Ensure your solution can handle the breadth of knowledge needed for complex queries
- **Evaluation metrics**: Define how you'll measure the accuracy and helpfulness of responses

### 4. User Interfaces

Your multi-interface approach is excellent. Additional thoughts:

- **Progressive disclosure**: Design interfaces that reveal complexity gradually as users become more proficient
- **Workflow integration**: Embed learning directly into the MP workflow where possible (e.g., contextual help)
- **Feedback loops**: Build mechanisms to capture user feedback on content quality and relevance

## Strategic Recommendations

Based on your situation, here are my recommendations:

1. **Start with a focused MVP**: Rather than building all interfaces simultaneously, begin with one high-impact persona (perhaps the most common role among your users) and one interface type.

2. **Consider a partnership approach with ACST**: Position this as a collaborative pilot that could benefit their broader customer base. This might help with content permissions and potentially share development costs.

3. **Evaluate existing platforms before building custom**: There are several platforms designed specifically for this use case that might reduce your development time:

   - **Spekit**: Offers in-app guidance and knowledge management
   - **Whatfix**: Provides contextual guidance and training
   - **Guru**: Knowledge management with browser extensions for contextual help

4. **Automation opportunities**: For tools like Scribe and Tango AI, while they may not have public APIs, they often support browser extensions or have enterprise plans with integration capabilities. Have you explored their enterprise offerings?

5. **Monetization potential**: Your insight about this being a broader market problem is spot-on. Consider how you might package this solution for other organizations facing similar challenges with different enterprise software.

## Next Steps Question

What aspect of this solution would you like to prioritize first? Would you prefer to focus on building a proof-of-concept for one persona type, or would you rather explore existing platforms that might accelerate your timeline?

#MP2AI/Boodle