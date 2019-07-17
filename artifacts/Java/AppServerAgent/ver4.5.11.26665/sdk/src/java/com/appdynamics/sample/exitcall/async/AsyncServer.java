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

import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;


/**
 * The class demonstrates use of appdynamics transaction api to mark the begin and end of
 * a continuing transaction from the AsyncClient using the beginContinuingTransaction, addCurrentThreadToTransaction,
 * removeCurrentThreadFromTransaction and endContinuingTransaction api.
 *
 * The correlation header parameter is used to start a continuing transaction.
 *
 * The sayHelloAsync method starts a new thread to complete the processing of the remote request (hence async).
 * i.e. the beginContinuingTransaction and endContinuingTransaction are invoked from different thread.
 *
 * To compile this program you will need the javagent.jar in classpath
 *
 * Run the rmiregistry.
 * For the server JVM set the following VM parameters as appropriate for your
 * setup
 *
 * VM params :
 *
 * -javaagent:/Users/manojacharya/Work/singularity-tech/GA/CustomAPI/server/javaagent.jar
 * -Djava.rmi.server.codebase=file:/Users/manojacharya/Work/IdeaProjects/GA10/out/classes/
 */

public class AsyncServer implements IAsyncServer {
    private static ITransactionDemarcator delegate = AgentDelegate.getTransactionDemarcator();

    public AsyncServer()
            throws RemoteException {
    }

    public void sayHelloAsync(String appdynamicsCorrelationHeader, String name) {
        String txId = delegate.beginContinuingTransaction(appdynamicsCorrelationHeader, null);
        new Thread(new MyRunnable(name, txId)).start();
    }

    class MyRunnable implements Runnable {
        String name, txId;

        MyRunnable(String name, String txId) {
            this.name = name;
            this.txId = txId;
        }

        public void run() {
            try {
                delegate.addCurrentThreadToTransaction(txId, "My Runnable", null);
                Thread.sleep(1000);
                String msg = "Hello " + name + " !";
                System.out.println(msg);
                delegate.removeCurrentThreadFromTransaction(null);
                delegate.endContinuingTransaction(txId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        try {
            System.setSecurityManager(null);

            String name = "AsyncServer";
            AsyncServer engine = new AsyncServer();
            IAsyncServer stub =
                    (IAsyncServer) UnicastRemoteObject.exportObject(engine, 0);
            Registry registry = LocateRegistry.getRegistry();
            registry.rebind(name, stub);
            System.out.println("AsyncServer bound");
        } catch (Exception e) {
            System.err.println("AsyncServer exception:");
            e.printStackTrace();
        }
    }


}
