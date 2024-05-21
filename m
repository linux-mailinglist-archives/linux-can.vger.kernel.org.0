Return-Path: <linux-can+bounces-652-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEEA8CAED3
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 15:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7EF283620
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33643770FD;
	Tue, 21 May 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RQVItXt0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="FYzzdApz"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F82757F7;
	Tue, 21 May 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296716; cv=none; b=g3BWpb+xeNcoLDGgW/Mkzt22ju6R9ax8VIoagTk8aznvcMQadjrJgHthr30TVnGSMkvTMpbANNXb5TMLV3YG8IETKV24saa0ORDzNXRitzN6992T/inOSsm/ads7HSC2hkYwsBiizR83mk871qSCrBpjc4U2vE07iZNb2ngcoDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296716; c=relaxed/simple;
	bh=poYwZzFrROnVvrzaB1PisgarOajrVBSZw1xGHbZ6Mkw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HHkzcn/A/y8b6/e44D2yRBLalsN/1nn8TUyvH/RAPu3sQ1xTh9dn9a8Eiyg25AS+Mn4YgBVANdbwVIltBM3GCtK+mC8hcEQud0mQnX9GxDntfGgQgp9p7QTFTi1ruUO1osTW4eev1IXsG3JYdtKQEG4CtjOEMHLiMgsx1ZWYcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RQVItXt0; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=FYzzdApz reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716296713; x=1747832713;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=pyP6xgaP2ZcvnjLNb6y+BeqcJGYFyeQAlt1mSCVUPeI=;
  b=RQVItXt0R2p5Y2s0dTb1QU49IAr40pTBR5w4jXxeCuzgwkMRzLO/TrG8
   x8jnPbPKD+WnTUQ9yUmsJ7gwMLQJ/+gwgPnOr7EotSZFRtXp1ZCXp4RBl
   xCV67DPErzd61G5e/RUyiQoLUp6UemLVF5gBc+iGv+5za1EyEcmLi295e
   7aXeJZ5/2g1PAx53PW4IT7/LMOiVdOT3GpylSWJZh3FHBV7lm/vdeaxNa
   1f1SyaD2uxcOeE2BtNlwW0yQP6lERFttCCXx7rMD+Kl0kuEEXKWJeDjdQ
   9FP3VcZD/SuDoQc75Q6VDDAMkuIUxif7qBwukHQZ5lWZmgr7xuUpcRm1w
   g==;
X-CSE-ConnectionGUID: awLlqhjFQ96EEj94Va4gnw==
X-CSE-MsgGUID: NUkJL+sDSL+9wLBhfnwFFg==
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; 
   d="scan'208";a="36993950"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 May 2024 15:05:04 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28CB0170EC5;
	Tue, 21 May 2024 15:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716296700;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pyP6xgaP2ZcvnjLNb6y+BeqcJGYFyeQAlt1mSCVUPeI=;
	b=FYzzdApz7tThIukYDrKmqX0u82ATqsGuqgWPsfl8vZIJur7Sx2eHrQc03VPYaIwXt63pu1
	UlxCZQlnPmSAXaSQFy1bvSyGSgyaXP+yRenRPZxx22jMtDK7pnxKW63unjZ22tTi20XoEx
	kfJh+/jRnDdAKNrFPumJtITBV0Lcy35YTQfqHnAgATCsYHcdPjZzc9/5JtVyWvqpWvc73f
	Nj8D36fUp2HTXSgT9ZMZOmFIb7Kps97g8txEBt2uYM/wBU8i/BXsfRlFY8zdJoKPs/QmVQ
	/moIaEly32masjAq/+u9T4RqGs7sbgYQcH7C0Wu8j7Kw4iibYZ0H6Dsh5UnITw==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: [PATCH v3 0/8] can: mcp251xfd: add gpio functionality
Date: Tue, 21 May 2024 15:04:50 +0200
Message-Id: <20240521-mcp251xfd-gpio-feature-v3-0-7f829fefefc2@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPObTGYC/4XNsQ6DIBSF4VcxzMUAFdROfY+mA+JFGRQKSm2M7
 1506dA0Hf+T3O+uKIA3ENAlW5GHaIKxY4rzKUOql2MH2LSpESOsIAUt8aAc43TRLe6csViDnGY
 PmNWSNlpI1fACpWPnQZvlgG/31L0Jk/Wv40+k+/qXjBQT3CiiBNUtURW5wjOfHrjzdna5sgPa4
 cg+GCfiJ8YSJihvqNCyKqv6G9u27Q2C3JhbDwEAAA==
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716296697; l=2868;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=poYwZzFrROnVvrzaB1PisgarOajrVBSZw1xGHbZ6Mkw=;
 b=UK5smkXVZ8q2P0ligQzIDJHupAMROG4DJZG8zeqDxt7DvCzWSH+lyPZM8+UbwEm5iZG1G80Pv
 cgILKhUfBmYDe5WhOPUz40zyVM6DjUYH5MFn1w1jlazytDxOjRyGIxh
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


