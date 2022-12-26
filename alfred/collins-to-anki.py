import json
import sys

from anki.collection import Collection
from anki.decks import DeckId

data = json.loads(sys.argv[1])

# write to anki

# TODO duplicate check

# print(col.sched.deck_due_tree())
# print(col.decks.get(did=1671540619691))
# print(col.find_notes(query=""))
# n = col.get_note(NoteId(1671540828784))
# for k in n.keys():
#     print(k, "=", n[k])
# print(col.get_note(NoteId(1671540828784)).note_type())

col = Collection("/Users/eric/Library/Application Support/Anki2/eric/collection.anki2")
deck = col.decks.by_name('daily word')
if len(col.find_notes(query="Front:" + data['word'])) == 0:
    n = col.new_note(notetype=col.models.by_name('daily word'))
    n['Front'] = data['word']
    n['Back'] = "<ol><li>" + "</li><li>".join(data['meaning']) + "</li></ol>"
    n['Phonetic'] = data['ipa']
    n.tags.append("alfred")
    n.tags.append("collins")
    col.add_note(n, deck_id=DeckId(deck['id']))
    col.save()
    print(data['word'] + " saved.")
else:
    print(data['word'] + " already existed.")
col.close()
