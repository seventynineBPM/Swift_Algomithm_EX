import UIKit

var queue = QueueSimple<String>()
queue.enqueue("mike")
queue.enqueue("tim")
queue.enqueue("ace")

print(queue.getElement())
print(queue.dequeue() ?? "empty")

var queueOpti = QueueOptimized<String>()
queueOpti.enqueue("age")
queueOpti.enqueue("address")
queueOpti.enqueue("phone number")

print(queueOpti.getElement())
print(queueOpti.dequeue()!)
