using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DLMS_GET_SET
{
    public static class ObisCodeHelper
    {
        public static bool ObisMatch(byte[] obis1, byte[] obis2)
        {
            if (obis1.Length != obis2.Length)
                return false;

            for (int i = 0; i < obis1.Length; i++)
            {
                if (obis1[i] != obis2[i])
                    return false;
            }
            return true;
        }

        // Common OBIS codes
        public static readonly byte[] ACTIVE_ENERGY = new byte[] { 1, 0, 1, 8, 0, 255 };
        public static readonly byte[] REACTIVE_ENERGY = new byte[] { 1, 0, 3, 8, 0, 255 };
        public static readonly byte[] VOLTAGE = new byte[] { 1, 0, 32, 7, 0, 255 };
        public static readonly byte[] CURRENT = new byte[] { 1, 0, 31, 7, 0, 255 };
    }
}