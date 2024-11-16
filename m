Return-Path: <linux-can+bounces-2078-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D79D0059
	for <lists+linux-can@lfdr.de>; Sat, 16 Nov 2024 19:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA5E1F23FF0
	for <lists+linux-can@lfdr.de>; Sat, 16 Nov 2024 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5A41BC065;
	Sat, 16 Nov 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M/o9Or9q"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D111B6D1D
	for <linux-can@vger.kernel.org>; Sat, 16 Nov 2024 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780202; cv=none; b=GVf9H/2NbvoMYULQPVdCMFNmJEgK9y4x/lsV4I1MCszxgEHsAGKqIxCtxRHcSCw6LtSCjVF71phDUjH4f3YW8BSHNfqTV+xxtbVd7HyKNFDbQ/kywshlfC54SJQ7gk5waQupDE8SN4C9cyS8fICtA1YOWv4wl812aFaX/I8GXUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780202; c=relaxed/simple;
	bh=nrpSX80iZEgD1tyuub9lydq0DIRCuLzTN3EI9VOm5RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVFQKCCVtNcKzuuu/cWCIUSunz5TZQsdQY+GGj0h+j8TGWSoSPvs6KyZsZur7ttpyszWr3DhhqWBkfCvKBJ2ffGv7R0EBa1EEkkBM4j1gmApL3CvVh9HXWeYPVgLwrD+PJ17XntySYWA0Eamhby47ptN75J5NaeC3DQZH2KgJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=M/o9Or9q; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so713264f8f.2
        for <linux-can@vger.kernel.org>; Sat, 16 Nov 2024 10:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780199; x=1732384999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzqc0qf43o4g73YzOl/3Mk2ZcRlSoSU0wYKvIRYgWeY=;
        b=M/o9Or9qDKQO6Miry9Q2iBYlM2DRWw4iWxL35GLPW+3oyJe99RrGwrcCcPLoO1XQtd
         8SumikWdm0I/2B1NJc+EQODXwn9UC3hbItUiDFsnjNMrMKFPlKHbT+dVgNcsQg7ytnPF
         dgudLLpLriV8soznxDZ9UYOUlg43oMldjBi2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780199; x=1732384999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzqc0qf43o4g73YzOl/3Mk2ZcRlSoSU0wYKvIRYgWeY=;
        b=L9mHw7ojv8FXHGmfEEtCG7Gu55wufEUmUPqKWX49WG+bIEoUwReYkLpuE4UYV17Hgg
         /a+UvNvSU5YDc9mrPHocd6LhzX2CX+Br8YpSVrrQa7BudqgP/8sZnAmw7rLcSV3UYVHs
         fcz/s/4tvAYp6ahJvyAs24e0LwWSbpwN1kIKiyZZKFEu9Pkx1xDVkohSEP6tpI2DBm7f
         7njqJzjk0f1CWtXi+hou6Ujp73mVZ3pPdU6GVUyNmU3qSHvE2U5PIA9u1GRsvzN3GnnE
         59QJ2HbeIVty7DDdk4Skku68sdBJ42pmhRnt2pGNED1nXX9IHktzhBVQ7NTo9ErYbS5F
         TjSw==
X-Forwarded-Encrypted: i=1; AJvYcCWTpbMPLxGkBOJjw1DlLiipU+SNhZVjwqflJFK7dDW78GzsA95deNhkf2Dm+dZVAE6bftAWsbJ74Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59QTuIGyQ5E9FpUJV3GlNOUWpm+3Fih6nnU+XBhrIaw3kzahh
	RF0QmBU6MN4KyB42jbYCXJOtZrxViLS0NsvYVNVaMHtVZarUc9+W3v3ch3xgVQU=
X-Google-Smtp-Source: AGHT+IGkyP3qGN+tINbIZ4XNnyhPqXqEDpgjVb/byBCp6YrVMvdl+zOjNIxpY2yrRpZDbbYKagylow==
X-Received: by 2002:a05:6000:4213:b0:37d:5042:c8de with SMTP id ffacd0b85a97d-38225a45297mr6503959f8f.22.1731780199189;
        Sat, 16 Nov 2024 10:03:19 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:18 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Haas <haas@ems-wuensche.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 6/7] can: ems_usb: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:35 +0100
Message-ID: <20241116180301.3935879-7-dario.binacchi@amarulasolutions.com>
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

The ems_usb_rx_err() function only incremented the receive error counter
and never the transmit error counter, even if the ECC_DIR flag reported
that an error had occurred during transmission. The patch increments the
receive/transmit error counter based on the value of the ECC_DIR flag.

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/usb/ems_usb.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 050c0b49938a..98a70a2fe189 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -361,7 +361,6 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 
 		/* bus error interrupt */
 		dev->can.can_stats.bus_error++;
-		stats->rx_errors++;
 
 		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
@@ -381,8 +380,12 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 		}
 
 		/* Error occurred during transmission? */
-		if ((ecc & SJA1000_ECC_DIR) == 0)
+		if ((ecc & SJA1000_ECC_DIR) == 0) {
 			cf->data[2] |= CAN_ERR_PROT_TX;
+			stats->tx_errors++;
+		} else {
+			stats->rx_errors++;
+		}
 
 		if (dev->can.state == CAN_STATE_ERROR_WARNING ||
 		    dev->can.state == CAN_STATE_ERROR_PASSIVE) {
-- 
2.43.0


