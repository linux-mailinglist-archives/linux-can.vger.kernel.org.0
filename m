Return-Path: <linux-can+bounces-457-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3F08AC4F1
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 09:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7739A28205D
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 07:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6150269;
	Mon, 22 Apr 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="DdZz0iIY"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F75029E;
	Mon, 22 Apr 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769931; cv=none; b=J1y9sRpKRhWe24nOYAB91PkJJfDxrErBeXdicDyzz26KxFL/Xfo0p+haJAmLBYyAVmt+fLADu0oTFFDG+IT5pg4qFzDChghIQs/uIs7Z08Uf4t5Zb4+P8Lfe9S04uWtfrUAYCoAlATcIs435siIqCpBoLneNQIPh43CYqCW9akM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769931; c=relaxed/simple;
	bh=hpSwpq8t85oJgWzBAb0sGwMKMZLQnDwXbtThMElaBjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJSE4fa7U4IuxTdBT9dZ1f17AKl9xWvfY70ObiVzWAr1EvUEj+EVnH7R4IBuorov1dGocUH76F7TLJuSjBqoGy0hLlHYgyVOrJVZVtFtzabZl2+bFEA6rr+YjfbA+O7s/r9hPW9zdQ7S39we8M0wPTgMvkR/pIq9NeMWcTRseEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=DdZz0iIY; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SF2ECz2nkc3iAx/gW3lWEA5oZJYY9ghIYAkmZKvVY/E=; b=DdZz0iIY61cgM89iG8hhc4U/c4
	mhqwc4EVqseuKe+ULiMA6LSl6sb1C4prfUGYE7zdiZTN1VsrpLMQVjJi+N8vWXVxTcYdDfyk8APay
	s+OkZDqeIWSkmnmvFaQJZte4EAu6BvupRWS3Uc2DcWyCOcaa1/0TKsVr0hOILvdm4SIM=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1rynWe-001JRH-2R;
	Mon, 22 Apr 2024 08:51:41 +0200
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
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 00/11] LIN Bus support for Linux
Date: Mon, 22 Apr 2024 08:51:03 +0200
Message-Id: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
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

Christoph Fritz (11):
  can: Add LIN bus as CAN abstraction
  HID: hexLIN: Add support for USB LIN bus adapter
  tty: serdev: Add flag buffer aware receive_buf_fp()
  tty: serdev: Add method to enable break flags
  dt-bindings: net: can: Add serdev LIN bus dt bindings
  can: Add support for serdev LIN adapters
  can: lin: Add special frame id for rx offload config
  can: bcm: Add LIN answer offloading for responder mode
  can: lin: Handle rx offload config frames
  can: lin: Support setting LIN mode
  HID: hexLIN: Implement ability to update lin mode

 .../bindings/net/can/linux,lin-serdev.yaml    |  29 +
 drivers/hid/Kconfig                           |  19 +
 drivers/hid/Makefile                          |   1 +
 drivers/hid/hid-hexlin.c                      | 594 ++++++++++++++++++
 drivers/hid/hid-ids.h                         |   1 +
 drivers/hid/hid-quirks.c                      |   3 +
 drivers/net/can/Kconfig                       |  26 +
 drivers/net/can/Makefile                      |   2 +
 drivers/net/can/lin-serdev.c                  | 467 ++++++++++++++
 drivers/net/can/lin.c                         | 547 ++++++++++++++++
 drivers/tty/serdev/core.c                     |  11 +
 drivers/tty/serdev/serdev-ttyport.c           |  19 +-
 include/linux/serdev.h                        |  19 +-
 include/net/lin.h                             | 105 ++++
 include/uapi/linux/can/bcm.h                  |   5 +-
 include/uapi/linux/can/netlink.h              |   2 +
 net/can/bcm.c                                 |  74 ++-
 17 files changed, 1918 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml
 create mode 100644 drivers/hid/hid-hexlin.c
 create mode 100644 drivers/net/can/lin-serdev.c
 create mode 100644 drivers/net/can/lin.c
 create mode 100644 include/net/lin.h

-- 
2.39.2


