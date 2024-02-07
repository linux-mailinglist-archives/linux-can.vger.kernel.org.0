Return-Path: <linux-can+bounces-209-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 649D784C778
	for <lists+linux-can@lfdr.de>; Wed,  7 Feb 2024 10:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F221F28772
	for <lists+linux-can@lfdr.de>; Wed,  7 Feb 2024 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE362D605;
	Wed,  7 Feb 2024 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ElNcL92z"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501128DC9
	for <linux-can@vger.kernel.org>; Wed,  7 Feb 2024 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298367; cv=none; b=uDzO7g4M6kD3Nz2oTQCvTkjYCwoPpG8BELAtxX/5RBXhpQczGY1/t/prSoy/HoUhd+1haS8WdqQVZNwpFvLBFyLUh4ZJdX2NDuBOCZNakFr0iEh3QSwjqEJjQrg2AtaSu2AG5do0cfh6gxx65EOV4uWHJeoupSK+XvsynsPSf9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298367; c=relaxed/simple;
	bh=seS2mYXKgOsaStLXlO6Hn49jlysXxgYFKeFnkw5vJfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtKjLcE1xELcGMGXZloM3ydn6BmCwzmt4wDLMv8RH9nRXDtmaNKtpeRLgFrb2IjBL+f6HC/WlUCHUQo43FNbtxSPzYZclsDwSFO0sDDWZ5cKrJ/k/Ta0yzfG7opMIgRILj9TEJIhqukztg3H0wI8bfx0cGxyvwk6KNbtSmjVROg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ElNcL92z; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a30e445602cso313740266b.0
        for <linux-can@vger.kernel.org>; Wed, 07 Feb 2024 01:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707298363; x=1707903163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6gvVLaAJJ5SpKKyjtFK2dGPARZlV56P68Im7wENaso=;
        b=ElNcL92zZytcCLqFP1+TVlCj8Yovx4+m24BMXj1d58bgaxq0Qc0OezZ045zKoSb07g
         OnvXQoL1ENdLa4OVtGc2bwtpqYqnJ6mqDWAaJimF/e9xvmTmbFhDbC+SDCcaHX7vClT2
         V2bbHR8XU0M4faxIbli7xslXLz9dU2WbdhjzUZxb/mgrEc138v1x8PS1AnUoOJW3z6TV
         hbLruAJ7Fpw0yeEhWe0R/KC9QCCSvu/7Qu6hl2eJlgeEcN92JHYaazweJfp7/3cWlzfQ
         3qGTb7TOKYLKyVHKwAZBgx0UJ9xwnlKm3yy1M1zShowbQfCl88MuFnvBlzKxHMhrUhCS
         hSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298363; x=1707903163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6gvVLaAJJ5SpKKyjtFK2dGPARZlV56P68Im7wENaso=;
        b=ljYY2XoCkZhk2sA2EoesxhFfXu01g1o6flkGY7/EJqRjsC6mitaPf0P8YDST/+dH0e
         idMXOlPbCIu5H8JHwrG7Il9WGgDwaXe9O0wJucSlbWXYApw7RkQJtaMd6Kx4XeeqtM5j
         zmCL8rvJQo0+mRF4j3VueJu5UNxurcJNHUTUYQOY+glHr6XkQFAoPW8he3vmHfsGy+7e
         /C9MfYco5KFWZbpUK6RRvcYUx6dkYyOjMwM0r1vAD7OK0c1PqlDjA0PQ/L415gCPP2kH
         J2EzXx/sThkEXc81lQLb7IlcJCDUxBs+epkIRYobcFyt61DYfMzvRTb/vyww8XdUbJni
         UFyw==
X-Gm-Message-State: AOJu0Yx+4112PC9IsmeYiUfgdiFArbKGdWYF3jzCoDck6tCWw1Suuxew
	WAJFoAKFXuyCSiQN2LXuxZ27X3cyhNO91nX1cUFXKx81oAdO5HONOwkdKg1q9JU=
