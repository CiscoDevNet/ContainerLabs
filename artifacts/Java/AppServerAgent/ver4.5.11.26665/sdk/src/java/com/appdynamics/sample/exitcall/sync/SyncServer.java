/**
 * Copyright (c) AppDynamics Technologies
 *
 *
 * @author manoj.acharya (macharya@appdynamics.com)
 * @version 2.0
 * @since 1.0
 */
package com.appdynamics.sample.exitcall.sync;

import com.appdynamics.apm.appagent.api.AgentDelegate;
import com.appdynamics.apm.appagent.api.ITransactionDemarcator;

import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;

/**
 * The class demonstrates use of appdynamics transaction api to mark the begin (beginContinuingTransactionAndAddCurrentThread)
 * and end (endContinuingTransactionAndRemoveCurrentThread) of a continuing transaction from the SyncClient.
 *
 * The correlation header is used to join a continuing transaction from a remote JVM
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
public class SyncServer implements ISyncServer, Runnable {
    private static ITransactionDemarcator delegate = AgentDelegate.getTransactionDemarcator();

    public SyncServer()
            throws RemoteException {
    }

    public String sayHello(String appdynamicsCorrelationHeader, String name) {
        // begin continuing transaction with header
        delegate.beginContinuingTransactionAndAddCurrentThread(appdynamicsCorrelationHeader, null);
        try {
            Thread.sleep(1000);
            String msg = "Hello " + name + " !";
            return msg;

        } catch (Exception e) {
            e.printStackTrace();
            return "Error in server :" + e.getMessage();
        } finally {
            delegate.endContinuingTransactionAndRemoveCurrentThread();
        }
    }


    //Instatiates the server and binds to the rmi registry
    public static void main(String[] args) {
        try {
            System.setSecurityManager(null);

            String name = "SyncServer";
            SyncServer engine = new SyncServer();
            ISyncServer stub =
                    (ISyncServer) UnicastRemoteObject.exportObject(engine, 0);
            Registry registry = LocateRegistry.getRegistry();
            registry.rebind(name, stub);
            System.out.println("SyncServer bound");
        } catch (Exception e) {
            System.err.println("SyncServer exception:");
            e.printStackTrace();
        }
    }

    public void run() {


    }
}
