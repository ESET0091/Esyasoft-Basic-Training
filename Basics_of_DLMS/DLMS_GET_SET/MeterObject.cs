using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DLMS_GET_SET
{
    public class MeterObject
    {
        public byte[] obis { get; set; }
        public string name { get; set; }
        public int value { get; set; }

        public MeterObject(byte[] obisCode, string objectName, int initialValue)
        {
            obis = obisCode;
            name = objectName;
            value = initialValue;
        }
    }
}
