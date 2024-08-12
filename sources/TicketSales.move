

module TicketSales {

    use aptos_framework::account;
    use aptos_framework::coin::{Coin, withdraw};
    use aptos_framework::event::{EventHandle, emit};
    use aptos_framework::signer::Signer;
    use aptos_framework::vector;

    struct Ticket has store {
        id: u64,
        event_name: vector<u8>,
        owner: address,
    }

    struct TicketSale has store {
        tickets: vector<Ticket>,
        price_per_ticket: u64,
        total_tickets: u64,
        tickets_sold: u64,
        sale_owner: address,
        event_name: vector<u8>,
    }

    struct TicketSaleManager has store {
        sales: vector<TicketSale>,
    }

    struct TicketPurchaseEvent has store {
        id: u64,
        buyer: address,
    }

    // Event handles
    struct TicketEvents has store {
        ticket_purchase_event_handle: EventHandle<TicketPurchaseEvent>,
    }

    public fun initialize(account: &signer) {
        let sale_manager = TicketSaleManager {
            sales: vector::empty(),
        };

        let ticket_events = TicketEvents {
            ticket_purchase_event_handle: account::new_event_handle<TicketPurchaseEvent>(account),
        };

        account::add_resource(account, sale_manager);
        account::add_resource(account, ticket_events);
    }

    public fun create_ticket_sale(account: &signer, price_per_ticket: u64, total_tickets: u64, event_name: vector<u8>) {
        let sale = TicketSale {
            tickets: vector::empty(),
            price_per_ticket,
            total_tickets,
            tickets_sold: 0,
            sale_owner: signer::address_of(account),
            event_name,
        };

        let manager_ref = borrow_global_mut<TicketSaleManager>(signer::address_of(account));
        vector::push_back(&mut manager_ref.sales, sale);
    }

    public fun purchase_ticket(account: &signer, sale_id: u64, payment: Coin) {
        let manager_ref = borrow_global_mut<TicketSaleManager>(signer::address_of(account));
        let sale_ref = &mut vector::borrow_mut(&mut manager_ref.sales, sale_id);
        
        assert!(sale_ref.tickets_sold < sale_ref.total_tickets, 101);
        assert!(Coin::value(&payment) >= sale_ref.price_per_ticket, 102);

        let ticket = Ticket {
            id: sale_ref.tickets_sold,
            event_name: sale_ref.event_name.clone(),
            owner: signer::address_of(account),
        };

        vector::push_back(&mut sale_ref.tickets, ticket);
        sale_ref.tickets_sold = sale_ref.tickets_sold + 1;

        // Transfer payment to sale owner
        let sale_owner_address = sale_ref.sale_owner;
        withdraw(account, sale_ref.price_per_ticket);
        Coin::deposit(&sale_owner_address, payment);

        // Emit purchase event
        let ticket_events = borrow_global_mut<TicketEvents>(signer::address_of(account));
        emit(&mut ticket_events.ticket_purchase_event_handle,TicketPurchaseEvent {id: sale_ref.tickets_sold - 1,buyer:signer::address_of(account)})
    }
}