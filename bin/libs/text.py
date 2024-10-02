import random
#import string

def generate_unique_string():
    adjectives = ["wicked", "mighty", "ruthless", "savage", "ferocious", "venomous", "merciless", "brutal", "vicious", "relentless"]
    nouns = ["digit", "griff", "kelpie", "krak", "mim", "amp", "pixie", "sprite", "wraith", "yeti"]
    
    adjective = random.choice(adjectives)
    noun = random.choice(nouns)
    #number = ''.join(random.choices(string.digits, k=4))
    
    string = f"{adjective}-{noun}"
    return string

