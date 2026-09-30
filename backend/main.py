from fastapi import FastAPI
from modules.cloud_egress_calculator import router as cloud_egress_router
from modules.nvdec_profiler import router as nvdec_profiler_router
from modules.protocol_jitter import router as protocol_jitter_router

app = FastAPI(title="Video Stream Network Engineering Analyst Tool")

app.include_router(cloud_egress_router, prefix="/api/v1/egress")
app.include_router(nvdec_profiler_router, prefix="/api/v1/nvdec")
app.include_router(protocol_jitter_router, prefix="/api/v1/protocol")

@app.get("/")
def root():
    return {"status": "ok"}
