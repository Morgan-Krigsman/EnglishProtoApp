//
//  LevelView.swift
//  EnglishProtoApp
//
//  Created by Morgan Krigsman on 22.10.2024.
//

import SwiftUI

struct LevelView: View {
    let level: Int
    @Environment(\.presentationMode) var presentationMode

    @State private var showQuiz = false
    @State private var showFailedAlert = false

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                // Level Title
                Text("Level \(level)")
                    .boldRoundedBrownText(size: 24)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.horizontal)

                // Level Image (Optional)
                if let imageName = levelImageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding()
                }

                // Level Description
                ScrollView {
                    Text(levelDescription)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(.brown)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .frame(maxHeight: 200)
                .padding(.horizontal)

                // "Start Quiz" Button
                Button(action: {
                    showQuiz = true
                }) {
                    Text("Start Quiz")
                        .boldRoundedBrownText(size: 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.lightBrown.opacity(0.9))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .sheet(isPresented: $showQuiz) {
                    QuizView(level: level, questions: getQuestionsForLevel(level)) { passed in
                        if passed {
                            completeLevel()
                        } else {
                            showFailedAlert = true
                        }
                    }
                }
                .alert(isPresented: $showFailedAlert) {
                    Alert(
                        title: Text("Quiz Failed"),
                        message: Text("You did not pass the quiz. Please try again."),
                        dismissButton: .default(Text("OK"))
                    )
                }

                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            .padding(.top, geometry.safeAreaInsets.top)
            .background(
                Image("level\(level)Background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            )
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarTitle("Level \(level)", displayMode: .inline)
    }

    // Computed property for level image name
    var levelImageName: String? {
        let imageName = "level\(level)Image"
        return UIImage(named: imageName) != nil ? imageName : nil
    }

    // Computed property for level descriptions
        var levelDescription: String {
            switch level {
            case 1:
                return "Start your journey at home with your family. Learn basic words about family members and daily routines."
            case 2:
                return "Help mom to clean the house and learn words related to cleaning and household items."
            case 3:
                return "Join your family in making dinner and discover words about cooking and kitchen utensils."
            case 4:
                return "Go shopping with mom at the supermarket and learn names of common foods and manners."
            case 5:
                return "Visit the doctor for a check-up and learn words related to health and the human body."
            case 6:
                return "Prepare for school by buying supplies and learn words about stationery and classroom objects."
            case 7:
                return "Visit the shopping center with your family and learn words about shopping and clothing."
            case 8:
                return "Play at the park with friends and learn words about playground equipment and outdoor activities."
            case 9:
                return "Enjoy a bicycle trip with your family and learn words about transportation and nature."
            case 10:
                return "Visit your grandparents in the countryside and learn words about farm life and family."
            case 11:
                return "Go hiking with grandpa and learn words about nature, hiking gear, and outdoor exploration."
            case 12:
                return "Take a trip to the zoo and discover names of various animals and their characteristics."
            case 13:
                return "Explore the underwater world at the aquarium and learn words about sea creatures."
            case 14:
                return "Spend a day at the beach and learn words about seaside activities and ocean life."
            case 15:
                return "Go camping with your family and learn words about camping equipment and night-time activities."
            case 16:
                return "Relax at the onsen (hot springs) and learn words about Japanese culture and relaxation."
            case 17:
                return "Experience the airport and learn words about air travel and airport procedures."
            case 18:
                return "Fly on an airplane and learn words related to flying and in-flight experiences."
            case 19:
                return "Travel abroad and learn words about different cultures, languages, and travel essentials."
            case 20:
                return "Enjoy a fun-filled day at an amusement park and learn words about rides and entertainment."
            default:
                return "Level description not available."
            }
        }
    
    // Function to get quiz questions for the level
    func getQuestionsForLevel(_ level: Int) -> [QuizQuestion] {
        switch level {
        case 1:
            return level1Questions
        case 2:
            return level2Questions
        case 3:
            return level3Questions
        case 4:
            return level4Questions
        case 5:
            return level5Questions
        case 6:
            return level6Questions
        case 7:
            return level7Questions
        case 8:
            return level8Questions
        case 9:
            return level9Questions
        case 10:
            return level10Questions
        case 11:
            return level11Questions
        case 12:
            return level12Questions
        case 13:
            return level13Questions
        case 14:
            return level14Questions
        case 15:
            return level15Questions
        case 16:
            return level16Questions
        case 17:
            return level17Questions
        case 18:
            return level18Questions
        case 19:
            return level19Questions
        case 20:
            return level20Questions
        default:
            return defaultQuestions
        }
    }

    // Function to handle level completion
    func completeLevel() {
        UserManager.shared.incrementUnlockedLevels(currentLevel: level)
        if let achievementName = achievementName(for: level) {
            UserManager.shared.unlockAchievement(name: achievementName)
        }
        presentationMode.wrappedValue.dismiss()
    }

    func achievementName(for level: Int) -> String? {
        switch level {
        case 1:
            return "First Steps"
        case 10:
            return "Halfway There"
        case 20:
            return "Master"
        default:
            return nil
        }
    }

    // Level Questions
    var level1Questions: [QuizQuestion] {
        return [
            QuizQuestion(question: "What is the word for 'mother'?", options: ["Mom", "Dad", "Sister", "Brother"], correctAnswer: "Mom"),
            QuizQuestion(question: "What is the word for 'father'?", options: ["Grandma", "Uncle", "Dad", "Aunt"], correctAnswer: "Dad"),
            QuizQuestion(question: "What is the word for 'baby'?", options: ["Child", "Baby", "Teenager", "Adult"], correctAnswer: "Baby"),
            QuizQuestion(question: "What do you say when you wake up?", options: ["Good night", "Hello", "Good morning", "Goodbye"], correctAnswer: "Good morning"),
            QuizQuestion(question: "What is the word for 'family pet'?", options: ["Car", "Tree", "Dog", "House"], correctAnswer: "Dog"),
            QuizQuestion(question: "What do you sit on in the living room?", options: ["Table", "Chair", "Sofa", "Bed"], correctAnswer: "Sofa"),
            QuizQuestion(question: "What room do you sleep in?", options: ["Kitchen", "Bedroom", "Bathroom", "Garage"], correctAnswer: "Bedroom"),
            QuizQuestion(question: "What do you use to eat cereal?", options: ["Fork", "Spoon", "Knife", "Chopsticks"], correctAnswer: "Spoon"),
            QuizQuestion(question: "What do you drink in the morning?", options: ["Juice", "Coffee", "Water", "Milk"], correctAnswer: "Milk"),
            QuizQuestion(question: "What do you brush your teeth with?", options: ["Hairbrush", "Toothbrush", "Comb", "Sponge"], correctAnswer: "Toothbrush"),
        ]
    }

    var level2Questions: [QuizQuestion] {
        return [
            QuizQuestion(question: "What tool do you use to clean the floor?", options: ["Vacuum", "Hammer", "Spoon", "Pencil"], correctAnswer: "Vacuum"),
            QuizQuestion(question: "What do you use to wipe the table?", options: ["Paper", "Towel", "Book", "Paint"], correctAnswer: "Towel"),
            QuizQuestion(question: "What do you throw in the trash can?", options: ["Toys", "Trash", "Food", "Clothes"], correctAnswer: "Trash"),
            QuizQuestion(question: "What do you do with dirty clothes?", options: ["Wear them", "Wash them", "Throw them", "Hide them"], correctAnswer: "Wash them"),
            QuizQuestion(question: "What do you use to clean windows?", options: ["Water", "Soap", "Window cleaner", "Milk"], correctAnswer: "Window cleaner"),
            QuizQuestion(question: "What do you use to sweep the floor?", options: ["Broom", "Fork", "Brush", "Sponge"], correctAnswer: "Broom"),
            QuizQuestion(question: "What do you wear on your hands to clean?", options: ["Gloves", "Socks", "Hat", "Scarf"], correctAnswer: "Gloves"),
            QuizQuestion(question: "Where do you put your toys after playing?", options: ["On the floor", "In the toy box", "Outside", "In the kitchen"], correctAnswer: "In the toy box"),
            QuizQuestion(question: "What day do you usually clean your house?", options: ["Monday", "Saturday", "Wednesday", "Friday"], correctAnswer: "Saturday"),
            QuizQuestion(question: "Who helps mom to clean the house?", options: ["Nobody", "Dad", "Children", "Pets"], correctAnswer: "Children"),
        ]
    }
    var level3Questions: [QuizQuestion] {
        return [
            QuizQuestion(question: "What room do you cook in?", options: ["Kitchen", "Bathroom", "Bedroom", "Garage"], correctAnswer: "Kitchen"),
            QuizQuestion(question: "What do you use to boil water?", options: ["Pan", "Pot", "Plate", "Cup"], correctAnswer: "Pot"),
            QuizQuestion(question: "What do you cut vegetables with?", options: ["Fork", "Knife", "Spoon", "Chopsticks"], correctAnswer: "Knife"),
            QuizQuestion(question: "What do you wear to keep your clothes clean?", options: ["Apron", "Jacket", "Hat", "Shoes"], correctAnswer: "Apron"),
            QuizQuestion(question: "What do you use to mix ingredients?", options: ["Whisk", "Spatula", "Spoon", "Fork"], correctAnswer: "Spoon"),
            QuizQuestion(question: "What do you bake cookies in?", options: ["Oven", "Fridge", "Microwave", "Toaster"], correctAnswer: "Oven"),
            QuizQuestion(question: "What do you use to fry eggs?", options: ["Pan", "Bowl", "Plate", "Cup"], correctAnswer: "Pan"),
            QuizQuestion(question: "What do you drink soup with?", options: ["Fork", "Spoon", "Knife", "Straw"], correctAnswer: "Spoon"),
            QuizQuestion(question: "Who helps you cook dinner?", options: ["Friends", "Family", "Neighbors", "Pets"], correctAnswer: "Family"),
            QuizQuestion(question: "What do you do before eating?", options: ["Wash hands", "Run", "Sleep", "Sing"], correctAnswer: "Wash hands"),
        ]
    }
    var level4Questions: [QuizQuestion] {
        return [
            QuizQuestion(question: "Where do you buy food?", options: ["Supermarket", "School", "Bank", "Hospital"], correctAnswer: "Supermarket"),
            QuizQuestion(question: "What do you use to carry groceries?", options: ["Basket", "Bag", "Cart", "All of the above"], correctAnswer: "All of the above"),
            QuizQuestion(question: "What do you buy to make sandwiches?", options: ["Bread", "Shoes", "Books", "Toys"], correctAnswer: "Bread"),
            QuizQuestion(question: "Where do you pay for your items?", options: ["Checkout", "Entrance", "Parking lot", "Aisle"], correctAnswer: "Checkout"),
            QuizQuestion(question: "What fruit is red and round?", options: ["Apple", "Banana", "Orange", "Grapes"], correctAnswer: "Apple"),
            QuizQuestion(question: "What vegetable is long and orange?", options: ["Potato", "Carrot", "Lettuce", "Broccoli"], correctAnswer: "Carrot"),
            QuizQuestion(question: "What do you need to buy milk?", options: ["Money", "Ticket", "Map", "Phone"], correctAnswer: "Money"),
            QuizQuestion(question: "Who helps you find things in the store?", options: ["Cashier", "Teacher", "Store clerk", "Doctor"], correctAnswer: "Store clerk"),
            QuizQuestion(question: "What do you wear on your feet?", options: ["Shoes", "Hat", "Gloves", "Scarf"], correctAnswer: "Shoes"),
            QuizQuestion(question: "What do you say when you want something?", options: ["Please", "Now", "Give me", "Hey"], correctAnswer: "Please"),
        ]
    }
    var level5Questions: [QuizQuestion] {
        return [
            QuizQuestion(question: "Who helps you when you're sick?", options: ["Doctor", "Teacher", "Chef", "Pilot"], correctAnswer: "Doctor"),
            QuizQuestion(question: "What do you wear on your arm when it's broken?", options: ["Cast", "Hat", "Scarf", "Gloves"], correctAnswer: "Cast"),
            QuizQuestion(question: "What do you use to see tiny things?", options: ["Microscope", "Telescope", "Glasses", "Camera"], correctAnswer: "Microscope"),
            QuizQuestion(question: "What do you get when you have a fever?", options: ["Medicine", "Candy", "Toy", "Book"], correctAnswer: "Medicine"),
            QuizQuestion(question: "What does the doctor use to listen to your heart?", options: ["Stethoscope", "Hammer", "Syringe", "Thermometer"], correctAnswer: "Stethoscope"),
            QuizQuestion(question: "Where do you sit in the doctor's office?", options: ["Chair", "Bed", "Floor", "Table"], correctAnswer: "Chair"),
            QuizQuestion(question: "What do you say when you feel pain?", options: ["Ouch", "Hello", "Goodbye", "Yes"], correctAnswer: "Ouch"),
            QuizQuestion(question: "What do you get after a check-up?", options: ["Sticker", "Homework", "Cake", "Toy"], correctAnswer: "Sticker"),
            QuizQuestion(question: "What do you need to get better?", options: ["Rest", "Run", "Jump", "Play"], correctAnswer: "Rest"),
            QuizQuestion(question: "Who takes you to the doctor?", options: ["Parents", "Friends", "Teacher", "Neighbor"], correctAnswer: "Parents"),
        ]
    }
    var level6Questions: [QuizQuestion] {
        return [
            QuizQuestion(question: "What do you write with?", options: ["Pencil", "Spoon", "Brush", "Fork"], correctAnswer: "Pencil"),
            QuizQuestion(question: "What do you use to color pictures?", options: ["Crayons", "Eraser", "Paper", "Glue"], correctAnswer: "Crayons"),
            QuizQuestion(question: "What do you put your books in?", options: ["Backpack", "Drawer", "Basket", "Shelf"], correctAnswer: "Backpack"),
            QuizQuestion(question: "What do you use to cut paper?", options: ["Scissors", "Knife", "Fork", "Pencil"], correctAnswer: "Scissors"),
            QuizQuestion(question: "What do you use to erase mistakes?", options: ["Eraser", "Pen", "Marker", "Crayon"], correctAnswer: "Eraser"),
            QuizQuestion(question: "What do you write on?", options: ["Paper", "Table", "Floor", "Wall"], correctAnswer: "Paper"),
            QuizQuestion(question: "What do you use to stick things together?", options: ["Glue", "Tape", "String", "Stapler"], correctAnswer: "Glue"),
            QuizQuestion(question: "What do you wear to school?", options: ["Uniform", "Pajamas", "Swimsuit", "Costume"], correctAnswer: "Uniform"),
            QuizQuestion(question: "Who teaches you at school?", options: ["Teacher", "Doctor", "Chef", "Pilot"], correctAnswer: "Teacher"),
            QuizQuestion(question: "What do you use to measure things?", options: ["Ruler", "Calculator", "Compass", "Clock"], correctAnswer: "Ruler"),
        ]
    }
    var level7Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "What do you use to pay for things?", options: ["Money", "Pillow", "Book", "Toy"], correctAnswer: "Money"),
                QuizQuestion(question: "What do you ride to go up and down floors?", options: ["Elevator", "Car", "Boat", "Bike"], correctAnswer: "Elevator"),
                QuizQuestion(question: "What store sells clothes?", options: ["Clothing store", "Grocery store", "Bookstore", "Pet shop"], correctAnswer: "Clothing store"),
                QuizQuestion(question: "Where do you buy shoes?", options: ["Shoe store", "Bakery", "Toy store", "Pharmacy"], correctAnswer: "Shoe store"),
                QuizQuestion(question: "What do you carry your purchases in?", options: ["Bag", "Hat", "Box", "Basket"], correctAnswer: "Bag"),
                QuizQuestion(question: "Who helps you find things in a store?", options: ["Salesperson", "Teacher", "Doctor", "Pilot"], correctAnswer: "Salesperson"),
                QuizQuestion(question: "What do you try on before buying?", options: ["Clothes", "Food", "Books", "Toys"], correctAnswer: "Clothes"),
                QuizQuestion(question: "What do you eat when you are hungry at the mall?", options: ["Snacks", "Paper", "Shoes", "Paint"], correctAnswer: "Snacks"),
                QuizQuestion(question: "Where do you go to watch movies?", options: ["Cinema", "Bank", "Hospital", "Library"], correctAnswer: "Cinema"),
                QuizQuestion(question: "Who do you go shopping with?", options: ["Family", "Dog", "Doctor", "Teacher"], correctAnswer: "Family"),
            ]
        }

        // Level 8: Park with Friends
        var level8Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "Where do you play with your friends?", options: ["Park", "Office", "Kitchen", "Garage"], correctAnswer: "Park"),
                QuizQuestion(question: "What do you swing on?", options: ["Swing", "Slide", "See-saw", "Monkey bars"], correctAnswer: "Swing"),
                QuizQuestion(question: "What do you slide down?", options: ["Slide", "Ladder", "Tree", "Fence"], correctAnswer: "Slide"),
                QuizQuestion(question: "What do you kick to play soccer?", options: ["Ball", "Stick", "Rock", "Bottle"], correctAnswer: "Ball"),
                QuizQuestion(question: "What do you climb on?", options: ["Monkey bars", "Bench", "Table", "Car"], correctAnswer: "Monkey bars"),
                QuizQuestion(question: "What insect buzzes and makes honey?", options: ["Bee", "Butterfly", "Ant", "Spider"], correctAnswer: "Bee"),
                QuizQuestion(question: "What do you have at the park when you eat outside?", options: ["Picnic", "Party", "Concert", "Class"], correctAnswer: "Picnic"),
                QuizQuestion(question: "What do you throw to play catch?", options: ["Ball", "Book", "Hat", "Shoe"], correctAnswer: "Ball"),
                QuizQuestion(question: "What do you do on a see-saw?", options: ["Up and down", "Side to side", "Round and round", "Jump"], correctAnswer: "Up and down"),
                QuizQuestion(question: "What do you wear on your head to protect from the sun?", options: ["Hat", "Gloves", "Scarf", "Socks"], correctAnswer: "Hat"),
            ]
        }

        // Level 9: Bicycle Trip
        var level9Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "What do you ride with two wheels?", options: ["Bicycle", "Car", "Boat", "Plane"], correctAnswer: "Bicycle"),
                QuizQuestion(question: "What do you wear on your head for safety?", options: ["Helmet", "Gloves", "Hat", "Shoes"], correctAnswer: "Helmet"),
                QuizQuestion(question: "What do you use to steer a bicycle?", options: ["Handlebars", "Pedals", "Seat", "Wheels"], correctAnswer: "Handlebars"),
                QuizQuestion(question: "What do you press to stop the bicycle?", options: ["Brakes", "Bell", "Light", "Horn"], correctAnswer: "Brakes"),
                QuizQuestion(question: "Where do you ride your bicycle?", options: ["Bike path", "Kitchen", "Roof", "Pool"], correctAnswer: "Bike path"),
                QuizQuestion(question: "Who do you go on a bicycle trip with?", options: ["Family", "Dog", "Doctor", "Teacher"], correctAnswer: "Family"),
                QuizQuestion(question: "What do you use to make noise on your bike?", options: ["Bell", "Light", "Basket", "Flag"], correctAnswer: "Bell"),
                QuizQuestion(question: "What do you wear on your feet when cycling?", options: ["Shoes", "Slippers", "Boots", "Sandals"], correctAnswer: "Shoes"),
                QuizQuestion(question: "What do you drink when you are thirsty?", options: ["Water", "Juice", "Milk", "Soda"], correctAnswer: "Water"),
                QuizQuestion(question: "What do you see in nature while biking?", options: ["Trees", "Buildings", "Computers", "Cars"], correctAnswer: "Trees"),
            ]
        }

        // Level 10: Visiting Grandparents in the Countryside
        var level10Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "Who are your mom and dad's parents?", options: ["Grandparents", "Siblings", "Cousins", "Uncles"], correctAnswer: "Grandparents"),
                QuizQuestion(question: "Where do your grandparents live?", options: ["Countryside", "City", "Beach", "School"], correctAnswer: "Countryside"),
                QuizQuestion(question: "What animals might you see on a farm?", options: ["Cows", "Elephants", "Penguins", "Dolphins"], correctAnswer: "Cows"),
                QuizQuestion(question: "What do you pick from trees in an orchard?", options: ["Fruits", "Stones", "Leaves", "Bugs"], correctAnswer: "Fruits"),
                QuizQuestion(question: "What vehicle might you ride on a farm?", options: ["Tractor", "Subway", "Airplane", "Boat"], correctAnswer: "Tractor"),
                QuizQuestion(question: "What do you sleep in at night?", options: ["Bed", "Chair", "Table", "Car"], correctAnswer: "Bed"),
                QuizQuestion(question: "What meal do you eat in the morning?", options: ["Breakfast", "Lunch", "Dinner", "Snack"], correctAnswer: "Breakfast"),
                QuizQuestion(question: "What do you see shining in the night sky?", options: ["Stars", "Clouds", "Rain", "Birds"], correctAnswer: "Stars"),
                QuizQuestion(question: "What pet might you play with at your grandparents' house?", options: ["Dog", "Lion", "Shark", "Whale"], correctAnswer: "Dog"),
                QuizQuestion(question: "What do you say when you arrive?", options: ["Hello", "Goodbye", "Thank you", "Please"], correctAnswer: "Hello"),
            ]
        }

        // Level 11: Hiking with Grandpa
        var level11Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "What do you wear on your feet for hiking?", options: ["Boots", "Slippers", "Sandals", "Socks"], correctAnswer: "Boots"),
                QuizQuestion(question: "What do you carry your things in?", options: ["Backpack", "Basket", "Briefcase", "Suitcase"], correctAnswer: "Backpack"),
                QuizQuestion(question: "What do you use to see far away?", options: ["Binoculars", "Microscope", "Camera", "Glasses"], correctAnswer: "Binoculars"),
                QuizQuestion(question: "What do you follow to stay on the path?", options: ["Trail", "River", "Road", "Sky"], correctAnswer: "Trail"),
                QuizQuestion(question: "What do you eat when you are hungry during hiking?", options: ["Snacks", "Stones", "Leaves", "Sticks"], correctAnswer: "Snacks"),
                QuizQuestion(question: "What animal might you see in the forest?", options: ["Bird", "Dolphin", "Camel", "Penguin"], correctAnswer: "Bird"),
                QuizQuestion(question: "What do you use to tell direction?", options: ["Compass", "Clock", "Calculator", "Phone"], correctAnswer: "Compass"),
                QuizQuestion(question: "Who do you go hiking with?", options: ["Grandpa", "Chef", "Doctor", "Teacher"], correctAnswer: "Grandpa"),
                QuizQuestion(question: "What do you wear to protect your eyes from the sun?", options: ["Sunglasses", "Gloves", "Scarf", "Hat"], correctAnswer: "Sunglasses"),
                QuizQuestion(question: "What do you drink to stay hydrated?", options: ["Water", "Milk", "Juice", "Soda"], correctAnswer: "Water"),
            ]
        }

        // Level 12: Trip to the Zoo
        var level12Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "Where do you go to see many animals?", options: ["Zoo", "Library", "Museum", "School"], correctAnswer: "Zoo"),
                QuizQuestion(question: "What animal has a long neck?", options: ["Giraffe", "Elephant", "Lion", "Monkey"], correctAnswer: "Giraffe"),
                QuizQuestion(question: "What animal is known as the king of the jungle?", options: ["Lion", "Tiger", "Bear", "Zebra"], correctAnswer: "Lion"),
                QuizQuestion(question: "What black and white animal eats bamboo?", options: ["Panda", "Penguin", "Zebra", "Skunk"], correctAnswer: "Panda"),
                QuizQuestion(question: "What animal swings from trees?", options: ["Monkey", "Kangaroo", "Elephant", "Hippo"], correctAnswer: "Monkey"),
                QuizQuestion(question: "What do you buy to enter the zoo?", options: ["Ticket", "Book", "Food", "Toy"], correctAnswer: "Ticket"),
                QuizQuestion(question: "What animal has a trunk?", options: ["Elephant", "Rhino", "Horse", "Dog"], correctAnswer: "Elephant"),
                QuizQuestion(question: "What do you use to take pictures?", options: ["Camera", "Phone", "Book", "Glasses"], correctAnswer: "Camera"),
                QuizQuestion(question: "What do you eat when you are hungry?", options: ["Snack", "Toy", "Book", "Paint"], correctAnswer: "Snack"),
                QuizQuestion(question: "Who do you go to the zoo with?", options: ["Family", "Doctor", "Teacher", "Chef"], correctAnswer: "Family"),
            ]
        }

        // Level 13: Trip to the Aquarium
        var level13Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "Where do you go to see fish and sea animals?", options: ["Aquarium", "Zoo", "Museum", "Park"], correctAnswer: "Aquarium"),
                QuizQuestion(question: "What animal has eight legs and lives in the sea?", options: ["Octopus", "Fish", "Dolphin", "Shark"], correctAnswer: "Octopus"),
                QuizQuestion(question: "What big fish has sharp teeth?", options: ["Shark", "Whale", "Seal", "Jellyfish"], correctAnswer: "Shark"),
                QuizQuestion(question: "What friendly animal jumps out of the water?", options: ["Dolphin", "Crab", "Lobster", "Starfish"], correctAnswer: "Dolphin"),
                QuizQuestion(question: "What animal carries its home on its back?", options: ["Turtle", "Frog", "Snake", "Bird"], correctAnswer: "Turtle"),
                QuizQuestion(question: "What do you look through to see the animals?", options: ["Glass", "Mirror", "Door", "Window"], correctAnswer: "Glass"),
                QuizQuestion(question: "What animal has a hard shell and pinchers?", options: ["Crab", "Seal", "Penguin", "Whale"], correctAnswer: "Crab"),
                QuizQuestion(question: "What do you wear to keep warm if it's cold inside?", options: ["Jacket", "Swimsuit", "Shorts", "Hat"], correctAnswer: "Jacket"),
                QuizQuestion(question: "What do you eat at the aquarium café?", options: ["Snack", "Toy", "Book", "Paint"], correctAnswer: "Snack"),
                QuizQuestion(question: "What color is the ocean?", options: ["Blue", "Green", "Red", "Yellow"], correctAnswer: "Blue"),
            ]
        }

        // Level 14: Going to the Beach
        var level14Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "Where do you play with sand and water?", options: ["Beach", "Mountain", "Forest", "Desert"], correctAnswer: "Beach"),
                QuizQuestion(question: "What do you build with sand?", options: ["Sandcastle", "House", "Boat", "Car"], correctAnswer: "Sandcastle"),
                QuizQuestion(question: "What do you wear to swim?", options: ["Swimsuit", "Pajamas", "Uniform", "Coat"], correctAnswer: "Swimsuit"),
                QuizQuestion(question: "What do you put on your skin to protect from the sun?", options: ["Sunscreen", "Water", "Soap", "Lotion"], correctAnswer: "Sunscreen"),
                QuizQuestion(question: "What do you use to dig in the sand?", options: ["Shovel", "Fork", "Spoon", "Knife"], correctAnswer: "Shovel"),
                QuizQuestion(question: "What do you lay on to relax?", options: ["Towel", "Bed", "Chair", "Table"], correctAnswer: "Towel"),
                QuizQuestion(question: "What do you collect at the beach?", options: ["Seashells", "Rocks", "Leaves", "Flowers"], correctAnswer: "Seashells"),
                QuizQuestion(question: "What animal might you see swimming?", options: ["Fish", "Bird", "Dog", "Cat"], correctAnswer: "Fish"),
                QuizQuestion(question: "What do you fly in the sky at the beach?", options: ["Kite", "Balloon", "Plane", "Bird"], correctAnswer: "Kite"),
                QuizQuestion(question: "What do you eat to cool down?", options: ["Ice cream", "Soup", "Hot dog", "Pizza"], correctAnswer: "Ice cream"),
            ]
        }

        // Level 15: Camping with Family
        var level15Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "What do you sleep in when camping?", options: ["Tent", "House", "Car", "Boat"], correctAnswer: "Tent"),
                QuizQuestion(question: "What do you sit around at night for warmth?", options: ["Campfire", "Table", "Pool", "Garden"], correctAnswer: "Campfire"),
                QuizQuestion(question: "What do you roast over a fire?", options: ["Marshmallows", "Apples", "Bread", "Ice cream"], correctAnswer: "Marshmallows"),
                QuizQuestion(question: "What do you look at in the night sky?", options: ["Stars", "Clouds", "Birds", "Kites"], correctAnswer: "Stars"),
                QuizQuestion(question: "What do you use to light up the dark?", options: ["Flashlight", "Phone", "Book", "Camera"], correctAnswer: "Flashlight"),
                QuizQuestion(question: "What do you roll out to sleep on?", options: ["Sleeping bag", "Towel", "Pillow", "Blanket"], correctAnswer: "Sleeping bag"),
                QuizQuestion(question: "What do you cook food on?", options: ["Grill", "Oven", "Microwave", "Stove"], correctAnswer: "Grill"),
                QuizQuestion(question: "What insect might you hear at night?", options: ["Cricket", "Bee", "Butterfly", "Ant"], correctAnswer: "Cricket"),
                QuizQuestion(question: "Who do you go camping with?", options: ["Family", "Doctor", "Teacher", "Chef"], correctAnswer: "Family"),
                QuizQuestion(question: "What do you need to start a fire?", options: ["Matches", "Water", "Food", "Paper"], correctAnswer: "Matches"),
            ]
        }

        // Level 16: Trip to Onsen
        var level16Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "What is a hot spring bath called in Japan?", options: ["Onsen", "Sushi", "Kimono", "Origami"], correctAnswer: "Onsen"),
                QuizQuestion(question: "What do you wear in an onsen?", options: ["Nothing", "Swimsuit", "Uniform", "Coat"], correctAnswer: "Nothing"),
                QuizQuestion(question: "What do you do before entering the onsen?", options: ["Wash your body", "Eat food", "Sleep", "Sing"], correctAnswer: "Wash your body"),
                QuizQuestion(question: "What do you feel in a hot bath?", options: ["Relaxed", "Hungry", "Angry", "Sad"], correctAnswer: "Relaxed"),
                QuizQuestion(question: "What do you dry yourself with?", options: ["Towel", "Paper", "Book", "Clothes"], correctAnswer: "Towel"),
                QuizQuestion(question: "What do you wear after the bath?", options: ["Yukata", "Suit", "Pajamas", "Uniform"], correctAnswer: "Yukata"),
                QuizQuestion(question: "What do you drink to refresh?", options: ["Juice", "Milk", "Soda", "Water"], correctAnswer: "Milk"),
                QuizQuestion(question: "Who do you go to the onsen with?", options: ["Family", "Friends", "Teacher", "Doctor"], correctAnswer: "Family"),
                QuizQuestion(question: "What do you see around the onsen?", options: ["Mountains", "Ocean", "Desert", "City"], correctAnswer: "Mountains"),
                QuizQuestion(question: "What season is nice for hot springs?", options: ["Winter", "Summer", "Spring", "Fall"], correctAnswer: "Winter"),
            ]
        }

        // Level 17: At the Airport
        var level17Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "Where do airplanes take off and land?", options: ["Airport", "Train station", "Bus stop", "Harbor"], correctAnswer: "Airport"),
                QuizQuestion(question: "What do you need to board a plane?", options: ["Boarding pass", "Book", "Toy", "Ticket"], correctAnswer: "Boarding pass"),
                QuizQuestion(question: "What do you put your clothes in when traveling?", options: ["Suitcase", "Basket", "Envelope", "Box"], correctAnswer: "Suitcase"),
                QuizQuestion(question: "Who flies the airplane?", options: ["Pilot", "Doctor", "Teacher", "Chef"], correctAnswer: "Pilot"),
                QuizQuestion(question: "What do you show for identification?", options: ["Passport", "Money", "Book", "Ticket"], correctAnswer: "Passport"),
                QuizQuestion(question: "Where do you wait for your flight?", options: ["Gate", "Platform", "Dock", "Garage"], correctAnswer: "Gate"),
                QuizQuestion(question: "What do you ride to get to the airplane?", options: ["Bus", "Car", "Train", "Bicycle"], correctAnswer: "Bus"),
                QuizQuestion(question: "What do you do with your luggage at check-in?", options: ["Check it in", "Throw it away", "Hide it", "Give it to a friend"], correctAnswer: "Check it in"),
                QuizQuestion(question: "What do you call a big airplane?", options: ["Jet", "Helicopter", "Glider", "Balloon"], correctAnswer: "Jet"),
                QuizQuestion(question: "Who helps you on the plane?", options: ["Flight attendant", "Pilot", "Driver", "Teacher"], correctAnswer: "Flight attendant"),
            ]
        }

        // Level 18: Traveling with Airplane
        var level18Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "What do you fasten during takeoff?", options: ["Seatbelt", "Shoes", "Hat", "Scarf"], correctAnswer: "Seatbelt"),
                QuizQuestion(question: "What do you look out to see the clouds?", options: ["Window", "Door", "Floor", "Ceiling"], correctAnswer: "Window"),
                QuizQuestion(question: "What do you listen to for safety instructions?", options: ["Announcements", "Music", "TV", "Radio"], correctAnswer: "Announcements"),
                QuizQuestion(question: "What do you eat on the plane?", options: ["In-flight meal", "Home-cooked meal", "Picnic", "Fast food"], correctAnswer: "In-flight meal"),
                QuizQuestion(question: "What do you use to hear music?", options: ["Headphones", "Glasses", "Hat", "Shoes"], correctAnswer: "Headphones"),
                QuizQuestion(question: "What do you read on the plane?", options: ["Magazine", "Book", "Newspaper", "All of the above"], correctAnswer: "All of the above"),
                QuizQuestion(question: "What do you feel when the plane moves suddenly?", options: ["Turbulence", "Excitement", "Sadness", "Anger"], correctAnswer: "Turbulence"),
                QuizQuestion(question: "What do you use to call a flight attendant?", options: ["Call button", "Phone", "Bell", "Clap"], correctAnswer: "Call button"),
                QuizQuestion(question: "What do you do if you are tired?", options: ["Sleep", "Run", "Jump", "Dance"], correctAnswer: "Sleep"),
                QuizQuestion(question: "What vehicle do you ride in the sky?", options: ["Airplane", "Boat", "Car", "Train"], correctAnswer: "Airplane"),
            ]
        }

        // Level 19: Traveling Abroad
        var level19Questions: [QuizQuestion] {
            return [
                QuizQuestion(question: "What do you call visiting another country?", options: ["Traveling abroad", "Staying home", "Going to school", "Working"], correctAnswer: "Traveling abroad"),
                QuizQuestion(question: "What do you need to enter a new country?", options: ["Passport", "Money", "Book", "Toy"], correctAnswer: "Passport"),
                QuizQuestion(question: "What language do you speak in another country?", options: ["Foreign language", "Home language", "Secret language", "No language"], correctAnswer: "Foreign language"),
                QuizQuestion(question: "What do you buy to remember your trip?", options: ["Souvenir", "Food", "Clothes", "Car"], correctAnswer: "Souvenir"),
                QuizQuestion(question: "Where do you sleep when traveling?", options: ["Hotel", "School", "Office", "Garage"], correctAnswer: "Hotel"),
                QuizQuestion(question: "What do you use to take pictures?", options: ["Camera", "Book", "Pen", "Phone"], correctAnswer: "Camera"),
                QuizQuestion(question: "What do you try that's new?", options: ["Food", "Homework", "Work", "Uniform"], correctAnswer: "Food"),
                QuizQuestion(question: "Who do you meet in another country?", options: ["New friends", "Old friends", "Pets", "Teachers"], correctAnswer: "New friends"),
                QuizQuestion(question: "What do you send to your friends?", options: ["Postcard", "Toy", "Money", "Clothes"], correctAnswer: "Postcard"),
                QuizQuestion(question: "What do you say in a new language?", options: ["Hello", "Goodbye", "Yes", "All of the above"], correctAnswer: "All of the above"),
            ]
        }
    var level20Questions: [QuizQuestion] {
        return [
            QuizQuestion(question: "What do you ride that goes up and down?", options: ["Roller coaster", "Ferris wheel", "Carousel", "Train"], correctAnswer: "Roller coaster"),
            QuizQuestion(question: "What ride spins around and has horses?", options: ["Carousel", "Bumper cars", "Water slide", "Swing ride"], correctAnswer: "Carousel"),
            QuizQuestion(question: "What do you eat that's fluffy and sweet?", options: ["Cotton candy", "Popcorn", "Hot dog", "Apple"], correctAnswer: "Cotton candy"),
            QuizQuestion(question: "What game do you play to win a prize?", options: ["Ring toss", "Soccer", "Tag", "Hide and seek"], correctAnswer: "Ring toss"),
            QuizQuestion(question: "What ride takes you high to see the view?", options: ["Ferris wheel", "Boat ride", "Train ride", "Slide"], correctAnswer: "Ferris wheel"),
            QuizQuestion(question: "What do you need to enter the park?", options: ["Ticket", "Money", "Map", "Hat"], correctAnswer: "Ticket"),
            QuizQuestion(question: "Who do you go to the amusement park with?", options: ["Family", "Teacher", "Doctor", "Mailman"], correctAnswer: "Family"),
            QuizQuestion(question: "What do you wear on your head to protect from the sun?", options: ["Hat", "Gloves", "Scarf", "Socks"], correctAnswer: "Hat"),
            QuizQuestion(question: "What do you use to buy snacks?", options: ["Money", "Book", "Toy", "Phone"], correctAnswer: "Money"),
            QuizQuestion(question: "What do you feel when you have fun?", options: ["Happy", "Sad", "Angry", "Tired"], correctAnswer: "Happy"),
        ]
    }

    // Continue adding similar blocks for levels 3 to 20.

    // Placeholder for default questions
    var defaultQuestions: [QuizQuestion] {
        return [
            QuizQuestion(question: "Default question?", options: ["Option A", "Option B"], correctAnswer: "Option A")
        ]
    }
}
