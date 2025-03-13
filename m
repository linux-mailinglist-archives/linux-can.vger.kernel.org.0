Return-Path: <linux-can+bounces-3052-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0901A5E93A
	for <lists+linux-can@lfdr.de>; Thu, 13 Mar 2025 02:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4993B846E
	for <lists+linux-can@lfdr.de>; Thu, 13 Mar 2025 01:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B766FC5;
	Thu, 13 Mar 2025 01:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWST81A1"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECA12868B;
	Thu, 13 Mar 2025 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828512; cv=none; b=sAK+eppJ50uJWo1mrSlcK58TuS/GL23Mufjdi9ERvj6Bf/MnbYHKLK4YEpYl8ulA+ScNRoFK6xzxTZsVJWMXN94N6d4g5b4DDTrzyPnkrLqEq4s0YJk9mThPPeVLO68u0GJ8nJg59dp8bF3t9a+w9ikLDJtnIJAEZ/+P+PojlfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828512; c=relaxed/simple;
	bh=P+4AM5HRF2zbjRcn8ySbDfLqoLWfeET2V3x8L7ECH7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePcj7+781AjEO4lwMceNTuqG7WgfzcljMTAUwkslxEAxDNjVsN7AeO3NpTfvEMFjavbgQvq19HBA/jbv+QMn6dFBiC6RK2/vdbEdGvBp1+4LtmpjXYPZ0H4jJAfo+RVyAqUmalfbe15UL1qQm3JjKkOm+cL8dTKetXeEr072vbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWST81A1; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e241443e8dso717746d6.0;
        Wed, 12 Mar 2025 18:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741828509; x=1742433309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CplJ4qBm1rlLiAX8XwqfY3czuxTznGHQa5yRNrScf2Q=;
        b=kWST81A19TNqSIDPcTTVcEgf27QXeAMxLh3jBYhWDGpPdGO+OrGEISiOCcf6RGobyE
         be3VBHqccI9jcgNZCfreyXPeDnR4JJesVZPy9wGl3uqX5zVN0XdbgbSfZxd6UYDDrQkz
         eJdvhEMrhB0m8DzbCGNpUwtlfps9xMmO/gDigamfODnNiaPSj4aT/K3cvs+u/6VSErJN
         WcmaBMpzVjWjlVrsNa1M7tkgq+Fv54j13Ieg1vyVnOr1ZawAcyDC3CcfbAhkQd0091XW
         u52nzNfKfa3kej7yaqMxqPBsEBRHkZN3Q6gO4GFKEHfBVp824D08ECar9HjIHtAPuFd6
         AAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828509; x=1742433309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CplJ4qBm1rlLiAX8XwqfY3czuxTznGHQa5yRNrScf2Q=;
        b=hevr7KIHLIXDdJq29nDQlYFXP/MiMrP63aLPbZXTKuDMcf1E3hQb+wcBhc4oeC6ruJ
         C6cum8FW8KRuF8qsgHp1rWa5C3xWhac4XvIbkuiYMKUDml1avWU+cXWYuGSPHnDYhtzo
         5kXluLPB2bvkn0wmcFlOHdAY0ULjndGwqhL15eQtSvpXmSwfJtOm7JsWftdMLuQvQeIu
         787OZ2Nf/EPy6pRknYlSgR59883BjGPAVmGpprSIS15J0dRAELYIUa/EHWQZlG4YsciT
         GBCGscSo75Yepv90cBx+p/y7PPQVn4E9ZT4CHIipAnX6QEd5WPEFP38m65n773IpC19s
         cSXw==
X-Forwarded-Encrypted: i=1; AJvYcCWaoolD55yslfkMSyodG+5HnXskUG0uYs21ikhiX3SyjfDrkirDjsbR+16mcfX9pIM0RSjGPoAolG9V4Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcoyyjC7Ns0hxXCb6BmQcaLHT9i1v2JKA/bkNEDaAt8yLJ43bo
	3tL1+Gz8xumw01pfXkIgMU3woEXbxPUyqaWmPK/Ibb/WicXzaX8=
X-Gm-Gg: ASbGncvB8gUWy8eSWjQMRSToBTAYk2Kf/zooq4xTS0cY8PEf7uLyid7JlX68H4F4lZy
	MjVKic3Xzwk5BCl5/Cksdg+vfxq8DnHv+iRnKs8HItKNvg4T2ZdGDMkknHDZsvU/qwPbhRlZLu3
	HBVHEtJg8vrHuyyherJ63+O9db8rqrrO7599hjxq3tL79w56Ua0BI1FFR6jfUNpYQccLywOUdzM
	PIlxGGpO40/nqCVWey7M92UadgaFKXKZ+L0EYwyTNexBm9q3AQMW8DxF1zBLyaaOVHybZn5YZBg
	CfWQOsWpF1L2faz36+FYq4VnFhEeluou7x3naW+dAA==
X-Google-Smtp-Source: AGHT+IHkt7gdCvT3sZMm/MUWsh89g+gMdYyxh1jTYIM+y9Ksbzc5TpKWzBj7zvLRqPmZLC8TC+4rDg==
X-Received: by 2002:a05:622a:2b0c:b0:474:e7de:8595 with SMTP id d75a77b69052e-47666ca49c3mr100937371cf.14.1741828509184;
        Wed, 12 Mar 2025 18:15:09 -0700 (PDT)
Received: from ise-alpha.. ([2620:0:e00:550a:642:1aff:fee8:511b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb6082d1sm2428761cf.12.2025.03.12.18.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:15:08 -0700 (PDT)
From: Chenyuan Yang <chenyuan0y@gmail.com>
To: mkl@pengutronix.de,
	kernel@pengutronix.de,
	mailhol.vincent@wanadoo.fr,
	heiko@sntech.de
Cc: linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chenyuan Yang <chenyuan0y@gmail.com>
Subject: [PATCH] can: rockchip: bail out if skb cannot be allocated
Date: Wed, 12 Mar 2025 20:15:05 -0500
Message-Id: <20250313011506.3132295-1-chenyuan0y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL pointer check in rkcanfd_handle_error_int() to
bail out if skb cannot be allocated.

This is similar to the commit f7f0adfe64de
("can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out if skb cannot be allocated").

Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index d9a937ba126c..90395cbdaab9 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -551,7 +551,7 @@ static int rkcanfd_handle_error_int(struct rkcanfd_priv *priv)
 
 	rkcanfd_handle_error_int_reg_ec(priv, cf, reg_ec);
 
-	if (!cf)
+	if (!cf || !skb)
 		return 0;
 
 	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
-- 
2.34.1


