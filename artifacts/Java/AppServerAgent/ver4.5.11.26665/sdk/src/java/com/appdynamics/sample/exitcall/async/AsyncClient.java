/**
 * Copyright (c) AppDynamics Technologies
 *
 *
 * @author manoj.acharya (macharya@appdynamics.com)
 * @version 2.0
 * @since 1.0
 */
package com.appdynamics.sample.exitcall.async;


import com.appdynamics.apm.appagent.api.AgentDelegate;
import com.appdynamics.apm.appagent.api.ITransactionDemarcator;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;




/**
 * This class demonstrates use of appdynamics Transaction api to
 * demarcate calls to Asynchronous remote services. The remote api implementation doesn't wait
 * for execution to complete before returning. The appdynamics ui shows the actual time spent in
 * client and server jvm.
 *
 * The AsyncClient makes a lookup to a remote AsyncServer object and
 * invokes sayHelloAsync method.
 *
 * The appdynamics transaction api is used to mark the begin (beginExternalCall) and end (endExternalCall) of
 * the remote api call.
 *
 * In this example the begin call returns a transaction correlation header that is
 * passed as a method parameter. The AsyncServer uses appdynamics transaction api
 * to pass the transaction header and mark the begin and end of continuing transaction.
 *
 * To compile this program you will need the javagent.jar in classpath
 *
 * Start the rmiregistry and run the rmi server
 * Set teh following VM param in the client JVM as appropriate for your setup
 *
 * VM params :
 *
 * -javaagent:/Users/manojacharya/Work/singularity-tech/GA/CustomAPI/client/javaagent.jar
 */

public class AsyncClient {
    String name = "AsyncServer";
    private static ITransactionDemarcator delegate = AgentDelegate.getTransactionDemarcator();

    public AsyncClient() {
    }

    /**
     * The POJO Rule defines the sayHelloAsync method as the transaction boundary.
     * The method looks up the remote rmi server object and invokes the remote method
     * @exception RemoteException
     * @exception NotBoundException
     * @exception InterruptedException
     */
    public void sayHelloAsync() throws RemoteException, NotBoundException, InterruptedException {
        Registry registry = LocateRegistry.getRegistry();
        IAsyncServer asyncServer = (IAsyncServer) registry.lookup(name);
        invokeServerAsync(asyncServer);
    }

    /**
     * Marks the begin and end of the remote server call
     * @param asyncServer
     * @return
     * @exception RemoteException
     */
    private void invokeServerAsync(IAsyncServer asyncServer) throws RemoteException {
        try {
            //asynchronous external call - synchronous boolean param is set to false
            //returns header and header is propagated to server
            String appdynamicsCorrelationHeader = delegate.beginExternalCall(name, name, false);
            asyncServer.sayHelloAsync(appdynamicsCorrelationHeader, "Foo bar");
        } finally {
            // end external call
            delegate.endExternalCall(false, null);
        }
    }

    public static void main(String args[]) throws NotBoundException, RemoteException, InterruptedException {
        int loopCount = 100;
        if (args.length == 1)
            loopCount = Integer.parseInt(args[0]);

        System.setSecurityManager(null);
        for (int i = 0; i < loopCount; i++) {
            AsyncClient asyncClient = new AsyncClient();
            asyncClient.sayHelloAsync();
            Thread.sleep(20 * 1000);
        }
    }
}
