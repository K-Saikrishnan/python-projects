"""Entrypoint."""

import logging

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.INFO)

if __name__ == '__main__':
  logger.info('Hello, World!')
