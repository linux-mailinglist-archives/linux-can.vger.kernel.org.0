Return-Path: <linux-can+bounces-516-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675CB8B95B4
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 09:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D811C20F4E
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 07:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A702C190;
	Thu,  2 May 2024 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="oYfZsp15"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6737022F00;
	Thu,  2 May 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636608; cv=none; b=CrGOnKMYgX4OFG9ZFOBoHv3mBzV2Oea7W4NiPREqfRc0P5zexw7jixy1iKwXcPrV/Hg9drc8d9nRT9wFMmdzid3cCOM/dMtNmBWxsfHT+ygSDyIlxHwDmHWZBHM84HRhycQqrTJ5SdmbZ2pNbX2xqGIoXYYJCF1z2f9QElKgMeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636608; c=relaxed/simple;
	bh=2WqGKQ7sG8p73RSus7aIVmhwSeFbo1dJFynMHU4XsCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k66bvFTXsjSmTpR4WdsHedd/Qy3ZC7VH1OogWbgJt5OxgkY4RzmJP+8l2rclCCDX29Qy3vgb7/Gt5QDaMn2izJuuHfACCgG7vPq49T8z7FqyVTTSeWMZwD/Ha98LxhGyRPVoGk/T3uLCghFC0u3xqoUmrL2Eeb+iJ1Q8pu61DvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=oYfZsp15; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wmXI9SDDcGadnI214+SdOevHMDtTo6rucZNKCeRvzpk=; b=oYfZsp15mxUZFdVM6E3jOK7cWl
	m6nPQsl5pARRwdtVpwmk3JgNPxqNKcsBmQJxaXq4mxBgNtNQhUY69/xcU42QoC8y0z3z35EVQKujU
	Us3oE9YbTjd0omigLAy/zW3JvsN+sC7czGE2GHrvbajU2R0Cg51qEtZNGx4SJEoUMo/U=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2RIs-001Yg7-22;
	Thu, 02 May 2024 09:56:31 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 00/12] LIN Bus support for Linux
Date: Thu,  2 May 2024 09:55:22 +0200
Message-Id: <20240502075534.882628-1-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is introducing basic Local Interconnect Network (LIN) (ISO
17987) [0] support to the Linux kernel, along with two drivers that make
use of it: An advanced USB adapter and a lightweight serdev driver (for
UARTs equipped with a LIN transceiver).

The LIN bus is common in the automotive industry for connecting
low-level devices like side mirrors, seats, ambient lights, etc.

The LIN bus is a lower-cost bus system with a subset of features of CAN.
Its earlier specification (before ISO) is publicly accessible [1].

This series of patches follows up on a discussion initiated by an RFC
patch series [2].

The core of this series is the first patch, which implements the CAN_LIN
glue driver. It basically utilizes the CAN interface on one side and
for device drivers on the other side it creates a rx() function and
several callbacks.

This approach is non-invasive, as LIN frames (nearly identical to CAN
frames) are just treated as a special case of CAN frames. This approach
eliminates the need for a separate API for LIN, allowing the use of
existing CAN tools, including the CAN broadcast manager.

For the responder part of LIN, when a device responds to a controller
request, it can reply on up to LIN its 64 possible IDs (0...63) with a
maximum of 8 bytes payload.  The response must be sent relatively
quickly, so offloading is used (which is used by most devices anyway).
Devices that do not support offloading (like the lightweight serdev)
handle the list of responses in the driver on a best-effort basis.

The CAN broadcast manager (bcm) makes a good interface for the LIN
userland interface, bcm is therefore enhanced to handle the
configuration of these offload RX frames, so that the device can handle
the response on its own.  As a basic alternative, a sysfs file per LIN
identifier gets also introduced.

The USB device driver for the hexLIN [3] adapter uses the HID protocol
and is located in the drivers/hid directory. Which is a bit uncommon for
a CAN device, but this is a LIN device and mainly a hid driver (and all
hid drivers go into drivers/hid).

The other driver, the UART lin-serdev driver requires support for break
detection, this is addressed by two serdev patches.

The lin-serdev driver has been tested on an ARM SoC, on its uart
(uart-pl011) an adapter board (hexLIN-tty [4]) has been used.  As a
sidenote, in that tty serial driver (amba-pl011.c) it was necessary to
disable DMA_ENGINE to accurately detect breaks [5].

The functions for generating LIN-Breaks and checksums, originally from
a line discipline driver named sllin [6], have been adopted into the
lin-serdev driver.

To make use of the LIN mode configuration (commander or responder)
option, a patch for iproute2 [7] has been made.

The lin-utils [8] provide userland tools for reference, testing, and
evaluation. These utilities are currently separate but may potentially
be integrated into can-utils in the future.

[0]: https://en.wikipedia.org/wiki/Local_Interconnect_Network
[1]: https://www.lin-cia.org/fileadmin/microsites/lin-cia.org/resources/documents/LIN_2.2A.pdf
[2]: https://lwn.net/Articles/916049/
[3]: https://hexdev.de/hexlin
[4]: https://hexdev.de/hexlin#tty
[5]: https://github.com/raspberrypi/linux/issues/5985
[6]: https://github.com/lin-bus/linux-lin/blob/master/sllin/sllin.c
[7]: https://github.com/ch-f/iproute2/tree/lin-feature
[8]: https://github.com/ch-f/lin-utils

Changes in v2:
 - add open/stop functions to also address teardown issues
 - adapt dt-bindings description and add hexdev
 - use 'unsigned int' instead of 'uint'
 - add and adapt macros
 - address review comments

Christoph Fritz (12):
  can: Add LIN bus as CAN abstraction
  HID: hexLIN: Add support for USB LIN bus adapter
  tty: serdev: Add flag buffer aware receive_buf_fp()
  tty: serdev: Add method to enable break flags
  dt-bindings: vendor-prefixes: Add hexDEV
  dt-bindings: net/can: Add serial (serdev) LIN adapter
  can: Add support for serdev LIN adapters
  can: lin: Add special frame id for rx offload config
  can: bcm: Add LIN answer offloading for responder mode
  can: lin: Handle rx offload config frames
  can: lin: Support setting LIN mode
  HID: hexLIN: Implement ability to update lin mode

 .../bindings/net/can/hexdev,lin-serdev.yaml   |  32 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/hid/Kconfig                           |  19 +
 drivers/hid/Makefile                          |   1 +
 drivers/hid/hid-hexdev-hexlin.c               | 641 ++++++++++++++++++
 drivers/hid/hid-ids.h                         |   1 +
 drivers/hid/hid-quirks.c                      |   3 +
 drivers/net/can/Kconfig                       |  26 +
 drivers/net/can/Makefile                      |   2 +
 drivers/net/can/lin-serdev.c                  | 514 ++++++++++++++
 drivers/net/can/lin.c                         | 562 +++++++++++++++
 drivers/tty/serdev/core.c                     |  11 +
 drivers/tty/serdev/serdev-ttyport.c           |  19 +-
 include/linux/serdev.h                        |  19 +-
 include/net/lin.h                             |  99 +++
 include/uapi/linux/can/bcm.h                  |   5 +-
 include/uapi/linux/can/netlink.h              |   2 +
 net/can/bcm.c                                 |  74 +-
 18 files changed, 2026 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
 create mode 100644 drivers/hid/hid-hexdev-hexlin.c
 create mode 100644 drivers/net/can/lin-serdev.c
 create mode 100644 drivers/net/can/lin.c
 create mode 100644 include/net/lin.h

-- 
2.39.2


