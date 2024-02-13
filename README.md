
I made some assumptions 
1- no Api app requested so i worked with normal views
2- no required styling for views so i made it very basic

Prerequisites
    Git
    Ruby (version 3.2.2 )
    Bundler
    Database server: PostgreSQL

Installation
    Clone the repository:
    git clone https://github.com/your-username/your-repo-name.git

Navigate to the project directory:
cd movies-assignment

Install dependencies:
bundle install

Create and configure your database:

Update config/database.yml with your database credentials.

Generate database structure:

rails db:create
rails db:migrate

Development

    Start the development server:

    rails server

This will launch the Rails server, usually accessible at http://localhost:3000.
