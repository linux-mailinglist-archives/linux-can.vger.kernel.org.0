Return-Path: <linux-can+bounces-1931-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EB59C33AE
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491611C20904
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0DC22619;
	Sun, 10 Nov 2024 15:59:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5990F80027
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254389; cv=none; b=oeJL2jBHrAV3KTRSrnu2wrkWrVbYFL2ieG1fqZ7D/yd3NohdP7hdXEd1aW2bYeg0L/OOpmm5J0J8xaUr/xlDQUswwfbDy4nWJo1I9IHf8bL/4n4k3bo9/eIfItrTONs7KKZWZCh459RXJmqnXUbXis5V24AagdJd5nklp0k1kbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254389; c=relaxed/simple;
	bh=rLIldrUZ8vWf4bt1AuzN1DhtyfJt7xyDiHgy9e3wVGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxzI3R9S1Q5mb3vfQnB30/jpxv3LuIsJePxLRyqVHYENR4aR3fQQO/fS6ClRYiXNtYyfg4+RGIY4Nm7yzkJIDE7gy0mNS+nmt+yRQv5V+trbjiG+rEP9/5uRBr/Lxuu764MFtcOEUGBubb2dx5I5zBMNg9O/QRl4DketcmIGfFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e625b00bcso3042953b3a.3
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254387; x=1731859187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=740E/6UvUIAz3rdVq3hABbQZSuN9sY/kfLAJyHttayk=;
        b=n7gaFLJjEwndUmA/P4SZz9NglgsK5jWI0aUwYerKvboNEucBHWzOXPRGsz71y478PF
         UyXwUkwNfPhmh5xijCrq9MqviWPcJgwFYalBve9CxN5UnEyugAq7S6gsELeztzsO3VeD
         pDH2YBVqW1EvV2odPc2Qp4RltSPOWOHT8T0MbsXImHgCALcGGKOQ8x1PMgYUPzd5Wcs+
         D8sDnaayIGL0eWMVrTNZ6FRAy5u+SZyFeio4/7N4YrILtPC7zXsr6oX0BvmWqR29rSGR
         1hl0biUs/U52ePd5L3zVkBauioE/KUu4Ix2BfEeRZA7PQUuKuZzDHhcfi96Qi94FqiQU
         etXw==
X-Gm-Message-State: AOJu0Yw37uQdjVkUEQjDjmQ8GWbFA2vpHXU/BB3DlxgtMYyiW5+0Mj/u
	Luc6dwJ9SYLkOtSAo++XnfPOvGcbd+kFLm7BA7S860WOnSFhUw6cmZ+TnQ==
X-Google-Smtp-Source: AGHT+IEBAKDdsZSwQPAWz6mqamIjStPEbCfhhwfuL9PEDbMl0zBAqpI9QNKYHE4o1vkJCw+g3TDpEw==
X-Received: by 2002:a05:6a00:138c:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-7241336bc75mr13776057b3a.21.1731254387389;
        Sun, 10 Nov 2024 07:59:47 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:47 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 10/14] can: netlink: make can_tdc_fill_info() FD agnostic
Date: Mon, 11 Nov 2024 00:55:59 +0900
Message-ID: <20241110155902.72807-26-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2800; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=rLIldrUZ8vWf4bt1AuzN1DhtyfJt7xyDiHgy9e3wVGs=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN4Lm3dbYOO3Q+xOLLdvfSkhbhmVd0mTrv2J0r03Ky 94z7H9WRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInc1GT4X9ahKvwtni3i4ZxH 5wOeP1vpOW3rh4mGUblv9At5TDj2pDAyHJvcfeSQ08nkz47GDCw1v552PO7jctWp4g5d/LHSX9i aAwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

This is a preparation patch for the introduction of CAN XL.

can_tdc_fill_info() depends on some varibles which are specific to CAN
FD. Move these to the function parameters list so that, later on, this
function can be reused for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 1809f5e53a75..6c3fa5aa22cf 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -498,12 +498,13 @@ static size_t can_get_size(const struct net_device *dev)
 	return size;
 }
 
-static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
+static int can_tdc_fill_info(struct sk_buff *skb,  const struct net_device *dev,
+			     struct data_bittiming_params *dbt_params,
+			     bool tdc_is_enabled, bool tdc_manual)
 {
 	struct nlattr *nest;
-	struct can_priv *priv = netdev_priv(dev);
-	struct can_tdc *tdc = &priv->fd.tdc;
-	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
+	struct can_tdc *tdc = &dbt_params->tdc;
+	const struct can_tdc_const *tdc_const = dbt_params->tdc_const;
 
 	if (!tdc_const)
 		return 0;
@@ -512,7 +513,7 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (!nest)
 		return -EMSGSIZE;
 
-	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL &&
+	if (tdc_manual &&
 	    (nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MIN, tdc_const->tdcv_min) ||
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCV_MAX, tdc_const->tdcv_max)))
 		goto err_cancel;
@@ -524,15 +525,15 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MAX, tdc_const->tdcf_max)))
 		goto err_cancel;
 
-	if (can_fd_tdc_is_enabled(priv)) {
+	if (tdc_is_enabled) {
 		u32 tdcv;
 		int err = -EINVAL;
 
-		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) {
+		if (tdc_manual) {
 			tdcv = tdc->tdcv;
 			err = 0;
-		} else if (priv->fd.do_get_auto_tdcv) {
-			err = priv->fd.do_get_auto_tdcv(dev, &tdcv);
+		} else if (dbt_params->do_get_auto_tdcv) {
+			err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
 		}
 		if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
 			goto err_cancel;
@@ -630,7 +631,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		     sizeof(priv->bitrate_max),
 		     &priv->bitrate_max)) ||
 
-	    can_tdc_fill_info(skb, dev) ||
+	    can_tdc_fill_info(skb, dev, &priv->fd, can_fd_tdc_is_enabled(priv),
+			      priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) ||
 
 	    can_ctrlmode_ext_fill_info(skb, priv)
 	    )
-- 
2.45.2


