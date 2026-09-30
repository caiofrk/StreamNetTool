from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

class EgressRequest(BaseModel):
    bandwidth_mbps: float
    hours_per_month: float = 730

class EgressResponse(BaseModel):
    egress_tb: float
    monthly_cost: float
    recommendation: str

@router.post("/calculate", response_model=EgressResponse)
def calculate_egress(req: EgressRequest):
    # bandwidth in mbps -> GB/s
    # 1 mbps = 0.125 MB/s = 0.000125 GB/s
    gb_per_hour = req.bandwidth_mbps * 0.125 * 3600 / 1000
    total_gb = gb_per_hour * req.hours_per_month
    total_tb = total_gb / 1024
    
    cost = total_gb * 0.11
    return EgressResponse(
        egress_tb=round(total_tb, 2),
        monthly_cost=round(cost, 2),
        recommendation="Consider localized edge hardware if monthly cost exceeds Capex/Opex of PCaaS workstations."
    )
