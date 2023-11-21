

module counter_addr::counter {

    use std::signer;
    use aptos_framework::event;
    use aptos_framework::account;




    // Errors
    const E_NOT_INITIALIZED: u64 = 1;

    struct CounterStruct has key {
        set_counter_event: event::EventHandle<u64>,

        counter: u64
    }

    public entry fun initialize_counter(account: &signer) {
        let  counter_resource= CounterStruct {
            set_counter_event: account::new_event_handle<u64>(account),
            counter: 0
        };
        // move the counter resource under the signer account
        move_to(account, counter_resource);
    }

    public entry fun increment_counter(account: &signer) acquires CounterStruct {
        // gets the signer address
        let signer_address = signer::address_of(account);
        assert!(exists<CounterStruct>(signer_address), 1);

        let counter_resource = borrow_global_mut<CounterStruct>(signer_address);
        // increment game counter
        let new_counter = counter_resource.counter + 1;
        
        // sets the game counter to be the incremented counter
        counter_resource.counter = new_counter;
        // fires a new counter created event
        event::emit_event<u64>(
        &mut borrow_global_mut<CounterStruct>(signer_address).set_counter_event,
        new_counter,
    );
    }



   
}