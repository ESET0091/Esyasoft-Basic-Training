using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DLMS_GET_SET
{
    public class Get_Set
    {
        private MeterObject[] meterObjects;
        private int meterObjectCount;

        public Get_Set(MeterObject[] objects)
        {
            meterObjects = objects;
            meterObjectCount = objects.Length;
        }

        // === GET Service ===
        public void DlmsGet(byte[] obis)
        {
            for (int i = 0; i < meterObjectCount; i++)
            {
                if (ObisCodeHelper.ObisMatch(obis, meterObjects[i].obis))
                {
                    Console.WriteLine($"[GET] {meterObjects[i].name} = {meterObjects[i].value}");
                    return;
                }
            }
            Console.WriteLine("[GET] OBIS not found.");
        }

        // === SET Service ===
        public void DlmsSet(byte[] obis, int newValue)
        {
            for (int i = 0; i < meterObjectCount; i++)
            {
                if (ObisCodeHelper.ObisMatch(obis, meterObjects[i].obis))
                {
                    meterObjects[i].value = newValue;
                    Console.WriteLine($"[SET] {meterObjects[i].name} updated to {newValue}");
                    return;
                }
            }
            Console.WriteLine("[SET] OBIS not found.");
        }

        // === ACTION Service ===
        public void DlmsAction(byte[] obis, string method)
        {
            if (method == "RESET")
            {
                Console.WriteLine("[ACTION] Resetting meter values...");
                for (int i = 0; i < meterObjectCount; i++)
                {
                    meterObjects[i].value = 0;
                }
                Console.WriteLine("[ACTION] Reset complete.");
            }
            else if (method == "SYNC_TIME")
            {
                Console.WriteLine("[ACTION] Synchronizing meter clock to system time...");
                // Time sync logic here
            }
            else
            {
                Console.WriteLine("[ACTION] Unknown method.");
            }
        }
    }
}