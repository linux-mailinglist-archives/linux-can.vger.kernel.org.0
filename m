Return-Path: <linux-can+bounces-2184-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1989D65A0
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7526282397
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE04118DF7F;
	Fri, 22 Nov 2024 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bkbNsZ9e"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900E18732B
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313818; cv=none; b=GZdEbGLFOoOy9k5NZvX6l5ITCLf2C8eHeff3rikMSjYSFZHLMiAjl/0chCalin6fSZ6I0LvzpqGJ91oV+g6FNGgkSe5ZV8UfbMSVcPIFRl0uaqKaC1Lj2+NrfNWvxjljFybFjv++zd5ddRWeJWasULIiuCIDcce67AOjnO592w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313818; c=relaxed/simple;
	bh=ldxR7DmjrgRcjjZ1Z/p/luxN1xxh7dfLbpLVH96Oblw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ogce8WtVViJwobtWyR3ULY9Y9p3umNTe7Hbk5D9cC2dMtp+QM1Ex8tbn73X+q/eFjM08P4BnU63RfZMnWOiaAXOP3ukat/xX/EWfME/WMReHdgaNtJPYn56AP7H+PSwzwSKD0KHCQMEpYGmBFBcLyKZAsrsd4T0veG87XD4XEjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=bkbNsZ9e; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539e63c8678so2954854e87.0
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313815; x=1732918615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXl+FSVARqVcRtIxq69Tn4oF98SIhVQqmrh7i+R1ZlE=;
        b=bkbNsZ9eaWAvGMRAzTcz9B8FpGfDFioyNBSHHNJzxKhfa1QFmu++vLFtiVnXxbkcyF
         +wFozAHgbeGaPcDup+3ENtLk22rJPmqmzcYO5l/jRjCx/OGeICUFaOhDLNnrJu0qvLFf
         dq2Tu4aZ89taKZGrnQlmBSZV2/u0AbKun65D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313815; x=1732918615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXl+FSVARqVcRtIxq69Tn4oF98SIhVQqmrh7i+R1ZlE=;
        b=hmiDrDsREL509ERxpx1hImXQlD0puk7qEzg1Ljg+PLWuqAh4Gt2SzwTRZERgr0r60C
         8YExWbUS9sF7ck91fRXkEs0W/1xrDhA1his1SaXapeAcRW3OmjjbHWFf3FAD1vGVasG8
         E0sXj7PSrw+n77Fm9AlrWJcbceuS1sNjgS3LVBqHWAHqd+02jktfgRfmvoCcNQacSRgS
         ObQcEddoHc2XWmdfpT2wIdh2tgayn0AlD7GE1PLvO7uzkbjwNWcRXPTxUmDbZqby5c51
         SS896Sz8AKcShi4NIVygRudW4EEnZ+HsWQxvGGaDvYGVD9owqxWY2vO+C2xrk8YboE9V
         q/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWi6Dl2VDVYOtpIYERm0eYx4xy39bRnjXZmcKU7uomi1SZ/rqMLXaBcIAwy+wJJXaFB4UDCzFU7Lac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxglU+jZ92jlGRDv2d956N7AOYC1pUGSfZBy8QcwKZRvIkoVX3J
	sAXLyJP2abqiR995OmJxeH2NKCh23LKGf6mApBnKU8KlrNLGkUIwjiEQqYwVMEA=
X-Gm-Gg: ASbGncue8YWKPdWsCxq0l2rzbKE17g2c/MBhoPt8UzN81JXqEhdN8JcKG1IweCW2mF7
	8WEVsf+SzxEUlfn4L1yzqDOb5A16ggUfz8yYdBSYtwxSjgAFcg1r59lYvvaIXvhhZe3wZiYyKfB
	B541JTQnSrOAta/91hf53SmRH9YaduigJBPSzcGcVod/tzcuMITVfTiQcHknaiu6yjs+SYAXCYB
	1tpkNWZbiE5cxHp1bT9G9+rZ+fGETn5hFtQjgRys5vQ178ljvYqZh0GPSlKVUhmc+mdAsfs2EAo
	8LLHa3GXYKFRnScjsXnhKIdw6erSkf4/qo/v6r4S6VItQsmAMUaBg4Ivlqfe34sdUPd/SyRWBfX
	gLesuNVqKPwUzvE5G
X-Google-Smtp-Source: AGHT+IHPZQFrM56J/OIyk1Q59hKMDjmlud7peYUn3uyJVNqixLxLsv4xopNTFKGImm55L3dfJExZHQ==
X-Received: by 2002:a05:6512:39c3:b0:53d:d957:9f92 with SMTP id 2adb3069b0e04-53dd9579fd5mr1789697e87.9.1732313815331;
        Fri, 22 Nov 2024 14:16:55 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:16:55 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 01/12] can: c_can: update statistics if skb allocation fails
Date: Fri, 22 Nov 2024 23:15:42 +0100
Message-ID: <20241122221650.633981-2-dario.binacchi@amarulasolutions.com>
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

This patch ensures that the statistics are always updated, even if the
skb allocation fails.

Fixes: 4d6d26537940 ("can: c_can: fix {rx,tx}_errors statistics")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Added in v2

 drivers/net/can/c_can/c_can_main.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index 511615dc3341..cc371d0c9f3c 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -1014,49 +1014,57 @@ static int c_can_handle_bus_err(struct net_device *dev,
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
-	if (unlikely(!skb))
-		return 0;
 
 	/* check for 'last error code' which tells us the
 	 * type of the last error to occur on the CAN bus
 	 */
-	cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
+	if (likely(skb))
+		cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
 	switch (lec_type) {
 	case LEC_STUFF_ERROR:
 		netdev_dbg(dev, "stuff error\n");
-		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_STUFF;
 		stats->rx_errors++;
 		break;
 	case LEC_FORM_ERROR:
 		netdev_dbg(dev, "form error\n");
-		cf->data[2] |= CAN_ERR_PROT_FORM;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_FORM;
 		stats->rx_errors++;
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
-		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_ACK;
 		stats->tx_errors++;
 		break;
 	case LEC_BIT1_ERROR:
 		netdev_dbg(dev, "bit1 error\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT1;
 		stats->tx_errors++;
 		break;
 	case LEC_BIT0_ERROR:
 		netdev_dbg(dev, "bit0 error\n");
-		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		if (likely(skb))
+			cf->data[2] |= CAN_ERR_PROT_BIT0;
 		stats->tx_errors++;
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
-		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		if (likely(skb))
+			cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
 		stats->rx_errors++;
 		break;
 	default:
 		break;
 	}
 
+	if (unlikely(!skb))
+		return 0;
+
 	netif_receive_skb(skb);
 	return 1;
 }
-- 
2.43.0


