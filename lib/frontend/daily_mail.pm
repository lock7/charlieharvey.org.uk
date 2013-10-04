package frontend::daily_mail;
use Dancer ':syntax';
use Dancer::Plugin::DBIC qw(schema resultset rset);

prefix '/daily_mail';

our @scapegoats = (
  "yobs wearing hoodies and baseball caps",
  "Eastern European terror gangs",
  "young single mothers",
  "homosexuals",
  "young muslim men",
  "asylum seekers",
  "paedophiles",
  "anarchists",
  "gypsies",
  "women",
  "Islamist youths",
  "hoody-wearing layabouts",
  "communist-sympathisers",
  "youths",
  "unemployed layabouts demanding benefits with menace",
  "so-called new age travellers",
  "teachers indoctrinated with sixties liberal values",
  "the politically correct Islington lefties",
  "insane Brussels bureaucrats",
  "anarchists calling themselves the Wombles",
  "anarchist leaders \"the elders\"",
  "glue-sniffing teenagers",
  "gangs of black youths",
  "thugs",
  "Guardian-reading do-gooders",
  "louts",
  "hooligans",
  "gangs of children, some still in their prams",
  "Noam Chomsky devotees",
  "followers of Hugo Chavez",
  "ravers smashed out of their tiny minds on ecstasy",
  "Cherie Blair&#8217;s friends",
  "miners, bent on revenge",
  "the unions",
  "hunt sabateours",
  "cyberterrorists",
  "criminal gangs from Eastern Europe",
  "French unions",
  "the Unions",
  "cyber criminals",
  "Twitter users",
  "Al Qu&#8217;aeda bosses",
  "enviro-Mental-ists",
  "lesbians",
  "homosexuals",
  "hoodies",
  "chavs",
  "the poor",
  "coloureds",
  "extremists",
  "bleeding heart liberals",
);

 
our @evil_behaviours = (
  "terrorising the elderly residents of a tranquil Gloucestershire village",
  "selling drugs to schoolchildren for fun",
  "threatening to smash up branches of McDonalds and Starbucks",
  "destabilising the British way of life",
  "being involved in the death of Princess Diana (God rest her precious soul)",
  "setting fire to pensioners whilst high on skunk and crack",
  "using skateboards and yobbish language to molest journalists",
  "squatting houses left empty by families on holiday",
  "getting away with arson",
  "looting and pillaging supermarkets",
  "urinating on the Union Jack",
  "burning policemen at the stake",
  "eating babies",
  "drilling for oil in one family's back garden",
  "pleasuring themselves on the alters of our great cathedrals",
  "setting fire to libraries",
  "selling heroin to the unions",
  "injecting crack into primary school children",
  "terrorising innocent investment bankers",
  "plotting the overthrow both of the British state and our way of life",
  "smoking skunk in the halls of Parliament",
  "defacing statues in Trafalgar Square",
  "holding illegal raves illegally in illegal fields",
  "injecting crack into the kneecaps of innocent passers by",
  "smashing up images of our queen of hearts, Lady Diana herself",
  "listening to loud music",
  "reading the works of Karl Marx",
  "praising Osama Bin Laden",
  "sacrificing goats to a gilded image of Ken Livingstone",
  "causing cancer",
  "tweeting the Interwebs into cyberterror on the Facebooks",
  "plotting to kidnap a senior royal",
  "binge drinking on council estates",
  "binge drinking",
  "welcoming foreigners",
  "engaging in steamy sex romps",
  "hacking the Gibson",
  "training in Al-Quaeda terror camps",
  "immigrating",
  "being foreign and suspicious looking",
  "ripping off hard working families",
);

