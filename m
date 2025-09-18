Return-Path: <linux-can+bounces-4734-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB43B83A76
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 11:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D07F4663D6
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E62D94AC;
	Thu, 18 Sep 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvtLc8mW"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B5529D292;
	Thu, 18 Sep 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186108; cv=none; b=uhqpHy+kYNcN4+dxTJ2eRhktQbW8ocDC4gQ8DkwoTzHrejR+qLyOnJzq4wqc3n8wUwjxHh6zG5NAlKkXiLywm2a0N5va6DV2hytc/dcciIOhIc9joeNrX6jW5pBzEVdrX84Cu/sfBsAO1JBbXoAG/QZNuRe/0zPYOLWyzWzVb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186108; c=relaxed/simple;
	bh=5rMvlimJ4W4wdpXOBkk6k7g6cY89cXqZ2dvZK554a0U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IZHDjtWRtul0iN2Kp9BU1JY5XCAchRdhl0kWyQESybWuOlkroYs7kt2yi2UFRBfgPZeyJS24K8CVZdwNM6uqoW1ACXxdau0OWxj8FTJzX8/zqV1uHk2QEt0ibEHgGx/ImOm+JptI9ZFtmqXt04zXylI95PkMe4qtJDb9/sPfq2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvtLc8mW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CA4C4CEE7;
	Thu, 18 Sep 2025 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758186106;
	bh=5rMvlimJ4W4wdpXOBkk6k7g6cY89cXqZ2dvZK554a0U=;
	h=From:Subject:Date:To:Cc:From;
	b=fvtLc8mWA99MkR1KcXW1Izmu9ujGbv8e7xYbBtE60LDXg7JFhQ9ZmuwsHQpAc5rfO
	 kG1xtFLR9dx/2DJUVSBGk/BNs6/+c+UQEMCXaTKph/Xbfr6w9MHu2AkGX0ZAlz7NFl
	 B+2Uj88Ro5eR6Dsk4lvljcTdAGy36gCQ913SDe7/GBWyxfPrtDddJE6195A4bU62M3
	 G6rNraF+R5zbSzR/p4/wuBtv8zAYWrjRNBlG8f/6Ib24cMDkBZfJqpqCSxDB2X2kBs
	 613xR/1lzWhzq+uJ3bVEhuP9xdCnDVa14Cqi+Yo05XPHibzGZmU7oO/XgWWAHrMf81
	 /8bcduPo4XRHg==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 0/4] can: populate ndo_change_mtu() to prevent buffer
 overflow
Date: Thu, 18 Sep 2025 18:00:23 +0900
Message-Id: <20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjKy2gC/x2MQQqAIBAAvyJ7bsEVguwr0cF0qz1koRVB+Pek4
 zDMvJA5CWfo1QuJb8myxwrUKPCriwujhMpgtGm1pQ69izjLg9t54dQaYuJAzlioxZG4qv82jKV
 86NIHbl0AAAA=
X-Change-ID: 20250918-can-fix-mtu-b521e1ed1a29
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>, 
 Akshay Bhat <akshay.bhat@timesys.com>, 
 Wolfgang Grandegger <wg@grandegger.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, 
 Yasushi SHOJI <yashi@spacecubics.com>, 
 =?utf-8?q?Remigiusz_Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=5rMvlimJ4W4wdpXOBkk6k7g6cY89cXqZ2dvZK554a0U=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmnT2VySv215XKrFNlufMix5qL+53Wf9p0LSQzambRxC
 d/uPU7bO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEyk4wIjwzwdy03yEWF7r/91
 do/2FZNYwRHqnL9D2ogrevWtZzsVohn+Rzv28Yr+/3Gh9GNmZxWLiBLjufQ0br36fat9Mzf93c/
 NCAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Four drivers, namely etas_es58x, hi311x, sun4i_can and mcba_usb forgot
to populate their net_device_ops->ndo_change_mtu(). Because of that,
the user is free to configure any MTU on these interfaces.

This can be abused by an attacker who could craft some skbs and send
them through PF_PACKET to perform a buffer overflow of up to 247 bytes
in each of these drivers.

This series contains four patches, one for each of the drivers, to add
the missing ndo_change_mtu() callback. The descriptions contain
detailed explanations of how the buffer overflow could be triggered.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Vincent Mailhol (4):
      can: etas_es58x: populate ndo_change_mtu() to prevent buffer overflow
      can: hi311x: populate ndo_change_mtu() to prevent buffer overflow
      can: sun4i_can: populate ndo_change_mtu() to prevent buffer overflow
      can: mcba_usb: populate ndo_change_mtu() to prevent buffer overflow

 drivers/net/can/spi/hi311x.c                | 1 +
 drivers/net/can/sun4i_can.c                 | 1 +
 drivers/net/can/usb/etas_es58x/es58x_core.c | 3 ++-
 drivers/net/can/usb/mcba_usb.c              | 1 +
 4 files changed, 5 insertions(+), 1 deletion(-)
---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250918-can-fix-mtu-b521e1ed1a29

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


