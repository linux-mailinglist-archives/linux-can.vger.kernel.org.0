Return-Path: <linux-can+bounces-7082-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LBiFzqztmmTFwEAu9opvQ
	(envelope-from <linux-can+bounces-7082-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 14:25:14 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABC290C36
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 14:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4871300B053
	for <lists+linux-can@lfdr.de>; Sun, 15 Mar 2026 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42AF34DB5F;
	Sun, 15 Mar 2026 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qAT/MxCX"
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD6258CCC;
	Sun, 15 Mar 2026 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773581110; cv=none; b=dEcPzrL2Uo2NIoj6RoK6GG8eB2MMPIXEO8dvDVSQJgMEjyd9xSBXTSxD2gRRDSeC3YHyoU4xvf19hrMQBsUfxTxdhBtGsEtS+qOVw5ZHPe1qNBq6tD5/Ro4sfkv7k75+3TbaGNDLDH3804I9pGLGzPFKrxtdCiRMoUC21gXEgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773581110; c=relaxed/simple;
	bh=lLRLi2BTbCwZG4eDKgGYZ7Yk5neuT+xytISPYPa8Jp0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Lyjo5wQEGge2xfssdaASY9gtmbFHQtGeMVKT7mchJENbZpI1E7lV6elnVRnxCjC71hdQCF0gRHi42U962cfEufRSCSXl7BVH5RLa00jxmvdO3leyC5Avd9y4m/ouj+y4CKNLTb9gGEZydOXVH0QVUAjrZTQ7gIIrZlwq18lmn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qAT/MxCX; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773581098; bh=HNuOcHpewasACVUbzW81ghPxRf31MUiu0gusA2Ne9TE=;
	h=From:To:Cc:Subject:Date;
	b=qAT/MxCX46b9q33KUhjzK/uLZ0Rptcx1evaR3A42zBhO4xbZnpa+UECc8Eh03OiPp
	 YdoekeS9UwdmC3caNSfYB/w5kIQ862d+u4kY9WAD+dOFTVm0v0LgYR1iBsD8ZqVKAB
	 nj9USNf6GR3BDu85fH6VDH1aWy53YybbmQ0f6OBs=
Received: from LAPTOP-KQCD4QBN.localdomain ([183.242.199.70])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 6359CE78; Sun, 15 Mar 2026 21:24:53 +0800
X-QQ-mid: xmsmtpt1773581093t9hgd8jpb
Message-ID: <tencent_C4EC82E859C642A082A288BBDB0D9179D505@qq.com>
X-QQ-XMAILINFO: NILSps3eteZwTJi6q0QSFsuH/29b8hnaJGlRlFA8mXLXOVT6smBh11j9/4w1NV
	 ytvf25mBkdaiPhJvGWu/u6BRxLJmaI6LXhZQ2LQujgDKRFo4Bz1IiovDnNOJVpSxPc1pAIm3phGc
	 SmE4IWpj+ZaYju9WAOF5p21B6NWO3ztGLKjl6EbR8bicIAlKvGGeM++6KTyhCOqAFfZOVo9j4xJe
	 9CweMltCtrQAiC9rYxvNU4TWh1xZPmi+1Yn9/FlIU7eavH8hMhGKjiBAwzynp/JpS9dMcKh8e63E
	 yqkhN3U/Afk7amZ9NBpAJ2A0RXjIlk+OAxIWGQm6zyfbcFiwrZ3339mTYMBx0dPMrhSV4Kb6uOLV
	 lAmT2/7yBS7nH1Oxo1GUHcRsrUnOUp2E63r2/i48DsZOR1rUuzRfa0orENADQpCWJWl+MP1ah+v8
	 ImDzr/CoJRw/sNxhKn7C5y3AFTQ7vslgJEg333mpoikfqsaZs6v8lfa9j85hmg+zbR/ax3z48E9D
	 58f2oxV2qz7tZvDhCXYJ8saj3tD43Wi0vVFmooJvOwG9PdR4HOpXup4hicSWErJs6nilss7ke7+d
	 8pmNjBOiST26sc7NYoEXGvZzm/Nc4QK6tKS/rxqsjYCWtuw8I3cqLHY+kjtnwWfCgil6CSuOtVhn
	 OqRF4UdqmeRzJA0oNsjgNqlZa746NOhAGf+BBZyJ1/oCOVianyxsjBXByIueLdo38P6r1p7g4iJ7
	 9J8yGiQF/VJ0HykSl5k8gwjZ1Fv4iovMgxmY55pSAw0l/RsgSmZ90ZuhE0fAAAGKQLdOptn63qMD
	 ZbkclDSU8pltfFwITxPeSuShNb3H4uCTbVE3p8gWBIWZtx9y4uN8+UsbUBZXrw00XZTRL6H7qTlq
	 vpEhOyB99Khbo1jOSNVOGyDZAsEUrJWQMkfOvJycEaWVyvIfguxPnsmwTc7IF+1moo7HprQmch+t
	 fjZFNDcXt7dlZ/+C42aq1lC5jVYVFsd3g7BkKCFIB2ih8viJcPlLSFYu5EwMbHPE69DfA2lwA55m
	 98yh9mS4WrR5FdgqEU5aO87LkKsKXcd3Nu2ln/flU8i8Lg7064
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Wenyuan Li <2063309626@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Alban Bedel <alban.bedel@lht.dlh.de>,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	25125283@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenyuan Li <2063309626@qq.com>
Subject: [PATCH v2] can: mcp251x: add error handling for power enable in open and resume
Date: Sun, 15 Mar 2026 21:24:51 +0800
X-OQ-MSGID: <20260315132451.4214-1-2063309626@qq.com>
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
	FREEMAIL_FROM(0.00)[qq.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7082-lists,linux-can=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,gocontroll.com,suse.com,lht.dlh.de,bjtu.edu.cn,vger.kernel.org,qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2063309626@qq.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AABC290C36
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

 drivers/net/can/spi/mcp251x.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index bb7782582f40..28324eed1303 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1225,7 +1225,11 @@ static int mcp251x_open(struct net_device *net)
 	}
 
 	mutex_lock(&priv->mcp_lock);
-	mcp251x_power_enable(priv->transceiver, 1);
+	ret = mcp251x_power_enable(priv->transceiver, 1);
+	if (ret) {
+		dev_err(&spi->dev, "failed to enable power: %d\n", ret);
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
@@ -1516,11 +1521,23 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
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
+			dev_err(dev, "Failed to restore power: %d\n", ret);
+			goto out;
+		}
+	}
+
+	if (priv->after_suspend & AFTER_SUSPEND_UP) {
+		ret = mcp251x_power_enable(priv->transceiver, 1);
+		if (ret) {
+			dev_err(dev, "Failed to restore power: %d\n", ret);
+			goto out;
+		}
+	}
 
 	if (priv->after_suspend & (AFTER_SUSPEND_POWER | AFTER_SUSPEND_UP))
 		queue_work(priv->wq, &priv->restart_work);
@@ -1529,7 +1546,8 @@ static int __maybe_unused mcp251x_can_resume(struct device *dev)
 
 	priv->force_quit = 0;
 	enable_irq(spi->irq);
-	return 0;
+out:
+	return ret;
 }
 
 static SIMPLE_DEV_PM_OPS(mcp251x_can_pm_ops, mcp251x_can_suspend,
-- 
2.43.0


