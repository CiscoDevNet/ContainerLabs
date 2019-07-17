/**
 * Copyright (c) AppDynamics Technologies
 *
 * @author manoj.acharya (macharya@appdynamics.com)
 * @version 2.0
 * @since 1.0
 */
package com.appdynamics.sample.multithread;


import com.appdynamics.apm.appagent.api.AgentDelegate;
import com.appdynamics.apm.appagent.api.ITransactionDemarcator;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

/**
 * Manages a thread pool and executes a set of runnables
 *
 * Uses appdynamics transaction api addCurrentThreadToTransaction and removeCurrentThreadFromTransaction
 * to associate an executor thread's activity with a global transaction.
 */
public class MultiThreadedExecutor {

    ScheduledExecutorService executorService;
    static ITransactionDemarcator delegate = AgentDelegate.getTransactionDemarcator();
    static volatile int counter;

    /**
     * Initilizes a pool of thread sready to execute tasks
     * @param threadPoolSize a pool of threads
     */
    public MultiThreadedExecutor(int threadPoolSize) {
        executorService = Executors.newScheduledThreadPool(threadPoolSize);
    }

    /**
     * Starts a set of task and returns the handle to futures that can be used to track status and completion
     * @param executors no of executors to start
     * @param txId the appdynamics transaction identifier
     * @return a set of futures
     */
    public List<ScheduledFuture> startExecutors(int executors, String txId) {
        List<ScheduledFuture> futures = new ArrayList<ScheduledFuture>(executors);
        for (int i = 0; i < executors; i++) {
            futures.add(executorService
                    .schedule(new MyRunnable(txId, "Executor - " + counter++), 0, TimeUnit.MILLISECONDS));
        }
        return futures;
    }

    /**
     * Tracks completion of the executors
     * @param futures the set of futures to track executors
     */
    public void waitForCompletion(List<ScheduledFuture> futures) {
        for (ScheduledFuture future : futures) {
            while (!future.isDone()) {
                try {
                    Thread.sleep(10);
                } catch (InterruptedException e) {
                }
            }
        }
    }

    public void shutdown() {
        executorService.shutdown();
    }

    /**
     * An execution task
     */
    class MyRunnable implements Runnable {
        String transactionId;
        String name;

        MyRunnable(String transactionId, String name) {
            this.transactionId = transactionId;
            this.name = name;
        }

        public void run() {
            try {
                // Marks the begin of the executor's activity, associates with the global transaction identified by transactionId
                delegate.addCurrentThreadToTransaction(transactionId, name, null);
                try {
                    Thread.sleep(20);
                } catch (InterruptedException e) {
                }

            } finally {
                // Marks the end of the current executors activity
                delegate.removeCurrentThreadFromTransaction(null);
            }

        }
    }
}
