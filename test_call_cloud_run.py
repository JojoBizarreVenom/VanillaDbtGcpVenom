import os
from pathlib import Path
import yaml
import urllib
import google.auth.transport.requests
import google.oauth2.id_token

import google.auth
from google.auth.transport.requests import Request as GoogleAuthRequest



NAME_TEMP_FILE = "tmp_file.yml"
PREFIX_SERVICE_CLOUD_RUN = "cloudrun-dbt-service-venom-"

command_find_url_cloud_run = f"gcloud run services list --filter={PREFIX_SERVICE_CLOUD_RUN} --format=yaml > {NAME_TEMP_FILE}"


def find_url_cloud() -> str:
    os.system(command_find_url_cloud_run)
    current_path = Path(__file__).parent.resolve()
    current_yaml_file = current_path / NAME_TEMP_FILE

    try:
        with current_yaml_file.open("r") as c:
            obj_yaml = yaml.load(c, Loader=yaml.Loader)
            url_cloud_run = obj_yaml["status"]["url"]
            return url_cloud_run

    except yaml.composer.ComposerError as e:
        raise yaml.composer.ComposerError(f"Multiple yaml in one file : {e}")

    finally:
        current_yaml_file.unlink()


def call_api_cloud_run(endpoint: str, audience: str) -> None:
    """Cloud Run uses your service's hostname as the `audience` value
    audience = 'https://my-cloud-run-service.run.app/'
    For Cloud Run, `endpoint` is the URL (hostname + path) receiving the request
    endpoint = 'https://my-cloud-run-service.run.app/my/awesome/url'

    Parameters
    ----------
    type_bhp : str
        Define the type of project bhp (emea, china, amas, apac)
    Returns
    -------
        None
    """
    req = urllib.request.Request(endpoint)

    try:
        auth_req = google.auth.transport.requests.Request()
        id_token = google.oauth2.id_token.fetch_id_token(auth_req, audience)
    except google.auth.exceptions.DefaultCredentialsError:
        auth_req = GoogleAuthRequest()
        creds, _ = google.auth.default()
        creds.refresh(auth_req)
        id_token = creds.id_token

    req.add_header("Authorization", f"Bearer {id_token}")
    urllib.request.urlopen(req)


if "__main__" == __name__:
    audience = find_url_cloud()
    endpoint = f"{audience}/dbt/run"
    call_api_cloud_run(endpoint, audience)