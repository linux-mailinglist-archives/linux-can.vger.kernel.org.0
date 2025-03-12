Return-Path: <linux-can+bounces-3050-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 987C2A5E2F3
	for <lists+linux-can@lfdr.de>; Wed, 12 Mar 2025 18:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D4B18979C9
	for <lists+linux-can@lfdr.de>; Wed, 12 Mar 2025 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887924FC1F;
	Wed, 12 Mar 2025 17:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9P+yJTH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A091C1F07;
	Wed, 12 Mar 2025 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741801525; cv=none; b=l8LeKvFPxEUgTEXtU3ez9c2ZAueeGyzChS0Flwq78BZnXYq4b6He2NBlX4hLWWH9nXM/+OxcMe9IFAxH9HLtQeXelhJdrnu3+elPubmbmknlxtiPT7e1hiRUrUKLOM24qPGQ6GRUxbiETx5iQRJmp3XL0sGSZQYNHuEYRiWBLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741801525; c=relaxed/simple;
	bh=122xJzOd1ODbkxxXzrAgg7StS4O2IbUSeCXvlztvOyU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tmyWcyueL77ixNTVse2QJNjLSsMCw7SwUwUjl9e58Jx0QZNkO3day2LsGVzDJOW1wY+wtB4y01yZlYDiTNMLRp6oXCe9nOFAceV/b9sdefnoOJANloaUmFW9YCv8oVTE331rAdi7YbC+IbFZlfV5fczCLcqHFsH8nPUWk8+LDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9P+yJTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E550C4CEDD;
	Wed, 12 Mar 2025 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741801524;
	bh=122xJzOd1ODbkxxXzrAgg7StS4O2IbUSeCXvlztvOyU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=s9P+yJTHuYcxQmXLxj6la1mXmVfIBKOGEM4KoqdQMD87smo7edJ/qQDres+SW67F/
	 Q8/F9ghsvgVbxcdYVO6BWIDpekowFWHudqfNzGxJRinHpAcpKtrJq8607sKuKKUOnY
	 gpa4z4F/G9/0vP00VTdPDUoCX1Us9A19mEfx8dWJPbeVbOX6gasBxeoZ+PVdmY8e48
	 mcRxIrussqE9j4CLCfXgmbi+czie9n/Od+ZFsy8tXLf6ZBeO0BDzTALKNe5yWSovZU
	 N9803FMth6wKU1OiQgn4gfRb97vI8VZLiT4CYsCrKBQSrITeoR8FnVlr7Pgrp3alye
	 6V9AevZrB0rLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B99C28B28;
	Wed, 12 Mar 2025 17:45:24 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH RESEND v4 0/2] can: flexcan: add transceiver capabilities
Date: Wed, 12 Mar 2025 18:45:21 +0100
Message-Id: <20250312-flexcan-add-transceiver-caps-v4-0-29e89ae0225a@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741801523; l=1800;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=122xJzOd1ODbkxxXzrAgg7StS4O2IbUSeCXvlztvOyU=;
 b=h7s8AGloWvFsNufNDUA8Nft4Rx1IuHBTW9TRg2XZ/KQBBQ8/fu8+L3QGC+yhaayVSQzSsyiPl
 Tv3vqDb4hpEAbNBrmspyHuW/WiMVFEPZgERzaj31BYKoBkahhCCl6yX
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

Currently the flexcan driver does only support adding PHYs by using the
"old" regulator bindings. Add support for CAN transceivers as a PHY. Add
the capability to ensure that the PHY is in operational state when the link
is set to an "up" state.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v4:
- Dropped "if: required: phys" in bindings
- Link to v3: https://lore.kernel.org/r/20250221-flexcan-add-transceiver-caps-v3-0-a947bde55a62@liebherr.com

Changes in v3:
- Have xceiver-supply or phys properties in bindings
- Switch do dev_err_probe in flexcan_probe when checking error of call
  devm_phy_optional_get
- Link to v2: https://lore.kernel.org/r/20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com

Changes in v2:
- Rename variable xceiver to transceiver in struct flexcan_priv and in
  flexcan_probe
- Set priv->can.bitrate_max if transceiver is found
- Fix commit messages which claim that transceivers are not supported
- Do not print error on EPROBE_DEFER after calling devm_phy_optional_get in
  flexcan_probe
- Link to v1: https://lore.kernel.org/r/20250211-flexcan-add-transceiver-caps-v1-0-c6abb7817b0f@liebherr.com

---
Dimitri Fedrau (2):
      dt-bindings: can: fsl,flexcan: add transceiver capabilities
      can: flexcan: add transceiver capabilities

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |  9 ++++++++
 drivers/net/can/flexcan/flexcan-core.c             | 27 +++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h                  |  1 +
 3 files changed, 31 insertions(+), 6 deletions(-)
---
base-commit: 6a24171b9625471abfc90c7b28c4b45bee64b3a4
change-id: 20241209-flexcan-add-transceiver-caps-7cff9400c926

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



