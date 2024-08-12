Introduction
This project is a decentralized ticket sales system built on the Aptos blockchain using the Move programming language. 
The system enables the creation, management, and sale of event tickets in a secure and transparent manner.
Each ticket is represented as a unique token on the Aptos blockchain, ensuring that the ticket ownership and transfer 
are verifiable and immutable.

Project Structure
Move.toml: Configuration file for the Move project.
sources/: Contains the Move source files defining the modules and functions for the ticket sales system.
scripts/: Scripts used for deployment and other tasks.
tests/: Contains test cases to ensure the functionality of the ticket sales system.
README.md: Documentation for the project.


Prerequisites
Before setting up the project, ensure you have the following installed:

Aptos CLI - To interact with the Aptos blockchain.
Move CLI - To compile and deploy Move smart contracts.
Rust - Required for building the Move language and Aptos CLI.
Node.js (Optional) - For running any additional scripts that might be needed.

Modules and Functions
Ticket.move
Defines the ticket as a resource and includes functions for creating, transferring, and validating tickets.

Event.move
Manages event creation, ticket allocation, and event-related metadata.

TicketSales.move
The core module that handles the logic for ticket sales, including purchasing and transferring tickets.

Key Functions
create_event: Creates a new event with a specified number of tickets.
purchase_ticket: Allows a user to purchase a ticket for a specific event.
transfer_ticket: Transfers a ticket from one user to another.
get_event_details: Retrieves the details of a specific event.

Future Enhancements
Secondary Market: Implement a marketplace for reselling tickets.
Event Cancellation: Add functionality for event organizers to cancel events and issue refunds.
Dynamic Pricing: Implement dynamic pricing based on demand.
Contributing
Contributions are welcome! Please follow these steps:

Fork the repository.
Create a new branch (git checkout -b feature-branch).
Make your changes.
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-branch).
Create a new Pull Request.
