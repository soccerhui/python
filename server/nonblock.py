import os
import fcntl
import socket
import select

#缺点：如果没有客户端链接，server进入死循环

response = 'HTTP/1.1 200 OK\r\nConnection: Close\r\nContent-Length: 1\r\n\r\nA'

server = socket.socket()
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(('0.0.0.0', 8080))
server.listen(32)

# set nonblocking
flags = fcntl.fcntl(server.fileno(), fcntl.F_GETFL)
fcntl.fcntl(server.fileno(), fcntl.F_SETFL, flags | os.O_NONBLOCK)

clients = set([])

while True:
        try:
                client, clientaddr = server.accept()  //not block
                clients.add(client)
        except Exception as e:
                pass

	#Python 不允许在遍历一个数组的时候修改数组的内容 （ clients.remove(c) ）
        for client in clients.copy():
                try:
			#client 也会继承 server 的非阻塞特性，所以对 client 的 recv 调用，也是非阻塞的
                        request = client.recv(4096)//not block
                        client.send(response)
                        clients.remove(client)
                        client.close()
                except Exception as e:
                        pass

