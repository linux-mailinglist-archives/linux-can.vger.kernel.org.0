Return-Path: <linux-can+bounces-6559-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMPjIoQik2kX1wEAu9opvQ
	(envelope-from <linux-can+bounces-6559-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:58:28 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADE41444F2
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 14:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB48C303D651
	for <lists+linux-can@lfdr.de>; Mon, 16 Feb 2026 13:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680593101B8;
	Mon, 16 Feb 2026 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="kyElz9Ir"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AD2C0F8E;
	Mon, 16 Feb 2026 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250039; cv=none; b=fghA6VUMCnwP0ETVBUZnW5HkQRIh5GWvSUnTpXjU/ooyTZQWGOItCEMM8OWYM+7kxitxwX8IBVjHiC7as0ttU/GFHrKCuYdxpbgpMoSIXTkLRwiEYHYBtaJvkSI8zQ3wd7pc8ziRlYcP8l5F4UCBnj0uEOIWG8+6RP16c4SErh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250039; c=relaxed/simple;
	bh=76svMepMws1psyYqLqUARRvEQn7urbg4CaIm/JPtgWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVp8g/E2wOyEzfbRDTWFzPeZeELy7VlXaUwlx8aKiOqZ1f32oaPsb2QMMI5TJSyqJRu27PH1En5Q01rK8kRGvHarlMOoggysd2ZONq7oCfXoYaRf6TwBw3ZbPIUPX9Ds1vzBIbkGAH47qmr2hnBLVYGUUNxyRHEpezdqXEg99T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=kyElz9Ir reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fF44X04WJz1FbwG;
	Mon, 16 Feb 2026 14:53:48 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fF44W4mCvz1DPkL;
	Mon, 16 Feb 2026 14:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1771250027;
	bh=/ldNGbzMFda1c7P28eD/pZ2C9Jcv9cbY2lY1aG2t0dU=;
	h=From:To:Cc:Subject:Date;
	b=kyElz9IrIctBKo0TA88BFrOzsClr9sullFRJ70ugKSm5ZXgY3nb9NTwrk93Ef/ucG
	 SwDI21e6WMnPBIvo4waYc3+WbRNxQf+dlkOE+MCs++ilvD5JWZvcj60K/lTsxsKw2v
	 npGNXSVrGflUFdrJAUnzkQnujJU8SesCL8UgztETI0lXRVLvd4eeCrHOz5Y8tduFdJ
	 o/XvB6RC5FhAaUdK/QD87i8RUlsRwPHDAEjQgfuMTEApraLKKCOqQ9PQv040KYU7gp
	 oWCpuZ80/2LxVbiRgOLONghg55ZkTFzdxxUGW7MrM71vlAl87AEWWliX2tOLelOkb8
	 QIhuOSaWfs+Pg==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v5 00/16] can: grcan: Enhance driver with CANFD Support and Improvements
Date: Mon, 16 Feb 2026 14:53:28 +0100
Message-ID: <20260216135344.23246-1-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6559-lists,linux-can=lfdr.de];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gaisler.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can,dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gaisler.com:mid]
X-Rspamd-Queue-Id: 0ADE41444F2
X-Rspamd-Action: no action

This patch series updates the GRCAN driver to support the GRCANFD core
from the GRLIB IP core library.

In addition to GRCANFD support, the updates include enhancements for
compatibility with NOEL-V (RISC-V) systems, such as matching drivers
using the 'compatible' identifier and adding support for reading clock
frequency via the common clock framework where available. The series
also includes improvements like functions for configuring
nominal bit-timing and optimizations for DMA operations.

This series also updates the driver documentation and bindings.
The old text binding is converted to YAML, a new vendor prefix
is added to reflect the updated ownership and an entry for the
driver is added to the MAINTAINERS file.

Arun Muthusamy (10):
  net: can: Convert gaisler,grcan to DT schema
  MAINTAINERS: Add maintainers for GRCAN CAN network driver
  can: grcan: Replace bit timing macros with literal values
  can: grcan: Simplify timing configuration
  can: grcan: add FD capability detection and nominal bit-timing
  can: grcan: Refactor GRCAN DMA buffer to use structured memory layout
  can: grcan: Add CANFD TX support alongside legacy CAN
  can: grcan: Add CANFD RX support alongside legacy CAN
  can: grcan: Update echo skb handling to match variable length CANFD
    frame
  can: grcan: Advertise CANFD capability

Daniel Hellstrom (5):
  can: grcan: Add clock handling
  can: grcan: optimize DMA by 32-bit accesses
  can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
  can: grcan: Add saving and restoring of CAN FD baud-rate registers
  can: grcan: Reserve space between cap and next register to align with
    address layout

Ludwig Rydberg (1):
  dt-bindings: Add vendor prefix for Frontgrade Gaisler AB

Changes in v5:
- can: Removed pointer arithmetic from opaque buffers.
- can: Refactor GRCAN DMA buffer to use structured memory layout.
- Link to v4: https://lore.kernel.org/all/20260128144921.5458-13-arun.muthusamy@gaisler.com/

Changes in v4:
- can: Removed unnecessary saving and restoring of registers.
- can: Corrected spacing inconsistencies.
- can: Revised how timing information is logged.
- can: Eliminated redundant checks for platform data,
- can: Recalculted the number fo descriptors needed for both CAN and
    CANFD.
- can: Eliminated multiple independent queue stop conditions.
- can: Aligned the order of patches.
- Link to v3: https://lore.kernel.org/all/20260122121038.7910-1-arun.muthusamy@gaisler.com/

Changes in v3:
- can: Replaced custom bit shifting with FIELD_PREP and GENMASK.
- can: Factorized common elements of struct canfd_frame and
    struct can_frame, excluding DLC assignment.
- can: Split the patch to separate code refactoring from the
    introduction of the new feature.
- can: Remove Unused macros
- Link to v2: https://lore.kernel.org/all/20251223105604.12675-1-arun.muthusamy@gaisler.com/

Changes in v2:
- bindings: Updated commit message to explain the removal of freq
  and systemid in the new binding.
- can: S-o-b is placed last in commit messages.
- can: Add values are directly added to the struct can_bittiming_const.
- can: Replaced custom bit shifting with FIELD_PREP and GENMASK for clarity.
- can: Drop do_set_bittiming() callback
- can: Remove forward declarations, unnecessary parentheses, redundant comments
- can: Adjust line breaks according to new character limits
- can: Eliminating unnecessary defines
- can: Enhance code efficiency with memcpy, use standard API to fetch device specific data and
  error handling.
- Link to v1: https://lore.kernel.org/all/20251118092115.3455-1-arun.muthusamy@gaisler.com/

 .../bindings/net/can/gaisler,grcan.yaml       |  62 +++
 .../devicetree/bindings/net/can/grcan.txt     |  28 -
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/net/can/Kconfig                       |   6 +-
 drivers/net/can/grcan.c                       | 519 +++++++++++++-----
 6 files changed, 448 insertions(+), 177 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt


base-commit: 4001bda0cc911fcdd3dde36963a17f4eac173d7d
--
2.51.0