X-Google-Smtp-Source: AGHT+IF4HNyoCZO55se0l0BPy/4YtphyGqsi+TwNxxDdF9HYXHyHZIaQGsoQ99lmVCm7Vcvr+x611A==
X-Received: by 2002:a17:906:44:b0:a38:3e90:e1ed with SMTP id 4-20020a170906004400b00a383e90e1edmr3509955ejg.7.1707298363662;
        Wed, 07 Feb 2024 01:32:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7xANWpOEcVoy0cWd1FA3d7ebTG317SnEhRB7lk6E7hkiAm5/6uwcW/39kazc+PLqt/PycVuIndwdXlbvHklivYovFU0XLCRZolNboHaIrA+inwYWFahk3rhFF814b/f/FfsQcecFwhKMQqNpTvs0ElMJRwYC18K3nh+0NwRJOLby27hHiIHAwIKn3jTppClv9Kt8buQhwqyu+N7NhRIjKk46jsnlv5eDDrkh5H3a7F6oKNqpcSzUPwu3Zt6qx28AKc1kW7nd8tdwL0hBxPNbY/5TQOvvQqf5tBjHDTwrr7U+OoXS/Up3rNS2evgdY/iSLZtAIM6NYSg92Yr13AZvtyQ4f+t2JgzH6gIe33oitODQbP1vqNvONyuk9pI8N/8H51lk156oIVFqEaK9vdivsuKZWL02jVWzYuG6qWUCFC5V/tkQH2k5FCDBR
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id qo9-20020a170907874900b00a388e24f533sm122336ejc.148.2024.02.07.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:32:43 -0800 (PST)
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
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 07/14] can: m_can: Add tx coalescing ethtool support
Date: Wed,  7 Feb 2024 10:32:13 +0100
Message-ID: <20240207093220.2681425-8-msp@baylibre.com>
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

Add TX support to get/set functions for ethtool coalescing.
tx-frames-irq and tx-usecs-irq can only be set/unset together.
tx-frames-irq needs to be less than TXE and TXB.

As rx and tx share the same timer, rx-usecs-irq and tx-usecs-irq can be
enabled/disabled individually but they need to have the same value if
enabled.

Polling is excluded from TX irq coalescing.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 6dad1f569f82..b31df3e3ceeb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1986,6 +1986,8 @@ static int m_can_get_coalesce(struct net_device *dev,
 
 	ec->rx_max_coalesced_frames_irq = cdev->rx_max_coalesced_frames_irq;
 	ec->rx_coalesce_usecs_irq = cdev->rx_coalesce_usecs_irq;
+	ec->tx_max_coalesced_frames_irq = cdev->tx_max_coalesced_frames_irq;
+	ec->tx_coalesce_usecs_irq = cdev->tx_coalesce_usecs_irq;
 
 	return 0;
 }
@@ -2012,16 +2014,50 @@ static int m_can_set_coalesce(struct net_device *dev,
 		netdev_err(dev, "rx-frames-irq and rx-usecs-irq can only be set together\n");
 		return -EINVAL;
 	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXE].num) {
+		netdev_err(dev, "tx-frames-irq %u greater than the TX event FIFO %u\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXE].num);
+		return -EINVAL;
+	}
+	if (ec->tx_max_coalesced_frames_irq > cdev->mcfg[MRAM_TXB].num) {
+		netdev_err(dev, "tx-frames-irq %u greater than the TX FIFO %u\n",
+			   ec->tx_max_coalesced_frames_irq,
+			   cdev->mcfg[MRAM_TXB].num);
+		return -EINVAL;
+	}
+	if ((ec->tx_max_coalesced_frames_irq == 0) != (ec->tx_coalesce_usecs_irq == 0)) {
+		netdev_err(dev, "tx-frames-irq and tx-usecs-irq can only be set together\n");
+		return -EINVAL;
+	}
+	if (ec->rx_coalesce_usecs_irq != 0 && ec->tx_coalesce_usecs_irq != 0 &&
+	    ec->rx_coalesce_usecs_irq != ec->tx_coalesce_usecs_irq) {
+		netdev_err(dev, "rx-usecs-irq %u needs to be equal to tx-usecs-irq %u if both are enabled\n",
+			   ec->rx_coalesce_usecs_irq,
+			   ec->tx_coalesce_usecs_irq);
+		return -EINVAL;
+	}
 
 	cdev->rx_max_coalesced_frames_irq = ec->rx_max_coalesced_frames_irq;
 	cdev->rx_coalesce_usecs_irq = ec->rx_coalesce_usecs_irq;
+	cdev->tx_max_coalesced_frames_irq = ec->tx_max_coalesced_frames_irq;
+	cdev->tx_coalesce_usecs_irq = ec->tx_coalesce_usecs_irq;
+
+	if (cdev->rx_coalesce_usecs_irq)
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC);
+	else
+		cdev->irq_timer_wait =
+			ns_to_ktime(cdev->tx_coalesce_usecs_irq * NSEC_PER_USEC);
 
 	return 0;
 }
 
 static const struct ethtool_ops m_can_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
-		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ,
+		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
+		ETHTOOL_COALESCE_TX_USECS_IRQ |
+		ETHTOOL_COALESCE_TX_MAX_FRAMES_IRQ,
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_coalesce = m_can_get_coalesce,
 	.set_coalesce = m_can_set_coalesce,
-- 
2.43.0


