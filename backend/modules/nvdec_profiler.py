from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

class ProfilerRequest(BaseModel):
    total_streams: int
    nvdec_ceiling: int = 27

class ProfilerResponse(BaseModel):
    required_gpus: int
    is_safe: bool
    message: str

@router.post("/profile", response_model=ProfilerResponse)
def profile_nvdec(req: ProfilerRequest):
    required_gpus = (req.total_streams + req.nvdec_ceiling - 1) // req.nvdec_ceiling
    return ProfilerResponse(
        required_gpus=required_gpus,
        is_safe=req.total_streams <= req.nvdec_ceiling,
        message=f"Determined hardware limits for {req.total_streams} streams within a 25W NVDEC thermal envelope."
    )
