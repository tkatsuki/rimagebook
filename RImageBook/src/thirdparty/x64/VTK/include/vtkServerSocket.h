/*=========================================================================

  Program:   Visualization Toolkit
  Module:    vtkServerSocket.h

  Copyright (c) Ken Martin, Will Schroeder, Bill Lorensen
  All rights reserved.
  See Copyright.txt or http://www.kitware.com/Copyright.htm for details.

     This software is distributed WITHOUT ANY WARRANTY; without even
     the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
     PURPOSE.  See the above copyright notice for more information.

=========================================================================*/
// .NAME vtkServerSocket - Encapsulate a socket that accepts connections.
// .SECTION Description
//

#ifndef __vtkServerSocket_h
#define __vtkServerSocket_h

#include "vtkSocket.h"

class vtkClientSocket;
class VTK_COMMON_EXPORT vtkServerSocket : public vtkSocket
{
public:
  static vtkServerSocket* New();
  vtkTypeMacro(vtkServerSocket, vtkSocket);
  void PrintSelf(ostream& os, vtkIndent indent);

  // Description:
  // Creates a server socket at a given port and binds to it.
  // Returns -1 on error. 0 on success.
  int CreateServer(int port);

  // Description:
  // Waits for a connection. When a connection is received
  // a new vtkClientSocket object is created and returned.
  // Returns NULL on timeout. 
  vtkClientSocket* WaitForConnection(unsigned long msec=0);

  // Description:
  // Returns the port on which the server is running.
  int GetServerPort();
protected:
  vtkServerSocket();
  ~vtkServerSocket();

private:
  vtkServerSocket(const vtkServerSocket&); // Not implemented.
  void operator=(const vtkServerSocket&); // Not implemented.
};


#endif

