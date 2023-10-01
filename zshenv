comment(){
  llm -s 'Add comments to this code. Respond with the code and comments. Do not alter the functional aspect of the code, but still return it. Be sure and include the code in the response. Do not respond in a markdown code block. Just respond with the code and comments. Do not preamble or say anything before or after the code. for example: If the user sent "print(1)\nprint(2)", you would reply "# Prints 1\nprint(1)\n# Prints 2\nprint(2)"' -o temperature .2
}

fix(){
  llm -s 'Fix the syntax of this code. Respond with the code including any fixes. Do not alter the functional aspect of the code, but simply fix it and respond with all of it. Do not respond in a markdown code block. Just respond with the code. Do not preamble or say anything before or after the code. for example: If the user sent "print(1", you would simply reply "print(1)"' -o temperature .2
}

edit(){
  llm -s 'Edit this text to remove unnecessary filler words such as "like", "you know", and unimportant adverbs. Respond with the edited text only. Do not alter the speaking style or primary content.' -o temperature .1
}

blog(){
  llm -s 'Write a blog about the topic from the user as a wise and succinct writer such as Paul Graham or Tyler Cowen, but only use high school term paper vocabulary or lower.' -o temperature .4 -o presence_penalty .2 -m  gpt-4
}

finish(){
  message=`cat`
  echo -n $message
  echo -n $message | llm -s 'Finish this input. Respond with only the completion text. Do not respond with the input. Do not preamble or say anything before or after the completion. For example: If the user sent "The sky  is", you would simply reply " blue." If the input is code, write quality code that is syntactically correct. If the input is text, respond as a wise, succinct writer such as Paul Graham or Tyler Cowen, but only use high   school term paper vocabulary or lower.' -o temperature .4 -o presence_penalty .2 -m gpt-4
}

tweeturl(){
  message=`cat`
  echo -n $message
  echo -n $message | llm -s 'Use this URL and make it a tweet that everyone will click on and interact with' -o temperature .4 -o presence_penalty .2 -m gpt-4
}

tweet(){
  message=`cat`
  echo -n $message
  echo -n $message | llm -s 'Take this content and make it a tweet that everyone will click on and interact with' -o temperature .4 -o presence_penalty .2 -m gpt-4
}
