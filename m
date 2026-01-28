Return-Path: <linux-can+bounces-6349-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J9oIlUiemmv2wEAu9opvQ
	(envelope-from <linux-can+bounces-6349-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:51:01 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BAAA3344
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 15:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B670301F878
	for <lists+linux-can@lfdr.de>; Wed, 28 Jan 2026 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A9361644;
	Wed, 28 Jan 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="l2e6CAdo"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DF29D266;
	Wed, 28 Jan 2026 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611771; cv=none; b=bRXnL3iHREiBW35b/5w+fe0sFUBbI72I8V1eJoOuAjDQgsS4xpHIBHGFAx+YmEFZ9l+xDYu00sosBgT047OqPP/8Iqce3alzb3Nluxx1DNJjNRyzL9oj4p+MVODpyPwG9cunUOJ7mYqmIjulC3bhycaUsxRX5zTZNQ9ulrAnBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611771; c=relaxed/simple;
	bh=uP2cOKdruvl6qwsVeeUsTvnz5P26iBixdoTTXV2Omr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tStIQNIxuf8YiGFXQE9YtDehha8WfetCAi3O4nHB6jgkrP8IdeWjsxHxhn02E8s/2IQ41Cs6GVpEPUpK716nGOd7s/nACqmr7bn+h96wfIZ3qynDUqnIvTQq9QIvUqlUEQ3h4KWLSsqvb+rd0+aX8PjchdCLLUb4Dy1Hpy70Whs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=l2e6CAdo reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f1QCV51pNz1FDXw;
	Wed, 28 Jan 2026 15:49:26 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4f1QCV2Qrjz1DR2b;
	Wed, 28 Jan 2026 15:49:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769611766;
	bh=82ROLeLJ+2Q+VCTc2a1/ZtC4JBygtVN8GobU/Tmp37k=;
	h=From:To:Cc:Subject:Date;
	b=l2e6CAdoQZSrem2k6R25bXa2917TmGwD6LGvEsFrDV3Zry+rGK8dYAnraagnBJ0kh
	 SEThIP0/of0uiAa2JTLgJBKLEmDuWZp8Rsvb7opUC0vaqEojbd7lAClNB0dyx5U4T6
	 8zrFaQgJv0HgmE+kZd8q9hbmXNFvEXnUniM80qePv8548vm3bUi4cBGH7Y02PV6kfH
	 105oNqSGnCBgB9VR/cDObdRHRkI/ewzafO2IRQpctR4U2VEpbo9qX/hAchMu5KviRa
	 d0GBG5avqE12KemSQILKhNKlatd7E28adceQiZ3lNDUr/rPR0FtyeTR2oKB5oQ8Itk
	 NEanCNCJx1tOg==
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
Subject: [PATCH v4 00/15] can: grcan: Enhance driver with CANFD Support and Improvemens
Date: Wed, 28 Jan 2026 15:49:06 +0100
Message-ID: <20260128144921.5458-1-arun.muthusamy@gaisler.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gaisler.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6349-lists,linux-can=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gaisler.com:~];
	TAGGED_RCPT(0.00)[linux-can,dt];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gaisler.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33BAAA3344
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

Arun Muthusamy (9):
  net: can: Convert gaisler,grcan to DT schema
  MAINTAINERS: Add maintainers for GRCAN CAN network driver
  can: grcan: Replace bit timing macros with literal values
  can: grcan: Simplify timing configuration
  can: grcan: add FD capability detection and nominal bit-timing
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
 drivers/net/can/grcan.c                       | 496 ++++++++++++------
 6 files changed, 426 insertions(+), 176 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt


base-commit: 4001bda0cc911fcdd3dde36963a17f4eac173d7d
--
2.51.0


