
from cloudevents.http import CloudEvent
import pytest

import main


def test_functions_eventsource_storage(capsys: pytest.LogCaptureFixture) -> None:
    attributes = {
        "id": "5e9f24a",
        "type": "google.cloud.storage.object.v1.finalized",
        "source": "sourceUrlHere",
    }

    data = {
        "bucket": "test_bucket_for_storage",
        "name": "new_blob_uploaded",
        "generation": 1,
        "metageneration": 1,
        "timeCreated": "2021-10-10 00:00:00.000000Z",
        "updated": "2021-11-11 00:00:00.000000Z",
    }

    event = CloudEvent(attributes, data)

    (
        event_id,
        event_type,
        bucket,
        name,
        metageneration,
        timeCreated,
        updated,
    ) = main.hello_gcs(event)

    out, _ = capsys.readouterr()
    assert "5e9f24a" in event_id
    assert "google.cloud.storage.object.v1.finalized" in event_type
    assert "test_bucket_for_storage" in bucket
    assert "new_blob_uploaded" in name
    assert metageneration == 1
    assert "2021-10-10 00:00:00.000000Z" in timeCreated
    assert "2021-11-11 00:00:00.000000Z" in updated