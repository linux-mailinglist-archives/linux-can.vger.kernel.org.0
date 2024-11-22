Return-Path: <linux-can+bounces-2180-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8DE9D60E3
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BD91F21514
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 14:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3496B14D452;
	Fri, 22 Nov 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Bvgf4Gh5"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A113959D;
	Fri, 22 Nov 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287183; cv=none; b=o+US0VHeVkJxvE8StXOQPSTxPKz+NKYmmlgMzPm4YL3pXsHcHztaMoCSgVu2xM643iOyxdQ4Qube6hNiuQImS4874rvr9S90wqk5ijs60fL2AtaXuYtMV+9MS0o40ot/U9kAM7X8Ud2qxIT1OSQx+C79T+s7VrjsCrSJyI1qnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287183; c=relaxed/simple;
	bh=ocC1FPl0f88WHZezE3pi1ctPnNrY3v/QbLLjCuAJfG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CoPDiLJW0L0yCefcHd5K9ctvcvzroC1L8V2gJ+5dbL1ahNk0tNDi/HKXuQsrALRSRkwrCXxRH55ToBPe7eQF5Rbzvd6l4r5Iel1Q67APZ1WtqPnXGuz+z3hw6iGHhL/VnshmBFpNb479LJtj4ZWOY7/VNep2MN+Jat+pVN9GUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Bvgf4Gh5; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cNrGz3wwQWKgtKhUWoIpdHoNu/ZJ8RPPnQ7AxElL624=; b=Bvgf4Gh5ZRVRmnx3mEYF3cuLw4
	Hj5bVTomEgsJa2zqHl0XKrCSHJT+jRCKs5C6Ct8LTeIv/uN0O8T4F/lWdXQMcP5IlPJchlgQ7Ng/D
	4uP9hveaHVOHcsWl70F4KjI0xqWMr5WsRvQSUjDHKYm1Lqp7htcLwyqxNCs0W1Fexruui3Y0NtQbQ
	TpP86taAcmKZM/A72PDIovGvxAmnVH3bmK2NtujOscGlSMVmSWDFmx8MoHvsUhe21Q2U0J1QH8nov
	F+ahQ7Y4xYwLygxfIfbvJxkTs8tkmewVs1m8Lu1ojx/elmXH36shvmT09SK5zw/FBwgBaevv+PMbl
	8JefKioA==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tEV1W-000KIE-F6; Fri, 22 Nov 2024 15:52:42 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tEV1W-000HFz-0n;
	Fri, 22 Nov 2024 15:52:41 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 22 Nov 2024 15:52:23 +0100
Subject: [PATCH can-next v3 2/3] can: tcan4x5x: add deinit callback to set
 standby mode
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-tcan-standby-v3-2-90bafaf5eccd@geanix.com>
References: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
In-Reply-To: <20241122-tcan-standby-v3-0-90bafaf5eccd@geanix.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27465/Fri Nov 22 10:41:26 2024)

At Vsup 12V, standby mode will save 7-8mA, when the interface is
down.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 7213d9894c82d079bf92f1ec62d4eebb500cdfa4..13014be4ab37d24680d25806de642a9c5c197020 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -279,6 +279,14 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
 	return ret;
 }
 
+static int tcan4x5x_deinit(struct m_can_classdev *cdev)
+{
+	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
+
+	return regmap_update_bits(tcan4x5x->regmap, TCAN4X5X_CONFIG,
+				  TCAN4X5X_MODE_SEL_MASK, TCAN4X5X_MODE_STANDBY);
+};
+
 static int tcan4x5x_disable_wake(struct m_can_classdev *cdev)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
@@ -377,6 +385,7 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 
 static const struct m_can_ops tcan4x5x_ops = {
 	.init = tcan4x5x_init,
+	.deinit = tcan4x5x_deinit,
 	.read_reg = tcan4x5x_read_reg,
 	.write_reg = tcan4x5x_write_reg,
 	.write_fifo = tcan4x5x_write_fifo,

-- 
2.46.2


