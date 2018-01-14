---
title: "Looking Back"
excerpt: "Before I move on to writing about the new technologies I am working with in my new position, I thought it would be good to look back over my time at my first technology job."
categories:
  - articles
---

Before I move on to writing about the new technologies I am working with in my new position,
I thought it would be good to look back over my time at my first technology job.

## Automated Testing

I spent a year and a half with [G2G3][1]; I was hired to work as a Junior Developer in Test,
to aid in creating an automated testing framework for browser and device testing
on a large project that was well under way. Apart from programming, everything else was
brand new to me. The level of testing I was doing at university was just, "Does it compile?"

Unfortunately, there wasn't much in the way of training, mentoring, or guidance in any form.
One of the senior web developers suggested signing up to [Pluralsight][2] for online courses,
which I did, and still use today. They have a wide range of courses that have so far been very helpful.
They don't have courses on everything I've been looking for, but they have enough to make the service worthwhile to me.

After settling in to the company, I started delving into BDD (Behaviour-Driven Development),
[SpecFlow][3], and [Selenium][4].

### BDD and SpecFlow

SpecFlow is a C# framework for defining your tests in the [Cucumber][5] Given, When, Then format which uses the [Gherkin][6] parser.
Each test becomes a Scenario, and a number of scenarios are grouped into Features.

This allowed for writing tests that were easy to understand by all areas of the team. The hardest part we found
was trying to define a consistent DSL (Domain Specific Language) which would also allow the use of an ubiquitous language.
This approach helps with DDD (Domain-Driven Design), if your team wants to go that way.

We were aiming for a situation where any member of the team would be able to write the tests and wouldn't need to know
anything about how these tests would actually be executed.

### Selenium

Beneath SpecFlow, we were using Selenium to control the browsers and devices (through [Appium][7]).
Selenium was a great tool to work with. I ended up doing what many sources suggested, which was to
create my own abstraction layer over Selenium to make some things a little easier.
Doing it this way also made it easier for me to automate devices and browsers through the same interfaces.
It took a while to fully understand how it worked on different browsers, and how to get around some of
the quirks, but overall it was nice to work with.

I created a framework to manage our implementation of these tools so that we could have automated tests
on all of our projects. I initially had the intention of extending this framework to automate the legacy
Windows desktop applications, but we abandoned this idea due to time constraints.

I wanted to change as little as possible in the code itself, so I implemented my own take on the
page object pattern. Rather than use classes, I decided to put all the page and element details into
configuration files. This worked out great, but was a little confusing to some members of the team,
so I then went on to rebuild the whole thing to use the more "classic" approach.

I wasn't too fond of this as there were just so many class files involved which were all very similar,
even after I broke the pages down into reusable components.

If I ever go back to creating my own automated testing framework, which I may do at some point,
I think I'd like to create it in such a way that both approaches were possible.

## Continuous Integration

At the company, we didn't have anyone working on CI. After my short time at [Cloudsoft][8],
I was keen to get automated builds across all projects. I started out working on Jenkins
without any build scripts. We would add the required build steps directly into [Jenkins][9],
which wasn't ideal. I did most of the build alterations directly in MSBuild, which was pretty unpleasant.

Months later, we moved to building on [TeamCity][10], and I started to learn the basics of F# so that
we could use [Fake][11] (F# MAKE) as our build scripting tool. TeamCity would simply execute a `build.bat`
file, and wait for the artefacts. This approach made it much easier to modify our build process,
and would have made it easy to move to any other build server if it was needed.

The hardest part about working with Fake, was the difficulty in Googling for help on the topic.

## Continuous Deployment

With everything automatically building, testing itself, and pushing out shared libraries correctly,
I then moved to making the applications deploy after successful builds. Our Head of Software Development,
who moved us onto TeamCity, also suggested using [Octopus Deploy][12].

Octopus was like magic; with little configuration, you could easily deploy a .Net application or website
out to an environment and promote it to the next when you were satisfied with its performance.
Once we had an understanding of everything that Octopus needed to work as best it could,
we had it managing our biggest projects across four different environments.

## Conclusion

Overall, this was quite the departure from Games Development. I haven't touched C++, AI, graphics, or physics
in years, and I imagine I would struggle to pick that back up. I had the intention of cleaning up most of
my university work so that I could *proudly* display it on GitHub, but I feel that will be much more of a
challenge now... and probably isn't really worth doing.

Learning about the various different areas of software development was a struggle, but very worthwhile.
I didn't get to do as much "proper" development as I would have liked, but at least my time at G2G3 gave
me a good understanding of areas that I probably would not have learned about otherwise.

<!-- References -->
[1]:  http://g2g3.com/ "G2G3"
[2]:  https://www.pluralsight.com/ "Pluralsight"
[3]:  http://www.specflow.org/ "SpecFlow"
[4]:  http://docs.seleniumhq.org/ "Selenium"
[5]:  https://cucumber.io/ "Cucumber"
[6]:  https://github.com/cucumber/gherkin "Gherkin"
[7]:  http://appium.io/ "Appium"
[8]:  http://www.cloudsoft.io/ "Cloudsoft"
[9]:  https://jenkins.io/ "Jenkins"
[10]: https://www.jetbrains.com/teamcity/ "TeamCity"
[11]: http://fsharp.github.io/FAKE/ "Fake"
[12]: https://octopus.com/ "Octopus Deploy"
