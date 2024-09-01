from fastapi import APIRouter
from pathlib import Path
import os
from loguru import logger

router = APIRouter(prefix="/dbt", tags=["dbt"])
DBT_FOLDER = Path(__file__).resolve().parents[1] / 'dbt_vanilla'

@router.get(
    "/run",
    summary="Create an item",
    description="Create an item with all the information, name, description, price, tax and a set of unique tags",
    response_description="The created item",
)
async def run():
    list_of_commande = [
        f"dbt deps --project-dir {DBT_FOLDER} --profiles-dir {DBT_FOLDER} --target dev", 
        f"dbt run --project-dir {DBT_FOLDER} --profiles-dir {DBT_FOLDER} --target dev"
    ]

    for command in list_of_commande:
        logger.info(f"command launch : {command} \n")
        os.system(command)

@router.get(
    "/debug",
    summary="Create an item",
    description="Create an item with all the information, name, description, price, tax and a set of unique tags",
    response_description="The created item",
)
async def debug():
    list_of_commande = [
        f"dbt deps --project-dir {DBT_FOLDER} --profiles-dir {DBT_FOLDER} --target dev", 
        f"dbt debug --project-dir {DBT_FOLDER} --profiles-dir {DBT_FOLDER} --target dev"
    ]

    for command in list_of_commande:
        logger.info(f"command launch : {command} \n")
        os.system(command)

@router.get(
    "/test",
    summary="Create an item",
    description="Create an item with all the information, name, description, price, tax and a set of unique tags",
    response_description="The created item",
)
async def test():
    list_of_commande = [
        f"dbt deps --project-dir {DBT_FOLDER} --profiles-dir {DBT_FOLDER} --target dev", 
        f"dbt test --project-dir {DBT_FOLDER} --profiles-dir {DBT_FOLDER} --target dev"
    ]

    for command in list_of_commande:
        logger.info(f"command launch : {command} \n")
        os.system(command)