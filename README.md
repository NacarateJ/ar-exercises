# Active Record Exercises

## Introduction

You'll find that this project has two Active Record "models" (classes):

1. Store
2. Employee

This means that there is a `stores` table and an `employees` table in the database that it is using. Since we are using an ORM, we just use the two ruby classes and their instances to manage (CRUD) that data.

We'll be modifying this database via Active Record only. The `setup.rb` file already defines the database structure so you _don't need_ to create anything in the database using SQL manually.

That said, feel free to connect to your Postgres database using `psql` or pgAdmin so that you can see what's in the database.

## Instructions

### Setup

1. Create a new Postgres database. Use `psql postgres` to connect to the database server. Use `create database ar_exercises;` to create the database.
2. Take a look at the `establish_connection` method call in `setup.rb`. This will allow Active Record to connect to _your_ Postgres database. If you are using vagrant, you should not need to make any changes here.
3. Run `bundle install` to install the gems.
4. Run the first exercise file to make sure the database connection is working: `bundle exec ruby exercises/exercise_1.rb`. It should just output "Exercise 1" at the end, since you don't yet have any code in there.

- Running without `bundle exec` may run the wrong version of ruby or it may use the correct version of ruby but with incorrect gem versions.
- Using `bundle exec` for ruby scripts/apps is fairly common in the Ruby community.

### Running Exercises

Complete the exercises by modifying the appropriate `exercises/exercise_*.rb` file and run the exercise using the `ruby` command.

Example:

    bundle exec ruby exercises/exercise_1.rb

Follow the instructions to work on the exercises within the `exercises` folder. Each exercise is to be completed in it's appropriate file.

**IMPORTANT:**

- Remember to `git commit` (and `git push`) at logical steps, like at the end of every exercise.
- You do not need to / should not comment out your code in each exercise as you move on to the next one. The exercises in this assignment are meant to build on and continue from the previous ones. That's why you see them requiring the previous ones.
- The setup ruby script actually drops and recreates the db tables with every run of the exercise. This is of course not practical in most real apps, because the data is usually meant to stay long term.

You can work with the models with irb by running

    irb -r './setup.rb'

## Exercises

### Exercise 1: Create 3 stores

1. Use Active Record's `create` class method multiple times to create 3 stores in the database:

