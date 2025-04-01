# CSA BI Prompt
In ChatGPT o1

Prompt:

I would like to take data from our pledges and donations csv yearly files and begin to use Microsoft Power BI and Copilot to analyze the data.

You and I as technology leaders will create the environment, however, our end user will be the Director of Development who can easily use what we create via the ability to ask questions about the data, as well as have standard dashboards of data to glance at.

First return a project requirements document and review it before the next step. 

Then, return the step-by-step instructions to help me create this environment in Microsoft Power Bi and how to integrate Copilot with it. Also give me step-by-step instructions for 2 options of loading the data: 1) via csv file uploads, and/or 2) a data connection via API to Ministry Platforms API to collect the data.

Create two well-formed markdown files for the PRD and the step-by-step instructions.

Make sure you think about going from the start of this project to the final result and the target user and that all the steps are documented in case we want to repeat these steps with another similar project. This should be easy on my IT team to understand implementation and easy on the Director of Development.

Don't worry too much about dashboards for any other end user right now except for the director. Also, don't create anything too complicated when it comes to the functions that allow the director to ask questions of the data. We can always build up functionality as he becomes more comfortable with BI.

--

For context: The Catholic Diocese of Pensacola-Tallahassee has an annual pledge campaign called the Catholic Sharing Appeal (CSA for short). Other dioceses may call it the Bishop's appeal and they're all similar. The goal is to have our parishioners pledge and then give money towards that pledge in order for the Pastoral Center to have funds to proceed with its necessary functions such as HR, Accounting, and IT. We use Ministry Platform to track all parishioner donor pledging and giving (which is in addition to their tithing). Ministry Platform has a robust REST API we can talk to fetch the pledging and giving data. Our Director of Development came to IT and asked if he could have tools that help him track current success with this year's campaign. He is measuring success using many variables such as the number of donors, the pledge amounts, the giving so far, which parishes are leading or lagging, and much more. IT does not have the time or resources to dedicate a staff member to analyzing the data so we would like to rely on Power BI and Copilot to achieve the development directors desires.
#CSA