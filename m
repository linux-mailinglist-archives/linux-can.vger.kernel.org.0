Return-Path: <linux-can+bounces-3193-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D63A6D945
	for <lists+linux-can@lfdr.de>; Mon, 24 Mar 2025 12:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF1C3AF759
	for <lists+linux-can@lfdr.de>; Mon, 24 Mar 2025 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E345525DAF7;
	Mon, 24 Mar 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpRkCDX0"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E92C4400;
	Mon, 24 Mar 2025 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816684; cv=none; b=JljdzKhUWfH9eikDVkpOxeS5H10YJflDPQrNVSdezkJXJK0L8IdKSEuXGrqDGjFHJqxduBU7ZLvKMz4xhS1dno98k+5iFy8R1w1d3j+iujMk56HKRLXINmXb4LhEEOvDjNl36SbCwlreGgLFvOLNgYVdATRia5M2WVxzUPt1ydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816684; c=relaxed/simple;
	bh=aH7jqNfcPpylN30vQMLnJO5n2GS+8MCwZkeDGGutTak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqfgEdKLhSBMNpbstuBG8mnUXvDra0khpikWQ7xoxqU5hwCDe73NhhI2PRVRD3oghgKPHOy8Gg2KuhI2LnDLknQcYs+L3DI5glhdwwO6Mpjz8s76lbLDFKdHBfdXznVDP0s3lJzyf0WQWN1YwbKHDOcYFtqWofpqgLC/Zb1r9Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpRkCDX0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22548a28d0cso74756135ad.3;
        Mon, 24 Mar 2025 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742816683; x=1743421483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FclWDOpQYZIOEMCx+3mDgK8c9fGIMqHvQ2gE2LcXKrg=;
        b=bpRkCDX0Z9TTiyiLniYc0WSWcC2q+Tx9VqirpaBvGDh4zSFWa4DyZLfl9aVEeXMeLi
         G0AG0NLJsgnvprMZk0QpDdr8W0xZaPePc8Pw8fOUR6wZyBIjR/SUEvJ+LdHOOfsf4vDV
         WpI8cRPu7OliP95r0+bdUch2UsDshsjb6bUS1uJ1WvfVg57qWQ9O1PJJQr/t3Mikhi6J
         B/9Xhrz8jyexi3N4FCT08iQ65DWETsDoOlIlw3I6nvV+yBQhdmEuok3+MxnG4bdT6rGt
         BzvQQ6LDxorXEkNBW4GzTyXtvKiwtrjopBJ1XdvxCZyc6I8JIiXcqEiEpQnEU2eZfVar
         E7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742816683; x=1743421483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FclWDOpQYZIOEMCx+3mDgK8c9fGIMqHvQ2gE2LcXKrg=;
        b=gq0/dwUfVTGHU0qNZCnoTFRtlH/acrd9QwgiiT0q+xENFVQ1pYJjKAZo7XTotm+cUa
         fpK8/e4HQ7kWlkpFVQTXDm0mcSz56OLMkyNTQtctk3kvVwbi7n6yw9OQt+b6yeCA97Kf
         YRKqcDjPArm6uEVi6YtZmrAi2hdgtc8VnDDIlTnJZ2O+4AylmilyE1ZCZbbHnJpX6Bri
         iXMVSFb2RCM6Tl2Otmw0FBWO6iBUI7ePO4kU9ilI6Uo33uJ/TEHth5/BQEIDucD8cOpP
         6tdPwsDHSLmfzjeis6jvAoEDt5Ablaq4gf6rNDxRa6JnP6WfOveSG0YemBXFRBvsxSML
         rdXw==
X-Forwarded-Encrypted: i=1; AJvYcCUxKkYnhkM7IwQAqXTgQWQ89MQwUZZDpWkLjELTFtW6zBaSOq/duoFn646cFsUKfYJ85IUJf7NTPNoUftEq@vger.kernel.org, AJvYcCXs3fOqRQNIVK8Ey/HMoG2ml8W6Q8sl2KbcRC0/84z9ADW5Uo/GMpupheq+as3E/n3axd/zV8E0giA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSt3OfyvKqJGagd1DR3gvofBrIetC7e8c90dCAsfQMlqJDVDh
	AzsqUBAgJZEh+4IMxsFahug7ZhAhmj3NRg1vu9dA2NPw7CniWboE7L6+8CHeXAg=
X-Gm-Gg: ASbGncvIXN+q8MVxkqH3Yh7FoxtFs1leL2DySZx61v3FqVRzQJnPAT4x5s4J0KGppIZ
	A15jESc/R9E1zVINq7CbjuTHVFgnr7NxiE5ZJTZoWjEOuGbzYXAG5M3ikniI4ZxAWnDsd2w3R25
	+jAac2aC0EZGpC5xwpRpTZ5pQCv2XFdk8fagjUZuPd4MSkBGReLAvpe8aANa+OEXIUgADTPqhKo
	AH3zZvbh0qC6vBvu33bIC0LlZRlVh2JGxZEPKWbSqQ7ZpobZXAGSLH1tIuKt/EVJxAE7bW0bO8K
	mzkU7pWA703FN0pX3/O766xcHmi3PeoIfOKqAI+93l5Dr6YVBofSayjC
X-Google-Smtp-Source: AGHT+IG0hePrJhwSgn3rCtEA92WDnZVJ/VYMDjPzw/eThcvEnlBPxwvaFn6CraVYwHOXq4RoU8sdHw==
X-Received: by 2002:a17:903:292:b0:220:c813:dfcc with SMTP id d9443c01a7336-22780e08cf6mr223591475ad.40.1742816682459;
        Mon, 24 Mar 2025 04:44:42 -0700 (PDT)
Received: from ownia.localdomain ([156.226.172.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3b242sm68618715ad.41.2025.03.24.04.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 04:44:42 -0700 (PDT)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Heiko Stuebner <heiko@sntech.de>
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Weizhao Ouyang <o451686892@gmail.com>
Subject: [PATCH] can: rockchip_canfd: fix broken quirks checks
Date: Mon, 24 Mar 2025 19:44:16 +0800
Message-ID: <20250324114416.10160-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First get the devtype_data then check quirks.

Fixes: bbdffb341498 ("can: rockchip_canfd: add quirk for broken CAN-FD support")
Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index d9a937ba126c..ac514766d431 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -907,15 +907,16 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	priv->can.data_bittiming_const = &rkcanfd_data_bittiming_const;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 		CAN_CTRLMODE_BERR_REPORTING;
-	if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
-		priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
 	priv->can.do_set_mode = rkcanfd_set_mode;
 	priv->can.do_get_berr_counter = rkcanfd_get_berr_counter;
 	priv->ndev = ndev;
 
 	match = device_get_match_data(&pdev->dev);
-	if (match)
+	if (match) {
 		priv->devtype_data = *(struct rkcanfd_devtype_data *)match;
+		if (!(priv->devtype_data.quirks & RKCANFD_QUIRK_CANFD_BROKEN))
+			priv->can.ctrlmode_supported |= CAN_CTRLMODE_FD;
+	}
 
 	err = can_rx_offload_add_manual(ndev, &priv->offload,
 					RKCANFD_NAPI_WEIGHT);
-- 
2.45.2


