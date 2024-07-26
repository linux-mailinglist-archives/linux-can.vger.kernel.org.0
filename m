Return-Path: <linux-can+bounces-1009-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA89F93D96C
	for <lists+linux-can@lfdr.de>; Fri, 26 Jul 2024 22:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97346285C63
	for <lists+linux-can@lfdr.de>; Fri, 26 Jul 2024 20:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B4143748;
	Fri, 26 Jul 2024 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XeGNwk76"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C913A40F
	for <linux-can@vger.kernel.org>; Fri, 26 Jul 2024 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024004; cv=none; b=m/kdWV9x3RzCogCG3exXWgOwbIju0vG7dhZ7oroc0//xTblcCm5W0NHPZvkznwiFm1Gwww1jG7a1DY/T15QLqA8B7KbeUgGwto+rirSGA7SaA5Uj6TlE7uQnQ7H2uSZhdz2fV4tJrgGz1Wx6HpHdaSBO8OaauXLKjvnFpEoFYh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024004; c=relaxed/simple;
	bh=umTkgL20LJJ5BJ5TMY3wbVVZSYY4K2TQqLUKPlJzF6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hX3VYQl1nVVHe2sg4lP3nJF20cfiBi/gQCWfN4geV+hHTFQFDMNlM4/K+lkxxqeMwDdt0czqZwXrrAmvPIqLQnYP6G579X1GkntxbMPKrmyzZUnndfs7Lu0Y8sxMWcgZFClxmT+yJ8hFLHYjHc9y+Vz9RDN40nK/juGtTlscPyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XeGNwk76; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52efbb55d24so2611235e87.1
        for <linux-can@vger.kernel.org>; Fri, 26 Jul 2024 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024000; x=1722628800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rRANtn5FFSQpIi4AkDQO6AI/rum9i8w5k7JfryoiRY=;
        b=XeGNwk76gxDVusoj/Y2TjLDt1/jG130lyY33Z7QsYOFtFv6quscWEU1Kq2TSR2zPTk
         DsxWKSn3JPj6FgaRW1gMmLmlyFP8XMc02jJvNkzWF06Q2qWrhLZhgC3NLgyjoUrqCTwl
         xJV6v3dTJXtX3u6rBT9PLD1Z8khP/p/FiRfsrpUt8SFsvS8vflYbn8fV7cvW8cTaNXUE
         uTCOQef5XDrBA+Rp/XrTmDSGnOyF1ZSxLz3p6quvyAAzalbrnfCZ5t9avdsSCQ4uWCh3
         7JD+hcrpJfyNtRw80aO7w1U7lMkydX1EqAHTd4LiqkrCnqWetqlnUhVt16TdW/4vCwjk
         ESQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024000; x=1722628800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rRANtn5FFSQpIi4AkDQO6AI/rum9i8w5k7JfryoiRY=;
        b=D6U66LQGw2USvdgm238oSmq+6Mb3oWL7TAe5tgh+ByOiPrfZnjSGzdh85NiQ2DABaR
         Hj8q4z4lyLbyOx9ieku8An9cpLnK9MSAeV5A/IH12x/foNsXC5TBkD2VLQ1TaUPYqbHZ
         +Ah0OuIaAKOfFfOCebjuCFIDP/xG9JrMhdJD8N6oceKIupWReBOjLesT3K8zFIMF1wVE
         6/84DXO6OyJuevy+trpQ95EeZFTIejSw/fg4IrXp0u3qAG69MGU/NnjZ8oGFfdceG7bv
         1Eb76eawRvfkdFlQyJiuYielPtBDrJbzk73VtLCBVwJHLldyyQQBjUD1pUWJ6KwOcsPy
         7+qg==
X-Forwarded-Encrypted: i=1; AJvYcCXAqaU6CGuxnk0q8+38JvFD01QD05ECFBdGejdujjYGZ/CzSszKVoHLOP4U5m2mWS5TXjJaADkKcORX0Pq0QgeaJeTSHnoTbXYI
X-Gm-Message-State: AOJu0YypbBNys4NfcfbPeIvY687hLXQ/AGamh9e34ldJ97BOvRQGKV/A
	vLkYbRoOgEVcwxzgCmJnnbsqcP+9d23RCwJiHMHPD+tiPLDian4mdxNpzBUIRcI=
X-Google-Smtp-Source: AGHT+IFqyJeT7Bd3hBXayuB7ciuhZR22Sas07xipqxPU0HZelY0F87AGXarcmLjhetiEv/Y3obpt/A==
X-Received: by 2002:a05:6512:2c96:b0:52f:d6d0:fc52 with SMTP id 2adb3069b0e04-5309b269222mr656156e87.6.1722023999888;
        Fri, 26 Jul 2024 12:59:59 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.12.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:59:59 -0700 (PDT)
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
Subject: [PATCH 1/7] can: m_can: Reset coalescing during suspend/resume
Date: Fri, 26 Jul 2024 21:59:38 +0200
Message-ID: <20240726195944.2414812-2-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726195944.2414812-1-msp@baylibre.com>
References: <20240726195944.2414812-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During resume the interrupts are limited to IR_RF0N and the chip keeps
running. In this case if coalescing is enabled and active we may miss
waterlevel interrupts during suspend. It is safer to reset the
coalescing by stopping the timer and adding IR_RF0N | IR_TEFN to the
interrupts.

This is a theoratical issue and probably extremely rare.

Cc: Martin Hundebøll <martin@geanix.com>
Fixes: 4a94d7e31cf5 ("can: m_can: allow keeping the transceiver running in suspend")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 7f63f866083e..9d7d551e3534 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2427,12 +2427,15 @@ int m_can_class_suspend(struct device *dev)
 		netif_device_detach(ndev);
 
 		/* leave the chip running with rx interrupt enabled if it is
-		 * used as a wake-up source.
+		 * used as a wake-up source. Coalescing needs to be reset then,
+		 * the timer is cancelled here, interrupts are done in resume.
 		 */
-		if (cdev->pm_wake_source)
+		if (cdev->pm_wake_source) {
+			hrtimer_cancel(&cdev->hrtimer);
 			m_can_write(cdev, M_CAN_IE, IR_RF0N);
-		else
+		} else {
 			m_can_stop(ndev);
+		}
 
 		m_can_clk_stop(cdev);
 	}
@@ -2462,6 +2465,13 @@ int m_can_class_resume(struct device *dev)
 			return ret;
 
 		if (cdev->pm_wake_source) {
+			/* Restore active interrupts but disable coalescing as
+			 * we may have missed important waterlevel interrupts
+			 * between suspend and resume. Timers are already
+			 * stopped in suspend. Here we enable all interrupts
+			 * again.
+			 */
+			cdev->active_interrupts |= IR_RF0N | IR_TEFN;
 			m_can_write(cdev, M_CAN_IE, cdev->active_interrupts);
 		} else {
 			ret  = m_can_start(ndev);
-- 
2.45.2


