Return-Path: <linux-can+bounces-2064-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B29CDA4C
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 09:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB6FB23201
	for <lists+linux-can@lfdr.de>; Fri, 15 Nov 2024 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E246A18C039;
	Fri, 15 Nov 2024 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="J1lOrnDQ"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A518BBAE;
	Fri, 15 Nov 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658570; cv=none; b=X/mcvfCaeb0Uq6uxh91db0LIH1RnaqU2VfVluEWfQIU++hYDzST08OevbCj6Rs3CF84kQUoyPOfItteoVY2TkmSWz0qc/zcVZWmQDhypO/MAGtJ625RCHj80vBt/HwXwH429Hlq6CZ5ROuRgX/HkqNziHRNgq1CMfWgtM323Zm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658570; c=relaxed/simple;
	bh=AlNSbTGZzzYhebHDyEMbrV6xohqUOXJctL+Pnj7/FUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LauJsy1n2QTE7gBUpJh5B0LhaYZvLXjVqLob5t0clRO49I9n7oyJVKbW5rKEtFxG7SJDCZog8XCzSgJdX2zNeLI1JeWAFyhjOXGqOuMm6v2pXkKkfgo064j9yPN/O4ta4ZD/2ZfMp0T1ekQ1hGDG0r/YxvDYuDVrAJi3L+Flufo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=J1lOrnDQ; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6ObOvMf1enZviPs8LOUyFoZzk/OF/FDf4jZp5aN0xyY=; b=J1lOrnDQGineuyhU9G/i3dC86f
	VFpv+KnsjMlB/DsgNpnCPlsphVgJ5VDtH2hdA8xYzkDkOQSILLqqbwD/xVuzLhSTdoABWQ+p3AwSW
	Xy46T2nqN+yvdtJJaOTX+JHlRaGGLtKvdmu35IFM9cBTxcYsXhl/SaPxZwQbpoO8wv5C0UpEPMXeu
	5xPNFXyakzqbDktQF+C57lO10roI9IW33S2Slakvs2q4rqlfuzNaflcWAa6b30XGFtv+yPwXHGAIZ
	Wn7CYt33zX7KQ6In2JFvZUPblY264c35Z3yWwBcKM3T3okdEUKsXAZBw+oyKd+nIq5eU79dcAWi5C
	95eJn7vw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tBrUk-000NVE-9L; Fri, 15 Nov 2024 09:15:58 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tBrUj-000OuX-2L;
	Fri, 15 Nov 2024 09:15:57 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Fri, 15 Nov 2024 09:15:51 +0100
Subject: [PATCH can-next v2 2/3] can: tcan4x5x: add deinit callback to set
 standby mode
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-tcan-standby-v2-2-4eb02026b237@geanix.com>
References: <20241115-tcan-standby-v2-0-4eb02026b237@geanix.com>
In-Reply-To: <20241115-tcan-standby-v2-0-4eb02026b237@geanix.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27458/Thu Nov 14 10:38:08 2024)

At Vsup 12V, standby mode will save 7-8mA, when the interface is
down.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 2f73bf3abad889c222f15c39a3d43de1a1cf5fbb..7e6eea2c04ee7fbeaa6c8b229f7f64bd04bee309 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -270,6 +270,14 @@ static int tcan4x5x_init(struct m_can_classdev *cdev)
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
@@ -359,6 +367,7 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
 
 static const struct m_can_ops tcan4x5x_ops = {
 	.init = tcan4x5x_init,
+	.deinit = tcan4x5x_deinit,
 	.read_reg = tcan4x5x_read_reg,
 	.write_reg = tcan4x5x_write_reg,
 	.write_fifo = tcan4x5x_write_fifo,

-- 
2.46.2


