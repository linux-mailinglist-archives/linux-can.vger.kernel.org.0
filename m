Return-Path: <linux-can+bounces-1014-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9F93D979
	for <lists+linux-can@lfdr.de>; Fri, 26 Jul 2024 22:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2221C233B1
	for <lists+linux-can@lfdr.de>; Fri, 26 Jul 2024 20:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF080149C5A;
	Fri, 26 Jul 2024 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NlYD3o0Z"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621314D29C
	for <linux-can@vger.kernel.org>; Fri, 26 Jul 2024 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024011; cv=none; b=b/fyZYfFbLIyZqB7ogF4RFAE8rynRx1WWtLCca+Ca4fOcqZnRukP49CwORF7qA7/pEaveIpzSURPDdbKsEgvcq5L2bQkxb/caeESWrudsOtYgcucqPkH1Zi5QoJ4j6PvJesyPYwKoyoIkhO8y5sVxGRs9FpIIKNVfGPP6+M5Rgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024011; c=relaxed/simple;
	bh=kgU2ysUlTalRtPMUoLD7OgezubN/PKKaPGTiUiaW48Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBu5ow+0fn0OB8Ex/XMuyw6GuyTXi1j+NDqCb5aJpvpqQMou5LXmCUSlJUs1e/s0liS7XVxZiEElsmp738Nf/S0tCv5M0OO9T8YbY3IBw17CJ51WWxch8azhnw57rgmcw3oUfmXGQEU/5L2xAGurrUo9cj2K5LLZ95N/NHMUohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NlYD3o0Z; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7a9e25008aso263919666b.0
        for <linux-can@vger.kernel.org>; Fri, 26 Jul 2024 13:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024008; x=1722628808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QclbSBAyJmUNV1FmC5rcCovTowLRmYkjOf848LBChQs=;
        b=NlYD3o0Z+f+qqZo503CsGvzWfjqwbQffSLp7v4bVtDGEAqtbj5HSGNxxXIQ3EYT0D3
         R93FAtVr02vR4SDdn0EOiveR4Ib4JikpmrGQJ4Ss4avFzBJknzUfUNMuEShCSbJ3+b8t
         x1xxzR1ZvJ2D4GiIHsLwDnJG3IsyDRscLBQRp5qRGOjhpkycUFaHBgu8kulP16AM4WD4
         hDH+kzrwCReG6tXU1B3qsA9XP/l55cPv3BWV9kjpBYIIc7mpm/eQjqjDqm73UU0HY4a4
         YcgQOK2hbACT2YemAX1E5i1FJKkX8e2R9lLYPzkWl6I2kT5AfI1z6s+bWkXlcQnHPho6
         XcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024008; x=1722628808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QclbSBAyJmUNV1FmC5rcCovTowLRmYkjOf848LBChQs=;
        b=CrNV2+6R2NhJp3B3ltHZmhdut9foYP6IJWaEUB2Fz2TIdxvVseTRfdv8dLHAbMtbN2
         ZvhX4a+7Kg7EfIHqm9vRSUQiUYsIIDCXn5hYXKzro3tJDrPlvOb58pA1GGybdbBpesz7
         1Qyf9EQAdst+eFZoy/1qfSSQkXLTg9xp6vbQF/pNDq/1s7KMalQOKfXQd3KgFyvPer8N
         HYyh2XHh5J4rsrRbbPWk1LpN1gUCMQv9GEfnOSTZU5VZz3Kta7aIs1Oc/qmb9Q4b+di6
         gbVgkiW+IWSwqdgEropL9AE9Ka7qBWKADxNbaOuXMz+1Avs3hnsa6UpOe8BLiEfzA4+U
         ssXA==
X-Forwarded-Encrypted: i=1; AJvYcCX0h6tMAApU1um4yWKeizlrx5lLcUtL/jZ3VimnVY/V2UKQb3loFChJAtzbszJWtU+zEckmerBI7eflQ+76RmDO8Vb0/RxMmRdZ
X-Gm-Message-State: AOJu0YxprNQm+pgGksvPj0HbuLxdA3Myqte2o7tUUSTv0GKK/a2Ku17g
	2rfbvl/++y4qrsU1BHxIlUKnkl5WnjtrnoIsbgTaHza/Er28uUnF8jdnB3PsSx8=
X-Google-Smtp-Source: AGHT+IGBz2/F4chosPYowE/GtxDK8/p2E686h0ildr36QYwqG2G1z5tpS2ZWzxOnfdGhbz9kV6ILlg==
X-Received: by 2002:a17:907:2da8:b0:a77:c824:b4c5 with SMTP id a640c23a62f3a-a7d4004414bmr37367666b.18.1722024008110;
        Fri, 26 Jul 2024 13:00:08 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:07 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] can: m_can: Reset cached active_interrupts on start
Date: Fri, 26 Jul 2024 21:59:43 +0200
Message-ID: <20240726195944.2414812-7-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726195944.2414812-1-msp@baylibre.com>
References: <20240726195944.2414812-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To force writing the enabled interrupts, reset the active_interrupts
cache.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index bf4a9ae76db9..7c9ad9f7174e 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1542,6 +1542,7 @@ static int m_can_chip_config(struct net_device *dev)
 		else
 			interrupts &= ~(IR_ERR_LEC_31X);
 	}
+	cdev->active_interrupts = 0;
 	m_can_interrupt_enable(cdev, interrupts);
 
 	/* route all interrupts to INT0 */
-- 
2.45.2


