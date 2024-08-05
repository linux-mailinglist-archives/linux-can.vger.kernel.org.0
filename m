Return-Path: <linux-can+bounces-1118-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1986D948197
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 20:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD33028EF45
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ECA165EF1;
	Mon,  5 Aug 2024 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HN7DwQpf"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A11667E1
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882678; cv=none; b=tf7UcGmnGHIpX0ytflrHdUl13CpJ2Sd1Ndrh96i+DjymBuuHuHFFtFxwHD/uPKhwzNNW5CnVpV4UN/YK3X22ggYe6/f8ZsTocgaSK7w1vnf+aMtWy017+Mi6Y7QHs6pRkadskcTusvTb2vyTqQMTwmM7dTwkYvH8XiCFq1yQTw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882678; c=relaxed/simple;
	bh=X0Lb8mIRnjkJhheZaa1C9/ChMOXWk5LNcIzDjYItBcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGfilLBwEDZ38Xa3At2ccFrtv9z8orRMjSNKG42OdLsBZIXUrvrVEyscxBKvbtbB8E0bhQZepqvcidniC1XRSryBjLOVIi6xie0hTgdCCaefQsfFrSMcKWiFF8cg3urib4wOwyA9oGsoMCUdZbDUFA7wJX45cribW5xTWQLABes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HN7DwQpf; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39b38295008so8129535ab.2
        for <linux-can@vger.kernel.org>; Mon, 05 Aug 2024 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882676; x=1723487476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RujnloDbg8cFq7uk55+LRxz/Crsv4ySF/ZqdPlHzEpI=;
        b=HN7DwQpflzpLuyP5NygpOyO7QqkBpC4FVYuyDb8ZrCNP/dmaqkiTb1/a/wndCCmV4V
         Jikb0MF78zkhUw08Cesz/UIOSa9GVbbWioHlJoy4xL5ZGRp4fri93KujXiAbwcsXDSwX
         dO9q05hGqsvqCt64G8cAoGqgc7KQPm/aDW50RYDtaEbIrS9q/l3J7/lYZPp4aJC7cqLN
         jnmIFHSoMfLQXscaKRdrlwYM/1UYsdDDFPxWNWD4DcgeDS7wz9Qlu8EErLU12FhvpN7o
         a6/Pkq3Y/X9MklUJy8jXnL66ZZr3P2jMPqwiaap2phRs/XVlIDNZDVdZFV54SDCmZIvQ
         H6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882676; x=1723487476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RujnloDbg8cFq7uk55+LRxz/Crsv4ySF/ZqdPlHzEpI=;
        b=I0VvG1ooi4H3CvnZ+ScPlylmaMw0MZkgBswg//sGue/0fKKnpexGXwbZZkSeI1/SaA
         ubVPUVQUlO2St/P+tOvvFKu0wx96C+2LSL+ukIm7UdqSoYOx1tKZJtJHv/w9RaCiVfH3
         Wj+tBnchFRqQOfA51Id9NHGfarTHWA/J/ST/f9+k5PkTrZYyEmtNK4K4CpgOkT3D/sqN
         wQZWDOGIVyerN57gUhERlNjeKkMmxJJuf6Xa6I9VDxUNHBzaCd3s0CFUr+7XS+FjYgfj
         pOQOFC8kKoNuwxAZeczBaNjXCDb0VbbaK4+77RGqJEo5zDETS7DE/5vgu0g+9+uyOCYI
         YMww==
X-Forwarded-Encrypted: i=1; AJvYcCX362+FaZykB0gwsTKavYJbVr1PWs+eJBFFWj9pVs+xk9p4pD36JUyPerOhOFvrE39f7gmylYy5jA5P2LCJPvjpUcfVE/hAwdbX
X-Gm-Message-State: AOJu0YzsyBbxkMDHhAgaWe4uqyH4RZTR/zFeA1aJd+SGliU1LnJD86ez
	p9oppKBD9/+z21YQEFZU15/ccYKHRH5suxSePOWH1hYQaFUQdwlgXhycKMFrwLA=
X-Google-Smtp-Source: AGHT+IGK/3ryl1QS+GGbx6p/ssfqROsmqw17pu1CF1Hk361QOM09xOIdr+6PvE5wAmPwTPNRUkFcmA==
X-Received: by 2002:a92:cd8e:0:b0:39b:3649:1b68 with SMTP id e9e14a558f8ab-39b36491d25mr111508215ab.13.1722882676415;
        Mon, 05 Aug 2024 11:31:16 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:15 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Simon Horman <horms@kernel.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] can: m_can: Remove coalesing disable in isr during suspend
Date: Mon,  5 Aug 2024 20:30:42 +0200
Message-ID: <20240805183047.305630-3-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805183047.305630-1-msp@baylibre.com>
References: <20240805183047.305630-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't need to disable coalescing when the interrupt handler executes
while the chip is suspended. The coalescing is already reset during
suspend.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9d7d551e3534..fd600ab93218 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1223,10 +1223,8 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 ir;
 
-	if (pm_runtime_suspended(cdev->dev)) {
-		m_can_coalescing_disable(cdev);
+	if (pm_runtime_suspended(cdev->dev))
 		return IRQ_NONE;
-	}
 
 	ir = m_can_read(cdev, M_CAN_IR);
 	m_can_coalescing_update(cdev, ir);
-- 
2.45.2


