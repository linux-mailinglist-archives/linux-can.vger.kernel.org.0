Return-Path: <linux-can+bounces-2075-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 711E39D0051
	for <lists+linux-can@lfdr.de>; Sat, 16 Nov 2024 19:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE2D1F22525
	for <lists+linux-can@lfdr.de>; Sat, 16 Nov 2024 18:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320A71AE016;
	Sat, 16 Nov 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KC447fUs"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7214D1A3BA1
	for <linux-can@vger.kernel.org>; Sat, 16 Nov 2024 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780196; cv=none; b=sGPBFXw0dK9LnGhOZOfzh/ss6kEOcU6rT6NuvvreRSvRq2a5OrKRtP/DQJ0M5wgpzz+7W6qiikyBJLuZYQPO2GJk5SzRo++ApRC6q3Lf0HglFSJ/qv4qhz+Hm/Q5hpp9OLUC92O//nGPJbx0AyQoSvdVOuFdhtRsG8wAXkbq2HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780196; c=relaxed/simple;
	bh=iVOkbe1eRnWeGsTAkh+kyxSnjEZFWE6KQVh2hr3CkMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM8aZoollF3pNFm8kIBKcN4Fy329ViZLuhIzZz9+slZEDcsXbmc0Cp/vk/rfV3pO6vr01IXtrCA7azMipTmPpFkI0+yVJP7lmX5YvzP+XLuJ+BpUaSFanwDfyKz28nw0VOR/PVU1O3IIFcs+RUeAolRmQZKrIfyNiNpH6v0iWBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KC447fUs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a4031f69fso454077266b.0
        for <linux-can@vger.kernel.org>; Sat, 16 Nov 2024 10:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780192; x=1732384992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1KN5qU2y25n0Oin8u2W01ajVRL3l5JZUYgBLtna1CA=;
        b=KC447fUsL8LwnpmfucdTwo0WlrEG83Da74tIB5BsC7E8xWn47ZcNLNSUbsGSztvXdU
         zsX07uTScA+wf3aZ7U2hOhW1k+StezN0wcUHaHR9JCpEIWtrHhTkrybJszUDRj9Qf8x+
         y2YULSNNzJphGose2I52z8dYmXnv6EHq5pUJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780192; x=1732384992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1KN5qU2y25n0Oin8u2W01ajVRL3l5JZUYgBLtna1CA=;
        b=N3jKLgZf76JlrWZ2bq3JoMIIDVBWQk01uhEd1HQ+NqyywLapf5h9VKDH5uIf87K6mp
         ufxikZDh9S5zNYcqflFpC5v39V85O/u6DhNkQaJkdRHCmPJ7KVTsAEYRwdpDjFJIEs9K
         YTqNnHI5wzywDvQ5LVddLxwUHRfxGA88GbBWEBAaDaUPD7Wan89/yBYG9aTOBfn247le
         k9n17s6JbKRcyGdU/kWAwh3IDJuobFegIPl1KRCY7LMKZsW1vIg5/7HSBjHUswpFfj3r
         BDA4riiGTE8vUP4pRGhl1TldV0u2oSZvqgBdqss5R6dLrZLUSDcrsZqBnQrJDFRLjvWy
         G19g==
X-Forwarded-Encrypted: i=1; AJvYcCWxJvQGKBUvzupScAeWw29CGw0JCMRq4UbXKBeeuquPfTm9byRaC8xU6/RxhxBYCVXk05GU/0BStxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv279CDsKjblL5M827nDO1ha/rKrymu9kA4na/Mn/vn/B0GjI7
	CgUpw8A1TWCiIniT9/XRI1ODI//ywUooe5b7HZ/kovB43D2Bl8fAd08RNsL6wqw=
X-Google-Smtp-Source: AGHT+IES+ynBAJVqc7eTqNBNioplQ+TxFxR95t5P1e/kKOcra0XnT3EiiSNrB4CCUflAKPlc0RxwSg==
X-Received: by 2002:a17:907:3689:b0:a9e:8612:eeca with SMTP id a640c23a62f3a-aa48352b54bmr627153166b.48.1731780192655;
        Sat, 16 Nov 2024 10:03:12 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:11 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/7] can: hi311x: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:32 +0100
Message-ID: <20241116180301.3935879-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
References: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hi3110_can_ist() function was incorrectly incrementing only the
receive error counter, even in cases of bit or acknowledgment errors that
occur during transmission. The patch fixes the issue by incrementing the
appropriate counter based on the type of error.

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/spi/hi311x.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 148d974ebb21..7a4d98037cd3 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -701,17 +701,22 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 
 				cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 				priv->can.can_stats.bus_error++;
-				priv->net->stats.rx_errors++;
-				if (eflag & HI3110_ERR_BITERR)
+				if (eflag & HI3110_ERR_BITERR) {
 					cf->data[2] |= CAN_ERR_PROT_BIT;
-				else if (eflag & HI3110_ERR_FRMERR)
+					priv->net->stats.tx_errors++;
+				} else if (eflag & HI3110_ERR_FRMERR) {
 					cf->data[2] |= CAN_ERR_PROT_FORM;
-				else if (eflag & HI3110_ERR_STUFERR)
+					priv->net->stats.rx_errors++;
+				} else if (eflag & HI3110_ERR_STUFERR) {
 					cf->data[2] |= CAN_ERR_PROT_STUFF;
-				else if (eflag & HI3110_ERR_CRCERR)
+					priv->net->stats.rx_errors++;
+				} else if (eflag & HI3110_ERR_CRCERR) {
 					cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
-				else if (eflag & HI3110_ERR_ACKERR)
+					priv->net->stats.rx_errors++;
+				} else if (eflag & HI3110_ERR_ACKERR) {
 					cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
+					priv->net->stats.tx_errors++;
+				}
 
 				cf->data[6] = hi3110_read(spi, HI3110_READ_TEC);
 				cf->data[7] = hi3110_read(spi, HI3110_READ_REC);
-- 
2.43.0


