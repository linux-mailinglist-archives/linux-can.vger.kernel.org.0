Return-Path: <linux-can+bounces-7462-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F59H3j49GnkGQIAu9opvQ
	(envelope-from <linux-can+bounces-7462-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 01 May 2026 21:01:12 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20E24AF029
	for <lists+linux-can@lfdr.de>; Fri, 01 May 2026 21:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C628A300159C
	for <lists+linux-can@lfdr.de>; Fri,  1 May 2026 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370333F6617;
	Fri,  1 May 2026 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCIoYpxR"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77D30EF97
	for <linux-can@vger.kernel.org>; Fri,  1 May 2026 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662066; cv=none; b=I113PcT83+zylditaU7tslCkqOMzJtqdZt2d+r4lwvYJHkOKKCpPjRnoI9y7X1oWo7zyaoN/WtfD416ALZLwrxlTVmVTBPH0zAdtQmoASpIhBBSU6V7oJOSo7ysrEiLA1X5Xy+/QvbiK+a6LWVcpABY1jNXPYUqGVf2A224Trz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662066; c=relaxed/simple;
	bh=u4A2voPR3vsE1mHjlW6yzcsF8o55aX5VN17zQzTBQBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EKmJOiHF5c+d4WF3lKPLpfLGvjwVDAtgQ/8LkR6V3lribBbIWeSV/EyZHw0H8ThrriZ+uc2ktxPIN6lC9swUo9athYzZpz7Yq+9FpUS4p612Mz1HHOR9aA9rrTHKql5BSiNHLV+XHyxIbLYLBlvO9PjaS7aS0h1N5QiO1hlET6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCIoYpxR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-362e30526f8so961248a91.3
        for <linux-can@vger.kernel.org>; Fri, 01 May 2026 12:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777662064; x=1778266864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oTnhLjm+3JWboEBKOT20RDnrgCD6r+pICX0KtRAwJkc=;
        b=KCIoYpxRXDKGEuao+wBf6rlkMASbPwrvClLbEQFFSi9pewFrgyoXX5ymISHlElbUjx
         xOW4JTM6uB2908BeP8R4nLbRpxzQACRIZpuyVj9o/0zbmYSBaxAf7vsVsqAnzLx1OhS/
         iBbEEDP63GdVy2ndXId/aazcmx8gerFDRQZS3JRWTKT1093eyB/ByOI4GC2EejtZOw+S
         LTKxsuHhmQmvzMm+eXkXCdVSymENqEavdRHRVpFbrjRhWPJoIrWEpWWPw50jRyehPhMg
         yWBeKcHAsWgLWQgoD5HjD+FueJjYXGpFYSCpeb1XVyfxZzxtewkMEIe9mWd6oUlpiUP0
         wccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662064; x=1778266864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTnhLjm+3JWboEBKOT20RDnrgCD6r+pICX0KtRAwJkc=;
        b=XQBXC7OouttAukGMSEQgcycf23Il1wcAeLO9JjZUf9yLUKXMTnE3Un+xB0iqmIPdhP
         tWX9hncXIS3B2SpRLtBklHYnSjCa+/N3VJfUk1cIa3ZJzj+yvQ/hOIUd1kMxkbDyT6XH
         AIFodG6mraGKBOu8LRavriVyBkcYIch2nK6bGuLp6LwVTusI71nordtukcDyY2XvCc9/
         76ORHeMCKXt72yyJ/j9uJ726qmGYzm30GE21A5mor07qPrHZxJoHXUiDW/8NLXQ+9ZBY
         1c34/pNUa05C8GxWIsjoqnfGUyBaxhiAZgz0NOD1JXBrDYT/wRNNqso07jpO5qAGhRUr
         nHTw==
X-Forwarded-Encrypted: i=1; AFNElJ8Xd6ltlOErOstOACE1TLIIP9ThqTMt+0hKfui1JRdjyfmciMFHvL48de3nGAzWh3hw4NQgFuJE5mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09S54zdxPa55JwTanvP1NaGrAzaKGkpfNj86wtmx8HjBpSUJG
	x0nMCUL8QKBVggQ8tiUJjQ7cVHwOwQvOZFkfMHJkLty8EQdxt1vNseoPFNe4yPGw
X-Gm-Gg: AeBDieuEWTovhfcfL9XKyV/49azhxVCGj+h2KVT6/18bbWI3LtKTC/VRl9qgP6HZpHH
	GlkGhJUOqS0SzyK2l8LZruOScC/Gq7pZ95bgfkmpzP7b+XDJu+LqbjJkovIWKQwnQMq09oKO3WV
	Qn2wj0aEgxnCGqnrnaRHrPSI7YuMkJNIpEmp0NGhjS0yuWc9S/wp8129h5OwgBFr0HRFIwTQghb
	S/v9+1WdFnOd5Gzj3tT6gtCBsmUdnaqKvLYKOK0kXx8E6cNn6w7tjXv+aE8+mOJaSIO3aje7Y+t
	xP2M88QvstF7CGK4TO7ZUTXf4CqNeXEBeSlDPqlE8FDOqbmaiI80+bFB0di4MRv1ETLNiNzN6kh
	ICqlbWXkEhpM0ro9eCLRoCTf1DXAA9WEx/dJbtVRRBEgPTLWpLMsk+a1YSMmAOamF4PxI+0CPyH
	XnXSIrMTKg2cmLm1EPWNwQw6G8/NBjABARvGcOwU8QDkSJFMw+jGA3VmijuYoXgWTOYXeHzREt
X-Received: by 2002:a05:6a20:918a:b0:3a2:e0d3:37d1 with SMTP id adf61e73a8af0-3a7f1eb20dbmr261690637.41.1777662063723;
        Fri, 01 May 2026 12:01:03 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6f063sm2734570a12.20.2026.05.01.12.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 12:01:02 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	Ondrej Ille <ondrej.ille@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH net-next] can: ctucanfd: use pm_runtime_resume_and_get() to balance reference count
