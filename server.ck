////////////////////////////////////////////////////////////
// Final Project
// Server Module
////////////////////////////////////////////////////////////
// Slork 2012
// Mayank Sanganeria, Jiffer Harriman, Hunter McCurry
////////////////////////////////////////////////////////////


//debug messages flags

0 => int debug_display;
0 => int debug_node_states;





// set number of num_nodes
Config.NUMNODES => int num_nodes;
// value of pulse
.1::second => dur T;

// send objects
OscSend xmit_to_nodes[num_nodes];
OscSend xmit_to_display;


//receive object
OscRecv receive_from_node;
Config.node_to_server_port => receive_from_node.port;
receive_from_node.listen();

//receive object for trigger
OscRecv receive_from_node_trigger;
Config.node_to_server_trigger_port => receive_from_node_trigger.port;
receive_from_node_trigger.listen();




//SCORE - define wail modes in sections
30 => int num_sections;
int wail_modes[num_sections];
for (0 => int i; i < num_sections; i++)
{
    0 => wail_modes[i];
}

//which sections have wail ON ?

1 => wail_modes[8];
1 => wail_modes[9];
1 => wail_modes[10];
1 => wail_modes[11];
1 => wail_modes[13];



// Initialize targets:
for (0 => int index; index < num_nodes; index++)
{
    xmit_to_nodes[index].setHost( Config.host_name(index), Config.server_to_node_port );
}
// Send display data to itself
xmit_to_display.setHost( Config.server_name(), Config.server_to_display_port );

// node states
NodeState node_states[num_nodes];

// initialize next nodes
for (0 => int i; i < num_nodes; i++) {
    i => node_states[i].machine_num;
    // (i+1) % num_nodes => node_states[i].next_node;
    //initialize with itself
    i => node_states[i].next_node;
}


//listen for requests
fun void listen_status_request()
{
    // create an address in the receiver, store in new variable
    receive_from_node.event( Config.osc_message_state(), Config.osc_message_state_data() ) @=> OscEvent oe_pulse;
    
    // infinite event loop
    while ( true )
    {
        
        // wait for event to arrive
        oe_pulse => now;
        <<<"recv msg">>>;
        //need to know who requested
        NodeState received_state;
        received_state.receive_message(oe_pulse);
        
        node_states[received_state.machine_num].copy_request_to_server(received_state);
        
        // do the needful
    }
}


//listen for triggers
fun void listen_status_request_trigger()
{
    // create an address in the receiver, store in new variable
    receive_from_node_trigger.event( Config.osc_message_state(), Config.osc_message_state_data() ) @=> OscEvent oe_pulse;
    
    // infinite event loop
    while ( true )
    {
        
        // wait for event to arrive
        oe_pulse => now;
        <<<"recv msg">>>;
        //need to know who requested
        NodeState received_state;
        received_state.receive_message(oe_pulse);
        
        node_states[received_state.machine_num].copy(received_state);
        
        // do the needful
    }
}



// Keyboard loop 
// monitors keyboard input and sets bang_next_beat to equal number pressed
fun void keyboard_loop()
{
    // Keyboard Setup
    Hid kb;
    HidMsg kb_msg;
    
    // open keyboard (get device number from command line)
    if( !kb.openKeyboard( 0 ) ) 
    {
        
        me.exit();
    }
    <<< "keyboard '" + kb.name() + "' ready", "" >>>;
    while(true) 
    {
        kb => now;
        while (kb.recv(kb_msg)){
            if (kb_msg.isButtonDown() )
            {

                <<< kb_msg.key >>>;
                if (kb_msg.key == 44) //space bar
                {
                    <<<"space bar pressed ... SLORK SILENCE!">>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        -1 => node_states[i].sequence_index;
                        0 => node_states[i].pulses_since_banged;
                    }
                }
                else if (kb_msg.key == 229) //right shift
                {
                    <<<"right shift pressed - kill connections">>>;
                    for (0 => int i; i < num_nodes; i++) 
                        i => node_states[i].next_node;
                }

                else if (kb_msg.key > 29 && kb_msg.key <40) // Number 1=30 and Number 9=38
                {
                    (kb_msg.key-29) => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 20) //q
                {
                    11 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 26) //w
                {
                    12 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 8) //e
                {
                    13 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 21) //r
                {
                    14 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 23) //t
                {
                    15 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 28) //y
                {
                    16 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 24) //u
                {
                    17 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 12) //i
                {
                    18 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 18) //o
                {
                    19 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 19) //p
                {
                    20 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 4) //a
                {
                    21 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 22) //s
                {
                    22 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 7) //d
                {
                    23 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 9) //f
                {
                    24 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 10) //g
                {
                    25 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 11) //h
                {
                    26 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 13) //j
                {
                    27 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 14) //k
                {
                    28 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 15) //l
                {
                    29 => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 46) //+
                {
                    Math.min(node_states[0].section + 1,num_sections) $ int => int numKey;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 45) //-
                {
                    Math.max(0,node_states[0].section - 1) $ int => int numKey;
                    <<< "number "+numKey+" pressed" >>>;
                    for (0 => int i; i < num_nodes; i++) 
                    {
                        numKey => node_states[i].section;
                        wail_modes[numKey] => node_states[i].wail_mode;
                    }
                }
                else if (kb_msg.key == 29) //z - put tempo back to default
                {
                    0.1::second => T;
                }
                
                else if (kb_msg.key == 27) //x - decrease tempo
                {
                    T + 0.005::second => T;
                }
                else if (kb_msg.key == 6) //c - increase tempo with certain max
                {
                    if (T>0.05::second)
                        T - 0.005::second => T;
                    
                }
                
                

            }
            
        }
    }
}

