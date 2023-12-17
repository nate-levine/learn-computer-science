# 6.0001/6.00 Problem Set 5 - RSS Feed Filter
# Name:
# Collaborators:
# Time: 12:00pm-12:20pm, 2:10pm-4:20pm : 5:50am-6:10am : 12:30pm - 1:15pm, 3:15pm - 3:30pm 

import feedparser
import string
import time
import threading
from project_util import translate_html
from mtTkinter import *
from datetime import datetime
import pytz

# I decided regex would be a good choice for parsing phrases
import re


#-----------------------------------------------------------------------

#======================
# Code for retrieving and parsing
# Google and Yahoo News feeds
# Do not change this code
#======================

def process(url):
    """
    Fetches news items from the rss url and parses them.
    Returns a list of NewsStory-s.
    """
    feed = feedparser.parse(url)
    entries = feed.entries
    ret = []
    for entry in entries:
        guid = entry.guid
        title = translate_html(entry.title)
        link = entry.link
        description = translate_html(entry.description)
        pubdate = translate_html(entry.published)

        try:
            pubdate = datetime.strptime(pubdate, "%a, %d %b %Y %H:%M:%S %Z")
            pubdate.replace(tzinfo=pytz.timezone("GMT"))
          #  pubdate = pubdate.astimezone(pytz.timezone('EST'))
          #  pubdate.replace(tzinfo=None)
        except ValueError:
            pubdate = datetime.strptime(pubdate, "%a, %d %b %Y %H:%M:%S %z")

        newsStory = NewsStory(guid, title, description, link, pubdate)
        ret.append(newsStory)
    return ret

#======================
# Data structure design
#======================

# Problem 1

class NewsStory(object):
    def __init__(self, guid, title, description, link, pubdate):
        self.guid = guid
        self.title = title
        self.description = description
        self.link = link
        self.pubdate = pubdate
    
    def get_guid(self):
        return self.guid
    
    def get_title(self):
        return self.title
    
    def get_description(self):
        return self.description
    
    def get_link(self):
        return self.link
    
    def get_pubdate(self):
        return self.pubdate


#======================
# Triggers
#======================

class Trigger(object):
    def evaluate(self, story):
        """
        Returns True if an alert should be generated
        for the given news item, or False otherwise.
        """
        # DO NOT CHANGE THIS!
        raise NotImplementedError

# PHRASE TRIGGERS

# Problem 2
class PhraseTrigger(Trigger):
    def __init__(self, phrase):
        Trigger.__init__(self)
        # Phrase is case insensitive
        self.phrase = phrase.lower()
    
    def is_phrase_in(self, text):
        """
        Returns True if the phrase is in the the text.

        :param_text: Text input
        :type_text: string
        :rtype: bool
        """
        # Remove punctuation from the text
        for char in string.punctuation:
            text = text.replace(char, " ")
        # Remove capitalization from text
        text = text.lower()
        # Split the text into words, then join them with single spaces
        text = " ".join(text.split())
        # Search for the phrase in the text using a regex word boundries
        return re.search(r"\b" + self.phrase + r"\b", text)


# Problem 3
class TitleTrigger(PhraseTrigger):
    def __init__(self, phrase):
        PhraseTrigger.__init__(self, phrase)
        # Phrase is case insensitive
        self.phrase = phrase.lower()

    def evaluate(self, story):
        return self.is_phrase_in(story.get_title())

# Problem 4
class DescriptionTrigger(PhraseTrigger):
    def __init__(self, phrase):
        PhraseTrigger.__init__(self, phrase)
        # Phrase is case insensitive
        self.phrase = phrase.lower()

    def evaluate(self, story):
        return self.is_phrase_in(story.get_description())

# TIME TRIGGERS

