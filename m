Return-Path: <linux-can+bounces-7086-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEovJLnXtmlfJgEAu9opvQ
	(envelope-from <linux-can+bounces-7086-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 17:00:57 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED157291520
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 17:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0F03031CD7
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7AE371D08;
	Sun, 15 Mar 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OcIQeyeM"
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD120F067;
	Sun, 15 Mar 2026 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590443; cv=none; b=s5np7ctqmWOEfyVxbLRnfu4OU6fg0v0vDu0tlRrySTBA8ocFSVJYT/plpzpnqXJO+m7kah/sZ0eGLqy9+nyRYhb39D/ExXNYrY/Uu+HG+QEbIw3deLxu6MOA51279+7mZp/NKeiZWbMGEsVO+bi4LcXI9e3AX1HxcRH/RD8JsF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590443; c=relaxed/simple;
	bh=8G40OCQgplRJmsLZCqvY+SqvdoddbK2f911JGeeQnOs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=mY1AmcBs5VzciQ+LRf3+itrZS65kfTnY7TV5ha9xfUWQQPavE8NeqJwH4i/VccA2MMlpttxgzAlxS4dqKwfjhu5S/Pswa7xP6FxANtBDHTiIcHeTf5mg6QC3y+AyTWuSEnfvCK9NeBTXAv0U4IAzyIsfzo2oGiaGy90erFtQkPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OcIQeyeM; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773590429; bh=DeNphzXrIWqC+f0pK/OMpMj3if5YA040WlRIO2rbttc=;
	h=From:To:Cc:Subject:Date;
	b=OcIQeyeM7Ur16Bgb3VSNYRYazf5tBX1XEr6wVtZppE43E6iVvYuwxMt7NdvXj+IRV
	 8dOoRIxIN9FcYDHGDNnHhnupdL56NSJYi3CbZ5RnRDJoWZTUS2YeJit5CcPHby/4hH
	 xm/pZyvEbEegjVMYKBzH5bxEQEVFsnOKOyhTUi8s=
Received: from LAPTOP-KQCD4QBN.localdomain ([183.242.199.70])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id 191487F; Mon, 16 Mar 2026 00:00:25 +0800
X-QQ-mid: xmsmtpt1773590425t4furour6
Message-ID: <tencent_F3EFC5D7738AC548857B91657715E2D3AA06@qq.com>
X-QQ-XMAILINFO: NnBlO8MsmACrE77YzQTmHsvBxpkgvdXTSuYuXRSFLTK76ZEm4eVffcq4iJrwLp
	 driGZ4q1x8YiaogvHctU3waZsb/CkDh4LE7a8qdA7IB90aphhj/iG+3dDzt2SGbM2J7729Lxmh49
	 Z+DtfTxFqPk5hQ3nAWEl1hbsQhlx8ekVsmFaYuwl/6cH+Gg/teAvewrhj1TOFJSniW53I4v44OlP
	 D46G0O2G61/XmxqLKOI7DCyiWyEaz0Wtm1uVNBoIk9/eYIS/q2kNh1HMd5jlnQ/IdPwC6gSM7O/m
	 AEGShhv9seOPdrtv5Crdls06xt7FFJVr07TlCsJgeWLhFmcQWHXBFBRtAEWJ9S1MgiTPZZFTn+V8
	 i7DH0hzm7kOr16ZNn9uky+4VRm0c0MqIRCPD/hHQfH9w79NT0zCRflVmyqGNudS5M4ImJzKivlo1
	 L2+IjVvFpJzV/jVi0U+aK/J9RAADUVByJ/UoQWBQMDzTshPd6yZDyMMus4Tkn1BiYxg0Pq4DZOM2
	 qayfo8Kcx4Tts2YAN7Xnn/fA08APs7raPUMNLFep3bjNuPQqIHMDFwL+wQIxQyI3Dg5SybviVzI6
	 qi1cIWy6Mo4aS/Tti0W4cPuphQ8PAUybHEYZQlYuZInr9h5HIe/BgUi71Rr1nJ9pYAqM5a6q95Jp
	 gU75mAK49QG1jpIyBO6eOOEaAImDChH+j7abxmyJDS47kO+91RN60HE/2UwELDY3Oj1CL/k9Zo6C
	 5L5fNS4MDaJH0lZa94xzUSE5j7mzacPmZXW0zt1eildIoLlp6JUsZJ3ddaMrUlk3XvDAMDT46RTc
	 RI7APtF7Whn3MZ26ICRykohg0D9o04r/+gFpsGA+K3ner86KGF8ZKq1H/2r528Jae4yKSJAFfNH2
	 M3IW3+BU96WPrUNFUr3pE3yZMRCL2u8X3baP+ZuI7kzAkFbGkkHeK14wRq4+BiyFJ4tjFg4yEyB/
	 2E0mYZxTI8NbVelb0VDovR6GEYUa6TDEbfRAP6HsGLn2V81BR2EfzjAvCcX3/F7L4yaf17Ey8ZDq
	 nwayN/ZHacPN5suLqh+fTBrtd29KUDM4/9OwaxDe0z4XaUmNXE
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Wenyuan Li <2063309626@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenyuan Li <2063309626@qq.com>
Subject: [PATCH v4]can: mcp251x: add error handling for power enable in open and resume
Date: Mon, 16 Mar 2026 00:00:22 +0800
X-OQ-MSGID: <20260315160022.10510-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bjtu.edu.cn,vger.kernel.org,qq.com];
	TAGGED_FROM(0.00)[bounces-7086-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2063309626@qq.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED157291520
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing error handling for mcp251x_power_enable() calls in both
mcp251x_open() and mcp251x_can_resume() functions.

In mcp251x_open(), if power enable fails, the driver should not continue
with device initialization. Add proper error checking and jump to
existing out_close label.

In mcp251x_can_resume(), if power enable fails during system resume,
propagate the error to PM framework and log the error with dev_err()
for debugging.

This ensures the driver properly handles power control failures and
maintains correct device state.
Signed-off-by: Wenyuan Li <2063309626@qq.com>

Add missing error handling for mcp251x_power_enable() calls in both
mcp251x_open() and mcp251x_can_resume() functions.

In mcp251x_open(), if power enable fails, jump to error path to close
candev without attempting to disable power again.

In mcp251x_can_resume(), properly check return values of power enable
calls for both power and transceiver regulators. If any fails, return
the error code to the PM framework and log the failure.

This ensures the driver properly handles power control failures and
maintains correct device state.

Signed-off-by: Wenyuan Li <2063309626@qq.com>
---
 drivers/net/can/spi/mcp251x.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index bb7782582f40..e59220aa70ed 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1225,7 +1225,11 @@ static int mcp251x_open(struct net_device *net)
 	}
 
 	mutex_lock(&priv->mcp_lock);