- Burnaby (annual_revenue of 300000, carries men's and women's apparel)
- Richmond (annual_revenue of 1260000 carries women's apparel only)
- Gastown (annual_revenue of 190000 carries men's apparel only)

2. Output (`puts`) the number of the stores using ActiveRecord's `count` method, to ensure that there are three stores in the database.

### Exercise 2: Update the first store

1. Load the first store (with `id = 1`) from the database and assign it to an instance variable `@store1`.
2. Load the second store from the database and assign it to `@store2`.
3. Update the first store (`@store1`) instance in the database. (Change its name or something.)

### Exercise 3: Delete the third store

1. Load the third store (into `@store3`) as you did the other two before.
2. Using Active Record's `destroy` method, delete the store from the database.
3. Verify that the store has been deleted by again outputting (`puts`ing) the `count` (as you did in Exercise 1.)

### Exercise 4: Loading a subset of stores

1. Borrowing and modifying the code from Exercise one, create 3 more stores:

- Surrey (annual_revenue of 224000, carries women's apparel only)
- Whistler (annual_revenue of 1900000 carries men's apparel only)
- Yaletown (annual_revenue of 430000 carries men's and women's apparel)

2. Using the `where` class method from Active Record, fetch (a collection of) only those stores that carry men's apparel. Assign the results to a variable `@mens_stores`.
3. Loop through each of these stores and output their name and annual revenue on each line.
4. Do another fetch but this time load stores that carry women's apparel and are generating less than $1M in annual revenue.

### Exercise 5: Calculations

1. Output the total revenue for the entire company (all stores), using Active Record's `.sum` calculation method.
2. On the next line, also output the average annual revenue for all stores.
3. Output the number of stores that are generating $1M or more in annual sales. **Hint:** Chain together `where` and `size` (or `count`) Active Record methods.

### Exercise 6: One-to-many association

We haven't used the Employee class (and employees table) at all yet. If you look at this table's column structure, you'll find that it has a `store_id` (integer) column. This is a column that identifies which store each employee belongs to. It points to the `id` (integer) column of their store.

Let's tell Active Record that these two tables are in fact related via the `store_id` column.

1. Add the following code _directly_ inside the Store model (class): `has_many :employees`
2. Add the following code directly inside the Employee model (class): `belongs_to :store`
3. Add some data into employees. Here's an example of one (note how it differs from how you create stores): `@store1.employees.create(first_name: "Khurram", last_name: "Virani", hourly_rate: 60)`
4. Go ahead and create some more employees using the create method. You can do this by making multiple calls to create (like you have before.) No need to assign the employees to variables though. Create them through the `@store#` instance variables that you defined in previous exercises. Create a bunch under `@store1` (Burnaby) and `@store2` (Richmond). Eg: `@store1.employees.create(...)`.

### Exercise 7: Validations for both models

1. Add validations to two models to enforce the following business rules:

- Employees must always have a first name present
- Employees must always have a last name present
- Employees have a hourly_rate that is a number (integer) between 40 and 200
- Employees must always have a store that they belong to (can't have an employee that is not assigned a store)
- Stores must always have a name that is a minimum of 3 characters
- Stores have an annual_revenue that is a number (integer) that must be 0 or more
- BONUS: Stores must carry at least one of the men's or women's apparel (hint: use a [custom validation method](http://guides.rubyonrails.org/active_record_validations.html#custom-methods) - **don't** use a `Validator` class)

2. Ask the user for a store name (store it in a variable)
3. Attempt to create a store with the inputted name but leave out the other fields (annual_revenue, mens_apparel, and womens_apparel)
4. Display the error messages provided back from ActiveRecord to the user (one on each line) after you attempt to save/create the record

## STRETCH

Having read a bit about Callbacks, it's time to play with them a bit to really let it sink in.

### Exercises
You're going to step up the Stores & Employees exercise a notch by solving some business problems by using Callbacks. This will help you get comfortable with them and also appreciate what problems they aim to solve.

### Exercise 1: Employee passwords
**Scenario:** We want to be able to give employees a password (string) that is auto-generated when their record is created in the database.

### Step 1: Setup
Create a new exercise file called `exercise_8.rb`, add the necessary `require_relative` calls based on the pattern you see previous exercises following in this project.

### Step 2: Modify Schema
In order to solve this problem, we need a new column on employees called `password`. Go ahead and modify the schema and it is as a `string` (which really just means `varchar` in SQL) column to the `employees` table.

### Step 3: Add a callback
Let's revisit the goal:

Before an employee is created, AR should automatically create a random (8 character string) password.

There are multiple ways to register callbacks in AR, instead of passing in a block, we suggest using the approach where you give it the name of a private method using symbols. Although it results in "more lines of code", it does read better and feels better organized.

Since the key words here are "before" and "created", you should investigate how to register a `before_create` callback method on the Employee model.

The callback method will really just be one line, where it will set `self.password` (or you could just write `password` instead) to a random 8 character string.

You could register this callback above or below your associations or validations. AR doesn't care. That said, we suggest the following order / style for your model definitions so that there is some consistency with them:

1. Declare Associations
2. Declare Validations
3. Register Callback Methods using symbols (method names)
4. ... Your regular methods ...
5. Private methods (eg: callback code)

**NOTE:** The callback method should ideally be a private method and have a descriptive name.

Can you speak to *WHY* the callback method should be private? What does that mean? If you're not sure, research and see if you can answer this question.

### Step 4: Verify
In `exercise_8.rb` create another employee for an existing store and once created (using `save` or `create`) but without specifying a password when creating the record so that it can be auto-created by the model.

Use `puts` in the exercise file to print out the password after the record is created to make sure that is working.

### Step 5: Question - What about `after_create`?
If you switch the `before_create` into an `after_create` instead, what do we expect will happen? Have a hypothesis and experiment.

Run your exercise to check your assumption.

If it does not work, is there a change you can make to the callback method itself to fix it, without reverting back to `before_create`?

Once you get it working with `after_create`, it's worth asking: Which approach is better. Thoughts?

### Step 6: Question - `before_save` instead ?
Similarly, what if you changed the `before_create` to a `before_save`? What's the challenge there?

Read up on the definition or experiment to find out what the result could be.

### Exercise 2: Disallow store destruction
***Scenario:*** For data integrity reasons, we want to restrict users from deleting (aka destroying) store records for stores that have 1 or more employees.

### Step 1: Setup
Create a new exercise file called `exercise_9.rb`, add the necessary `require_relative` calls based on the pattern you see previous exercises following in this project.

### Step 2: Destruction code
Add the following "driver" code to your new exercise file:

# Make sure non-empty stores cannot be destroyed
@store1 = Store.find(1)
if @store1.destroy
  puts "Store destroyed! It has #{@store1.employees.size} =/"
else
  puts "Could not destroy store :)"
end

```ruby
# Make sure non-empty stores cannot be destroyed
@store1 = Store.find_by(id: 1)
if @store1.destroy
  puts "Store destroyed! It has #{@store1.employees.size} =/"
else
  puts "Could not destroy store :)"
end

# Make sure empty stores can be destroyed
@empty_store = Store.create!(name: 'Test Empty Store', annual_revenue: 0, mens_apparel: true, womens_apparel: true)
if @empty_store.destroy
  puts "Empty Store destroyed! This is good"
else
  puts "Whoa! Empty store should be destroyable... Not cool!"
end
```

Running this exercise you will find that it allows destruction of store1 which *does* have employees.

### Step 3: Implement restriction
Register a callback on the Store model that will help you stop the destroy life cycle from taking place in that condition. You'll need to research how to do this!
