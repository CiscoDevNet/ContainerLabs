package com.appdynamics.sample.exitcall.sync;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * Copyright (c) AppDynamics Technologies
 * @author manoj.acharya (macharya@appdynamics.com)
 * @version 2.0
 * @since 1.0
 */
public interface ISyncServer extends Remote {
    public String sayHello(String appdynamicsCorrelationHeader, String name) throws RemoteException;
}