our @mad_quotes = (
  "the day of the yob is upon us",
  "arbeit macht frei",
  "As I look ahead, I am filled with foreboding. Like the Roman, I seem to see the River Tiber foaming with much blood.",
  "yet again these oafs have destroyed my evening.",
  "kill the commie swine",
  "I like sponge",
  "If only we had a privitised National Identity scheme this would never have happened",
  "our prisons are like holiday camps.",
  "the lady&#8217;s not for turning",
  "I can no longer sit back and allow Communist infiltration, Communist indoctrination, Communist subversion and the international Communist conspiracy to sap and impurify all of our precious bodily fluids.",
  "was it for this politically correct insanity that I fought and died in eight world wars? I think not!",
  "I blame all of this on stealth taxes and permissive education in the 1960s.",
  "surely something can be done?",
  "make no mistake if this is allowed to continue Armageddon shall surely be upon us and woe betide all who would seek to impose upon us a surveillance society. For on that day the right shall inherit the Earth!",
  "these dole-scrounging n&#8217;er-do-wells must be eliminated at all costs.",
  "a glorious thousand-year reich seems like the only practical choice to stem the tide of economic migrants",
  "new Age travellers? Not in this age. Not in any age. Let others speak for these New Age travellers. We will speak for their victims.",
  "society needs to condemn a little more and understand a little less.",
  "we are a grandmother",
  "read my lips; no new taxeis",
  "we are coming slowly, painfully to an autumn of understanding, I hope it will be followed by a winter of common sense.",
  "I have always said if you want a speech, ask a man. If you want something done, ask a woman.",
  "I grew up in the 1930s with an unemployed father. He did not riot. He got on his bike and looked for work, and he went on looking until he found it.",
  "A large proportion of Britain&#8217;s Asian population fail to pass the cricket test. Which side do they cheer for?",
  "But many of the unemployeds had become static and didn&#8217;t know that if they got on a bus for an hour&#8217;s journey, they&#8217;d be in Cardiff and could look for the jobs there.",
  "Waterboarding is not torture",
  "Ban this sick filth",
  "I think hanging is too good for them; Its time to consider the reintroduction of crucifiction, especially for criminals.",
  "Multiculturalism has failed utterly",
  "Hoorah for the blackshirts!",
  "We need a lot less of the passive tolerance of recent years and much more active, muscular liberalism. Especially for the blacks.",
  "Things got out of hand and we&#8217;d had a few drinks. We smashed the place up and Boris set fire to the toilets.",
  "Its the terrorists fault. Watch my eyes. Te-rror-ists. Now I can say anything I like and you&#8217;ll think it makes sense somehow. Brilliant. Te-rror-is-ts.",
);


our @tory_looneys = (
  "Margaret Thatcher",
  "Enoch Powell",
  "Boris Johnson",
  "The deputy commisioner of the Metropolitan Police",
  "an unnamed source",
  "Mr I.P.Freely of Tunbridge Wells",
  "a hardworking family",
  "Beyonce",
  "Norris McWhirter, speaking posthumously",
  "Paul Dacre",
  "David Cameron",
  "Michael Howerd",
  "John Major",
  "Vince Cable",
  "Theresa May",
  "Amanda Platell",
  "Ian Dunkin-Donuts",
  "Jeremy Clarkson",
  "Richard Littlejohn",
  "Lala from the teletubbies",
  "The Queen",
  "Jim Davidson",
  "Bernard Manning",
  "Anne Widdecombe",
  "Jonathan Aitkin",
  "Bernard Jenkin",
  "Theresa May",
  "Norman Tebbit",
  "Jacob Rees-Mogg",
  "David Cameron",
  "Nick Clegg",
  "George Osborne",
  "The Pope",
  "The English People",
  "James May",
  "Angela Merkel",
  "Winston Churchill, speaking through a medium",
  "Nicolas Sarkozy",
  "a homeowner",
  "some bloke in the pub",
  "Conservative head office",
);

our @thatcher_headlines = (
  "Some People Don&#8217;t Revere Thatcher. Kill. Them. NOW!!!",
  "Canonize Mrs Thatcher",
  "Thatcher Funeral Should Have &#8217;Miners and Police&#8217; Theme To Annoy Scargill",
  "Iron Lady Was Great, and Anyone Who Doesn&#8217;t Think She Was Is Evil",
  "Thatcher Will Rise Again To Judge Gays",
  "Thatcher Was NOT Heading Away From Exclusion Zone",
  "Thatcher Was Queen Of Our Hearts",
  "Left-Wing Are Smelly And We Miss Maggie",
  "Thatcher, Blah, Blah, Blah",
  "Thatcher Given Opportunity to &#8217;Buy Own Coffin&#8217;",
  "Did We Mention That Thatcher Was Dead?",
  "We Loved Maggie. Stop Taking The Piss",
  "Tributes NOT A Cynical Way To Cash In On Our Blessed Iron Lady&#8217;s Death",
  "Who Loved Thatcher More? Us Or Pinochet?",
  "Thatcher Funeral Privatized. Sid Told.",
  "&pound;1 squillion tax payer bill for Thatcher death party clean up enitrely reasonable",
  "Thatcher body found hidden in squatted caravan",
  "Vegans spoil Thatcher funeral with tofu shower",
  "Sick rioters eat Iron Lady - blame police kettle",
  "90% of immigrants don&#8217;t care who Thatcher is",
);

