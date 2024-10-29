Return-Path: <linux-can+bounces-1826-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D79B44C5
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 09:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E22282E3F
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3DC204959;
	Tue, 29 Oct 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ieCSYjL8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BE203711
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191608; cv=none; b=GfigQ6ZWX0XnWQrcXOUyC69oFw2SYn1+AYKPGN3pz8aBCqNtUxvMEE8Err/VXXfDD16MFGNYWCA8s4Fpd5ywOH1Os/nPWtsxdv/+BRI8qnpf0MX4uC1GwhxiKFR2vDmwHqQKbg0NkDPMy9IOCD9P1HJZo+sfotakAOaxZIEZ+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191608; c=relaxed/simple;
	bh=lvBH4nDZzUSZ6y5ghSyZfw8hPI3PkCQivKPs3UeNvug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZMBhrDAX8wDuPflnuM6cxzuu06WRJ6xRCanNf7PJWpcaTlleMt1QFB/0oswqywwi7uXci+id82D+vkyzalBJoyhYAGTOKO4dFRet2UZgSJnoAuehLxD3VWODFEQFLWUVchtohgxEoGvyln5WbQYOsnLAmScIqayVKAyky/ly6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ieCSYjL8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f58c68c5so8571253e87.3
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 01:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191604; x=1730796404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwyMMsHa5HEUfO6bt7mbb/5lMim+t5T1aF2qtApwxpM=;
        b=ieCSYjL8IptPLaZ6hAKobBQVUhO21p62duTr9ghMpGYtc5ZkBmVVueIBViErvlFGgE
         NavjIn9YhmofkH8a3crQQ9DMdJW+ilmF1VIljCWPMUuObs1kiO8XCxljiguWXYiVS65J
         xKsk/YOdvh3ojWawT5hFbSp01kogXP/RH8Xc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191604; x=1730796404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwyMMsHa5HEUfO6bt7mbb/5lMim+t5T1aF2qtApwxpM=;
        b=e4mQsrNmX1JHKF9Ooqpxd+6h4HdxQSIdMAeQFINwETJXnfWSiMamDmO2zNCRbcb1dA
         c0lcmyFV/fATqRYXlLOAj4jE7FlIXZAgnMb9Q0c3QuDucgzwUVUujd30v5GC4Hjn4jXR
         V3uyvcIAUQ0KgYToEF+5aJqeFJCyo+RKs/VFQsAzJJWepLjPv7sGNvKYmM7LysMTZfkz
         eXDgh+eFSrY1YdVxMdNolHdZM3J/ni6zS3/fF21EhScEatX66nqlIcBQeRsToRZiU4wm
         b7YuC7P+SeKt5DfmgptX1Gc0qU+CeuOIs6QIMNr+d24nneaHTqw8YqDyH3OFmNPF2b9W
         7aMw==
X-Forwarded-Encrypted: i=1; AJvYcCWu2UkwvO6w3gc6JK0u/9Yh4dQ/hS74gpt+KWdnZm3C2QliZDDkcRPkUczMJPof7uLui7UWCxz4Cz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRkzYk6w2G4p0XzwlSOauL5EVSyGMHwbZZdizJNkvBZ29Lshqe
	+xg7H6BaZIpk2ejQe9j1iS7rqdwTGrqEyyCYneORHxkXvZlwnP50G4pqN9/+Gdg=
X-Google-Smtp-Source: AGHT+IEISmXm1iH8AiJejbMa004PxvUCwKNYOyyhBpeNGrG9KbTdzRJ6Jk4J3pez3yKENXfTWV0g2Q==
X-Received: by 2002:a05:6512:1252:b0:536:a4f1:d214 with SMTP id 2adb3069b0e04-53b348cc55cmr9003984e87.19.1730191604452;
        Tue, 29 Oct 2024 01:46:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:46:44 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 2/6] can: flexcan: use can_update_bus_error_stats()
Date: Tue, 29 Oct 2024 09:44:46 +0100
Message-ID: <20241029084525.2858224-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
References: <20241029084525.2858224-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch delegates the statistics update in case of bus error to the
can_update_bus_error_stats().

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/flexcan/flexcan-core.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..790b8e162d73 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -819,7 +819,6 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	struct flexcan_regs __iomem *regs = priv->regs;
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	bool rx_errors = false, tx_errors = false;
 	u32 timestamp;
 	int err;
 
@@ -834,41 +833,31 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (reg_esr & FLEXCAN_ESR_BIT1_ERR) {
 		netdev_dbg(dev, "BIT1_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT1;
-		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_BIT0_ERR) {
 		netdev_dbg(dev, "BIT0_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT0;
-		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_ACK_ERR) {
 		netdev_dbg(dev, "ACK_ERR irq\n");
 		cf->can_id |= CAN_ERR_ACK;
 		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
-		tx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_CRC_ERR) {
 		netdev_dbg(dev, "CRC_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT;
 		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
-		rx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_FRM_ERR) {
 		netdev_dbg(dev, "FRM_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_FORM;
-		rx_errors = true;
 	}
 	if (reg_esr & FLEXCAN_ESR_STF_ERR) {
 		netdev_dbg(dev, "STF_ERR irq\n");
 		cf->data[2] |= CAN_ERR_PROT_STUFF;
-		rx_errors = true;
 	}
 
-	priv->can.can_stats.bus_error++;
-	if (rx_errors)
-		dev->stats.rx_errors++;
-	if (tx_errors)
-		dev->stats.tx_errors++;
+	can_update_bus_error_stats(dev, cf);
 
 	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
 	if (err)
-- 
2.43.0


