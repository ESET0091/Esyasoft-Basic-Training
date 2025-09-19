using System;

namespace DLMS_GET_SET
{
    class Program
    {
        static MeterObject[] meterObjects;

        static void Main(string[] args)
        {
            InitializeMeterObjects();

            Get_Set dlmsService = new Get_Set(meterObjects);

            // Test GET operation
            byte[] testObis = ObisCodeHelper.ACTIVE_ENERGY;
            // You'll need to make DlmsGet public and accessible
            // dlmsService.DlmsGet(testObis);

            // Test SET operation
             dlmsService.DlmsSet(testObis, 100);

            Console.WriteLine("DLMS GET/SET Service Demo");
        }

        static void InitializeMeterObjects()
        {
            meterObjects = new MeterObject[]
            {
                new MeterObject(ObisCodeHelper.ACTIVE_ENERGY, "Active Energy", 12345),
                new MeterObject(ObisCodeHelper.REACTIVE_ENERGY, "Reactive Energy", 6789),
                new MeterObject(ObisCodeHelper.VOLTAGE, "Voltage", 230),
                new MeterObject(ObisCodeHelper.CURRENT, "Current", 5),
                // Add more meter objects as needed
            };
        }
    }
}