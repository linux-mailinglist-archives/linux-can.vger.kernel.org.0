Return-Path: <linux-can+bounces-567-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA388BC73C
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 08:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369351F20F6C
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 06:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8D6481D0;
	Mon,  6 May 2024 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EHiCA22R";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Vtm39H5a"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA05446CF;
	Mon,  6 May 2024 06:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714975208; cv=none; b=YTYgDhDraTr8nT7WRPXGYzo/4C9DglLyK9Dq5ujrEvPgtNbhnLAeswQmjfQlJPMcF8x/dExZHxPeNWMTE3pL2b6tco5H/K+4nfoSXgbfIAeSFKeC8nePst2fo3UpwCttwYIsxn9mo+DuXmYkHKsgk7UK/uWhcGoOHyFm4Iac2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714975208; c=relaxed/simple;
	bh=KgXnKpGS7j1W3cutgX8wg9tLYZP638mj6jJLbZ5G8vc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CuEQdz22JXI2DJSx7KozMjFZb2yKWkMyH92eJpwBDaEFBNSe7St8dnYuDfv1AHA8Lzo/xqmfCyMAZnDOzMxvpCdM2sh8ayCOKcjeXf5G8m6EzgQKEyvJRVc8HhvsXS5/o19MtkrYpOoYTf/VO+3+eaDK1V4HgbulNVqZVGWKUP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EHiCA22R; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Vtm39H5a reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714975204; x=1746511204;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=l3MdTi3j5rgN9hablWq4x9eXzyjzcKzMbwO6NXO+aaM=;
  b=EHiCA22RU9a6TXMdsKwwIqJVsGtLy/nqR+iOqStrG+o992P/BkEGyyX8
   AlTIA662U27S3PHqo3hudlvYXGL9vxzuF0onKdWGuKAnhix9e3IqAIqh7
   eSYoVgRWaOM9wfNhAzegjh6ziZk8aDNPk+h0lRI0VAQoLW3w3334LDqrQ
   gLnVuKjw3uu562s0en0eY3DeQPsNjznLGaTpq/d4BGQg3X7eJ52T18jii
   c19JNp6d5xxLFiQf0u1X8Z9u96/uyf+BxLTolXKP4d0HR5GMoYjpaWBCp
   JgwN4cyZh/AfVX/H1zb718Cafm6IHfxN2KYE7It9QUN2lwf+AUaJ9DQLX
   w==;
X-CSE-ConnectionGUID: +uTMB1GFQXmbfrsmdPDoVA==
X-CSE-MsgGUID: OMx7XGLVRQq/x9s8/5GUDQ==
X-IronPort-AV: E=Sophos;i="6.07,257,1708383600"; 
   d="scan'208";a="36751415"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 06 May 2024 07:59:55 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3BD9173BE6;
	Mon,  6 May 2024 07:59:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714975190;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=l3MdTi3j5rgN9hablWq4x9eXzyjzcKzMbwO6NXO+aaM=;
	b=Vtm39H5anoxbM1aUl+yWA8prXdExh6xoe229iwcpBplsba0xQz+fZERui+38S4ew+gBFiI
	O25THqy0p+Oq8btgHkFC4cWbf1Ol3kb22FnSbF8EzRjDhhYOS2fSNH9DlJRLx+CGmGXFN2
	uJVaQMQEdVoKF6u7itQctQSxaxWMuSObQPx00/2BbnWrEjBBXsP41qrwR/oYFjgxnOMmYB
	xt9lOqQqVQYDudGuzR8wrwz0/+g6DxFyH3+4DmtU3gqg+uWcwLaDgmbUeRTx/w2e3y9Bj+
	9NS7yyzxk/mQubr0Bjsb8xLntzq5N5OEAC4hKu65+5Q0Uo2/DUObcxAbZ+Y8jg==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Subject: [PATCH v2 0/6] can: mcp251xfd: add gpio functionality
Date: Mon, 06 May 2024 07:59:42 +0200
Message-Id: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM5xOGYC/4WNOw6DMBAFr4JcZ5FtAflUuUdEYZY1bAE2NhAix
 N3jcIGUM9Kbt4tIgSmKR7aLQCtHdmMCfckE9mbsCLhNLLTUhSzUFQb0ulSbbaHz7MCSmZdAoO9
 GNbYy2JSFSGMfyPJ2hl914p7j7MLn/FnVz/5NrgokNCixUraVeJNPeufzBF1wi8/RDaI+juMLO
 Dhl3sIAAAA=
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
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714975188; l=2584;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=KgXnKpGS7j1W3cutgX8wg9tLYZP638mj6jJLbZ5G8vc=;
 b=7MCvY1oUqEGxOEz551MKsVGPD++UONYKxvQw8sMdfJLoFDcUcnb9IVLWW5VJUx17pEC7RdbSr
 W0gcK9K3JooCnPXfEtdH/OrQn++G+vXjgMaBpr51GxzxdHDDkPv2hCX
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

The mcp251xfd allows two pins to be configured as GPIOs. This series
adds support for this feature.

The GPIO functionality is controlled with the IOCON register which has
an erratum. The second patch is to work around this erratum. I am not
sure if the place for the check and workaround in
mcp251xfd_regmap_crc_write is correct or if the check could be bypassed
with a direct call to mcp251xfd_regmap_crc_gather_write. If you have a
better suggestion where to add the check please let me know.

Patch 1-3 from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-0-c26a93a66544@pengutronix.de/
Patch 4 is the fix/workaround for the aforementioned erratum
Patch 5 adds the gpio support
Patch 6 updates dt-binding

---
Changes in v2:
- picked Marcs patches from https://lore.kernel.org/linux-can/20240429-mcp251xfd-runtime_pm-v1-0-c26a93a66544@pengutronix.de/
- Drop regcache
- Add pm_runtime in mcp251xfd_gpio_request/mcp251xfd_gpio_free
- Implement mcp251xfd_gpio_get_multiple/mcp251xfd_gpio_set_multiple
- Move check for rx_int/gpio conflict to mcp251xfd_gpio_request
- Link to v1: https://lore.kernel.org/r/20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com

---
Gregor Herburger (3):
      can: mcp251xfd: mcp251xfd_regmap_crc_write(): workaround for errata 5
      can: mcp251xfd: add gpio functionality
      dt-bindings: can: mcp251xfd: add gpio-controller property

Marc Kleine-Budde (3):
      can: mcp251xfd: properly indent labels
      can: mcp251xfd: move mcp251xfd_timestamp_start()/stop() into mcp251xfd_chip_start/stop()
      can: mcp251xfd: move chip sleep mode into runtime pm

 .../bindings/net/can/microchip,mcp251xfd.yaml      |   5 +
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 310 +++++++++++++++++----
 drivers/net/can/spi/mcp251xfd/mcp251xfd-dump.c     |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c   |  31 ++-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c      |   2 +-
 .../net/can/spi/mcp251xfd/mcp251xfd-timestamp.c    |   7 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tx.c       |   2 +-
 drivers/net/can/spi/mcp251xfd/mcp251xfd.h          |   7 +
 8 files changed, 303 insertions(+), 63 deletions(-)
---
base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
change-id: 20240417-mcp251xfd-gpio-feature-29a1bf6acb54

Best regards,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