Date: Sat,  2 May 2026 00:30:05 +0530
Message-Id: <20260501190005.3342916-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A20E24AF029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-7462-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[cmp.felk.cvut.cz,gmail.com,pengutronix.de,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.992];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cambiumnetworks.com:mid,cambiumnetworks.com:email]

pm_runtime_get_sync() increments the runtime PM usage counter even when
it returns an error code, which forces every caller to handle the error
path by manually invoking pm_runtime_put_noidle().  In ctucanfd this is
done in three places (ctucan_open(), ctucan_get_berr_counter() and
ctucan_probe_common()), but the open-coded pattern is error-prone and
needlessly verbose.

pm_runtime_resume_and_get() was introduced specifically to solve this:
on failure it drops the usage count itself, so the caller only has to
return the error code.  Convert all three call sites and adjust the
matching error message strings.

No functional change other than dropping the unbalanced
pm_runtime_put_noidle() that was already paired with a failure path
where the resume failed -- the new helper handles that internally.

Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
 drivers/net/can/ctucanfd/ctucanfd_base.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 0ea1ff28dfce..961c24494984 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -1202,11 +1202,10 @@ static int ctucan_open(struct net_device *ndev)
 	struct ctucan_priv *priv = netdev_priv(ndev);
 	int ret;
 
-	ret = pm_runtime_get_sync(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
 	if (ret < 0) {
-		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
+		netdev_err(ndev, "%s: pm_runtime_resume_and_get failed(%d)\n",
 			   __func__, ret);
-		pm_runtime_put_noidle(priv->dev);
 		return ret;
 	}
 
@@ -1284,10 +1283,9 @@ static int ctucan_get_berr_counter(const struct net_device *ndev, struct can_ber
 	struct ctucan_priv *priv = netdev_priv(ndev);
 	int ret;
 
-	ret = pm_runtime_get_sync(priv->dev);
+	ret = pm_runtime_resume_and_get(priv->dev);
 	if (ret < 0) {
-		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n", __func__, ret);
-		pm_runtime_put_noidle(priv->dev);
+		netdev_err(ndev, "%s: pm_runtime_resume_and_get failed(%d)\n", __func__, ret);
 		return ret;
 	}
 
@@ -1401,11 +1399,10 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
 
 	if (pm_enable_call)
 		pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
+		netdev_err(ndev, "%s: pm_runtime_resume_and_get failed(%d)\n",
 			   __func__, ret);
-		pm_runtime_put_noidle(priv->dev);
 		goto err_pmdisable;
 	}
 
-- 
2.25.1


