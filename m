Return-Path: <linux-can+bounces-7059-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG/6GVnUr2kfcgIAu9opvQ
	(envelope-from <linux-can+bounces-7059-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 09:20:41 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF3247325
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 09:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A84773071C24
	for <lists+linux-can@lfdr.de>; Tue, 10 Mar 2026 08:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109A13ED5AB;
	Tue, 10 Mar 2026 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="fBRgyb26"
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE93368263;
	Tue, 10 Mar 2026 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773130656; cv=none; b=OIKaygicG4N8218aKhVRXubddOKECgm1Y8m1TuitadXLrV4/Yk655DO42iwp1CEc8yn0DVIL3aVcs/ePDxPEJOnlz7UXqsnZpkV+zPvNXqmXtWpsYPvrEhR/Ze+8rW51rT2XsnrFD/HhwYhN/OnSR7AkKqOChpLaMfosQaXpLek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773130656; c=relaxed/simple;
	bh=Vu6WThxl4ZOOkgR8C7BZaCvaLVkKU6//6nxK2HH+BkM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=eMgMxqJbRlscc49Np9n3VUzSX6FFsMY6N766cnZ3XpE3tfDqrLZ6BxQf64kegHDuHaCB2OOLUOLjdB9VhMe4CwPSPqXpigAtEtu27ZJ53W792OPGGKDn/Y7jkAmFlCVZPMR086Dw6XEM1/xUBCacwyMaaelnGT7Z9p6t4vLv8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=fBRgyb26; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1773130650; bh=Hp3xOAjRXN2jhLbRr6qhx3k1Y4Y/wVzAO1sGIAQPoa0=;
	h=From:To:Cc:Subject:Date;
	b=fBRgyb26ZentLydJWRf5dJ/lPUGBd57CPPTFIvRxV+iZhIyK+bD2eK0rKEAp2xho+
	 r0G3B9t1reha4Sr4urpKGMc3UwqkE9uyxaGAnMQZOO3VhuzeVh7cRHNlokaGvHxlcT
	 I+VBe1d+TJGwh/Q3oCsfGVgxpo/tK8EIOZQAgqdU=
Received: from LAPTOP-KQCD4QBN.localdomain ([183.242.199.70])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 4109FC7B; Tue, 10 Mar 2026 16:16:16 +0800
X-QQ-mid: xmsmtpt1773130576tpn1a8wnk
Message-ID: <tencent_4FDD118829AB6217A4CF1B169C156845FF08@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GJU9F7OKNDXhUG78UsU8/ET2PeD2K3mI6rJe1FwBxLY+DOg1L+B
	 7JwUmwHYWZoObe0CJO4dXkZXX2f44jgpBEm/haru1paz9+e28poCYFBCYTWXEL8CvavPpmykUNdU
	 Q9QtiEhk0QnEUCbk8UYenpEdasG9au+lagRerWk0Xz+vEKSgB/PD9c8lSAe4Y33z4AXK2kZsCnmq
	 f0kftJ+zBENasq6YQganCvAy3yRVzvZawM8zqMcqeNIpOx/IQRJKL71x/iw08opal6pTkqPG7z+V
	 NgUaHGsDGiPU1l/G1NoMaGe2NDGTlpKugfI/+lShdnt3/LEm2R4oqFkC20xOXprcT9o5m25a2YNs
	 wR7GLQ4ngwICZ2iMR/G4TM/Yctkl5KpBJ5ZnxYbLgor6qH6WtOkABCslkjcDdYXRGo3Q1nECxZe8
	 zz2+e85lxnHjmAKE/1isojxWhB/9L+L0SCzZ+J2AB73mpigOupzU4yee2SLNyMUcLe/TUhhc6SyC
	 0u9vsA9W20M4lW5hFcs7j0Y+MJpHMVk4BHZKFXGxzlT31Yf3g6WlY82eH+eY+Dx/kNrBp5CMESLk
	 14R7JqzBlht+MJzd9RvWxwBYTL+98JbnhT1bHLahYLbNxTrb6nySB4IjFM274InsQlFNM8r2RnUj
	 c0r1vAmLa+9UnSOamtHKmwEalogAVYimILSHtNyo44f1dJpCf7RQQ42Oz0bbL4GNB8hDnqC+NFIa
	 +5bt2SqfkiyMjJJKnhwvUAslQqIOH2Pk5SiNXMD4pURoHAevfqKV6FSiDbEvlMqnqgAjQ4HNS7Ae
	 OuFeub75I8Zgn/Nw5x1VTJavx4+tBX5uCJ0EgDyLbEBRZN/zx4JE4gZ6lQPOZo0+PfEEubcQBViu
	 6tn4R/bclvZVgcqzVP5FQKIkgv9oRtoyNTdHzLcnw2o75W483tspUQSEDGmj5am8mqWog84n+wkq
	 E1NW93qaXjKDVckMD2y/gHzGycMGQvq0SRzA7XRlMZxEwZyEcT8X+JWyogAZsCAJNx0/J7ZoD23W
	 /XtabNAfEaX6mdb1S0Y23CmXadKaM=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
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
Date: Tue, 10 Mar 2026 16:16:01 +0800
X-OQ-MSGID: <20260310081604.22474-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0BCF3247325
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	LONG_SUBJ(2.20)[293];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7059-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bjtu.edu.cn,vger.kernel.org,qq.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	FREEMAIL_FROM(0.00)[qq.com];
	FROM_NEQ_ENVFROM(0.00)[2063309626@qq.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:dkim,qq.com:email,qq.com:mid]
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


