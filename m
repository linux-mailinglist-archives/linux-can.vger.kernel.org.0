Return-Path: <linux-can+bounces-2193-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B12FF9D65C9
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5202825AA
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EBC1DFE30;
	Fri, 22 Nov 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lBBNAMA8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAD01DFDB4
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313830; cv=none; b=qwV8ZobvdgwbNVOgVE2d2T9B/g0X9mljSsTBgle5gv1UrxK3w9tvafNUgGqrE7eOixG7xqIYuGCOrA1umiZScG6AVPaHOMiu2E8+gkv4z2OcSeduHkSWlTjprpn5YQ7sbG7LJWBEwwr3cu6b72jQj2WkpVi6L96m3Ynr/yFp5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313830; c=relaxed/simple;
	bh=aZI6nysz82pEP0emeVa6kVzsEW4+gM9gju+4YJnXy/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=py28as3BUgUJMPzzv8P0YFgfpdzHFaBD82cSE3zzveyg70p+jv59CwpYoDHyyaUiiqMys1M3j7bNFTmD9L0F59GRwfMt/OzJ6F+lXojkdJW4w6UffMGt6DXGjIZfc/mO1EQsqT/dcYyv93v72nrQ63IxbcJSnCKYE0mdDj5JdEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=lBBNAMA8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so4728387e87.2
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313825; x=1732918625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlpDyiJR/k7vKSJ97gJNXRm8erHzYQsibasSD5BWwAI=;
        b=lBBNAMA826kS2z6gmmowxrqiHnksOIYc2O+jiPjTFWkgOdb9EZl+Dc6RmuCjTtn3o7
         7vDxWpwjwbwty5GO40i4ot38fHM+XcUCtBLYsENSBpZXXEcMMd/fwNRi6jsYMn5T0Wzq
         4+OpEMMgkgWU2/W9kl1d6tTS6h713own8F92k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313825; x=1732918625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlpDyiJR/k7vKSJ97gJNXRm8erHzYQsibasSD5BWwAI=;
        b=D82UI9Xnvj7c/IRfQn3T8XBRHW17pG3qP94ftenu/DgWPVus+AW24wfpy81QRdd/Oo
         cdilKeXslxnRsc9LBLfWCGsGkeXxavWsmauuaFX+tDyqbu9UkAAA5y+fjkrZELw+qgfb
         UiE6z+iarxe3Tk5ikZ4KVyUjpbpAnlxIPAkarwiZ9rpnxB8IOhNAoMkKhye7Xwt7YtOr
         WmivgvjNQnBZedzdU21uzCKoQaznsR9t90BQ0PM97ms5DnBMjlj3xBHMxv1u9idHT9k6
         kk803iU2SyUK/UEr5SCfkD0bvQchcl0keNwGuCGWHCpadWhLvBiI2BuaZQR2I7M49xAx
         +n7g==
X-Forwarded-Encrypted: i=1; AJvYcCVnA5yhsTnOuwaFrfKPt0Bqbr2mTt3bHbtqPLZEsxm6H7NYhd8TXMZJ5kFTB+PPid0Mr10JkcE3GUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJegkH+tHL6pWCVFKfY1lRVDSENAjg3iJwvq2Iwp4BMXpIF+GO
	4rq7YayknwYPrulMj2cXDqQW39/1kYYa39Qj0r5Bm9BQWnqaNVD2lj9m9l/eGAs=
X-Gm-Gg: ASbGncsjNMTx4WTmEHOzjE7YWVYzIIGy08aJ9ONhN/x5nfmynMGhC5fp9378h8k+ecc
	oKvM3O4MeGNKdC9+TulyMHo+RG1nUNi1egxJyaYTkklqGgNCrRWM9HMO81r+dWiCn2A55+ecj/3
	Y2jUaaKwc8+j5NV+uwuGU9zzk+M/L9rDk/o9AsW0yReaS2j5Pzb1luoI60mxpLfLrmPRNHkcciH
	blzlqgL7OB0vq0cqyia5lm87zOSLOWmAXDEk5MlA6E2S3vTVUjWF5X6KGkf5jV6ZEgbFsI1pV1d
	kD4UjcN/Im6OB676MVpjfQetDGIOjqDwFE+ngUQAjr3UOzp6+NO+d8pasPfjt8dXh/BMhBUUOJE
	hSMdHkHusOftZbix7
