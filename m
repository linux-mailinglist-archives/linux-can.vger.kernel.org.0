Return-Path: <linux-can+bounces-2188-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067339D65A8
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDD9282253
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D781D2F54;
	Fri, 22 Nov 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KZZfyM3k"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E671C9B62
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313823; cv=none; b=BQHw+lOrBTyN/5iSTrkpOAytz4icYsWxXFiHmbfkWuzk7LrXWPXgzkkBmYTt84N7h6W37ApJsbWqNYhiOye+0ef6sIJzlEXrOgmjCLLBHyvfm5JYSBqUPCJiN5UF2FQbDZSp3N0HrGMTjZLAJRxy2JAcgc4HmTrwZ2ymT5MUpRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313823; c=relaxed/simple;
	bh=X5bhrWLbCQAe1csEiDvUzppWIlVR+MJIkYpWOBniS+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G99v2F4J2nHxFqyMPAjqeW6wqlQ7LuDvzUosGAD1v60fC6LY/A3uUar/loXsm6BoYYyWlVJpyIVKdg8CA1xxniW3KHQNML2dAANtwU9B/p58qCLMeleiwlHipfxOE7l4B1MJahCUZ1hgpk3Ngql4/jvvzCRT2pEqYbcROvBhBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=KZZfyM3k; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9e8522c10bso429321666b.1
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313820; x=1732918620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH36KmdYBNGOfsV00pmvqC+HZVSDrTPa9bev2FjcerA=;
        b=KZZfyM3kgN4sBMgzzvKjeWTKrcEf1uvhl0axEYrHnc8GUPjRupSI+oE4qZivkZAxGg
         5TjtCZkCPzJ7HhY6JMFwfurehnPLZuJtNEYyC/0UiG39C8JolUWpK3pGyO5fGQQB08it
         IkULMu+mozFhtfsBc8UcPCaDxfW1Kx3nhECbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313820; x=1732918620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH36KmdYBNGOfsV00pmvqC+HZVSDrTPa9bev2FjcerA=;
        b=rpuyzoeFi+rOfO3UXkFva3U3rl+eswCBiAVQICox+wWOxC50U6onvUb37FLh/XcC7y
         WRMNBeUDFq+wyXYB3DKQetv8JJaJhzE7nY+BPnBynOgQrpgzEvP0ERXZacTXu3jyklsO
         wAt2SV/RciW8TyJIQtu1q+NNJxW1rdabe7UtKYpAa0jEZZUDjYP84CL+vRkDNKusCclG
         8lIbGDj9o4OYrK3wOeJ44r083t3Li89XaYiO3hsySG59JDfT5b0olxf8wMB37D8tbP5a
         Ll9iXZH19nc17TpCTHSpUuAizaHv34OnH1rkL3fHR+eSz0xRO3kvfM7o70QJqUr4NrBo
         rMMw==
X-Forwarded-Encrypted: i=1; AJvYcCV2h9LqudGrwnpyU2Ys+h8ol/P13O2gegxNQE0nDCnhVCHX478uEbBbq+Dd0y1XkZKsAlUDFOdDYe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwXUPY8pD98YbG9vvGLxyoBzVWHDSbu4T1NfvYHCEdXAY6jrNY
	1NL6rpp3+URWaehTZ31SF/mdB5NjmiRPBCEbGSOYBeZFMP8tnG6SwPk4K4dIUXM=
X-Gm-Gg: ASbGncs0Rl8sKirojsWDeV8xc+z9lzc/NaRzGv+hb5DBlLXbtbDox5xTme1Pc5KiLNs
	+DPMu61OEuuMhwCEPk14G20V0BUwhIX2u9s0v9S6Sevw/PpbfMEx8flJEdnOOVMRCZrLXSdMzy6
	sBqz2VKD4peKqbEWRvnVwKIxLnfSJpL6zAL+bP7H1W5RrCsNPrixoD5euvJXZFoU13fXOYdRJ9h
	RV1wCm/SKev094fPVboyuyrTo0gU6W7gJCWNlt+Y+u9YRlN1PLlAyYWkKu/Rs3RVVmMWW9vW5dn
	qvLH0Gl002ny6PCMpd4CR9SjZ6YahdgFl1xTl6rftFtZ8kZkfkfxYgDksGbgvYOhgW19nMPOosh
	S2ORRuaxxhvkN8zBZ
X-Google-Smtp-Source: AGHT+IH8FamDuZmqAUT6oJKKDvFN60oAvN/pj+lUo2fax+NOxU2EwGrNeXSVdxgLNcVN9PSpE7hbhw==
X-Received: by 2002:a17:907:aa8:b0:a91:1699:f8eb with SMTP id a640c23a62f3a-aa509d5aca6mr395581566b.28.1732313819950;
        Fri, 22 Nov 2024 14:16:59 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:59 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 05/12] can: hi311x: update state error statistics if skb allocation fails
Date: Fri, 22 Nov 2024 23:15:46 +0100
Message-ID: <20241122221650.633981-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
References: <20241122221650.633981-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch ensures that the statistics related to state error counters
(i. e. warning, passive, and bus-off) are updated even in case the skb
allocation fails. Additionally, the bus-off state is now also handled.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/spi/hi311x.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index b67464df25ff..25d9b32f5701 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -663,8 +663,6 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			u8 rxerr, txerr;
 
 			skb = alloc_can_err_skb(net, &cf);
-			if (!skb)
-				break;
 
 			txerr = hi3110_read(spi, HI3110_READ_TEC);
 			rxerr = hi3110_read(spi, HI3110_READ_REC);
@@ -673,14 +671,15 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			can_change_state(net, cf, tx_state, rx_state);
 
 			if (new_state == CAN_STATE_BUS_OFF) {
-				netif_rx(skb);
+				if (skb)
+					netif_rx(skb);
 				can_bus_off(net);
 				if (priv->can.restart_ms == 0) {
 					priv->force_quit = 1;
 					hi3110_hw_sleep(spi);
 					break;
 				}
-			} else {
+			} else if (skb) {
 				cf->can_id |= CAN_ERR_CNT;
 				cf->data[6] = txerr;
 				cf->data[7] = rxerr;
-- 
2.43.0