# these may end up in another file for convienience at some point. it'll do for now though.
our @story_styles = (
  "%S have been %e the Mail can exclusively reveal. 
 
  How long can this political correctness gone mad be tolerated by British people?
 
  %T said of %s, \"%q\" 
  
  %S made no comment about the accusations when we didn&#8217;t ask.
",

 "The Mail has learned that %s are responsible for %e. 
 
Has the world gone mad? %S are %e with impunity. Hanging is surely too good for these no good scum. Why doesn&#8217;t the Government use all the money it has stolen from the hardworking families of Britain in stealth taxes to make amends for the situation. Probably because they are too busy lining their pockets!
 
The Mail spoke to %t, who said \"%q\"
",

"In a shocking indictment of our permissive society it has this week emerged that %s have been %e.
 
Things have gone too far. Its bad enough that we tolerate the spicy food and loud music of %s without allowing them to terrorise decent, middle class families as well.
 
The Mail will be starting a campaign against %s and we promise our readers now that we shall not rest until each one of them is hunted down like a dog. %T speaking in support of our campaign said \"%q\".
 
Have things gone too far? Have your say on our webshite!
",

"Why, Oh Why, Oh Why do we allow %s such freedom? Not only are they probably communists, but %s have this week been revealed as %e.
 
If only the Government and the guacomole-munchers of Islington were a little less concerned with helping Johnny-foreigner and a little more concerned with the rights of the hard working majority of our glorious Nation, then perhaps %s would not get away with such treachery.
 
That certainly seems to be the opinion of %T who this week said, \"%q\".
 
So, next time you are at a dinner party and the menu involves sun dried tomatoes, just consider whether you think that %e is acceptable behaviour.
",

"Now %s are %e whilst elderly patients in the NHS still have to queue for years in blood spattered corridors. 
 
 Scroungers and misfits are allowed to terrorise our 4X4s whilst our police sit idly by. The only explanation can be that %s are atheistic Trotskyite witches bent on the destruction of all we hold dear in this isle of ours for the benefit of their infernal overlord Beelzebub. Even their uniform of hoodies bears a striking resemblence to the witches of old.
 
How are we to rid our nation of these evil witches and warlocks?
 
Certainly not with holiday camp prisons and free love as the politically correct Whitehall bureaucrats want!
 
Our \"Burn the Witch\" campaign will rid the land of this evil using the only language they understand - fire. We intend to burn six %s a week for the next year so that their evil souls may descend into the very pits of hell from whence they have slunk.
  
Speaking of the Daily Mail&#8217;s exclusive \"Burn the witch\" campaign, %T said, \"%q\"
",

"Shocking news has come to light that a recent spate of %e has been perpetrated by %s.
 
 The Mail can reveal that %s are actually not human at all but have been spawned in Europe by a bureaucrat known as Saruman who intends to wrest control of all that is good and decent using this army of misfits.
 
 %T said of the %s, \"%q\".
 
",

"With schools turning out a generation of illiterate hoodlums, crime threatening our every movement and a Government that treats criminals with kid gloves rather than forcibly immasculating them, is it any wonder that, once more %s have been %e?
 
 What is needed is some very serious discipline. We can beat sense into %s - all it takes is a little British spunk, some backbone and a big stick.
  
 Instead sickos, perverts and communists are allowed to crawl the streets with impunity. %E must no longer be tolerated, especially when perpetrated by %s.
 
 Speaking exclusively to the Mail about %s, %T said \"%q\".
 
",

"%T has today said \"%q\".
 
Speaking at Alton Towers %T&#8217;s comments come in a week that has seen %s involved in %e on an ever more frequent basis.
 
%T&#8217;s comments are both brave and perceptive. In a country where children as young as five are regularly exposed to %s it is about time that someone had the guts to stand up and tell the truth. %S and the liberal communist atheist society that spawns them must be eliminated.
",
"Now children are openly being encouraged to flout the laws of morality and the land. %S have been %e outside nursery schools. 
 
Terror expert %T has analysed the phenomenon in a new book which we certainly aren&#8217;t plugging although it is available from our bookshop for just &pound;7.99; a fantastic 1.7% discount.
 
In \"%E: The True Face Of Evil\", %T says, \"%q\". 
 
A decent \"Big Society\" that cared about children would bring back hanging for %s. After the hanging the still twitching bodies would be deported to somewhere tropical and foreign.",

"I&#8217;m not racist but surely allowing %s to flout our British way of life means that things have gone too far? %E is just not British. 
 
Some leftists will predictably argue that %s aren&#8217;t %e in reality. But reality has a well known left-wing bias. %T agrees with me, saying today, \"%q\". 
 
Let&#8217;s kick out the sickos and reclaim our traditional British heritage.",

"The terror level was raised to beige today after MI5 said that they certainly had vague yet specific intelligence about a probable certain threat that might or might not occur or not occur under certain circumstances on British soil or abroad perhaps unless another thing that might be a threat if it were to happen which it might or might not but it definitely might. 
 
The terror plot probably involved %s who rumours have emerged have been involved in %e since 1978. 
 
%T speaking from a hotel in Barbados said, \"%q\". ",

"Sick filth on television, a nanny state, stealth taxes, floods of immigrants and now %e. Welcome to Broken Britain! 
 
Last Thursday following an intensive 20 minute investigation on Facebook, %T revealed that %s have been %e with impunity. 
 
These misfits surely shouldn&#8217;t be allowed in a country that is still ostensibly Christian. Corporal punishment is the only option for %s.  

\"That might sound harsh but so is having your children broken into and your house taught to hate itself in the name of multiculturalism in our so-called schools.\" %T went on to say. 
 

%T concluded, \"%q\".",

"Now boffins have discovered that %s can cause cancer as well as being, frankly, distasteful.

Docktawh Gillian Keith, speaking from her underground nutrition dome said, \"Ever since %T told me about it, I have been trying to cure %e with a powerful mix of micronutrients, goji berries and spirulina.\"

She added \"As it turns out %e is almost completely identical to cancer, in how it affects the balance of our chakras. And everybody knows that %e is mostly caused by %s, who are known to promote a negative orgone balance in the red layer of the energy rainbow.\"

Of course liberal-minded multiculturalists will no doubt assume that comparing %s to carcinogens is \"racist\", but they can&#8217;t deny the simple facts of the case. And the Mail is happy to back Gillian&#8217;s words; she gave us a fresh insight into Broken Britain by saying, \"%Q\". 
"
);


