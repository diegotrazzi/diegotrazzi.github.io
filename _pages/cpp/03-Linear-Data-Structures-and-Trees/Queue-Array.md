---
title: "Array-Based Implementation of Queue (FIFO)"
---

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/FIFO.gif" alt="CLL" height="150">
</div>

A queue is a linear data structure that follows the **First In, First Out (FIFO)** principle: the first element added is the first removed, like people lining up for a bus. It supports key operations: **enqueue (add to back), dequeue (remove from front), peek (view front), isEmpty, and isFull**. Queues are abstract data types and can be implemented using arrays, linked lists, or other structures, depending on the application’s needs. FIFO ensures fairness and order, useful in scheduling and data processing.

## Representing a Circular Queue with an Array [Ring Buffer]

<div style="text-align: center;">
  <img src="/images/cpp/03-Linear-Data-Structures-and-Trees/LIFO-ring-buffer03.gif" alt="CLL" height="350">
</div>

This explains how to implement a queue using an array, specifically a circular queue to reuse space after dequeuing. The queue tracks elements with **front, rear, and size pointers**. Key operations - **enqueue, dequeue, peek, isEmpty, and isFull** — all run in constant time $O(1)$:

```cpp

```