package com.appdynamics.sample.exitcall.async;

import java.rmi.Remote;
import java.rmi.RemoteException;

/**
 * Copyright (c) AppDynamics Technologies
 * @author manoj.acharya (macharya@appdynamics.com)
 * @version 2.0
 * @since 1.0
 */
public interface IAsyncServer extends Remote {
    public void sayHelloAsync(String appdynamicsCorrelationHeader, String name) throws RemoteException;
}
