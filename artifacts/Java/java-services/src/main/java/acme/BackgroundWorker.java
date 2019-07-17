package com.java.acme;

import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantReadWriteLock;
import java.util.Random;

public class BackgroundWorker {
	
	private class Worker implements Runnable {

		private int lockMS;
		private Lock lock;

		public Worker(Lock lock, int lockMS) {
			this.lock = lock;
			this.lockMS = lockMS;
		}
		
		public double cryptolock() {

			Random rand = new Random();
			double x = rand.nextInt(100000);

			if (x < 0) {
				return Double.NaN;	
			} 

			double tolerance = 1E-15;
			double y = x;
			
			while (Math.abs(y - x/y) > tolerance*y) {
				y = (x/y + y) / 2.0;
			}
			return y;
		}

		@Override
		public void run() {
			long start = getTime();
			
			/** try and get the lock, wait up milliseconds time to get it */
			try {
				if (lock.tryLock(lockMS, TimeUnit.MILLISECONDS)) {
					while (getTime() - start < lockMS) {
						try {
							cryptolock();
						}catch (Exception e) {}
					}
				}
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			finally {
				lock.unlock();
			}
		}
		
		private long getTime() {
			return new Date().getTime();
		}
		
		public Thread doWork() {
			Thread t = new Thread(this);
			
			t.start();
			
			return t;
		}
	}
	
	public BackgroundWorker() {
		
	}
	
	public Lock getWriteLock() { 
		return new ReentrantReadWriteLock().writeLock();
	}

	public void doWorkBackground(Lock lock, int durationMS) {
		
		Worker worker1 = new Worker(lock, durationMS);
		Worker worker2 = new Worker(lock, durationMS);
			
		Thread t1 = worker1.doWork();
		Thread t2 = worker2.doWork();
		
		try {
			t1.join();
			t2.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			t1.interrupt();
			t2.interrupt();
		}
	}
	
	public void doBackgroundWork(int durationMS) {
		Lock lock = getWriteLock();
		
		doWorkBackground(lock, durationMS);
	}
}
