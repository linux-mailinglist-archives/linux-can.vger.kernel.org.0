Return-Path: <linux-can+bounces-2000-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C77B9C5DBF
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90571F21CFA
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F00C21315C;
	Tue, 12 Nov 2024 16:51:45 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60D2212D3E;
	Tue, 12 Nov 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430305; cv=none; b=EO6Vt5lCVPdYcYgSUZfLZA2UNs1R2nLcPkwYQmempewB3ldNBCmyhYa6PAkf1s/fWzRXj4pNtKMg4ntEyWYkGMvoau4uj70pkqqdLHrNFvU6C4B4wtAGRw9ooPnB26U2yvXiuPLE3ymsPVkvvg3XIKLhKK+E+1A/0PP+xPQKQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430305; c=relaxed/simple;
	bh=ge6WToV2LD3RgxXc7bfGJlRMQKEfKVqLb33pph0b678=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coVJGVPUcy+LTQGvqlsTq3qrc48d7OpCUHJQX7lutGkMAUMPeEkoIhHhrGl71T/dKZlRuJ9P75oYI51Rt1YAg+HlCd7xvtGIpWJ9hfnn2a4uCWxEmAmlhEAUEGkgv+MyKq7rSumfM/yO4w/94DhEPHmWkolZu7lNS839PmyJJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e467c3996so4788908b3a.2;
        Tue, 12 Nov 2024 08:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430303; x=1732035103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCNBJc3uUpKarH5QnEi/kXlb0a0dXh62yQ1NHQ7/+Wg=;
        b=j5c2MLgm9LM2jY9qlyhbPytkHNLaAlgmOTyNgbm718DEK7L8YmodcfO0/frm35+0yo
         jujdAMrVuyI9TgErdmAmxdEQBQwvvV0ebgzusRYPhUZkAsc4aimxXu0JKVvhiSnMrIWl
         +25svdRPbLLPYwV13DfunCb0D76k/FW1492DDxf6X7DmwBT6ev7RtiQDnxZqbuJ8lcop
         Ub/+8r47WalVImJiwzCHy6Gy7S0DHLuI/+0499U6A2ySvWt79rV8bf4lzTZbv7nzYJzb
         lyuD4wMwlIDJKw4yWADthwUgy9cF3/wgRql8bEXcSbpj7ilXBI+5BCuS/GwfHZPP1o6f
         KcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzL/4LOKxUMSJeWD4fPuDP7ZoNojFYfBmx+wNi81mMCPjhN5fPmchTphjlXoV3XjVkN/pIqApeGjnb528=@vger.kernel.org, AJvYcCXdx4cv9pfKuGnyQQ5VO1jsAFXKaBp9YJvonpy2ZZhjIhl/FWwGwmjon/+HXQN69OQmzEbGh2AM@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMCtyvrCI2q59yMjjy3DDpDXeNHiGXy4/OIinhmG13cHAkXeN
	0HamtsPZHOxC5PEuSF0dAEgBm+7l6ILan3kVZerV7Vo22FysANHTI3LvNg==
X-Google-Smtp-Source: AGHT+IGojFE8rKJQBBsF6z3vR9sMa07PdFrXTe3eJTCWnHtqaSAVMaYol+38slXcoet4/MbV7HRCuQ==
X-Received: by 2002:a05:6a00:1909:b0:710:5848:8ae1 with SMTP id d2e1a72fcca58-7241327d7aamr22368753b3a.4.1731430302857;
        Tue, 12 Nov 2024 08:51:42 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860aa5sm11271260b3a.32.2024.11.12.08.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:51:42 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 5/5] can: netlink: can_changelink(): rename tdc_mask into fd_tdc_flag_provided
Date: Wed, 13 Nov 2024 01:50:20 +0900
Message-ID: <20241112165118.586613-12-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
References: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=ge6WToV2LD3RgxXc7bfGJlRMQKEfKVqLb33pph0b678=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnG7e1FzdcYi8/NWHPxRsqxAN4lhdMOb1eLVb7bs6yDo 2FWrm9LRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIm8jWBkmJk00b14P7NpVPMC 7Y3brzS/SN/dpz5/g81xrwl+cZs7TzMyNO5z9PhzaZHbGZ55PcKz5rZVlNW4+GdrX90ZMOniGf4 0ZgA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The only purpose of the tdc_mask variable is to check whether or not
any tdc flags (CAN_CTRLMODE_TDC_{AUTO,MANUAL}) were provided. At this
point, the actual value of the flags do no matter any more because
these can be deduced from some other information.

Rename the tdc_mask variable into fd_tdc_flag_provided to make this
more explicit. Note that the fd_ prefix is added in preparation of the
introduction of CAN XL.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 27168aa6db20..f346b4208f1c 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -189,7 +189,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct netlink_ext_ack *extack)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	u32 tdc_mask = 0;
+	bool fd_tdc_flag_provided = false;
 	int err;
 
 	/* We need synchronization with dev->stop() */
@@ -234,11 +234,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
-		tdc_mask = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
+		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
 		 */
-		if (tdc_mask)
+		if (fd_tdc_flag_provided)
 			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
@@ -342,7 +342,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;
 			}
-		} else if (!tdc_mask) {
+		} else if (!fd_tdc_flag_provided) {
 			/* Neither of TDC parameters nor TDC flags are
 			 * provided: do calculation
 			 */
-- 
2.45.2


