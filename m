Return-Path: <linux-can+bounces-2885-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5405DA3D313
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 09:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0EF3BCE9E
	for <lists+linux-can@lfdr.de>; Thu, 20 Feb 2025 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF61EB18C;
	Thu, 20 Feb 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGX35v5N"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A31EA7D1;
	Thu, 20 Feb 2025 08:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039738; cv=none; b=O4P0ydPxzDTeIk/SpIGUtGDXWOpVXwqoqf9CX1xPsdw3aWjaCb+xriqlxye0x9M9jCOaPGI430cJohbGYtbkI7R2XETr4N6U8d53IZpYqvXJHIIyTNCBs8I6xexL94AgwKYhj0ic7UV2BGwtWIiMBBuZbP5yWieM3pdh1cCotvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039738; c=relaxed/simple;
	bh=dYNzNnDUVJsbRyXzM8XFrFfkx6xG+nwzlZJauQTJpQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T6L6L6ZWd16Y/Op0Xmx5Zm0KdnJpd175ndYtm+q9NeyekvVr7WWvsiAjtjou6sOH22JExr2yMGzuTrLWqLTnTIjMyIt4MyGihmWBz2naQ+d2NBVHWriijRGJTrEvYB8u9p2f/yn7Lo0ZiY263iN4mJW2Ub2rAIokzqww2b38mqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGX35v5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE9EAC4CED1;
	Thu, 20 Feb 2025 08:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740039737;
	bh=dYNzNnDUVJsbRyXzM8XFrFfkx6xG+nwzlZJauQTJpQk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=PGX35v5NJTyfIwX+MKVs8stlKdtQrNbBsGV5XE8gtpcV9A9+XNeIlYbuHsdkIiLO1
	 /vRMZgxyd5DubJYoDXhOs9OEpdE6VI5qxx618dVNNz+jWdoAFPJRwsIt5ZqZw4spUC
	 7tZCXtfjgCSK7zsB5BW+C19Rdq6GQJEe5z9Qp0xaQudytvBfUUaEOD956HCnSsNROn
	 u0SIs8oI5Vnk6PksOLc+/yXA2XQiAAex5xQnGGQTz6RTDnQvdW9wKxQEIzPsmQkigN
	 EIINWivarCm8FrzrdlBCL6WuD91tuDbG7UKudVOas+ayEVhmEjjbf9xbFnSJ+/V0Xj
	 ArZo+7W9whDug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EAEC021B1;
	Thu, 20 Feb 2025 08:22:17 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v2 0/2] can: flexcan: add transceiver capabilities
Date: Thu, 20 Feb 2025 09:22:09 +0100
Message-Id: <20250220-flexcan-add-transceiver-caps-v2-0-a81970f11846@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADHmtmcC/33NQQ6CMBCF4auQrh3TNgjiynsYFu0wlUkQyJQ0G
 MLdLRzA5f8W39tUJGGK6lFsSihx5GnMYS+Fwt6NbwLuciurbWmsbiAMtKIbwXUdLOLGiMSJBND
 NEWoMoSm1xsZWKhOzUOD15F9t7p7jMsn3fEvmWA/4pq0x/+FkQANWzvv6bmqvw3Ng8j2JXHH6q
 Hbf9x+ioKcrywAAAA==
X-Change-ID: 20241209-flexcan-add-transceiver-caps-7cff9400c926
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740039736; l=1344;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=dYNzNnDUVJsbRyXzM8XFrFfkx6xG+nwzlZJauQTJpQk=;
 b=evm6O7mYDxCtOKp8A8CnrlU/rHYr8kuulQS+eoMve4A2FUGZS1MSjkroJiayb8QQ+NunFEU1I
 odyHJcFbY6MDIfesF5ezX32AvRVo0/bxg/NA82d2w5+DYaQUWsWKZ67
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

 .../devicetree/bindings/net/can/fsl,flexcan.yaml   |  3 +++
 drivers/net/can/flexcan/flexcan-core.c             | 30 +++++++++++++++++-----
 drivers/net/can/flexcan/flexcan.h                  |  1 +
 3 files changed, 28 insertions(+), 6 deletions(-)
---
base-commit: 6a24171b9625471abfc90c7b28c4b45bee64b3a4
change-id: 20241209-flexcan-add-transceiver-caps-7cff9400c926

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



