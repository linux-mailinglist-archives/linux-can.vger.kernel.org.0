Return-Path: <linux-can+bounces-5488-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAD5C68884
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 10:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id BCA812A4A7
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A530FF39;
	Tue, 18 Nov 2025 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="VuKw5I4s"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA4302758;
	Tue, 18 Nov 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458218; cv=none; b=bVSl9AS2bNu/ITBkyPsgiZjqPD8PA4k7fUmHr/qtISW8uuNbGc9+VZA2650YAaLOeNas/Q0Xs5l//eG6F5I8eDgF9hQKEwlMRZz9bVI7BZIiE9TCAOhba+Khjr2cLgw1JS71bL6Xyx0WRkgIALHUfWBpYEQjylZRdJws1bVw9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458218; c=relaxed/simple;
	bh=+PcfyNVTARJoeXWxI7D9aaTTu6aSZve4kQvaVAZvn3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNIlSDTyH4lg1yVz3RngQgiReCOSafE7c8YIqT6jXvDJ7/qFuMey65nRLBnD+nNzI8u0AwEfTDBsztS/5wSMfiz1Hgno2GDxj/G73Pdi6lmkvAUcfV1VoVwndwuxl29G7PprFoI0xWZfQH6labsv9pfPjil/pT4+7k5IJctLnWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=VuKw5I4s reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4d9fHk0mpdz1DHcL;
	Tue, 18 Nov 2025 10:21:22 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4d9fHj4cNKz1DHYP;
	Tue, 18 Nov 2025 10:21:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1763457681;
	bh=B450eTSI8zJ2BnfDplznr7LN7dZPFFaNNxLcRYyEPUA=;
	h=From:To:Cc:Subject:Date;
	b=VuKw5I4sKcwsDdPbHu43tleKay4b7uqh2Q0MJjhVwIxw49lVwYWtCmGGsGzWthYIv
	 HgvKJdaVB2SOO5PyNjV4FoT80XCK2h8VtAM3Prx4Y11rkpSK/wK6sAR5HUwfhw9ZQC
	 EWyvljAISr/JQ9Qwc5UabKHqLSfN2zwd5HLz1txGn65Q4CwoK6b2PyjJOq6AKdXrSe
	 SIRDEW1uTrmjfwJL8FbFbDJs7wzwyvGpBu4lg7KeFKUbZORJvOO4Z/h6gZqJT1vH7l
	 0nre3LXksH/ogaIF8CiarmtwBtYl3vibsEDAzZT4n1WG26S/E7b/HMnumzeUQBijTO
	 7AHDiY4lK2Onw==
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
Subject: [PATCH 00/10] can: grcan: Enhance driver with CANFD Support and Improvements
Date: Tue, 18 Nov 2025 10:21:05 +0100
Message-ID: <20251118092115.3455-1-arun.muthusamy@gaisler.com>
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

 .../bindings/net/can/gaisler,grcan.yaml       |  85 ++++
 .../devicetree/bindings/net/can/grcan.txt     |  28 --
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/net/can/Kconfig                       |   6 +-
 drivers/net/can/grcan.c                       | 470 ++++++++++++++----
 6 files changed, 473 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt


base-commit: 4001bda0cc911fcdd3dde36963a17f4eac173d7d
--
2.51.0


