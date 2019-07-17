/**
 * Copyright (c) AppDynamics Technologies
 *
 * @author manoj.acharya (macharya@appdynamics.com)
 * @version 2.0
 * @since 1.0
 */
package com.appdynamics.sample.multithread;

/**
 * The following sample program demonstartes the use of appdynamics transaction api to manage multi threaded transaction
 * activities
 *
 * It demonstrates the following four scenarios
 *
 * - executePOJORule - a POJO Transaction rule is setup in controller / agent xml to mark the transaction boundaries.
 * The transaction identifier is created by appdynamics agent. Worker threads are associated to the global transaction using this identifier.
 *
 * - executePOJORuleCustomTxId - a POJO Transaction rule is setup in controller / agent xml to mark the transaction boundaries.
 * The transaction identifier is set by the application program. Worker threads are associated to the global transaction using this identifier.
 *
 * - executeCustomTransactionIdentification - programmatic demaraction of transaction boundaries.
 * The thread begins a transaction and waits for worker threads to complete and ends the transaction. 
 *
 *
 * - executeCustomTransactionIdentificationAsyncWait - programmatic demaraction of transaction boundaries. The transaction
 * begin and end are on different thrads i.e. the begin thread doesn't wait for completion of multi threaded execution. The end
 * transaction is invoked from a separate thread
 *
 * For the server JVM set the following VM parameters as appropriate for your setup
 *
 * VM params :
 *
 * -javaagent:/Users/manojacharya/Work/singularity-tech/GA/CustomAPI/server/javaagent.jar
 *
 */


import com.appdynamics.apm.appagent.api.AgentDelegate;
import com.appdynamics.apm.appagent.api.ITransactionDemarcator;

import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.ScheduledFuture;

public class MultiThreadServer {
    MultiThreadedExecutor executor;
    private static ITransactionDemarcator delegate = AgentDelegate.getTransactionDemarcator();

    public MultiThreadServer(int threadPoolSize) {
        executor = new MultiThreadedExecutor(threadPoolSize);
    }

    // POJO Rule demarcates transaction boundaries
    public void executePOJORule(int noOfExecutors) {
        // get appdynamics transcation id and pass it to executors
        String txId = delegate.getUniqueIdentifierForTransaction();
        List<ScheduledFuture> futures = executor.startExecutors(noOfExecutors, txId);
        executor.waitForCompletion(futures);
    }

    // POJO Rule demarcates transaction boundaries
    public void executePOJORuleCustomTxId(int noOfExecutors) {
        String myTxId = "My Custom Tx " + UUID.randomUUID().toString();
        // set application defined transcation id and pass it to executors
        delegate.setUniqueIdentifierForTransaction(myTxId);
        List<ScheduledFuture> futures = executor.startExecutors(noOfExecutors, myTxId);
        executor.waitForCompletion(futures);
    }


    // api demaracated tx boundaries, begin and end on calling thread
    public void executeCustomTransactionIdentification(int noOfExecutors) {
        // begin transaction on current thread and wait for completion
        delegate.beginOriginatingTransactionAndAddCurrentThread("Multi Threaded - Custom Transaction", null);
        String txId = delegate.getUniqueIdentifierForTransaction();
        List<ScheduledFuture> futures = executor.startExecutors(noOfExecutors, txId);
        executor.waitForCompletion(futures);
        // mark the end of transaction on current thread
        delegate.endOriginatingTransactionAndRemoveCurrentThread();
    }

    // api demarcated tx boundaries, begin and end transcations on separate threads
    public void executeCustomTransactionIdentificationAsyncWait(int noOfExecutors) {
        // begin transaction and start thread a new thread to end transaction
        String txId = delegate.beginOriginatingTransaction("Multi Threaded - Custom Transaction - Async", null);
        List<ScheduledFuture> futures = executor.startExecutors(noOfExecutors, txId);
        new Thread(new EndTransaction(txId, futures)).start();
    }

    class EndTransaction implements Runnable {
        String txId;
        List<ScheduledFuture> futures;

        EndTransaction(String txId, List<ScheduledFuture> futures) {
            this.txId = txId;
            this.futures = futures;
        }

        public void run() {
            delegate.addCurrentThreadToTransaction(txId, "End Transaction", null);
            executor.waitForCompletion(futures);
            delegate.removeCurrentThreadFromTransaction(null);
            delegate.endOriginatingTransaction(txId);
        }
    }

    /**
     * The input param specifies the no of times the
     * @param args loop count
     * @exception IOException
     * @exception InterruptedException
     */
    public static void main(String[] args) throws IOException, InterruptedException {
        int loopCount = 100;
        if (args.length == 1)
            loopCount = Integer.parseInt(args[0]);

        MultiThreadServer server = new MultiThreadServer(2);
        //        for(int i=0; i < loopCount; i++)
        //        {
        //            server.executePOJORule(2);
        //            Thread.sleep(20*1000);
        //        }
        //
        //        for(int i=0; i < loopCount; i++)
        //        {
        //            server.executePOJORuleCustomTxId(2);
        //            Thread.sleep(20*1000);
        //        }

        for (int i = 0; i < loopCount; i++) {
            server.executeCustomTransactionIdentification(2);
            Thread.sleep(20 * 1000);
        }

        for (int i = 0; i < loopCount; i++) {
            server.executeCustomTransactionIdentificationAsyncWait(2);
            Thread.sleep(20 * 1000);
        }
    }
}
