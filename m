Return-Path: <linux-can+bounces-5910-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B77E6CD8FB4
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 11:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3156830019CB
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C9232ED2F;
	Tue, 23 Dec 2025 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="SPo0MndN"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC1932E14F;
	Tue, 23 Dec 2025 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766487396; cv=none; b=U9DDkodj8TGtEq7q9QZ4qEIz5b44JLmuaAIgMEePTeL2jH9HFm0cgGPAXRVt9ckhvtvpjYwCSnJpJcx49E9aKB70hCUCbZ5iSyyNaRsT80T76JyLnrNZdwz0so/YLrBf2dXvGmS5fXOD6nAoxwCDKUaeK7ZSvC+vvVhA5sp6Gbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766487396; c=relaxed/simple;
	bh=iX7OdH4a7pIAa62jl9q9p/7wMMo74peMp686VxD2Nl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EPGq4r1e0KEmUnxaprWgt9IfkUer4+KgV0mCs1+TsaPAqacepjmAx12pY+qucfrPaLUpvWPZVIS5uE/QwMuF1qiesLeqtHKw+/KUBqMU0BBLyX6uGMsdttmnl00qqVUXqB1RvAEI/0l5FReHR38bTgHqf9dvb2rgJT6nxKqKpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=SPo0MndN reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dbBlC25p3z1DDSH;
	Tue, 23 Dec 2025 11:56:23 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dbBlC06L7z1DDXY;
	Tue, 23 Dec 2025 11:56:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1766487383;
	bh=8CkVG3PHqS3kI3uWyaSSWPJ0Gx8T7F8DZSJHRba42dA=;
	h=From:To:Cc:Subject:Date;
	b=SPo0MndN5l/y2FyK8wdvRbvDCUkXSKdTpkwvTHeTfTX20+gm4d1FHIt+8CuMtxCUh
	 DfQwB0W/YQDr6MYI6cG5EGJLNZ7j+fYcX9C0sHf34jZPOx+4I3FiHUlxsLMlvRfR03
	 o2pHhsjlj45gN/gFZ5T3MrPYvSc1p9FwPG/1nnf2kXe9MJCg7FaRmRAe1v0uxr/u/u
	 Mvhn1nk/bUu1QiSME1vo11HefnZdUlSrhmWbkd2Hf591INj+01mYrohNi2bKUv0tgd
	 hmUPExZfIM7LzGEVjHEpZ25werD9RpudrPQJvj5Cq/g2EYoUw2CjqiUiPYYOyAWU9s
	 JGO59dHKeEYTQ==
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
Subject: [PATCH v2 00/10] can: grcan: Enhance driver with CANFD Support and Improvements
Date: Tue, 23 Dec 2025 11:55:54 +0100
Message-ID: <20251223105604.12675-1-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Arun Muthusamy (3):
  dt-bindings: net: can: grcan: Convert GRCAN CAN controllers binding
    from txt to YAML
  MAINTAINERS: Add maintainers for GRCAN CAN network driver
  can: grcan: Add CANFD support alongside legacy CAN

Daniel Hellstrom (6):
  can: grcan: Add clock handling
  can: grcan: add FD capability detection and nominal bit-timing
  can: grcan: optimize DMA by 32-bit accesses
  can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
  can: grcan: Add saving and restoring of CAN FD baud-rate registers
  can: grcan: Reserve space between cap and next register to align with
    address layout

Ludwig Rydberg (1):
  dt-bindings: Add vendor prefix for Frontgrade Gaisler AB

Changes in v2:
- bindings: Updated commit message to explain the removal of freq
  and systemid in the new binding.
- can: S-o-b is placed last in commit messages.
- can: Add values are directly added to the struct can_bittiming_const.
- can: Replaced custom bit shifting with FIELD_PREP and GENMASK for clarity.
- can: Drop do_set_bittiming() callback
- can: Remove forward declarations, unnecessary parentheses, redundant comments
  and unnecessary debug printouts.
- can: Refactored variable declarations to follow the reverse-xmas-tree style.
- can: Adjust line breaks according to new character limits
- can: Eliminating unnecessary defines
- can: Enhance code efficiency with memcpy, use standard API to fetch device specific data and
  error handling.
- Link to v1: https://lore.kernel.org/all/20251118092115.3455-1-arun.muthusamy@gaisler.com

 .../bindings/net/can/gaisler,grcan.yaml       |  62 +++
 .../devicetree/bindings/net/can/grcan.txt     |  28 -
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/net/can/Kconfig                       |   6 +-
 drivers/net/can/grcan.c                       | 508 +++++++++++++-----
 6 files changed, 437 insertions(+), 177 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt


base-commit: 4001bda0cc911fcdd3dde36963a17f4eac173d7d
--
2.51.0


