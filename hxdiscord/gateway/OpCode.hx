package hxdiscord.gateway;

class OpCode
{
    public static function checkOpCode(op:Int)
    {
        var opcode:String = "";
        switch (op)
        {
            case 0:
                opcode = "dispatch";
            case 1:
                opcode = "heartbeat";
            case 2:
                opcode = "identify";
            case 3:
                opcode = "presence update";
            case 4:
                opcode = "voice state update";
            case 6:
                opcode = "resume";
            case 7:
                opcode = "reconnect";
            case 8:
                opcode = "request guild members";
            case 9:
                opcode = "invalid session";
            case 10:
                opcode = "hello";
            case 11:
                opcode = "heartbeat ack";
        }
        return opcode;
    }
}