## What it is
A simple command line Ruby interface for a quick overview of a hospital's patients. 
Depending on the patient data input (currently just the diagnosis) and a list of administered medication (currently just the name of the formula), we can check the patients' health status.
Naturally, it only covers a very limited number of cases.

## Logic
Via the command line interface a user can introduce the arguments that will be parsed by the `InputParser`. It will convert the arguments into `Patient` and `TreatmentSession` objects and also validate the user input (respective errors will be raised if the input is somehow invalid).

Since the medication can only be dispensed to all of the patients at once, the TreatmentSession stays the same for all of the patients.

During this mentioned treatment session, we iterate over all of the provided patients to check which therapeutical outcome the treatment will have. 

We do so via the `PatientTreatmentSession` object that is personal to each of the patients (currently the customisation is only done through the diagnosis but it can be easily developed further on).

If any diagnosis changes need to be applied, it's done so by the `Patient` object itself.

Once this is done, the `OutputFormatter` displays the stats we're interested in.

## How to start it
```shell
cd hospital-ruby && ruby main.rb "<first argument list for patients>" "<second argument list for medicine administered>"
```

## How to run the tests
```shell
bin/test
```

## "Product" questions that need to be clarified
- What is the order of priority for potential therapeutic and side effects? Do the side effects always have a priority? (That's what has been implemented currently)
- Does the flying spaghetti monster aka resurrection randomizer apply to the whole lot of patients (current implementation) or is it a matter of individual luck?

## Potential code improvements
- ~~add test coverage for all the business logic~~
- extract the "therapeutic" logic into a dedicated lib (probably YML file) to not have it hard embedded in the code
- make the error messages more explicit
- introducing a modular structure into the code architecture (e.g. `Treatment` module for all of the potential therapeutic and side effect management and a `Utility` module for the parser and formatter)
- I haven't checked for very perverted edge cases, so chances are there would be minor bugs related to them. For a real production case unit tests would be there :)
- Absolutely zero performance tests / optimisation, simple because of the console nature of the app that makes any serious performance issues rather unlikely.

This is of course a non exhaustive list of improvements, more would definitely come should the functionality of the app evolve.

With the current level of detail I'd say this architecture provides enough flexibility and stays easy to understand and maintain, should that be necessary.

## Why did I decide to do it in Ruby
Cause I wanted to implement the whole thing fast, as it sounded like a fun exercise in code architecture, the kind of thing that I completely LOVE. 
Ruby was the easiest choice for that (unlike Java, that would definitely be limiting and would not allow me to fully concentrate on the architecture). It's also easy to read even for non-rubyists, so here it goes.

This said, I might try to transform this solution into Java code for the sake of learning, but I wouldn't want it to be hanging over me for an indefinite amount of time (that would probably be the case since my current Java level is the actual zero). 

