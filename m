Return-Path: <linux-can+bounces-1012-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9AA93D976
	for <lists+linux-can@lfdr.de>; Fri, 26 Jul 2024 22:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD5D5B23287
	for <lists+linux-can@lfdr.de>; Fri, 26 Jul 2024 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B7153804;
	Fri, 26 Jul 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EDh3v0EF"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817F150990
	for <linux-can@vger.kernel.org>; Fri, 26 Jul 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024010; cv=none; b=rNMWtRR+eFr8jFijMDxn0IO8x5hSiWTX5jlzDJNgXoTBqOnfdLoJkmHOtzPg7KCOB8IW/2fasjkV/ksWDOOeEAMJSiC8Wf/KJojTRGJF0ItBcDqXbkkdGXYjy1aB6VE+EsoDHhOYfJqGH8nBeNjxt5ZK6RGGglEboFAVOCPsWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024010; c=relaxed/simple;
	bh=t6EwZ6i4na0n8NMTSrZB1GIshA5X1Zsp8851eUofPjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQq/FbBlWu5VQGOFLxlUjMXSMd32Mfi7DKJk2YGMYKbRY52FfyrqKu3sQ9VlsAfFdUT5/oVqr3M9V0Qzg8KBAxckY79S93TRUhNcVaa25Me//FFji84dvO6j5NZhASy23zIoBJkKjZVu4U6Yu/rdrTKyUGDDjz6LYWvittsbozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EDh3v0EF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so2577166a12.3
        for <linux-can@vger.kernel.org>; Fri, 26 Jul 2024 13:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024007; x=1722628807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6vACS09qfMp/6TXOWUchSNtennyGoJCWfR5pa4HeUA=;
        b=EDh3v0EFWYqQmztkws5YnVxrv1SuxKZ8kmQRNhuc5bTBh/bYHU37tPzY8fKgRtfVyN
         2xIylUEHb2cLXibbi1af4e9HjV+A8jnEhnwBXncpSIdYUxnJl5R6d0R/RDpPnKTJoeEX
         Rd223ZHVWOSba2uKp2XM1rpY4/Ghxp6E/P7t2uQFjwHX/X7JeAznwy4wXkvm7ORml0p9
         pCSmBNAx1QoywM+k3EhxU2QAFLVHiU8zkkvcBKkrKZCL4zZQ/crpYlM4RVj/0t8SDADP
         RXhh2gl+8gpoVAD6qfu2aiGdZ/2DLMRLrWJe6EQKC7otVZ/jWcBcFR10yCCt+SeLp8OP
         I8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024007; x=1722628807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6vACS09qfMp/6TXOWUchSNtennyGoJCWfR5pa4HeUA=;
        b=W+h1K1oKDYB8HMSiLsj2AZD6jJ/m1Ix+Jzy5m0Td15gdcky60Dh3zUKDlpeTN0kaP+
         SvV8GgQk86gsk5kGcqMylopwOB7FI/Hvjvrckjt2Hn4FW+OH56ry1/tOJArEqMFeY7+U
         ChyqaAnA0+XZtnQ4coMFzF2Ex6d8TQkaifNAQ6aKrGrduvrwpOgvuNErcqJfyG4lL9X0
         ylg6Z6+QfJosv3E+rPFn9j1r9jHvj2Hp5NVz9mddAbl9AaGyZY3iLob4wLt+Hh5wjuXL
         HHtv+mhdN8l/twzN4okjQlK3ihIWDGIX7RXQoOMYV3DFFW6ClglnKkwcH08XG/LFnS6v
         vkyA==
X-Forwarded-Encrypted: i=1; AJvYcCWcF8YnbP+B8DoJoywWnKrziLn6eWcikhLucnDqY2VlGXsLAUJ1Z0Dz7XU9FK4XOOHtVrUJ0zG1RRyM2t/HZXQzMUUuku5R6c1l
X-Gm-Message-State: AOJu0Yzj/EUgYFmccUd7E77KJ/GW8FUq5WW+ySqXKDAmtFqcY8KyRwpG
	Pi87q9MADj66/CXQ4hr0b+cWfNQURpXAEUVq9Rxx/Fu87RnDn192dtQHsnLIleM=
X-Google-Smtp-Source: AGHT+IEvy1txv1WUQfzxlMFCu8wRQC6RbvPsAnRENjxXb+mowGIzRFW6VNoCJbR9EDAeoYQ9pEjbew==
X-Received: by 2002:a17:907:7e92:b0:a7d:33f0:4d58 with SMTP id a640c23a62f3a-a7d40128730mr45428566b.48.1722024007043;
        Fri, 26 Jul 2024 13:00:07 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:06 -0700 (PDT)
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
Subject: [PATCH 5/7] can: m_can: disable_all_interrupts, not clear active_interrupts
Date: Fri, 26 Jul 2024 21:59:42 +0200
Message-ID: <20240726195944.2414812-6-msp@baylibre.com>
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

active_interrupts is a cache for the enabled interrupts and not the
global masking of interrupts. Do not clear this variable otherwise we
may loose the state of the interrupts.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index e70c7100a3c9..bf4a9ae76db9 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -483,7 +483,6 @@ static inline void m_can_disable_all_interrupts(struct m_can_classdev *cdev)
 {
 	m_can_coalescing_disable(cdev);
 	m_can_write(cdev, M_CAN_ILE, 0x0);
-	cdev->active_interrupts = 0x0;
 
 	if (!cdev->net->irq) {
 		dev_dbg(cdev->dev, "Stop hrtimer\n");
-- 
2.45.2