# Problem 5
# TODO: TimeTrigger
class TimeTrigger(Trigger):
    def __init__(self, time_string):
        """
        Time has to be in EST in the string format: "DD Mon YYYY HH:MM:SS",
        and is converted to a datetime using the format string: "%d %b %Y %H:%M:%S".
        """
        Trigger.__init__(self)
        pubdate = datetime.strptime(time_string, "%d %b %Y %H:%M:%S")
        # Specify datetime is EST
        self.pubdate = pubdate.replace(tzinfo=pytz.timezone('EST'))


# Problem 6
class BeforeTrigger(Trigger):
    def __init__(self, time_string):
        TimeTrigger.__init__(self, time_string)

    def evaluate(self, story):
        return story.get_pubdate().replace(tzinfo=pytz.timezone('EST')) < self.pubdate
    
class AfterTrigger(Trigger):
    def __init__(self, time_string):
        TimeTrigger.__init__(self, time_string)

    def evaluate(self, story):
        return story.get_pubdate().replace(tzinfo=pytz.timezone('EST')) > self.pubdate


# COMPOSITE TRIGGERS

# Problem 7
class NotTrigger(Trigger):
    def __init__(self, trigger):
        self.trigger = trigger

    def evaluate(self, story):
        # Return True if the trigger evaluates to False
        return not self.trigger.evaluate(story)

# Problem 8
class AndTrigger(Trigger):
    def __init__(self, trigger_1, trigger_2):
        self.trigger_1 = trigger_1
        self.trigger_2 = trigger_2

    def evaluate(self, story):
        # Return True if both triggers evaluate to True
        return self.trigger_1.evaluate(story) and self.trigger_2.evaluate(story)

# Problem 9
class OrTrigger(Trigger):
    def __init__(self, trigger_1, trigger_2):
        self.trigger_1 = trigger_1
        self.trigger_2 = trigger_2

    def evaluate(self, story):
        # Return True if one or both tirggers evaulate to True
        return self.trigger_1.evaluate(story) or self.trigger_2.evaluate(story)


#======================
# Filtering
#======================

# Problem 10
def filter_stories(stories, triggerlist):
    """
    Takes in a list of NewsStory instances.

    Returns: a list of only the stories for which a trigger in triggerlist fires.
    """
    # Create an empty list to keep track of stories that evaulate to True
    stories_copy = []
    # For each story
    for story in stories:
        # Test each trigger
        for trigger in triggerlist:
            # If any trigger evaulates the story to True
            if trigger.evaluate(story):
                # Add the story to the list that evaulated to True
                stories_copy.append(story)
                # Stop searching triggers for that story
                break
    # Return stories that evaulated to True
    return stories_copy


