Return-Path: <linux-can+bounces-663-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BAA8CC2E8
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 16:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC710286086
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0852C1420B3;
	Wed, 22 May 2024 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="bxBc8p6X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tgGdvNnV"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BD913D899;
	Wed, 22 May 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387373; cv=none; b=gVa32PuB22ONtYtmh7U74wT2BKXGvIPHFdwVHgRI+pzwp1pIcJi7MlXvurhoTkpJTGvFrGlPgPf2NXRpPurq1v3me2MDcL/oZFxi99mgBLBtK6+rVRJG84lVOsGUjLsyztSci/FLw8wcUKoE5LW7unnPjw3sMr3qLUEAX/Ra4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387373; c=relaxed/simple;
	bh=poYwZzFrROnVvrzaB1PisgarOajrVBSZw1xGHbZ6Mkw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kf5SwS58TQMkbYLe8O3/RGAAPai2bGv4ztkR5Wraq5lE7mIVzRht1gxpm7BN09tlPQY/izIaNvFgOPfQJuK7as/lGwKtoXCHImv9iqqEje3IzGOVW7IqmhaYHAzpO2R0nQ4uRn8qoW5dmFepOZ62GERdBI/Ze/VMoZm1lB7f6oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=bxBc8p6X; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tgGdvNnV reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716387371; x=1747923371;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=pyP6xgaP2ZcvnjLNb6y+BeqcJGYFyeQAlt1mSCVUPeI=;
  b=bxBc8p6X1rlVP3q0ghqYDq4vDGDFIEyoAqn4q2lI9Pq6/KFGfe4QxX3T
   9rcEmugGfS0pTmMe20raAQ+BhGaDTNdEUNg21bGUamw6yURgYhjKmMDFG
   tGb8e3Lz/RxEYmNBW8Cm+/5kV8+mHi7WnhfkI9487/SgfsnLaQOUC1ax6
   uEUedBsCFR+I2KyKl2Oj41k+4jSwUeUNMAnppSdJAvCVFuyOIioJb44MO
   rFx/t/L/0SER+dEmsexh9Rn31jlNb0ZQlIXUAXoUF24ZkdCLZX2NdZAoF
   JJoKCCqas2+XUTfAuKszPeYz9wmVGadw/0zTefQOmxteWeI39DzKBlZYx
   w==;
X-CSE-ConnectionGUID: ItvqHDVoScCNDD8qdXzqGQ==
X-CSE-MsgGUID: JOzqs72yQ2ayPma6NH9rjQ==
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="37017658"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 May 2024 16:16:02 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D667F160CA6;
	Wed, 22 May 2024 16:15:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716387357;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pyP6xgaP2ZcvnjLNb6y+BeqcJGYFyeQAlt1mSCVUPeI=;
	b=tgGdvNnV+1b8REiUhwMHuwl6aGlzYeaM5Ahgx0UQW9pLsCgLuwrjOJYVMZWzjZ/eXHdVIC
	nDxX8ThVbAtXfU7AbMxWR2CRHh5j6kxBUlhm8opuAU/XuBuIo7CJ6IT3uklYLD02i4mk8P
	/+p5hfenhpVyvRhWFLekPHZbPb3ADgj3j1eBVYDl1LzFc1m70M8gT/7NhHITSQk8jCAV2q
	W6C/ifgsYJmSKNA98pDu3GeXJDLt8W16N2pO4uxTw/4eAHNY2qvXKhVu4cPkacuVkIiogh
	pWB1eKVgIleSGJlktebuiOMU1JKw89muq1LBM96TxvpuWtZL2rkxiI8KGZGr0A==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: [PATCH RESEND v3 0/8] can: mcp251xfd: add gpio functionality
Date: Wed, 22 May 2024 16:15:17 +0200
Message-Id: <20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716387339; l=2868;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=poYwZzFrROnVvrzaB1PisgarOajrVBSZw1xGHbZ6Mkw=;
 b=ksfiujku3m4JTx2U6PYibn/TjEeEI2vdaP8wABQL4ifUTdhURQ1JgTdHCUfytZ94EeakbQNiw
 ezNuirdEwqTDbJ0PDjtqLLBshcXRNqAbCawI8FMWpVRR4KS+vTK8wAk
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

The mcp251xfd allows two pins to be configured as GPIOs. This series
adds support for this feature.

The GPIO functionality is controlled with the IOCON register which has
an erratum.

Patch 1-3 from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-0-c26a93a66544@pengutronix.de/
Patch 4 refactor of no-crc functions to prepare workaround for non-crc writes
Patch 5 is the fix/workaround for the aforementioned erratum
Patch 6 only configure pin1 for rx-int
Patch 7 adds the gpio support
Patch 8 updates dt-binding

---
Changes in v3:
- Implement workaround for non-crc writes
- Configure only Pin1 for rx-int feature
- moved errata check to .gather_write callback function
- Added MCP251XFD_REG_IOCON_*() macros
- Added Marcs suggestions
- Collect Krzysztofs Acked-By
- Link to v2: https://lore.kernel.org/r/20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com

Changes in v2:
- picked Marcs patches from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-0-c26a93a66544@pengutronix.de/
- Drop regcache
- Add pm_runtime in mcp251xfd_gpio_request/mcp251xfd_gpio_free
- Implement mcp251xfd_gpio_get_multiple/mcp251xfd_gpio_set_multiple
- Move check for rx_int/gpio conflict to mcp251xfd_gpio_request
- Link to v1: https://lore.kernel.org/r/20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com

---
Gregor Herburger (5):
      can: mcp251xfd: utilize gather_write function for all non-CRC writes
      can: mcp251xfd: add workaround for errata 5
      can: mcp251xfd: only configure PIN1 when rx_int is set
      can: mcp251xfd: add gpio functionality
      dt-bindings: can: mcp251xfd: add gpio-controller property

Marc Kleine-Budde (3):
      can: mcp251xfd: properly indent labels
      can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
      can: mcp251xfd: move chip sleep mode into runtime pm

 .../bindings/net/can/microchip,mcp251xfd.yaml      |   5 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 338 ++++++++++++++++-----
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c     |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   | 116 +++++--
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |   2 +-
 .../net/can/spi/mcp251xfd/mcp251xfd-timestamp.c    |   7 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c       |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |  11 +
 8 files changed, 389 insertions(+), 94 deletions(-)
---
base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
change-id: 20240417-mcp251xfd-gpio-feature-29a1bf6acb54

Best regards,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