get '/' => sub {
	template 'daily_mail/view', {
		title => 'Daily Mail story generator',
		description => 'It generates Daily Mail style DM stories. For lazy Daily Mail hacks and others.',
		story => _make_story()
	}	
};

# make a DM story
sub _make_story {
  my $story					= _get_elem(\@story_styles);
  my $scapegoat			= _get_elem(\@scapegoats);
  my $evil					= _get_elem(\@evil_behaviours);
  my $mad_quote			= _get_elem(\@mad_quotes);
  my $right_winger	= _get_elem(\@tory_looneys);
  $story =~ s/%s/$scapegoat/g;
  $story =~ s/%S/ucfirst $scapegoat/ge;
  $story =~ s/%e/$evil/g;
  $story =~ s/%E/ucfirst $evil/ge;
  $story =~ s/%q/$mad_quote/g;
  $story =~ s/%Q/ucfirst $mad_quote/ge;
  $story =~ s/%t/$right_winger/g;
  $story =~ s/%T/ucfirst $right_winger/ge;
  $story =~ s/\n/<br \/>/g;
	return $story;
}

# takes an array ref. returns an element at a random offset 
# within the array.
sub _get_elem {
  my $aref = shift;
  my $rnd  = int(rand(scalar(@{$aref})));
  return ${$aref}[$rnd-1];
}

# Special Thatcher headlines to celebrate^Wcommemorate our glorious leader's death.
sub _thatchline {
  uc get_elem(\@thatcher_headlines);
}