#======================
# User-Specified Triggers
#======================
# Problem 11
def read_trigger_config(filename):
    """
    filename: the name of a trigger configuration file

    Returns: a list of trigger objects specified by the trigger configuration
        file.
    """
    # We give you the code to read in the file and eliminate blank lines and
    # comments. You don't need to know how it works for now!
    trigger_file = open(filename, 'r')
    lines = []
    for line in trigger_file:
        line = line.rstrip()
        if not (len(line) == 0 or line.startswith('//')):
            lines.append(line)

    # Create a dictionary of trigger names (key) and triggers (value)
    trigger_dict = {}
    # Create an empty list of triggers to return
    added_triggers = []
    for line in lines:
        # Remove "ADD" keyword and split along the commas into a list of trigger names
        if line.startswith("ADD"):
            trigger_names = line.split(",")
            # For each trigger name (not including the "ADD" keyword)
            for trigger_name in trigger_names[1:]:
                # Add that trigger to the dictionary if the trigger exists
                try:
                    # Check if the trigger is already in the dictionary
                    if trigger_name in trigger_dict:
                        # If it is, don't add it again
                        pass
                    else:
                        added_triggers.append(trigger_dict[trigger_name])
                # Raise an error if the trigger does not exist
                except KeyError:
                    raise KeyError(f'"{trigger_name}" is not the name of a trigger.')
        else:
            # Split the line along the commas into a list of elements
            elements = line.split(",")
            # Trigger name
            name = elements[0]
            # Trigger keyword
            keyword = elements[1]
            # Select trigger based on the keyword
            if keyword == "TITLE":
                if len(elements) == 3:
                    trigger_dict[name] = TitleTrigger(elements[2])
                else:
                    print(f"{keyword} takes 3 arguments")
            elif keyword == "DESCRIPTION":
                if len(elements) == 3:
                    trigger_dict[name] = DescriptionTrigger(elements[2])
                else:
                    print(f"{keyword} takes 3 arguments")
            elif keyword == "AFTER":
                if len(elements) == 3:
                    trigger_dict[name] = AfterTrigger(elements[2])
                else:
                    print(f"{keyword} takes 3 arguments")
            elif keyword == "BEFORE":
                if len(elements) == 3:
                    trigger_dict[name] = BeforeTrigger(elements[2])
                else:
                    print(f"{keyword} takes 3 arguments")
            elif keyword == "NOT":
                if len(elements) == 3:
                    trigger_dict[name] = NotTrigger(elements[2])
                else:
                    print(f"{keyword} takes 3 arguments")
            elif keyword == "AND":
                if len(elements) == 4:
                    trigger_dict[name] = AndTrigger(elements[2], elements[3])
                else:
                    print(f"{keyword} takes 4 arguments")
            elif keyword == "OR":
                if len(elements) == 4:
                    trigger_dict[name] = OrTrigger(elements[2], elements[3])
                else:
                    print(f"{keyword} takes 4 arguments")
            # If the keyword is not a valid keyword, tell the user
            else:
                print(f"{keyword} is not a valid keyword.")
    # Return the added triggers
    return added_triggers


SLEEPTIME = 15 #seconds -- how often we poll

def main_thread(master):
    # A sample trigger list - you might need to change the phrases to correspond
    # to what is currently in the news
    try:
        t1 = TitleTrigger("election")
        t2 = DescriptionTrigger("Trump")
        t3 = DescriptionTrigger("Clinton")
        t4 = AndTrigger(t2, t3)
        triggerlist = [t1, t4]

        # Problem 11
        triggerlist = read_trigger_config('triggers.txt')
        
        # HELPER CODE - you don't need to understand this!
        # Draws the popup window that displays the filtered stories
        # Retrieves and filters the stories from the RSS feeds
        frame = Frame(master)
        frame.pack(side=BOTTOM)
        scrollbar = Scrollbar(master)
        scrollbar.pack(side=RIGHT,fill=Y)

        t = "Google & Yahoo Top News"
        title = StringVar()
        title.set(t)
        ttl = Label(master, textvariable=title, font=("Helvetica", 18))
        ttl.pack(side=TOP)
        cont = Text(master, font=("Helvetica",14), yscrollcommand=scrollbar.set)
        cont.pack(side=BOTTOM)
        cont.tag_config("title", justify='center')
        button = Button(frame, text="Exit", command=root.destroy)
        button.pack(side=BOTTOM)
        guidShown = []
        def get_cont(newstory):
            if newstory.get_guid() not in guidShown:
                cont.insert(END, newstory.get_title()+"\n", "title")
                cont.insert(END, "\n---------------------------------------------------------------\n", "title")
                cont.insert(END, newstory.get_description())
                cont.insert(END, "\n*********************************************************************\n", "title")
                guidShown.append(newstory.get_guid())

        while True:

            print("Polling . . .", end=' ')
            # Get stories from Google's Top Stories RSS news feed
            stories = process("http://news.google.com/news?output=rss")

            # Get stories from Yahoo's Top Stories RSS news feed
            stories.extend(process("http://news.yahoo.com/rss/topstories"))

            stories = filter_stories(stories, triggerlist)

            list(map(get_cont, stories))
            scrollbar.config(command=cont.yview)


            print("Sleeping...")
            time.sleep(SLEEPTIME)

    except Exception as e:
        print(e)


if __name__ == '__main__':
    root = Tk()
    root.title("Some RSS parser")
    t = threading.Thread(target=main_thread, args=(root,))
    t.start()
    root.mainloop()