-	mcp251x_power_enable(priv->transceiver, 1);
+	ret = mcp251x_power_enable(priv->transceiver, 1);
+	if (ret) {
+		dev_err(&spi->dev, "failed to enable transceiver power: %pe\n", ERR_PTR(ret));
+		goto out_close_candev;
+	}
 
 	priv->force_quit = 0;
 	priv->tx_skb = NULL;
@@ -1272,6 +1276,7 @@ static int mcp251x_open(struct net_device *net)
 	mcp251x_hw_sleep(spi);
 out_close:
 	mcp251x_power_enable(priv->transceiver, 0);
+out_close_candev:
 	close_candev(net);
 	mutex_unlock(&priv->mcp_lock);
 	if (release_irq)
@@ -1516,11 +1521,25 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	int ret = 0;
+
+	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
+		ret = mcp251x_power_enable(priv->power, 1);
+		if (ret) {
+			dev_err(dev, "failed to restore power: %pe\n", ERR_PTR(ret));
+			return ret;
+		}
+	}
 
-	if (priv->after_suspend & AFTER_SUSPEND_POWER)
-		mcp251x_power_enable(priv->power, 1);
-	if (priv->after_suspend & AFTER_SUSPEND_UP)
-		mcp251x_power_enable(priv->transceiver, 1);
+	if (priv->after_suspend & AFTER_SUSPEND_UP) {
+		ret = mcp251x_power_enable(priv->transceiver, 1);
+		if (ret) {
+			dev_err(dev, "failed to restore transceiver power: %pe\n", ERR_PTR(ret));
+			if (priv->after_suspend & AFTER_SUSPEND_POWER)
+				mcp251x_power_enable(priv->power, 0);
+			goto out;
+		}
+	}
 
 	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
 		queue_work(priv->wq, &priv->restart_work);
@@ -1529,7 +1548,8 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 
 	priv->force_quit = 0;
 	enable_irq(spi->irq);
-	return 0;
+out:
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
-- 
2.43.0