X-Google-Smtp-Source: AGHT+IFM4zz1P0zcbDlpIS0RlDY0cn+D//lyH7aVLQCevJCESOfOR94A0A1KmXqMkwxRcXzDyP6m0w==
X-Received: by 2002:a05:6512:304c:b0:53d:da89:a491 with SMTP id 2adb3069b0e04-53dda89a8abmr1706753e87.10.1732313825233;
        Fri, 22 Nov 2024 14:17:05 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:04 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 09/12] can: sja1000: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:50 +0100
Message-ID: <20241122221650.633981-10-dario.binacchi@amarulasolutions.com>
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

The sja1000_err() function only incremented the receive error counter
and never the transmit error counter, even if the ECC_DIR flag reported
that an error had occurred during transmission. Increment the
receive/transmit error counter based on the value of the ECC_DIR flag.

Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update statistics even if skb allocation fails

 drivers/net/can/sja1000/sja1000.c | 67 ++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ddb3247948ad..4d245857ef1c 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -416,8 +416,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	int ret = 0;
 
 	skb = alloc_can_err_skb(dev, &cf);
-	if (skb == NULL)
-		return -ENOMEM;
 
 	txerr = priv->read_reg(priv, SJA1000_TXERR);
 	rxerr = priv->read_reg(priv, SJA1000_RXERR);
@@ -425,8 +423,11 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (isrc & IRQ_DOI) {
 		/* data overrun interrupt */
 		netdev_dbg(dev, "data overrun interrupt\n");
-		cf->can_id |= CAN_ERR_CRTL;
-		cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		if (skb) {
+			cf->can_id |= CAN_ERR_CRTL;
+			cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
+		}
+
 		stats->rx_over_errors++;
 		stats->rx_errors++;
 		sja1000_write_cmdreg(priv, CMD_CDO);	/* clear bit */
@@ -452,7 +453,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		else
 			state = CAN_STATE_ERROR_ACTIVE;
 	}
-	if (state != CAN_STATE_BUS_OFF) {
+	if (state != CAN_STATE_BUS_OFF && skb) {
 		cf->can_id |= CAN_ERR_CNT;
 		cf->data[6] = txerr;
 		cf->data[7] = rxerr;
@@ -460,33 +461,38 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (isrc & IRQ_BEI) {
 		/* bus error interrupt */
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		ecc = priv->read_reg(priv, SJA1000_ECC);
+		if (skb) {
+			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
-
-		/* set error type */
-		switch (ecc & ECC_MASK) {
-		case ECC_BIT:
-			cf->data[2] |= CAN_ERR_PROT_BIT;
-			break;
-		case ECC_FORM:
-			cf->data[2] |= CAN_ERR_PROT_FORM;
-			break;
-		case ECC_STUFF:
-			cf->data[2] |= CAN_ERR_PROT_STUFF;
-			break;
-		default:
-			break;
-		}
+			/* set error type */
+			switch (ecc & ECC_MASK) {
+			case ECC_BIT:
+				cf->data[2] |= CAN_ERR_PROT_BIT;
+				break;
+			case ECC_FORM:
+				cf->data[2] |= CAN_ERR_PROT_FORM;
+				break;
+			case ECC_STUFF:
+				cf->data[2] |= CAN_ERR_PROT_STUFF;
+				break;
+			default:
+				break;
+			}
 
-		/* set error location */
-		cf->data[3] = ecc & ECC_SEG;
+			/* set error location */
+			cf->data[3] = ecc & ECC_SEG;
+		}
 
 		/* Error occurred during transmission? */
-		if ((ecc & ECC_DIR) == 0)
-			cf->data[2] |= CAN_ERR_PROT_TX;
+		if ((ecc & ECC_DIR) == 0) {
+			stats->tx_errors++;
+			if (skb)
+				cf->data[2] |= CAN_ERR_PROT_TX;
+		} else {
+			stats->rx_errors++;
+		}
 	}
 	if (isrc & IRQ_EPI) {
 		/* error passive interrupt */
@@ -502,8 +508,10 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		netdev_dbg(dev, "arbitration lost interrupt\n");
 		alc = priv->read_reg(priv, SJA1000_ALC);
 		priv->can.can_stats.arbitration_lost++;
-		cf->can_id |= CAN_ERR_LOSTARB;
-		cf->data[0] = alc & 0x1f;
+		if (skb) {
+			cf->can_id |= CAN_ERR_LOSTARB;
+			cf->data[0] = alc & 0x1f;
+		}
 	}
 
 	if (state != priv->can.state) {
@@ -516,6 +524,9 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 			can_bus_off(dev);
 	}
 
+	if (!skb)
+		return -ENOMEM;
+
 	netif_rx(skb);
 
 	return ret;
-- 
2.43.0


