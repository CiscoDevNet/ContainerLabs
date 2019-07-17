<?php
if(!extension_loaded('appdynamics_agent')) {
    function appdynamics_start_transaction($arg1, $arg2) {}
    function appdynamics_continue_transaction($arg1) {}
    function appdynamics_end_transaction() {}
    function appdynamics_begin_exit_call() {}
    function appdynamics_end_exit_call() {}
}
