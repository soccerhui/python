import os
import fcntl
import socket
import select

response = 'HTTP/1.1 200 OK\r\nConnection: Close\r\nContent-Length: 1\r\n\r\nA'

server = socket.socket()
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(('0.0.0.0', 8080))
server.listen(32)

flags = fcntl.fcntl(server.fileno(), fcntl.F_GETFL)
fcntl.fcntl(server.fileno(), fcntl.F_SETFL, flags | os.O_NONBLOCK)

clients = {}

epoll = select.epoll()
epoll.register(server, select.EPOLLIN)

while True:
        events = epoll.poll()

        for fileno, event in events:
                if fileno == server.fileno():
                        client, clientaddr = server.accept()
                        epoll.register(client, select.EPOLLIN)
                        clients[client.fileno()] = client
                elif event == select.EPOLLIN:
                        client = clients[fileno]
                        request = client.recv(4096)
                        client.send(response)
                        del clients[fileno]
                        epoll.unregister(client)
                        client.close()
