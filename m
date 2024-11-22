Return-Path: <linux-can+bounces-2185-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A519D65A3
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA90282282
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C201AA792;
	Fri, 22 Nov 2024 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ony2tUkd"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52749189F36
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313820; cv=none; b=Tbims3Pl7lov7nx3i9D1JAANCpW2EBDjggAx6fOjpp3m2HqB1QozNPOpSqYyQMxEu9FrK/j9pRSyHRLGxHGqjXi6zMpSKuO1vSni55Cn6rENfRjcfUsiUir5muGCXs4HVR1QAMRgk8NJTu00C3iC1VOGIcivh81btDFd3J3/rvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313820; c=relaxed/simple;
	bh=cfN/Sqofe2yynbRgQXfBL6ERxMwzjmzkAWAp/j8LOdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1D8iLssP1MWJBX/uqWXRppTQomC7UcX3MUkkaZr9yCmxefHtABv4/oJyhW1t/AjkyVpiIvAIZXPAfTOqPMvRRUaSWveDUf8XYYR07/N7QxTDmtXXaC/oK8dnBR14i/pE9ijSjFYQDU1vTrXY9LDxQRtMVS3GHRp527s6KxmZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ony2tUkd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa20944ce8cso662979666b.0
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313817; x=1732918617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HrdX116se3rn9QRZsQ51ceQKyywuhiVyeVP2xiWD4c=;
        b=ony2tUkdauEIYZVEV/1jP8fiwqKeU4V4xvrVR4z5nok9zNeaZs1wGnAXaI1dj0N+tZ
         KVJj3Bg83OubPEuE7KlXnFOYjYXtGqGhBb/hK6V8a0mM4ymG271Nv9CPoxaT3a7yVgv4
         slHmejqsov+WI/jJuxWqKaCD86kYqO0FUmb38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313817; x=1732918617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6HrdX116se3rn9QRZsQ51ceQKyywuhiVyeVP2xiWD4c=;
        b=OD330HDAJ7VOGSmbFBPtlDMhoIIFyqafP61F9ZZAit5ziwQMgv4I4apjSrNpAxybUZ
         rc/qfKIlTHKL/ENbrB3ChQYDq1F6tKK+yp+lTdMru1HUvynAC0VOPiS3Wg4kVLnaVMGg
         K7kuzBy7T7nXJ0A12RTVypbZuYhRk1Ja74pBmMmAQ/K+z7JV2koO9csPX6puBc2GG2GP
         M1PajWXl3qQJ/TnO3rhRZ8amNP7N2fn3tcncc/wcV9dS/8eU6ffRO0ieKX05Yb/9Jhql
         P49heVI1eR683NkyUR0fasFknkO8bOAoPVvUlkBXNBFXdhLl9jUMMYc4wTHCumwkTgDw
         getw==
X-Forwarded-Encrypted: i=1; AJvYcCXbOzkHONf5Q5qBebmrqcPDJ10beRRLFyAm0PX8RV9lkhTshmjLxDc88OAG7wO4jHznn24nTRkZ2pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhB35ubVeIinfIZs1rO3wBRiLk5saEW8pVO4l9Ug3K611vP2Fs
	wz5NeNjMdOX7Sc33kDqJz6JksPD8uHQbWrgpeugAUhbifQY1DzwURAAMH2DUlHE=
X-Gm-Gg: ASbGncuI71BE8MUiL9yGxA/Cy/7lUn+DxwMRSQLgE6DDXYoyRL4KPmMM/vHXWA/Dq/I
	uxoooeVOXqjoDLuRtXR86SziBUGIyXrbx8m5qqZ4LEauuJO5ao+auATcotm5Dw8AKmV6Cb8PwpI
	C057Q7WA7OnH8DCJYDPEvzR7ItoSD4iCe1OQKeq0TWiX+MttAamH6eb1pMzF3pDjcyTfMikX8kv
	soHPRWW11OlaZFfnU/aafUOND6mhJIm4iDKdbzJIP8bCj6tAk27wwV3/SBlWGI7xYRjSW7pRykh
	anErrosjwi0Z8dVa1yCKZ304avQYE5yoVQQJ8nrJt1jB4Of0rfHa4KoKxhQ/LqA3KUn2ExUYYmV
	Cjjqs9KCsZXrm+2hK
X-Google-Smtp-Source: AGHT+IHRSafR/Hd70o+h3rYpO/7VHYMjBwxEdj1MERjp9IAi6352iOe+u8OcuPheRZbM1LDn8364LQ==
X-Received: by 2002:a17:906:31c1:b0:aa5:24df:ca8 with SMTP id a640c23a62f3a-aa524df1311mr297959966b.18.1732313816670;
        Fri, 22 Nov 2024 14:16:56 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:56 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maxime Ripard <mripard@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org,
	linux-can@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v2 02/12] can: sun4i_can: call can_change_state() even if cf is NULL
Date: Fri, 22 Nov 2024 23:15:43 +0100
Message-ID: <20241122221650.633981-3-dario.binacchi@amarulasolutions.com>
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

The function can_change_state() can also be called if the allocation
of the skb fails, as it handles the cf parameter when it is null.
Additionally, this ensures that the statistics related to state error
counters (i. e. warning, passive, and bus-off) are updated.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/sun4i_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 360158c295d3..17f94cca93fb 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -629,10 +629,10 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		tx_state = txerr >= rxerr ? state : 0;
 		rx_state = txerr <= rxerr ? state : 0;
 
-		if (likely(skb))
-			can_change_state(dev, cf, tx_state, rx_state);
-		else
-			priv->can.state = state;
+		/* The skb allocation might fail, but can_change_state()
+		 * handles cf == NULL.
+		 */
+		can_change_state(dev, cf, tx_state, rx_state);
 		if (state == CAN_STATE_BUS_OFF)
 			can_bus_off(dev);
 	}
-- 
2.43.0


