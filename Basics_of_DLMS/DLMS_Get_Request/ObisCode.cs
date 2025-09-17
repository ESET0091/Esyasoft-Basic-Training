using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


    /*Assignment - DLMS/COSEM communication example
in C# .net, demonstrating how to:

Define and pack an OBIS code

Construct a GET request APDU*/

    using System;
    using System.Collections.Generic;

    namespace DLMS_Get_Request
    {
        // OBIS Code class
        public class ObisCode
        {
            public byte A { get; set; }
            public byte B { get; set; }
            public byte C { get; set; }
            public byte D { get; set; }
            public byte E { get; set; }
            public byte F { get; set; }

            public ObisCode(byte a, byte b, byte c, byte d, byte e, byte f)
            {
                A = a; B = b; C = c; D = d; E = e; F = f;
            }

            public byte[] ToByteArray()
            {
                return new byte[] { A, B, C, D, E, F };
            }

            public override string ToString()
            {
                return $"{A}-{B}:{C}.{D}.{E}.{F}";
            }
        }
  
    }

