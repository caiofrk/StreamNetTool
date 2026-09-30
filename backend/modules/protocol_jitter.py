from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

class ProtocolRequest(BaseModel):
    protocol: str # RTSP or SRT
    wan_latency_ms: float

class ProtocolResponse(BaseModel):
    frame_drop_probability: float
    recommendation: str

@router.post("/simulate", response_model=ProtocolResponse)
def simulate_protocol(req: ProtocolRequest):
    if req.protocol.upper() == "RTSP":
        prob = min(req.wan_latency_ms * 0.05, 100.0)
        rec = "Edge-conversion hardware required due to RTSP (UDP) jitter over public internet."
    else:
        prob = min(req.wan_latency_ms * 0.001, 5.0)
        rec = "SRT Auto Repeat reQuest (ARQ) mitigates frame-drop risks over WAN."
        
    return ProtocolResponse(
        frame_drop_probability=round(prob, 2),
        recommendation=rec
    )
