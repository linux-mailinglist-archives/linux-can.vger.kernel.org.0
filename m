Return-Path: <linux-can+bounces-6977-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GFGJ50Bq2msZQEAu9opvQ
	(envelope-from <linux-can+bounces-6977-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:32:29 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0358E224F09
	for <lists+linux-can@lfdr.de>; Fri, 06 Mar 2026 17:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1F2E300EC98
	for <lists+linux-can@lfdr.de>; Fri,  6 Mar 2026 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0EF3EF0CB;
	Fri,  6 Mar 2026 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="It8KzpK7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683543EB7EA;
	Fri,  6 Mar 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814597; cv=none; b=ETuY1fkQow2f0DN0OjTkM5JBAgyGs2zsle22pASZJwGyosQqJw1EZtJKLiWTGifnUSRAYdMv6I/tilh5hEoDfMUhMqLfJwJqr8P4Bsy/FPQOZAoYAroqu5hWStrBsLGud9U+HkSPHZzcPKKCT+/xlcp6cRzYzBQsSTFdhk65BNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814597; c=relaxed/simple;
	bh=Tm+0YBqYQ/pql6jCbOISHN/w/8nBI+5mhZezjkiroVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhCuuLd7Cd3rL9ZuKkJ7rY+OpAebxROGGNOs6edpqCJjCBtiaTYq05vIqyGMZObeHYHKlF87rHRu8d4+tTaG5tW/403ThrXQAjR6/b7hp0LPLLxBpianF5E+gwqhOV+EaLDYZ0i754+QJidDRgHMdppo8s4iwR6J7yrZ9t18dS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=It8KzpK7 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4fSBh85cDRz1Fg9H;
	Fri,  6 Mar 2026 17:29:44 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4fSBh83pQvz1DDTQ;
	Fri,  6 Mar 2026 17:29:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1772814584;
	bh=ra9PtKAjEDEq2SILzN4E0t6D3nPs1sA1h7StgLLXUH8=;
	h=From:To:Cc:Subject:Date;
	b=It8KzpK7yKui3BloitH9WQE6U2gQbM3l/QhJiBpNn1ORH0r01jQ8lHHtTW89gF8vr
	 NKkwiEBhg82UGjKoTBMutOEwMMTL4doFTp4bsYIXuOFbDLCflmK/rp2KyZuZPRC0I7
	 kglDjjzE+KdE11CRzAGLJ5wTuwQmvbNPG2ES4ts6Sh4kiR6AXZ747roX4A6VFWvLq6
	 GLzRk160PeSm4jdUTLnR1lk3ZlLq+sjer9uELO5yuc2FcpDfcHHKT2hCcRUxtw+wzS
	 VP4H28PejksrUpka+QMfvl7uPR70C6sxlYx+5iDQXIoKBqdQRp4EaRnVv2Zc3w6dB7
	 YXn+El8LteFew==
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
Subject: [PATCH v6 00/15] can: grcan: Enhance driver with CANFD Support and Improvements
Date: Fri,  6 Mar 2026 17:29:19 +0100
Message-ID: <20260306162934.22955-1-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0358E224F09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6977-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_PERMFAIL(0.00)[gaisler.com:s=simplycom2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.muthusamy@gaisler.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.895];
	DKIM_TRACE(0.00)[gaisler.com:~];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gaisler.com:mid]
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
  dt-bindings: net: can: gaisler,grcan: Convert to DT schema
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

Daniel Hellstrom (4):
  can: grcan: Add clock handling
  can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
  can: grcan: Add saving and restoring of CAN FD baud-rate registers
  can: grcan: Reserve space between cap and next register to align with
    address layout

Ludwig Rydberg (1):
  dt-bindings: Add vendor prefix for Frontgrade Gaisler AB

Changes in v6:
- can: Implemented anonymous unions for cleaner buffer access.
- can: Removed unnecessary patch.
- can: Replaced GRCAN_CLASSIC_DATA_SIZE with CAN_MAX_DLEN.
- Link to v5: https://lore.kernel.org/all/20260216135344.23246-6-arun.muthusamy@gaisler.com/

Changes in v5:
- can: Removed pointer arithmetic from opaque buffers.
- can: Refactor GRCAN DMA buffer to use structured memory layout.
- Link to v4: https://lore.kernel.org/all/20260128144921.5458-13-arun.muthusamy@gaisler.com/

Changes in v4:
- can: Removed unnecessary saving and restoring of registers.
- can: Corrected spacing inconsistencies.
- can: Revised how timing information is logged.
- can: Eliminated redundant checks for platform data,
- can: Recalculated the number of descriptors needed for both CAN and
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
 drivers/net/can/grcan.c                       | 516 +++++++++++++-----
 6 files changed, 445 insertions(+), 177 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt


base-commit: 4001bda0cc911fcdd3dde36963a17f4eac173d7d
--
2.51.0