spork ~listen_status_request();
spork ~listen_status_request_trigger();
spork ~keyboard_loop();

//TODO: better way to spawn loops
//0 => node_states[0].sequence_index;

fun void update_pulses()
{
    
    int changed_this_update[num_nodes];
    for( 0 => int i; i < num_nodes; i++ )
    {
        if (debug_node_states)
            node_states[i].print();
        0 => changed_this_update[i];
        node_states[i].pulses_since_banged++;
    }
    
    for( 0 => int i; i < num_nodes; i++ )
    {
        
        if (!changed_this_update[i])
        {
            //look for active sequences
            if (node_states[i].sequence_index != -1)
            {
                node_states[i].sequence_index++; //advance sequence
                1 => changed_this_update[i];
                0 => node_states[i].pulses_since_banged;
            }
            if (node_states[i].sequence_index >= node_states[i].sequence_length) //if sequence over
            {
                -1 => node_states[i].sequence_index;              //deactivate seqence
                if (node_states[i].next_node!=node_states[i].machine_num) // if pointing to someone
                {
                    0 => node_states[node_states[i].next_node].sequence_index;  //activate next sequence
                    //send_display_transition(i, node_states[i].next_node);
                    1 => changed_this_update[node_states[i].next_node];   
                }
                else if (node_states[i].wail_mode == 1)       //if pointing to no one, and wail mode on, keep wailing
                    0 => node_states[i].sequence_index;
                
            }
        }
    }
}

// infinite time loop
while( true )
{
    //update pulses
    update_pulses();
    
    //send display data separated by a time lapse
    T/3 => now;
    send_display_playing();
    T/3 => now;
    send_display_connections();
    T/3 => now;
    send_display_pulses_since_banged();
    
    
    //send data to nodes
    for( 0 => int i; i < num_nodes; i++ )
    {
        // start the message...
        xmit_to_nodes[i].startMsg( Config.osc_message_state(), Config.osc_message_state_data() );
        
        // a message is kicked as soon as it is complete 
        node_states[i].send_message(xmit_to_nodes[i]);
    }
}

fun void send_display_connections()
{
    xmit_to_display.startMsg( Config.osc_message_server_to_display_connections(), Config.osc_message_server_to_display_connections_data() );
    for( 0 => int i; i < num_nodes; i++ )
    {
        if (debug_display)
            <<<"sending display_connections">>>;
        node_states[i].next_node => xmit_to_display.addInt;
    }
    
}
fun void send_display_playing()
{
    if (debug_display)
        <<<"sending display_playing">>>;
    xmit_to_display.startMsg( Config.osc_message_server_to_display_playing(), Config.osc_message_server_to_display_playing_data() );
    
    for( 0 => int i; i < num_nodes; i++ )
    {
        if (node_states[i].sequence_index != -1)
            1 => xmit_to_display.addInt;
        else
            0 => xmit_to_display.addInt;
    }    
}
fun void send_display_transition(int node_from, int node_to)
{
    if (debug_display)
        <<<"sending display_transition">>>;
    xmit_to_display.startMsg( Config.osc_message_server_to_display_transition(), Config.osc_message_server_to_display_transition_data() );
    node_from => xmit_to_display.addInt;
    node_to => xmit_to_display.addInt;    
    
}

fun void send_display_pulses_since_banged()
{
    if (debug_display)
        <<<"sending display_pulses_since_banged">>>;
    xmit_to_display.startMsg( Config.osc_message_server_to_display_pulses_since_banged(), Config.osc_message_server_to_display_pulses_since_banged_data() );
    for( 0 => int i; i < num_nodes; i++ )
    {
        node_states[i].pulses_since_banged => xmit_to_display.addInt;
    }
    
}
 