Return-Path: <linux-can+bounces-211-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6756184C77D
	for <lists+linux-can@lfdr.de>; Wed,  7 Feb 2024 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E45D287C0B
	for <lists+linux-can@lfdr.de>; Wed,  7 Feb 2024 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F184328DB;
	Wed,  7 Feb 2024 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yr52eb1m"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA52D61A
	for <linux-can@vger.kernel.org>; Wed,  7 Feb 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298369; cv=none; b=IePyGdRxJ7ygYCdQpPWevO4FWCyQHtn1XnPwZeSIQLj8fn0EaKiONA6GbszBq9/Ztmy44pNACQFCLCbzkT4CC3HZS/ludUPM7kE25QzQvOfGYD/PHiYVtWDPPADXNNvVBsugZ+hXD+ZL2SNKkZeu8Mh5NNDwMv6g8CZkJ0zy7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298369; c=relaxed/simple;
	bh=aKBUlv2DFPCwVWl5pJMCuyW+k9TrqdFHUb5U5vXcunk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2HLFpjT7RD8TEGbkpCcmXzmhdjrE8TYNvM5+Xs2xiHrZ1S8awDdKmebosz7pMjiw7Du+6zE6qJbMN8xHC7WRV+rN+uVFKwff7tLwMZo912ufcfKTIfEEI1OhxJb1Bi9miXK8+2VBK8mK3+oyDf9O+xn3iwLQygqfw18+xnhqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yr52eb1m; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a30e445602cso313746466b.0
        for <linux-can@vger.kernel.org>; Wed, 07 Feb 2024 01:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298366; x=1707903166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wnVAPfyJw/OWLzF0KC9/8j6EFFYXdSKnHtbnBIj0M4=;
        b=yr52eb1mW125jCltaBGmDjWa/s//g6OqeZgJm5+0jg99pU05Hq3lxheaasPtXu2Fmv
         Kxsv/KykeFvUskDsHI0d6U8F7W9TtzLdMiN45+7V4v8YOP1lVwIojtt0+m67IYtKOfId
         a1coJOe+p5R3ie1HGHqZfN9f+EfQF84wZLQdd5uL1w0KG4EYHKO84kMTMrxdpmtZ+Ek9
         miQ5qO4jupNeKC+Hj/l6SfamsDnOIVl6/je1uKNqNx4tzoFJvve8b2qlF9l62+JEMwyI
         dXRj5hzv5WxM0p84joxOE5Vlnt9y1M3v+87qni+xZJ/FogbV13aqIWsqFQ0LM5LYQvHt
         kYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298366; x=1707903166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wnVAPfyJw/OWLzF0KC9/8j6EFFYXdSKnHtbnBIj0M4=;
        b=XXTPT9eSSBtc4Nmor0+vQDAt1w+3vy7Wah1ndZq4SAzwNrZRvz4W76k6+MnNBmgBEU
         prrelpkRhSNFKHFJq6x1+a4YsWmgAzSszRkAjxLsm3d/Rgr8/AEZ61loCFzKdxRwyG4K
         OvAA0W2rzSV2w6Jtp8BTW148+WG6H7TXWW2EWwZKb47fvxg1pReyj7STHzvPLJdrQw+u
         1PXrbhBS2aaxNnSqKH4i3O/o4q5AA5TOK9DA6VKyvR7w2WBwJntBiqT5LSm/6O+EBrQx
         cwEUaassgkV2pOH/mADSYW7izK3bXidgaXl/VMz3Ai8ZSw9T3sqv64zBNq88103Qd9XR
         QMxQ==
X-Gm-Message-State: AOJu0YzggFzdK8c8s+BwngLrTgVgJwBBuHMzwNH9rS4Z/uwLGpjbCWS4
	ezm7rwN2yrsH9EHIyC8O0qsFjv3jtacHpY2Yc43/4qLtWcFnC2H53RBOwqAaj3I=
X-Google-Smtp-Source: AGHT+IH/ac8IYvq7UtxjoqJsQqsYKi7OfrJ0bxLeaVa4t92XhpXT9PVqfuRz747vxJlfzrBWeeQQBg==
X-Received: by 2002:a17:906:4a55:b0:a29:b31d:1dc6 with SMTP id a21-20020a1709064a5500b00a29b31d1dc6mr6433899ejv.6.1707298365844;
        Wed, 07 Feb 2024 01:32:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyB+sEDgwVroEEABf/EC8CBwKYStKI1pDrhDVBp+wYYsW4z0rBIht3GoJpe1ZZTp/K+ai0i4RUed/8k/inlZRsbRhPDmbz3gJziXnSv0jqDCMReuRfCEczWtF+zhjLDTBgI+LIOzdbOxRLYhEMIsUXEWp7MvDvFTF2u6ufwunQn0pxxCxKyL5WPNGtEscZwe6wpspeFo3MZWDn4n5YHlOM7GvEQ5UXs+NTmmCSTtJT7A52yYwhr+YVNjBl5snpno56dRb02mTzj31OO5UlCbJj0F3jw9Vy8f8fQ2A/EI2lxOoMmC4HvIInNfUKzKh1ZQ0N1v+CTkaOYR9X4RanHuIwNuMGYodxcc9CTwMXobhGL9VPODR8Ge/RTdzyM4JPch8qARgg81F9K18vp0GqQxwuATlYxYqTtXSlYcAtjs1Yop6sInKLSBUtX88hx/NfVYUImd2obnrdNkRmn34Rt8eGf4FUa2oK
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:45 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <horms@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH 09/14] can: m_can: Cache tx putidx
Date: Wed,  7 Feb 2024 10:32:15 +0100
Message-ID: <20240207093220.2681425-10-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207093220.2681425-1-msp@baylibre.com>
References: <20240207093220.2681425-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m_can_tx_handler is the only place where data is written to the tx fifo.
We can calculate the putidx in the driver code here to avoid the
dependency on the txfqs register.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 8 +++++++-
 drivers/net/can/m_can/m_can.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 1b62613f195c..a8e7b910ef81 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1504,6 +1504,10 @@ static int m_can_start(struct net_device *dev)
 
 	m_can_enable_all_interrupts(cdev);
 
+	if (cdev->version > 30)
+		cdev->tx_fifo_putidx = FIELD_GET(TXFQS_TFQPI_MASK,
+						 m_can_read(cdev, M_CAN_TXFQS));
+
 	return 0;
 }
 
@@ -1793,7 +1797,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 		}
 
 		/* get put index for frame */
-		putidx = FIELD_GET(TXFQS_TFQPI_MASK, txfqs);
+		putidx = cdev->tx_fifo_putidx;
 
 		/* Construct DLC Field, with CAN-FD configuration.
 		 * Use the put index of the fifo as the message marker,
@@ -1827,6 +1831,8 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
+		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
+					0 : cdev->tx_fifo_putidx);
 
 		/* stop network queue if fifo full */
 		if (m_can_tx_fifo_full(cdev) ||
diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
index 1e461d305bce..0de42fc5ef1e 100644
--- a/drivers/net/can/m_can/m_can.h
+++ b/drivers/net/can/m_can/m_can.h
@@ -101,6 +101,9 @@ struct m_can_classdev {
 	u32 tx_max_coalesced_frames_irq;
 	u32 tx_coalesce_usecs_irq;
 
+	// Store this internally to avoid fetch delays on peripheral chips
+	int tx_fifo_putidx;
+
 	struct mram_cfg mcfg[MRAM_CFG_NUM];
 
 	struct hrtimer hrtimer;
-- 
2.43.0


