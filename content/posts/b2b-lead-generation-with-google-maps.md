+++
date = '2024-12-04T16:32:00-06:00'
draft = false
title = 'B2B Lead Generation With Google Maps'
tags = ['maps', 'google', 'scraping', 'golang', 'pywright', 'docker', 'analytics']
+++

When tasked with acquiring B2B leads for work, it wasn't just a matter of "Hey, obtain some leads for us to call," it was more like, "Hey, I want to see 150,000 leads in our CRM by Friday." This is not an easy task. I knew I was in for the ride of a lifetime this week. Simply put, I had no idea how I was going to get 150,000 leads in 5 days, this seemed absolutely insane, and unachievable. Naturally, I told them, "No problem." What was I thinking?

## Enter My Software Dev Skills

In an attempt to achieve the goal, I turned to my whiteboard, literally. Wiped off all my scribbled notes and infrastructure diagrams, and started plotting. I know Google has an API for maps, but at what cost for trying to pull that many leads. They wanted this done on the large budge of ***FREE***. I knew it could be done, I've built scrapers in the past. I just didn't know how I was going to tackle this particular project.

After scribbling and erasing a bunch of diagrams, dependencies, and other ideas, I landed on a simple idea. Let me build the core in go. Super small footprint, and has great concurrency. How was I going to manipulate the websites though? Well, in walked pywright. The match made in heaven!

I started building out the simple application, laying out the framework for the data I needed to pull from Google Maps. In addition to laying out the data structure, I needed a way to queue up jobs. I could spin up some RabbitMQ, but that seemed a bit overkill for something so simple as acquiring leads from a map. I decided to use a SQLite database to store the jobs, and search parameters, and utilize this as my queue. It would also provide a nice visual for me to know which jobs were still waiting, which have completed, and which were being worked on.

Fantastic! My diagram was starting to grow, and started looking like an actual project. I didn't want to store the data in the database, as I need to be able to quickly import it into our CRM. What if I just wrote it to a CSV file as it was being read from the website. This was the decided approach.

## Throwing Together The Code

After about an hour of thinking through the problem, and diagramming out what I was looking to achieve, I pulled up neovim, and went to town writing out some Go code. After a few hours, of constant failure to compile, forgetting to run `go mod tidy` and `go get` I finally had the basic structure of the scraper working. The only downside, I had to pass each query as a flag when running the application. I needed a way to speed this up, and actually use my data store.

I took the extra step, and built out a UI for the application, where I could not only quickly setup my scraping parameters, but also monitor my job queue. We were now in business. It was time to let this baby fly!

## Maiden Voyage

It was time to setup a queue for the application to work through, so, I went searching for a list of cities in Colorado, where the company I work for is based. I copied the cities from a list, and slapped a query in front of them such as `restaurants in ` allowing me to then just paste all the cities in my text editor, and simply copy and paste the query in front of them with a rapid firing of Down Arrow, Home, CTRL+V. Copying this new list of queries into my UI, I clicked the button to queue the job.

To much excitement, it entered the queue with a `waiting` state, and quickly changed to `working`. I saw the new CSV file appear on in Dolphin. Excitement started to build, as I opened the CSV file in a text editor, and started to see the lines appear. Each line a new record from my applications results.

## Final Thoughts

Though I was initially terrified of the task provided to me of acquiring 150,000 B2B leads in 5 days, I realized that not only could it be achieved, but it could be achieved for the budget of ***FREE*** that my company desired to spend. The experience of planning out the architecture of the application, building it, and orchestrating the build process with docker the entire project could be modular, and run anywhere with a simple command. This made the project entertaining, and fun to work on.

I look forward to what other crazy experiences are thrown at me when it comes to building software.