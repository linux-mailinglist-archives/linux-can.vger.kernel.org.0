Return-Path: <linux-can+bounces-2074-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B6C9D004D
	for <lists+linux-can@lfdr.de>; Sat, 16 Nov 2024 19:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6B8283F91
	for <lists+linux-can@lfdr.de>; Sat, 16 Nov 2024 18:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA4199EA8;
	Sat, 16 Nov 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IOzwUli6"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCECF193091
	for <linux-can@vger.kernel.org>; Sat, 16 Nov 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780193; cv=none; b=th69QwqThxBxa5rh5XcZ8MdkxQp+KkCGhCH4nJvFxjUzEANq2EyPbhApJyhc2gHG2+yobvG0D1qkdaN6SMams99CQ7HCV/zSiwHAfecdSKx3r39nWYluhc2rITbP8BpblQu9ZlVXAERi5/5/l5zfIkuJPwsN+21BS4PaBen4458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780193; c=relaxed/simple;
	bh=A34sGZ1LJl0UqZM4Ywby3Ot5AJSBqH2ddrj3nuGd0os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H2ocRcEQcV1TCtFgCGdG9me1E7PO5U6NCZjKyUjnVGinoGSMf3R0Jibl2X6wMWMTkVrGNKAxCHyUxj5cclAFfFs4oRDVU5KqZ7ZnDKoUeeL9ku7CMmx65MOq3f5JQqcL83oSTH9FVlZApbV2xtBIUVHB+fXlA2ZPJM5bDBYNIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=IOzwUli6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa20c733e92so255623066b.0
        for <linux-can@vger.kernel.org>; Sat, 16 Nov 2024 10:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780190; x=1732384990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKS1He5MRcB9KzHlUh7sCjUXRUA/E/nSRL0TriRLZjg=;
        b=IOzwUli6lxoPfAGdmsommEzymo7E/Gf2QmVx3z6spbZionuPtyq/b4yhuTeQ0HNc9M
         CHm9ugJCn0br6/wHKUyWoIdLDThfLAE/S2xu5eXHAlrd1Ne+zb4Xrpqb5dQ1edjq+aiG
         bZCorLoEnlEIReD3DCEMYzXo7Re0hGvtmFMr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780190; x=1732384990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MKS1He5MRcB9KzHlUh7sCjUXRUA/E/nSRL0TriRLZjg=;
        b=C4XgkDCSzRGzzNVN0Rh3qPgA9Wwys3+sGduZ6yZXgt8nWnAIdZhVq7pMrHxwwBXwhG
         NrlLUU3H0fpphjrFw5nYToiRH1eA6WWA165Wv/OYgUigQXRjPvnPRqcfbiVKOjbKTT/g
         AQijc7KOB1O0Y4iqTbOiswc1tIxWFgUlX9fM1vMJiVeoKfQcFUFi7AAEwvR/xcQWkCOv
         h1esBHeDi3iglJvSbmoW2h+/azi750iiBbLzrl7Z2k5vf/cqjbA6ot81rijApx7MJE4a
         gHbJ0QYCArVnmv6f5Wu0u5kO0d277gV3E3KkbN1ICpciZDo3FpbtsU/B+S36ynMr2dOe
         N1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWYAUyVHsIt7U6me1DvqPS43ZEPZ9dIcQKqTCbt7KlxdjOIpGk/hY6SItjECp/O4/CG/d6vb8pag9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLSu/yW36Z6SbIAiUvW+Uct0JmiFNYJi9ktEo+nDswy8KauZK
	hz/9HKDdcXXCEjcU5y0pip6Gc+RIGOzPMtmDxk0a7u+sl7CDGTra/FVkYx7dtJDzRtCv+yJY0Om
	i
X-Google-Smtp-Source: AGHT+IFQitaQvnvCpjPNTAPjRJikCJXH/36A9a4AKWk86qEm3fbIuRU18rHtQaOlozEwQjJKTxS63g==
X-Received: by 2002:a17:906:d542:b0:a99:f887:ec1d with SMTP id a640c23a62f3a-aa48354c913mr613773866b.49.1731780189884;
        Sat, 16 Nov 2024 10:03:09 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:09 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 2/7] can: ifi_canfd: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:31 +0100
Message-ID: <20241116180301.3935879-3-dario.binacchi@amarulasolutions.com>
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

The ifi_canfd_handle_lec_err() function was incorrectly incrementing only
the receive error counter, even in cases of bit or acknowledgment errors
that occur during transmission. The patch fixes the issue by incrementing
the appropriate counter based on the type of error.

Fixes: 5bbd655a8bd0 ("can: ifi: Add more detailed error reporting")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/ifi_canfd/ifi_canfd.c | 29 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index d32b10900d2f..3944821303fc 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -390,7 +390,6 @@ static int ifi_canfd_handle_lec_err(struct net_device *ndev)
 		return 0;
 
 	priv->can.can_stats.bus_error++;
-	stats->rx_errors++;
 
 	/* Propagate the error condition to the CAN stack. */
 	skb = alloc_can_err_skb(ndev, &cf);
@@ -400,26 +399,40 @@ static int ifi_canfd_handle_lec_err(struct net_device *ndev)
 	/* Read the error counter register and check for new errors. */
 	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-	if (errctr & IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST)
+	if (errctr & IFI_CANFD_ERROR_CTR_OVERLOAD_FIRST) {
 		cf->data[2] |= CAN_ERR_PROT_OVERLOAD;
+		stats->rx_errors++;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST)
+	if (errctr & IFI_CANFD_ERROR_CTR_ACK_ERROR_FIRST) {
 		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		stats->tx_errors++;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST)
+	if (errctr & IFI_CANFD_ERROR_CTR_BIT0_ERROR_FIRST) {
 		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		stats->tx_errors++;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST)
+	if (errctr & IFI_CANFD_ERROR_CTR_BIT1_ERROR_FIRST) {
 		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		stats->tx_errors++;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST)
+	if (errctr & IFI_CANFD_ERROR_CTR_STUFF_ERROR_FIRST) {
 		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		stats->rx_errors++;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST)
+	if (errctr & IFI_CANFD_ERROR_CTR_CRC_ERROR_FIRST) {
 		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		stats->rx_errors++;
+	}
 
-	if (errctr & IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST)
+	if (errctr & IFI_CANFD_ERROR_CTR_FORM_ERROR_FIRST) {
 		cf->data[2] |= CAN_ERR_PROT_FORM;
+		stats->rx_errors++;
+	}
 
 	/* Reset the error counter, ack the IRQ and re-enable the counter. */
 	writel(IFI_CANFD_ERROR_CTR_ER_RESET, priv->base + IFI_CANFD_ERROR_CTR);
-- 
2.43.0


