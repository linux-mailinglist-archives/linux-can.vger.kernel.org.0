Return-Path: <linux-can+bounces-2195-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCAF9D65B5
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C55DB2823FB
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010301E048A;
	Fri, 22 Nov 2024 22:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aBwHWpdB"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249441DFE3E
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313832; cv=none; b=Vd8jSAlOp9qv7+87L/TBanM90QE/zLEM/Gd66mOxDSDNjP2YjBxmOZgetNrcqawPcEvpiK4JtYxDZ4aDrLlwtcO9IvVw8Fke+NDbqnrTzva8qmIVY58jHIfsSzvMscxQUKSmgpkPkkfjS216ZPNZUbBfLA+B/vBRU4CvQ0JafQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313832; c=relaxed/simple;
	bh=UIfE/i9uNl2q+Mi+kE8Q7UwUe7PKkReqlrcUvsBIvQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjfWqxWDO1p2OFfhHPjkG3Q+vdvMUJGvCdRYTOO8bgd1Tk2lUX05J1InPDWxixRf4ZaTVP0UaWo6SZTeIWm8UMbLrPNPl6FGqxneVKm0POOiirYdOtfLMcEM3REjhPVkIdFP4oDojrBfFVrvxLAXbSOXIpz+rc+7r6RIUYKDDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=aBwHWpdB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53d9ff92ee9so3096753e87.1
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313829; x=1732918629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIjLTiSdjHPZdtn456NOY4iL8rLUfrRnErOspsYBZzw=;
        b=aBwHWpdBYtOMzrVwIkcQU/deEsfrwLJVBYkTWRzhekbIQ0QvtOK+ZtBgEzkeW9521y
         fRJPF1n9Avbc3VXYXDNuDMMELY2bPSwgDYoGUxr7Wvz++vYndKJcKhbRS7Pksu9cp5CO
         0aaRgIsbvQEZutrle1DH36U+MIMwgh3c1tyB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313829; x=1732918629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIjLTiSdjHPZdtn456NOY4iL8rLUfrRnErOspsYBZzw=;
        b=TKtKtDP8tfZkkEBVxSlZcwIXpC+GquvVFjupVD+JwtZXRkayV+a+CBbSLPNreeundZ
         nuLIiBlz3DEd4fRopWiqah4TRf1toOBIeV0Ce/mSDM1lVLZ5ZrH61WbbTqvL35qtBsqG
         bnG3MbjmpuH2ri0ganIpdHGBagezBc5wyBPm2PQbnfdVP44nyJXtNRoXkybmfT6xTloj
         KPXJRgP2SgxiJXMiEhRigZo3pp/xVyQdkI3mk6xPxp4ccChDjHLOFeP72k8xYr8Mu7f0
         +tMqoVW5fI+j4XVbyQVMIrxDOWuiUYFgT7s5mDZNY1+P48gZUQkrClAF/GmMlULP46Pj
         U7Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXwNK4eO7smXepaSem9BqZjHKSzTrCpqYURpwcaseI+bvexbpEJrh4PErZ6EQKwdyMQCDxk2WRZN5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KAQz5aJmURMYzwRe+69iv4VsIK8T3DJzdnBx5JZXux/+me8T
	NA4eDS6IxX+Hv8xhpAMx27MyQIBAqcQixY/jgxLMHf+dV2U51t2q0IPn2Aa7Gp3GZ68sh3lNzEe
	x
X-Gm-Gg: ASbGncu9ePxBK3lWvdxoEtBIx7pd98O85GquhZNacHvHQ6cIWjC9NzXG8PsSjHyjjbc
	Ba/tlr01UnXAbdHJGy22TxHrGKSLvbA2f0P+96b6E6s4j3rbTifyx2wz3TSm5AyfIlfYCFfODGq
	GYymwPBUgK4Q0dHkGbleVbdLGEpiF+GkU+YhNBk/eQpkFF4vy0FPSV8+2ftNSUsJNZZr2ipwLDK
	c3OKLEYKrB1kScJH1nktoLjSZYJCyCi5zlsvbykREnjwVIr1TfL8inZlR0dqkO/RrbubeS65MpX
	SeoP0QWNya2yBRdrYVpHxYGCvBO4UbpyN6QTQR5TmhUL9w0cbJ+nsG2hhoT8GVe+vHKWasc+uZM
	WGhxmcFD/PIZ8LNX0
X-Google-Smtp-Source: AGHT+IFzF09O/6bEbltd8l52ut4lZtd8WfeN0mrpAjDZSWj2O9HkQlqmxkwqoiHxqAM9cuMjAuwfqg==
X-Received: by 2002:ac2:51b5:0:b0:53d:d3ff:77f6 with SMTP id 2adb3069b0e04-53dd3ff77fdmr2299001e87.46.1732313829337;
        Fri, 22 Nov 2024 14:17:09 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:09 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	"Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 12/12] can: f81604: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:53 +0100
Message-ID: <20241122221650.633981-13-dario.binacchi@amarulasolutions.com>
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

The f81604_handle_can_bus_errors() function only incremented the receive
error counter and never the transmit error counter, even if the ECC_DIR
flag reported that an error had occurred during transmission. Increment
the receive/transmit error counter based on the value of the ECC_DIR
flag.

Fixes: 88da17436973 ("can: usb: f81604: add Fintek F81604 support")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Fix patches 7 through 12 to ensure that statistics are updated even
  if the allocation of skb fails.
- Add five new patches (i. e. 1-5), created during the further analysis
  of the code while correcting patches from the v1 series (i. e. 7-12).
- Update statistics even if skb allocation fails

 drivers/net/can/usb/f81604.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index bc0c8903fe77..e0cfa1460b0b 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -526,7 +526,6 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 		netdev_dbg(netdev, "bus error interrupt\n");
 
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		if (skb) {
 			cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
@@ -548,10 +547,15 @@ static void f81604_handle_can_bus_errors(struct f81604_port_priv *priv,
 
 			/* set error location */
 			cf->data[3] = data->ecc & F81604_SJA1000_ECC_SEG;
+		}
 
-			/* Error occurred during transmission? */
-			if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0)
+		/* Error occurred during transmission? */
+		if ((data->ecc & F81604_SJA1000_ECC_DIR) == 0) {
+			stats->tx_errors++;
+			if (skb)
 				cf->data[2] |= CAN_ERR_PROT_TX;
+		} else {
+			stats->rx_errors++;
 		}
 
 		set_bit(F81604_CLEAR_ECC, &priv->clear_flags);
-- 
2.43.0


