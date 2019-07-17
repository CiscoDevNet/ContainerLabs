/**
 * Copyright (c) AppDynamics Technologies
 *
 *
 * @author manoj.acharya (macharya@appdynamics.com)
 * @version 2.0
 * @since 1.0
 */

package com.appdynamics.sample.exitcall.sync;

/**
 * This class demonstrates use of appdynamics Transaction api to
 * demarcate calls to synchronous remote services using custom protocols.
 *
 * The SyncClient makes a lookup to a remote SyncServer and
 * invokes sayHello(...) method.
 *
 * The appdynamics transaction api is used to mark the begin (beginExternalCall) and end (endExternalCall) of
 * the remote api call.
 *
 * In this example the begin call returns a transaction correlation header that is
 * passed as a method parameter. The SyncServer uses appdynamics transaction api
 * to pass the transaction header and mark the begin and end of continuing transaction.
 *
 * To compile this program you will need the javagent.jar in classpath
 *
 * Start the rmiregistry and run the rmi server
 * Set the following VM param in the client JVM as appropriate for your setup
 *
 * VM params :
 *
 * -javaagent:/Users/manojacharya/Work/singularity-tech/GA/CustomAPI/client/javaagent.jar
 *
 *
 */

import com.appdynamics.apm.appagent.api.AgentDelegate;
import com.appdynamics.apm.appagent.api.ITransactionDemarcator;

import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;


public class SyncClient {
    String name = "SyncServer";

    //Fetch the appdynamics transaction delegate
    private static ITransactionDemarcator delegate = AgentDelegate.getTransactionDemarcator();

    public SyncClient() {
    }

    /**
     * The POJO Rule defines the sayHello method as the transaction boundary.
     * The method looks up the remote rmi server object and invokes the remote method
     * @exception RemoteException
     * @exception NotBoundException
     * @exception InterruptedException
     */
    public void sayHello() throws RemoteException, NotBoundException, InterruptedException {
        Registry registry = LocateRegistry.getRegistry();
        ISyncServer server = (ISyncServer) registry.lookup(name);
        String msg = invokeServer(server);
        System.out.println("Message from server [" + msg + "]");
    }

    /**
     * Marks the begin and end of the remote server call
     * @param server
     * @return
     * @exception RemoteException
     */
    private String invokeServer(ISyncServer server) throws RemoteException {
        try {
            //begin external call, returns header and header is propagated to server
            String appdynamicsCorrelationHeader = delegate.beginExternalCall(name, name, true);
            return server.sayHello(appdynamicsCorrelationHeader, "John Doe");
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
            SyncClient client = new SyncClient();
            client.sayHello();
            Thread.sleep(20 * 1000);
        }
    }
}
