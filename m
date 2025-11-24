Return-Path: <linux-can+bounces-5634-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D201DC7FE3A
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 11:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 075154E4AAE
	for <lists+linux-can@lfdr.de>; Mon, 24 Nov 2025 10:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D542FB97E;
	Mon, 24 Nov 2025 10:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVh2Exk0"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DFE2FABEE
	for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763980130; cv=none; b=l+wORgViamazXr1L94iOQfh3LoBcyZyW1m9NerlQZj2puGE4pf5JidVkXFhGiZLYEwBUur3Si5vY+lWjrNmSD9fs3Sh5AWaerctRT8VbYPwVxDZOZImXXeHWxf1QE5Yqh2Y+uf+ZwR5rS6PedCREIwdH2hF6QsMJl1uV2bZLODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763980130; c=relaxed/simple;
	bh=rPyNl3IXKetzOLBOyKPO8g0EGzeg1E0yIt+StmCCebY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgR14SA57hoc5JTwNEMBurwaC/ku8jeunVGr39Y+P92TVH1uVzk2gDZO37aZYbby/d5HAPfJWfqC/b7MFaqkq3YZhiS5XmHHBOn3e4cTrDz9Cr94mfc6bnu8MgECQOZK3UhP6g+GsBA2GKCuI0EZheoXBtkdpG2egvkC/5ztQ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVh2Exk0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so36544715e9.2
        for <linux-can@vger.kernel.org>; Mon, 24 Nov 2025 02:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763980125; x=1764584925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgtID0nFX3nGFRlE1VlQTXM54bzqiyChn12CU60+xHU=;
        b=cVh2Exk0kdpfHBpQzoRTAAoqyObCeHVYdZEaR0HVcowQPhVc97J5zLWVx5EYn8sVwS
         JBs9LVSyd2bDukM5lIKj+ciA/Dw6TBlmD0u+AEPWT1YmDlRguKHrg7G0sNj5nZ6+R6UZ
         k7ToFbUaZQD5BHbyOXjMRAmI+rL6Y8AWVfsC1l1/+6WlqXc/lfxHfrcDxb8WgHgQnoDC
         XJSk6aKTYNnpS2FSHGaGvgzMSe8hWYH2NV5atjHbfp/iGLWrbxAqMCC3BwLKaCivxsQ6
         7VBjWB5v22GMT9gzYYJJ8TZCPqPB/eNWNH2YM9TEa+MQkggrvdbnxLoFyShKXCVRl5XU
         YMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763980125; x=1764584925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WgtID0nFX3nGFRlE1VlQTXM54bzqiyChn12CU60+xHU=;
        b=Oje5tfIkgargT7RQNUpVSAS3DFaHnBeonhbgo4uDr/G6+usw31jjtndT+PWcgIQU5D
         5Y83Mq3KAE2zVPaMXAo03GA7w+0sTWtRUtlH800S6gOoVmO/Veqez1Jsh1N4tUqjgY4U
         yARDME3G3a2nI0uvKCedyyRMbJ5R8m86Vr3laJ2Zg1YAoObYhTvp8ebw3OapeRbT+32I
         S3ZOGQU9ubvWQFDY8XQbXsFRbIxSveL3lUIyFIaznDE9JUJqrNMKBc/ebZGJ1RS8Dn32
         Inlw96LdFOnn+bKOaL5nLlUDyX/LEMKDh5wFC3dG/fQl98L9azU35A8IiFYB/XriSYvh
         IVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSW3BJgKwwC6dJLPSIjjoy6AC4GMy4p7zU7y8QvW1jdmLc31Cw87vk6teEu5iepPZzm9sj4fdTFoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfwfJdoXwdJWUq5woUMYml+AukxuN/bUrtkQkYuPNrNm0oikU
	YBX7oJB+1W9N8opz/SPyj2r/A5m4J1pO5oU1xaa6xhZA3fcl2YpnaKGl
