import socket

response = 'HTTP/1.1 200 OK\r\nConnection: Close\r\nContent-Length: 1\r\n\r\nA'

server = socket.socket()
#这行代码的作用是保证在 TIME_WAIT 状态下 bind() 调用可以成功，能够使服务器退出之后，可以被立即重启。
server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server.bind(('0.0.0.0', 8080))
server.listen(32)

while True:
        client, clientaddr = server.accept()  # blocking
        request = client.recv(4096)  # blocking
        client.send(response)  # maybe blocking
        client.close()
