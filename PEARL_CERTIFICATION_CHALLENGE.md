Overview
Your task is to build a Home Asset Management App, allowing users to create and manage homes along with their key assets—essential systems and equipment that impact a home’s functionality, efficiency, and value. These assets include appliances, solar panels, and HVAC systems, among others. The app should provide a clear and intuitive way for users to track and update these assets over time

The goal of this challenge is to produce production-ready code. This will be evaluated along a number of criteria, beyond just whether or not the resulting application runs.

Feature Requirements

Home Management
Users should be able to see a list of its homes
Users should be able to create, edit, and delete homes.
Each home has a name (e.g., “Lakeview Cabin”, “Downtown Loft”) and a valid US address.

Home Assets Management
Users should be able to view the assets associated with a given home.
Users should be able to add assets to a home (searching through a predefined & static asset list). A home can have more than one of the same kind of asset.
Users should be able to remove assets from a home.

Data Handling
The application can store data in memory using state management, which is sufficient for this challenge. Local caching (e.g., Hive, SharedPreferences, SQLite) is not required but is considered a bonus if implemented.

Technical Expectations
Your implementation should follow best practices for a production-ready codebase. The main focus of our evaluation will be on architecture, maintainability, and testability rather than just completing the features.

Tech Stack & Requirements
The app must be built with Flutter.
The app must run on Android, iOS, and Web.

Submission Guidelines
Host your code in a public GitHub, GitLab, or Bitbucket repository.
Provide a README file explaining:
How to set up and run the project.
Any design choices or trade-offs made.
How to run tests.
If applicable, details about CI/CD pipelines.
Submit a link to your public repository.

Bonus
Implement CI/CD pipelines for automatic builds, testing and linting.
Provide a hosted live demo for the Web version (e.g., Firebase Hosting, Vercel, Netlify).