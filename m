Return-Path: <linux-can+bounces-1837-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C249B4893
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 12:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7071F23932
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 11:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E3205AC7;
	Tue, 29 Oct 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PinnH299"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B517020604D
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 11:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202398; cv=none; b=IVysHvycCKdA6jQWVFDcDNdnmkg1xFwyy+N9UfkAbrTU4Sc+9ooOjwpKRgni1xXqyR2/+nr9Ys0iFL2SNctrnuXv04eqAA24RER4tTvUUlaOUfJ22jZ6fCuRlk0DsaB599JwsYrmxRHRJvEEcUwXibiYy0QTnzkhgLiSbMeUT8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202398; c=relaxed/simple;
	bh=ObcxKrOJuRTNwCOEUuw+kHKZ0OKSz2WYHmM1Yr7rSe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0hn2p7gKAacrT85WUCibpdZmcrckTe1UKicsguDTSSUq4F6x2gDnSeZmekqU/qF4nMYJLlCMJI9e3ep4ozlY8T915j0Conv985NvVmaE/LfZKLJ9jC+wXKYtwrMID0mTaXl7+8aEoydFF09A8Bx0Btaa3aKlPC6k4P7DKsfbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=PinnH299; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c96df52c52so6705024a12.1
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 04:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202395; x=1730807195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7adbskWkIDNXIMmiplteQ28nVqw9eSy+g9bzGzeRhzI=;
        b=PinnH299/uEy4TxyYXuZhDS/pn+2eH4oHGcd9XwzRb9S4mBn0goYlyuqvWoSxyR+LD
         ti7Go3C6H8l850c6IlCpeqywWGELhU12icqtX3eVBXHq9bsp1hXeNAnzBJOs1Tj/AiTZ
         5CucjPNsDO4bhRxzCDD3Scz0e76R6e9R6HAWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202395; x=1730807195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7adbskWkIDNXIMmiplteQ28nVqw9eSy+g9bzGzeRhzI=;
        b=RpFe/xFipR0N443f0uKb8lv/WQdkWrZ62w90qr56UQl3pVVKGddJRSOXbzZZpEjjQ4
         Me4ulS5/Urt2HReKCc+l6JmsMOky9tv6AJIdGuTsRYR5cYBAoGUWhFF+5QVaXv44R/sb
         EeFMR9lP/cTlcqJlc08er+WizF6gtc08VjxCViuVUcOa+8A3wDjMxMlPhapfM9rcpbyx
         rBqdFDcvodya/FXo4/EcIaHKl5Zm+6Sb/xbmiSrougq7khg+6LMvNfnJa1hgcnUQQ0tV
         QYQTz00FWut4cVjUL+1oXi5xxA8i3Bx6mMHBdH2mB+4+LubqLJiQ/8dthvKT5s5c6J5C
         PrCA==
X-Forwarded-Encrypted: i=1; AJvYcCXGgbdHIcYDETU+tYNz4mLni80Fnelsw61pwJ73X5vQvgwyp3GJkt2Yn+NeyGcJ1qR4XPugz/QZVn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEqsrwFnQJrwggMzaew4MCrnaX/pTMu3g3TufQDeD9QY9huL2
	v27MeRqC1/SJG0sUGskx9zIDrVx2+tEChFPUhF4ZJ7k1iQS9c6msxCy9rmQyQLE=
X-Google-Smtp-Source: AGHT+IEHZCG9S0yeWDe0PN2X2hte0+8dcnp+dlwTiRKwdv0plWgzGS6JkeJjpjq8WZy/HEjHYA/Vhw==
X-Received: by 2002:a05:6402:43cb:b0:5cb:6ca3:af96 with SMTP id 4fb4d7f45d1cf-5cbbf8acc32mr10238323a12.19.1730202394731;
        Tue, 29 Oct 2024 04:46:34 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:34 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [RFC PATCH v3 4/6] can: flexcan: use helpers to setup the error frame
Date: Tue, 29 Oct 2024 12:45:28 +0100
Message-ID: <20241029114622.2989827-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
References: <20241029114622.2989827-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v2)

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


