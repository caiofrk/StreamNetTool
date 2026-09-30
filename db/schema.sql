-- Supabase DB schemas for StreamNetTool
CREATE TABLE IF NOT EXISTS site_configurations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_name TEXT NOT NULL,
    camera_count INT NOT NULL,
    resolution TEXT NOT NULL,
    protocol TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

CREATE TABLE IF NOT EXISTS hardware_pricing (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    gpu_model TEXT NOT NULL,
    nvdec_limit INT NOT NULL,
    capex_cost NUMERIC(10, 2) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);
