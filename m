Return-Path: <linux-can+bounces-2076-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E149D0053
	for <lists+linux-can@lfdr.de>; Sat, 16 Nov 2024 19:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51831287506
	for <lists+linux-can@lfdr.de>; Sat, 16 Nov 2024 18:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3A61B0F3C;
	Sat, 16 Nov 2024 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="asoGproX"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9611AF0D4
	for <linux-can@vger.kernel.org>; Sat, 16 Nov 2024 18:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780198; cv=none; b=Z7Mtmq7lqLhgGhjvvQ0VtiClrf+NQ11am2dL8nWLSY9ccwI8gnbI9S8YorxwtMnL31rvUIaFA78akxprIGdcbbjcY1/np+EPvM9ZWMiCuY9vfvcQbrsj6gi2cReNeeSFeI6TnP3vpBSZyinAV2UHDpkueWDzAAGV2YeEAN0Ly7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780198; c=relaxed/simple;
	bh=b+NraIsUClYsl+LKVbalvzNKBzSiT/wtutwKCT3G2ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TuDE7Raq35dYTd4XZtEAfzawhbJxNnb/Da1ZNWOEEOr+ml2DcTLf6qDTsZibLQO13UeG6GiUa/MWvw+AdeIPbsH7XnRGKZXRFiZBvXX0musCvh1ATEmg/MQFIt93dgxS59j/f7KYXmEjkB/Pla8CXbJdflzPJVOimg3GaNv61Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=asoGproX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e8522c10bso432903766b.1
        for <linux-can@vger.kernel.org>; Sat, 16 Nov 2024 10:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780195; x=1732384995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPi0av2xe0jC0J5HdvNkCxIcsg4iO3imVdR2/hegefY=;
        b=asoGproXuz1ZNgmEjSgCPF6L9Vv8f07KkLdTa0sETtE3Xsy1+7ZCsAMGhxDV6/VdJj
         WZg/Vq6znz40fyTgL24alMigYmclmtdnurp9jvan3a3yxsO+B6GMGD9dpCF8kjqeLITW
         yR7Le4s+AX/pKt5G0XvK0X3VmmrXGCxP01pHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780195; x=1732384995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPi0av2xe0jC0J5HdvNkCxIcsg4iO3imVdR2/hegefY=;
        b=VFZAIWnG/WRmb+zKe+ZxklFFxyOLEXDqupgRyaPeTNiJL6qwsQAZ8XjiK8WC3ieplv
         v5edpmeLVX56xymuiSbP8RNSIXR6QB60nqeLPkLxp4R/RY9m9Rd90UQv1HDU+B2hVLol
         87nyyEdsHCvvYlZo/5peBtSUJJnlMKH1+CmmuOCZRiZ3iQEwStIduat1RSWsUUY1rFXr
         aSjmsVrEA3+AoSPfiPXlBMgyHWo3fxAduKl8oS4dmrPQTxQ+KhNySO2OgSCwGU88YeFS
         Ke0RucOdoK3xa67hPOwr5Ea7OWMv67vHA+oELK/lABJC/WkL8T8fvoLSGQI//jk46T6r
         eDwA==
X-Forwarded-Encrypted: i=1; AJvYcCWZiNkI12nAZyoHSCgLSwwVq4B7wNztanNTzD9pd2+nJ04qjKxZHnAD0IC6Pi1CxJH4LnCzhvj8Dt8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5cdMzAvnDmxLCzYB5bsFGs0gWn8Kqpyc/HwZLR/a+mINav+6k
	L62814Ih5Q8pMiBdoStRknn2ZN2Sofg9E+QJSMVrXAXERHpfQ36jRJ8k4TnN0pQ=
X-Google-Smtp-Source: AGHT+IGiCGpsd+G1WFq5UxLc4I4k8txDJ+JeMk91+wJgoZFiUor+BpmbVpSQLk7uJcDP3qphPmkBiw==
X-Received: by 2002:a17:907:9813:b0:a9e:c266:4e82 with SMTP id a640c23a62f3a-aa48185c694mr772769266b.6.1731780195092;
        Sat, 16 Nov 2024 10:03:15 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:14 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <oliver.hartkopp@volkswagen.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 4/7] can: sja1000: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:33 +0100
Message-ID: <20241116180301.3935879-5-dario.binacchi@amarulasolutions.com>
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

The sja1000_err() function only incremented the receive error counter
and never the transmit error counter, even if the ECC_DIR flag reported
that an error had occurred during transmission. The patch increments the
receive/transmit error counter based on the value of the ECC_DIR flag.

Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/sja1000/sja1000.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index ddb3247948ad..706ee8f6b7db 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -460,7 +460,6 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 	if (isrc & IRQ_BEI) {
 		/* bus error interrupt */
 		priv->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		ecc = priv->read_reg(priv, SJA1000_ECC);
 
@@ -485,8 +484,12 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 		cf->data[3] = ecc & ECC_SEG;
 
 		/* Error occurred during transmission? */
-		if ((ecc & ECC_DIR) == 0)
+		if ((ecc & ECC_DIR) == 0) {
 			cf->data[2] |= CAN_ERR_PROT_TX;
+			stats->tx_errors++;
+		} else {
+			stats->rx_errors++;
+		}
 	}
 	if (isrc & IRQ_EPI) {
 		/* error passive interrupt */
-- 
2.43.0


