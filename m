Return-Path: <linux-can+bounces-2192-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF959D65B2
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1D42822A4
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB961DFE25;
	Fri, 22 Nov 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="eOTy88oW"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067501DFDAD
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313830; cv=none; b=sEWeZz59l1GpdxSLo8lcKlNurR7YA+eO429xP8r3bpAG1BfxxM44UaNIhjzlJ85/v9SeDU+au0sZVo8s9c/vN9OPchdGTpcHaXGrPj6f3gbe+WccEFkabVQsmpA0fuQalBGllg4yG5ZDorbNzZsWspXSu9wSpN6DvQ3uiWWUde4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313830; c=relaxed/simple;
	bh=suvkAfBGBjUXa2245JmSbUdEzRQCqXoVi3fUmt5kocQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY0xHycZHl82MsVEpie5h3IJ1boyfOK5mcILmvGCvRybHVxcS5ARghG/uEV59a8Vpq1aTpkaO879Erypy34goyiNzvL9N7rPEIETT8H/WVmTaYeqhiWvL/wueTzzbOAj9KBTYsJEQ3qWs50Wl+9BwKKvFI4i/si0K9/zNdr67+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=eOTy88oW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ef275b980so410535266b.0
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313826; x=1732918626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koSu2Qr3uUTmv0FA1/R7W/a8VprfWgcqXI/05k6MgFU=;
        b=eOTy88oWwRKhGbYe/jJydKcu7IAjIigG/XN0jF/BEKmSgdCCufy9oWQmhOhZZrVXLH
         EAjXtBZo0r/7v0EuYI3ZhE4MTxsn6uuv/m8om06XKXD5qY7KnNGtSwSChlxyKy6YCd0y
         84guymLA14ZlPoQO7YNj9CKpXk0RpniapbbbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313826; x=1732918626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koSu2Qr3uUTmv0FA1/R7W/a8VprfWgcqXI/05k6MgFU=;
        b=Lw8xM68pEfVQCahvqgkrhe7yRuCJSeu20rqnWmqB0ZkGI13n/UrqNd86uGfNqBj+vj
         hqdvkH+2a5uvLFaP6hgJM8SbzgsVYcbfDrTz8LpuV1VACMwyToZh5oxAvQ3IpyKFlR6f
         o+qjk8fBsqRyk8ZAHP+/Hq8Ke6O0qK1YhVzvyeEnymjnSXRN2NBiXHDaiSCW+TUVogbj
         eDduzq68LCQMIXEx4A3MU1vtoTh9x/tL7nGnrsPsCxHbih0bJ1Bp1d0Mkz5mf2R/3KAm
         b34nu/mTy0ayP9y23MaUSa9Ewy60R7sXeKqU8NqjrkrviNbry5pCwWI2RbQB7sW2oFOC
         zREQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHLyVWaxHMGra67nNuClcEwarwvVFHHRWJUo8NH+kjoriy6H2jOSmKnt+lH5pO4DjYjwhzmCWjbdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHUGHPky58NKliwm5e5IDDDqZzM8T0vpO1TU6diQ0YgEiceRUg
	x8WtIkXSlpBfaPNs1INf2CjAXdmRTVYSfWQRo4GPyYQfm/QQQoLNAuxwL/L92mU=
X-Gm-Gg: ASbGnctOq7UNbeV2mtLha77tSuYa+mT3B1WYWUcDOuNsDyVVhHxWUYTYCmB/YaJM/xH
	hdUTaev2IFwymf4MxYpHpjKeuz6KBWdn8ziPJdV8vvCJXleevD+ZhJMKszG6PC2mOFiriXEkpH1
	U2w6VeA3QUyi8TAWUmyrQ3E1hcwSIr01x0GMsj0qULByOK/oi7ojqSxCW8znA6PjS8GotzTr805
	2PsPZ/vwaswJGhptgDRcn5OOF0B0flcp+HVYI4j8nGrE9h1UpawpDKWrKhdekCPvMDBk9lfa/mP
	tp/3A3nIVQVvR9O/jCYDD4Z+TDRDXTNNoCEwDz/z2W9aXrc+TZ/GKBFb8xsr85KPgsh4fhZYToy
	RRLHZSbM7jexSiDB3
X-Google-Smtp-Source: AGHT+IGzFnZJs4h2n/iV/ioahj7WXElDTwCpUUULB2OBEylU5ouM6Ybr9FJMu/M15S4g4KqefHT26Q==
X-Received: by 2002:a17:906:31da:b0:aa5:30c0:384b with SMTP id a640c23a62f3a-aa530c03aecmr47395466b.24.1732313826492;
        Fri, 22 Nov 2024 14:17:06 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:06 -0800 (PST)
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
Subject: [PATCH v2 10/12] can: sun4i_can: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:51 +0100
Message-ID: <20241122221650.633981-11-dario.binacchi@amarulasolutions.com>
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

The sun4i_can_err() function only incremented the receive error counter
and never the transmit error counter, even if the STA_ERR_DIR flag
reported that an error had occurred during transmission. Increment the
receive/transmit error counter based on the value of the STA_ERR_DIR
flag.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update statistics even if skb allocation fails

 drivers/net/can/sun4i_can.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 840b972498c1..5285bb0b7c69 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -579,7 +579,6 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 		/* bus error interrupt */
 		netdev_dbg(dev, "bus error interrupt\n");
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		if (likely(skb)) {
 			ecc = readl(priv->base + SUN4I_REG_STA_ADDR);
@@ -601,9 +600,15 @@ static int sun4i_can_err(struct net_device *dev, u8 isrc, u8 status)
 					       >> 16;
 				break;
 			}
-			/* error occurred during transmission? */
-			if ((ecc & SUN4I_STA_ERR_DIR) == 0)
+		}
+
+		/* error occurred during transmission? */
+		if ((ecc & SUN4I_STA_ERR_DIR) == 0) {
+			if (likely(skb))
 				cf->data[2] |= CAN_ERR_PROT_TX;
+			stats->tx_errors++;
+		} else {
+			stats->rx_errors++;
 		}
 	}
 	if (isrc & SUN4I_INT_ERR_PASSIVE) {
-- 
2.43.0


