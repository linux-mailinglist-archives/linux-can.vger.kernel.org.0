Return-Path: <linux-can+bounces-7058-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOgrHnKnr2l2bQIAu9opvQ
	(envelope-from <linux-can+bounces-7058-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 06:09:06 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6A6245655
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 06:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83BDB305B97A
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 05:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8003B5315;
	Tue, 10 Mar 2026 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rv1hp2Ir"
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A138BF80;
	Tue, 10 Mar 2026 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773119338; cv=none; b=N7XCQQOshz9vjWKlTKZ8kC1LncGwjobfGh8KeRD90DtlRokktIR1H2zrxckES1tWIwmQDNaXMh5RNGWT789DXQ+2pCd8gFIOSn8HRDUb7NlLNQ82+2zWgNgaLLDXnXltZLYRKKpG1aQtcvjmEdtbOwHxBL9f951NNYTJRpx7ubg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773119338; c=relaxed/simple;
	bh=Vu6WThxl4ZOOkgR8C7BZaCvaLVkKU6//6nxK2HH+BkM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=IZirWGHAg6ByeZb6NZ7HUQx4U3PX8Z2yKRsdUMMFTSG9chJbv3WSmENPEttec5JHvNIBTkjngrFG3g6Jvoudk/+2SMb6fp45Z+l0P9xxa2gxrO/XYva+rIkerGmOdC/P+YsnwrSiB70xZJJl/wFHFuFtJrqw/INF2ORH0TigKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rv1hp2Ir; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773119329; bh=Hp3xOAjRXN2jhLbRr6qhx3k1Y4Y/wVzAO1sGIAQPoa0=;
	h=From:To:Cc:Subject:Date;
	b=rv1hp2IrHlMD6ApfjWlpegeE7pKHKUXZ7aT1Q/zK1E/cP7mLizw/LPH1oQfzTqwCN
	 hvhdQr7HbpfvVMJZL19SM/3CZZKaqH4ouHVI8iBVPWp/saplDq6IvF616xwIlKT0TC
	 9kE6tAFptHF6MNCf/WgmeLzuGbblRuoRPkZgkQdI=
Received: from LAPTOP-KQCD4QBN.localdomain ([183.242.199.70])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 22DAC4F7; Tue, 10 Mar 2026 13:08:45 +0800
X-QQ-mid: xmsmtpt1773119325t3l9a7sp6
Message-ID: <tencent_B5E2E7528BB28AA8A2A56E16C49BD58B8B07@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxO46zM8xVt6z57bu2PBmguQ255dUMe7FDEHT1jQlGe7zeUkhN3tJ
	 8OfzDE+byPlWQN5VnvKFQmKcBGahF7RasOf+xhv2aK0ZXMq9O230rq7doDgurA2FzQmfL84knkYe
	 61M2f6dHmM1E+wTQec8RnBH7p7jydzA39bcmLLpfW1OtjclRtArn9rOsUEK563ZvBNAbs1YICq27
	 ypHxhOznvhW6EggLXfsvcdGoJHKxE4a2PXjAyXk4H27vM5PACP1ma2UUTxAn2j29WtZQAXUlH7+v
	 6ORG/Npm/pFIYDQJ4bzf+oXpJx0TlJCVCn/4WgztvAyHd81PA/fon31PUDS/URPD8MNMqbpUUcJA
	 KfK2UdywppWL10w1xxLsFRvQFdoLa5FkdtqIo11hya3DkJTlntVcRuJBZf1Y4dGI9W3kMIS0fGr4
	 RAtf+VNYRov/rTc6vAj2CWBVL0oGsw1NSaokuoormQNwpZaQaMR9X9qU8IYB2Md4NgP9hN1U0WGs
	 NczrVnzS6BSgIA5txF+64A1HkDK7ER5+kuUvFq+kJNElcE1GZJxI3AtgYNr/3AFpUnkPHNxkT0/I
	 CaubUX0zbEWeRlXnbc1+40Kn9kR3UNS28ouPMJh9A+XQ420qta++3GRMUd3fTQMZVmcPzdXmW40Q
	 INV1Veu/2i8aWlTA9+PKkYPl7hNWuRjc3EcXWh3z7IvmCm/gRx/Xs8Xe1D42szFxu9OF7Nxl/LIw
	 9Y2mDoyGXvvzOyKMQ1Cr3UdjVTsBmFCZKzQssIMtlhTWp1NEEd3uXKbWqTmbI9RbSS+fWlelOvl+
	 lX6OwUVkPGdc8UoA8P/aOm8Hrh/Wps42VchqY0YEIED1ckuTD9iCrgkcyTJeoB/xJt9gSCi0v8xR
	 ISE70tuBCCcLIwnNNMmvnAVa4IO4dRmi69VEIB2ehA1JHXhq7g3sGuZOZybZgrnh0e44uNmaS3eT
	 nT2dJZKngSJNyh6Kxc8s2FM4AU79oMImSi6UsF7E/GPRMaQmGd2IjmeQwswD29kWsXz/fAkJ2Xjm
	 B+MZ8Zcw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Wenyuan Li <2063309626@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn,
	23120469@bjtu.edu.cn,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenyuan Li <2063309626@qq.com>
Subject: [PATCH] Signed-off-by: Wenyuan Li <2063309626@qq.com> spi: hi311x: Add check for hi3110_power_enable() return value In hi3110_open(), the return value of hi3110_power_enable() is not checked. If power enable fails, the device may not function correctly, while the driver still returns success.
Date: Tue, 10 Mar 2026 13:08:44 +0800
X-OQ-MSGID: <20260310050844.3517-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB6A6245655
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.24 / 15.00];
	LONG_SUBJ(2.20)[293];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7058-lists,linux-can=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bjtu.edu.cn,vger.kernel.org,qq.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qq.com:?];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[2063309626@qq.com,linux-can@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	DMARC_DNSFAIL(0.00)[qq.com : SPF/DKIM temp error,quarantine];
	NEURAL_HAM(-0.00)[-0.748];
	TAGGED_RCPT(0.00)[linux-can];
	FREEMAIL_FROM(0.00)[qq.com];
	R_DKIM_TEMPFAIL(0.00)[qq.com:s=s201512];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a check for the return value and propagate the error accordingly.

Signed-off-by: Wenyuan Li <2063309626@qq.com>
---
 drivers/net/can/spi/hi311x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index e00d3dbc4cf4..f0444b4c5b6e 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -755,8 +755,9 @@ static int hi3110_open(struct net_device *net)
 		return ret;
 
 	mutex_lock(&priv->hi3110_lock);
-	hi3110_power_enable(priv->transceiver, 1);
-
+	ret = hi3110_power_enable(priv->transceiver, 1);
+	if (ret)
+		goto out_disable;
 	priv->force_quit = 0;
 	priv->tx_skb = NULL;
 	priv->tx_busy = false;
@@ -790,6 +791,7 @@ static int hi3110_open(struct net_device *net)
 	hi3110_hw_sleep(spi);
  out_close:
 	hi3110_power_enable(priv->transceiver, 0);
+ out_disable:
 	close_candev(net);
 	mutex_unlock(&priv->hi3110_lock);
 	return ret;
-- 
2.43.0