X-Gm-Gg: ASbGncs8lJPmUk8yjPqav7cuP8VuLweqOfIftowR0CJkhzqNXJfhP7UhbIvTMZ2k0vp
	qHsunOrDI0nqHpRUz3MGwFPNEUaoLHS+/o/WD6I/OEHODENu81ecsHAc8wQaReBnCM+V9wLbNKn
	P5euQrgfDpz3T5a+OgjlMLbjt7Ci2N/jo2hS9roIwToy2G6EVfmBPYSQnY4mpP2yk4CVIhEzr9+
	6PyyWRHM6IKG1/uhTb9gOmTKHn1aA5E8R1pmSL7qBtsGGP9tux0ugxkuBbvaDoWyoBg/MvNCWi+
	Q2L1ikzIHLZlkBJ3H3/mHAVDsUAtTodi8crWoX+79A1eSrqCraEoH+g/Nv6sNf+S0pwadnNZbj3
	dTj2Lpiq63D6OGRVGOIfZiBZ0mKXkSyY2D+sFv2868voy49rXjphshZa1rgYhsnAPPtX/0tdNY9
	ie5eEKE4AkOrDnqyYY5K7bS7/uK5D/US1uokgb5V4RF5eXXWPIA90uaEQJVVuSDD+ZDvn4cvVKd
	YMYrHHiOnJiUYxw
X-Google-Smtp-Source: AGHT+IGyTyi4ltNsVDvmhl+/roG3AiodjJTRXbT98h+eS1FAwZ4STCcD5g+TawJPyCHRDRFgKtjvvg==
X-Received: by 2002:a05:600c:1c0c:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-477c018a099mr148973035e9.15.1763980124606;
        Mon, 24 Nov 2025 02:28:44 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1df334sm186753945e9.3.2025.11.24.02.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 02:28:44 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 7/7] can: rcar_canfd: Add suspend/resume support
Date: Mon, 24 Nov 2025 10:28:32 +0000
Message-ID: <20251124102837.106973-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251124102837.106973-1-biju.das.jz@bp.renesas.com>
References: <20251124102837.106973-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

On R-Car Gen3 using PSCI, s2ram powers down the SoC.  After resume, the
CAN-FD interface no longer works.  Trying to bring it up again fails:

    # ip link set can0 up
    RTNETLINK answers: Connection timed out

    # dmesg
    ...
    channel 0 communication state failed

Fix this by populating the (currently empty) suspend and resume
callbacks, to stop/start the individual CAN-FD channels, and
(de)initialize the CAN-FD controller.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Collected tag
 * Fixed the typo in error path of rcar_canfd_resume().
---
 drivers/net/can/rcar/rcar_canfd.c | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 5a555b01ffbb..4a653d8978ba 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2278,11 +2278,64 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 
 static int rcar_canfd_suspend(struct device *dev)
 {
+	struct rcar_canfd_global *gpriv = dev_get_drvdata(dev);
+	int err;
+	u32 ch;
+
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+		struct rcar_canfd_channel *priv = gpriv->ch[ch];
+		struct net_device *ndev = priv->ndev;
+
+		if (!netif_running(ndev))
+			continue;
+
+		netif_device_detach(ndev);
+
+		err = rcar_canfd_close(ndev);
+		if (err) {
+			netdev_err(ndev, "rcar_canfd_close() failed %pe\n",
+				   ERR_PTR(err));
+			return err;
+		}
+
+		priv->can.state = CAN_STATE_SLEEPING;
+	}
+
+	/* TODO Skip if wake-up (which is not yet supported) is enabled */
+	rcar_canfd_global_deinit(gpriv, false);
+
 	return 0;
 }
 
 static int rcar_canfd_resume(struct device *dev)
 {
+	struct rcar_canfd_global *gpriv = dev_get_drvdata(dev);
+	int err;
+	u32 ch;
+
+	err = rcar_canfd_global_init(gpriv);
+	if (err) {
+		dev_err(dev, "rcar_canfd_global_init() failed %pe\n", ERR_PTR(err));
+		return err;
+	}
+
+	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
+		struct rcar_canfd_channel *priv = gpriv->ch[ch];
+		struct net_device *ndev = priv->ndev;
+
+		if (!netif_running(ndev))
+			continue;
+
+		err = rcar_canfd_open(ndev);
+		if (err) {
+			netdev_err(ndev, "rcar_canfd_open() failed %pe\n",
+				   ERR_PTR(err));
+			return err;
+		}
+
+		netif_device_attach(ndev);
+	}
+
 	return 0;
 }
 
-- 
2.43.0


