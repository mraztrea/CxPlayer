# Contract: Soniox WebSocket API

**Type**: External WebSocket API
**Provider**: Soniox Inc.
**Endpoint**: `wss://stt-rt.soniox.com/transcribe-websocket`

## Connection Flow

1. **Open WebSocket** tới endpoint
2. **Gửi config JSON** (text frame) ngay sau khi kết nối thành công
3. **Stream audio** (binary frames) — PCM data 16kHz mono
4. **Nhận response** (text frames) — JSON chứa transcription tokens
5. **Đóng kết nối** với close code 1000

## Config Message (Client → Server)

```json
{
    "api_key": "<string>",
    "model": "stt-rt-v4",
    "audio_format": "pcm_s16le",
    "sample_rate": 16000,
    "num_channels": 1,
    "enable_endpoint_detection": true,
    "max_endpoint_delay_ms": 3000,
    "enable_speaker_diarization": true,
    "enable_language_identification": true,
    "translation": {
        "type": "one_way",
        "target_language": "<string>"
    },
    "context": {
        "text": "<string, max 500 chars>"
    }
}
```

## Audio Data (Client → Server)

- Format: Binary WebSocket frames
- Encoding: PCM signed 16-bit little-endian (`pcm_s16le`)
- Sample rate: 16000 Hz
- Channels: 1 (mono)

## Keepalive (Client → Server)

```json
{"type": "keepalive"}
```

Gửi mỗi 15 giây khi không có audio data.

## Response Message (Server → Client)

```json
{
    "tokens": [
        {
            "text": "<string>",
            "translation_status": "original" | "translation" | "none",
            "is_final": true | false
        }
    ]
}
```

| Field | Type | Description |
|-------|------|-------------|
| text | string | Nội dung transcription/translation |
| translation_status | string | "original" = ngôn ngữ gốc, "translation" = bản dịch, "none" = không áp dụng |
| is_final | boolean | true = finalized, false = provisional (có thể thay đổi) |

## Error Handling

| Scenario | Expected Behavior |
|----------|------------------|
| Invalid API key | Server đóng WebSocket với close code/message |
| Rate limit exceeded | Server đóng WebSocket |
| Network interruption | WebSocket onFailure triggered |
| Session timeout (~3 phút) | Client chủ động reset trước khi timeout |
