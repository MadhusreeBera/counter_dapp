

// module counter_addr::counter {

//     use std::signer;
//     use aptos_framework::event;
//     use aptos_framework::account;

//     // Errors
//     const E_NOT_INITIALIZED: u64 = 1;
//     const E_NOT_OWNER: u64 = 2;


//     struct CounterStruct has key {
//         set_counter_event: event::EventHandle<u64>,
//         counter: u64
//     }

//     public entry fun initialize_counter(account: &signer) {
//         assert!(signer::address_of(account) == @counter_addr, E_NOT_OWNER);
//         let  counter_resource= CounterStruct {
//             set_counter_event: account::new_event_handle<u64>(account),
//             counter: 0
//         };
//         // move the counter resource under the signer account
//         move_to(account, counter_resource);
//     }

//     public entry fun increment_counter(account: &signer) acquires CounterStruct {
//         // gets the signer address
//         let signer_address = signer::address_of(account);
//         assert!(exists<CounterStruct>(signer_address), 1);

//         let counter_resource = borrow_global_mut<CounterStruct>(signer_address);
//         // increment game counter
//         let new_counter = counter_resource.counter + 1;
        
//         // sets the game counter to be the incremented counter
//         counter_resource.counter = new_counter;
//         // fires a new counter created event
//         event::emit_event<u64>(
//         &mut borrow_global_mut<CounterStruct>(signer_address).set_counter_event,
//         new_counter,
//     );
//     }



   
// }

module counter_addr::moveCounter {

    // use aptos_framework::account;
    use std::signer;
    // use aptos_framework::event;
    // use std::string::String;
    // use aptos_std::table::{Self, Table};
    // use std::vector;

    // Errors
    const E_NOT_INITIALIZED: u64 = 1;
    const E_NOT_OWNER: u64 = 2;

    struct CounterStruct has key {
        // frequency: Table<address, Frequency>,
        global_counter: u64,
        // address_vector: vector<address>,
        // frequency_vector: vector<u64>
    }

    struct Frequency has store, drop, copy {
        value: u64
    }


    public entry fun create_counter(account: &signer) {
        assert!(signer::address_of(account) == @counter_addr, E_NOT_OWNER);
        let global_counter_resource = CounterStruct {
            // frequency: table::new(),
            global_counter: 0,
            // address_vector: vector::empty<address>(),
            // frequency_vector: vector::empty<u64>()
        };
        // move the CounterStruct resource under the signer account
        move_to(account, global_counter_resource);
    }

    public entry fun increment_counter(_account: &signer) acquires CounterStruct {
        // gets the signer address
        // let signer_address = signer::address_of(account);
        // assert module owner has created a list
        assert!(exists<CounterStruct>(@counter_addr), E_NOT_INITIALIZED);

        // gets the CounterStruct resource
        let counter_resource = borrow_global_mut<CounterStruct>(@counter_addr);

        // increment global counter
        let new_counter = counter_resource.global_counter + 1;
        counter_resource.global_counter = new_counter;

        //increment frequency for signer

        // if(table::contains(counter_resource.frequency,signer_address)){
        //     let frequency = table::borrow_mut(&mut counter_resource.frequency, signer_address);
        //     frequency.value = frequency.value + 1;
        // }
        // else{
        //     let frequency = Frequency{
        //         value: 1
        //     };
        //     table::upsert(&mut counter_resource.frequency, signer_address, frequency);
        // }

        // if(vector::contains(counter_resource.address_vector,signer_address)){
        //     let index = vector::index_of(counter_resource.address_vector,signer_address);
        //     let frequency = vector::borrow_mut(&mut counter_resource.frequency_vector, index);
        //     frequency = frequency + 1;
        // }
        // else{
        //     vector::push_back(&mut counter_resource.address_vector, signer_address);
        //     vector::push_back(&mut counter_resource.frequency_vector, 1);
        // }

    }

    public fun get_global_count(): u64 acquires CounterStruct {
        assert!(exists<CounterStruct>(@counter_addr), E_NOT_INITIALIZED);
        borrow_global<CounterStruct>(@counter_addr).global_counter
    }

    // public fun get_table(): Table<address, u64> acquires CounterStruct {
    //     assert!(exists<CounterStruct>(@counter_addr), E_NOT_INITIALIZED);
    //     borrow_global<CounterStruct>(@counter_addr).frequency
    // }

    // public entry fun complete_task(account: &signer, task_id: u64) acquires CounterStruct {
    //     // gets the signer address
    //     let signer_address = signer::address_of(account);
    //     // assert signer has created a list
    //     assert!(exists<CounterStruct>(signer_address), E_NOT_INITIALIZED);
    //     // gets the CounterStruct resource
    //     let counter_resource = borrow_global_mut<CounterStruct>(signer_address);
    //     // assert task exists
    //     assert!(table::contains(&counter_resource.frequency, task_id), ETASK_DOESNT_EXIST);
    //     // gets the task matched the task_id
    //     let task_record = table::borrow_mut(&mut counter_resource.frequency, task_id);
    //     // assert task is not completed
    //     assert!(task_record.completed == false, ETASK_IS_COMPLETED);
    //     // update task as completed
    //     task_record.completed = true;
    // }

    
}
