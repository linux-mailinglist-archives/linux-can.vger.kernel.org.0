Return-Path: <linux-can+bounces-1828-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1429B44CD
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 09:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D51B2256B
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31808204022;
	Tue, 29 Oct 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VHk3xHnx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5B2038D4
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191652; cv=none; b=nvwhfHK0bVExfKe6mzkBX+DUW34oR2m98tVlIUrHuLgXpNb48bW47jRAQzdHp9q9PDl3YNNY25njprZafY6H7jC8ClBM9W0QZdWxFVGpfdGQSwl5xSk1e10KGFdSuznw4UEqveez8mSL+OVj+l4s/pbUMqcOmAF2AU/igncvUhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191652; c=relaxed/simple;
	bh=h7q/acvtv/EbvBgEu40V7O6TnS/rdJMYxd+3YF+xHDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9nDQSv8E99m0ghU2XtI2O3LGoUszcqtpBIjSGJmeIatrUcrUFvf+wcHgYm5ONLfdBz2BsQp1XLxyDTW2g04gFv6jjJnI9kU9PaJD3/WU9GbhLJjXSm2TTP29XY838eyrjW2kJtP5sWbVFe0X02Fkjqp02BTu6YZ6TekGYAZbg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=VHk3xHnx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso637139866b.3
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 01:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191648; x=1730796448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CK//WN8U4xdL+REXrdvFlQyVdfbEwHB2hFl4Gz57z6E=;
        b=VHk3xHnxYx/5IhZpFDa3Ql8KImeAsQL5mb8xKJdrdQqQfposhhLdEDca89cRgrxY0N
         tdz9bxDw5szNNzxZgCEXmgGwXr32MxIiU8+5Vd+ajnKzEEjCbNFGXHjzHGuI5mUPiepW
         KtQFfQE9CcY7g25M4uExGAG7IgaBeSoRk1sXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191648; x=1730796448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK//WN8U4xdL+REXrdvFlQyVdfbEwHB2hFl4Gz57z6E=;
        b=tYQ4JOpc8EBavF8Tz+BwcDmttUrX6FNNawC27rA3ajQIu4PVuJ7zF9zuEuFl1cv1xD
         2nJP621jqrFE69H9TBhIRi1SrzPlM6lryiX7E+1OCmIbKIfTmCUByXHptx1DQSDgrglj
         EB4vzTK/asWH5B13+6gUkXXw/vLWi5O486QEOoPpNGSo00RT0fg1NbWvJQhW+DFCYE6N
         +lJf4duXDANyRk1ZmsKEeneBdB8aNcixckeGv3CMTHcvvuuYADrLWfbwFDZ4X5yTLzQU
         kFJU2RnJUj3qHewEh+9IYuLieLoBgonl/Ue3QKkRPCVlV8hi0x40r8KWwjE4UhBARvpc
         JwqA==
X-Forwarded-Encrypted: i=1; AJvYcCUGe899RXre1Zus4UtP122mDaO0mchZKr4flJIW4p64MtoLzrmuaJvvGjonbBrlXreRP7USoLT7Tjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCuXC5bpJxMqmYRP0t5zymrcIwS0srAlfUJkc/Jfv3HjRAvLUZ
	k5HrXtTX+OTFk6ALss/Tx216EvPRT/j0c9v6F5VAl15bjCkdDbrhepgsObUY4ZE=
X-Google-Smtp-Source: AGHT+IEEvcd9jXfbuVGlCd40DSEmDtz/pFWMMuaMwVq9ls2ukas2NGlSAug7KVnalEtyIqCy75g4iw==
X-Received: by 2002:a17:907:2d93:b0:a9a:3f9d:62f8 with SMTP id a640c23a62f3a-a9de5ce1831mr1160141666b.19.1730191648241;
        Tue, 29 Oct 2024 01:47:28 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:47:27 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 4/6] can: flexcan: use helpers to setup the error frame
Date: Tue, 29 Oct 2024 09:44:48 +0100
Message-ID: <20241029084525.2858224-5-dario.binacchi@amarulasolutions.com>
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

The patch replaces the code that directly accesses cf->data[] for setting
up the CAN error frame with the appropriate helpers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Replace the macros with static inline funcions calls.
- Update the commit message

 drivers/net/can/flexcan/flexcan-core.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 790b8e162d73..85a124a31752 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -828,33 +828,31 @@ static void flexcan_irq_bus_err(struct net_device *dev, u32 reg_esr)
 	if (unlikely(!skb))
 		return;
 
-	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	can_frame_error_init(cf);
 
 	if (reg_esr & FLEXCAN_ESR_BIT1_ERR) {
 		netdev_dbg(dev, "BIT1_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		can_frame_set_err_bit1(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_BIT0_ERR) {
 		netdev_dbg(dev, "BIT0_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		can_frame_set_err_bit0(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_ACK_ERR) {
 		netdev_dbg(dev, "ACK_ERR irq\n");
-		cf->can_id |= CAN_ERR_ACK;
-		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		can_frame_set_err_ack(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_CRC_ERR) {
 		netdev_dbg(dev, "CRC_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT;
-		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		can_frame_set_err_crc(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_FRM_ERR) {
 		netdev_dbg(dev, "FRM_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+		can_frame_set_err_form(cf);
 	}
 	if (reg_esr & FLEXCAN_ESR_STF_ERR) {
 		netdev_dbg(dev, "STF_ERR irq\n");
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		can_frame_set_err_stuff(cf);
 	}
 
 	can_update_bus_error_stats(dev, cf);
-- 
2.43.0


