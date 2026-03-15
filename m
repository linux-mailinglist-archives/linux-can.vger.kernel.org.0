Return-Path: <linux-can+bounces-7084-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCvkJADNtmniIwEAu9opvQ
	(envelope-from <linux-can+bounces-7084-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 16:15:12 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E2291284
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 16:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B29A230074E3
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A96237104F;
	Sun, 15 Mar 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FmiOFz5/"
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331B0370D61;
	Sun, 15 Mar 2026 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773587707; cv=none; b=kEaV73LYE+l3TdMFs4USwSo66h3H7RARysZmSvxFV4+gQYuQaEMDQXDXQDbPapeWFZkFR63u+RTL/ednjutQpa6XPtAzzmtYMJGFazoULFne/eznOuBtHus3RLds5/UPp1R03n8KBTyPwafDGgbplNPvhXKhATiN6//XrG0mIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773587707; c=relaxed/simple;
	bh=81dizodNk0zOUy6KvWhkt77dnzvT5V59hH5ZFszRoY4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=WBesI89B4mtUsnz5zg7fWuLe6SYLAPumu+9HAOe3ilwZXBhHgjY3HXRPMNAudgMaBdo67fjk8Q+U8QlPy46ZCBYwwTgp4qOYW/zMl+Cz4UQFcrj3+1XvnQpfeXB++JLBCoS9CmflR6k3rduyfkl5twl4SCVXh4ZVvPemf+EZP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FmiOFz5/; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773587692; bh=a6oFsneHtXyuzO/8oIcDwibG9lUKQV3CWiXAjwYPes8=;
	h=From:To:Cc:Subject:Date;
	b=FmiOFz5/kkiPjHihQYesLPrnIKOm6R1bG9XE40/sPXj+1SM0KyFR8aXNcJVm6OAgo
	 o1pumjmM5vtqmCgGt2OUjuY9D+0+BzAUmKYZPT/4RqZZDlWood2z6qpWsUBptxg2N4
	 KeTVhb8r7gdYT8CvBVAsmCbxNgzjtD8tvwKJKxwM=
Received: from LAPTOP-KQCD4QBN.localdomain ([183.242.199.70])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 3B09DC7C; Sun, 15 Mar 2026 23:14:48 +0800
X-QQ-mid: xmsmtpt1773587688tdlz8uu5a
Message-ID: <tencent_3DBF7B03B16695EA62EA19C742BDE2A6A805@qq.com>
X-QQ-XMAILINFO: NMiAo2azIaDArJdhGUJZ+aRpIkYOmK8UZee7GWpyxhkoSuiwRr77aVi76cG5TD
	 JNlj/ZwPJe0Dy1loVesuDdl9V18VqSa9n3YcVQsxzK4DNAje5csu8j2ZYALAXHRCjLMiTyzw9ZDS
	 Rz6lGo8iigAr+iJ2h0vB805jMtwTmzDzet+AbdtGUqd/6YzjMSFiAFVoCka96SkqAX4BLmgDueAT
	 HMYVLy1o2UZO0rCLHQaGVBsAYzAKTqbr7UyR3xTE/zJTQPwBlJTb/6XbIHTxNKdjH+nOVeV8gOCn
	 kF2aDQo2KHVk312u7bRpNuxEOCdIcD8k0M2n3IkzGNLPDj9GeTaTodxnsckoeosYuquyhSPs4MPI
	 l8IjA8A7SVpFsv4z2/trsGJQsXIYDLaCTxpxGlSLshyPYEVN3RVrYVdnwFACC9iHhj4T9E0iRTXS
	 2tfZToJvlQrwXA8EvY+KzberWgydMTjc8fWj6AbwoaWgW4Ur4SfIU9chlx7iyOP9M/W+8XjP2vjR
	 u6WZokMEHJ96njylovrWwDLMNdubFfCpipWS5HAnDt0WEDmQ2A+JWp6PoZXA7NfPpNgn9DyvprF8
	 52ocWowoarHRsLnIIN2QyVz6lRIJLvO6ldwuMbpZBmmrBs94uN6QkgGvG/eO8TbvKYp89J41+S7F
	 7UbeKOlWOwQYGn/QHKmM3qNYIxo1E6VEX1saOzZjWitcd9uqbcrPozRrPRLff1YMkS3002MVdOHQ
	 3LJymIMVMczFA8BmFqHUgFT94++2qbHTQ+c5qOzzOFe163zMZMEJmOI667Oy4LBCL9Q3Io1EeBl6
	 g2+e8mZFooES/U4ZwX7FFkzZb5fy1CBVXGBjAInPPN6OsvrjqMUE2BRPV2zhfPIX7ySeAAEpWTDZ
	 bzbHYQssCoj24ePB4iMERQppJzIgrtUpVWufWiuUxtErL+SkTiViyewKcerp5F+WGO8jj0AnB93E
	 SxziAnWsudLQg5ax5JuMLNlOi5hUfmpR6ZlAGVg7Su/JNw0O0/bDsioIiREnL1zl+3Bj8sksn9sz
	 DEn/k60JUrmhAc1zMHZwE8yUA5GtG2APIJO7JT7fWuKOaU4AvG
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Subject: [PATCH] V3-can: mcp251x: add error handling for power enable in open and resume
Date: Sun, 15 Mar 2026 23:14:45 +0800
X-OQ-MSGID: <20260315151446.6292-1-2063309626@qq.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bjtu.edu.cn,vger.kernel.org,qq.com];
	TAGGED_FROM(0.00)[bounces-7084-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qq.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[qq.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2063309626@qq.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E4E2291284
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
 drivers/net/can/spi/mcp251x.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index bb7782582f40..6e17133a4e03 100644
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
@@ -1516,11 +1521,26 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct mcp251x_priv *priv = spi_get_drvdata(spi);
+	int ret = 0;
 
-	if (priv->after_suspend & AFTER_SUSPEND_POWER)
-		mcp251x_power_enable(priv->power, 1);
-	if (priv->after_suspend & AFTER_SUSPEND_UP)
-		mcp251x_power_enable(priv->transceiver, 1);
+	if (priv->after_suspend & AFTER_SUSPEND_POWER) {
+		ret = mcp251x_power_enable(priv->power, 1);
+		if (ret) {
+			dev_err(dev, "Failed to restore power: %pe\n", ERR_PTR(ret));
+			goto out;
+		}
+	}
+
+	if (priv->after_suspend & AFTER_SUSPEND_UP) {
+		ret = mcp251x_power_enable(priv->transceiver, 1);
+		if (ret) {
+			dev_err(dev, "Failed to restore transceiver power: %pe\n", ERR_PTR(ret));
+			/* If the transceiver fails to be enabled, turn off the power that has been enabled.*/
+			if (priv->after_suspend & AFTER_SUSPEND_POWER)
+				mcp251x_power_enable(priv->power, 0);
+			goto out;
+		}
+	}
 
 	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
 		queue_work(priv->wq, &priv->restart_work);
@@ -1529,7 +1549,8 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 
 	priv->force_quit = 0;
 	enable_irq(spi->irq);
-	return 0;
+out:
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
-- 
2.43.0


