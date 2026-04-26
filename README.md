# OneWire Docker

A Docker container for OWFS (One-Wire File System) designed to work with Home Assistant and other home automation systems. This container provides a reliable way to interface with 1-Wire devices such as temperature sensors (DS18B20, DS18S20), switches, and other peripherals.

## Features

- **OWFS Integration**: Full One-Wire File System support
- **Multiple Interfaces**: HTTP, FTP, and server interfaces
- **Health Monitoring**: Built-in health checks for service monitoring
- **Flexible Configuration**: Environment-based service control
- **Home Assistant Ready**: Optimized for integration with Home Assistant

## Prerequisites

- Docker and Docker Compose
- 1-Wire hardware (optional for testing with fake devices)

## Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd onewire-docker
   ```

2. Start the container:
   ```bash
   docker compose up -d
   ```

The container will start with fake devices for testing. Access the web interface at `http://localhost:2121`.

## Configuration

### Environment Variables

- `START_OWHTTPD`: Set to `true` to start the HTTP interface (default: `false`)
- `START_OWFS`: Set to `true` to start the FUSE filesystem mount (default: `false`)

### OWFS Configuration

The container uses `/config/owfs.conf` for OWFS configuration. On first run, a template configuration is copied from `owfs.conf.template`.

Key configuration options:
- **Mount Point**: `/mnt/1wire` - where the 1-Wire filesystem is mounted
- **Server Port**: `4304` - for client connections
- **HTTP Port**: `2121` - web interface
- **FTP Port**: `2120` - FTP access

### Device Configuration

To use real 1-Wire devices, modify `/config/owfs.conf`:

```ini
# For USB adapters
server: usb = all

# For serial devices
server: device = /dev/ttyS1

# For W1 kernel module (Raspberry Pi)
server: w1
```

## Ports

- `2120`: FTP interface
- `2121`: HTTP web interface
- `4304`: OWFS server for client connections

## Usage

### With Home Assistant

In your Home Assistant configuration, add the OneWire integration and point it to the container:

```yaml
onewire:
  - host: onewire
    port: 4304
```

### Accessing Devices

- **Web Interface**: Visit `http://localhost:2121` to browse devices
- **Filesystem**: If OWFS is enabled, devices are available at `/mnt/1wire`
- **FTP**: Connect to `ftp://localhost:2120`

### Testing with Fake Devices

The default configuration includes fake devices for testing:

- DS18S20 temperature sensor
- DS2405 switch
- DS18B20 temperature sensor

## Building

To build the Docker image:

```bash
docker compose build
```

Or manually:

```bash
docker build -t onewire-docker .
```

## Health Checks

The container includes health checks that monitor:
- owserver process
- owhttpd process (if enabled)
- owfs process (if enabled)

Check container health:

```bash
docker ps
```

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure the container has `SYS_ADMIN` capability and `/dev/fuse` device access
2. **No Devices Found**: Check your 1-Wire hardware connection and configuration
3. **Port Conflicts**: Verify that ports 2120, 2121, and 4304 are available

### Logs

View container logs:

```bash
docker compose logs -f onewire
```

## Contributing

Contributions are welcome! Please feel free to submit issues, feature requests, or pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [OWFS Project](http://owfs.org/) - One-Wire File System
- [Home Assistant](https://www.home-assistant.io/) - Home automation platform