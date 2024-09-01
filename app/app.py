from fastapi import FastAPI
from routers import dbt

description = """
API for dbt 🚀

## Users

* **anyone who need it**
"""

app = FastAPI(
    debug=True,
    title="API template",
    description=description,
    version="1.0.0",
    contact={
        "name": "Jonathan Ndamba",
        "email": "jonathan.ndamba.pro@gmail.com",
    },
    license_info={
        "name": "venom",
    },
)

app.include_router(dbt.router)