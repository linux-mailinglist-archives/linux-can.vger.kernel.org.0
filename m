Return-Path: <linux-can+bounces-1123-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3DD9481A6
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 20:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904171C21C21
	for <lists+linux-can@lfdr.de>; Mon,  5 Aug 2024 18:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9114416BE13;
	Mon,  5 Aug 2024 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MGgdwHrj"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230616CD0C
	for <linux-can@vger.kernel.org>; Mon,  5 Aug 2024 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882694; cv=none; b=cbcmxJU3TPlVyXRJMXpKH7m98/46OcSfcbB5h66G+iNd3i/Ygu6UD8ILuoCIcRn7kl/hdlvQiYj3AKpsP5n+lABDAFEPv6lzL0SJaeSwNz2efWITJoWuTmxmMgh0/9Koldb4zyHqMsz8+TWnTCeu4KBCPRk+/H3eKVevLb6rtDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882694; c=relaxed/simple;
	bh=ChE2g8Bo15dbwXQCCELmyUPyayPuAqr/37EK4Q7ZpbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsANCbsond47/mz//pB63FNvcoEeXqYvMF1fCAt1vkPsordvs1kAmkMraXquCgpv8/wb3L+ZO6sSXN8MHX/wk6YtZGj0pxQmuuvhJ90yQO74MkU0Blk94tvgrnGr3ulDFqRG1ZRDd/3MSwfNl/8KGqZLOx+4jx6JrzC6V+8urcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MGgdwHrj; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39b04f0b486so24071245ab.0
        for <linux-can@vger.kernel.org>; Mon, 05 Aug 2024 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722882692; x=1723487492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt7QmiC+1K2MGxeb2j6VpzaOIs10RnCuQP9HHad9ocQ=;
        b=MGgdwHrjvjGji3glD5U++0SrVoXTlB2Dl3dc3MSCu1tPObTpuhxJXWBlElVZ4/XKEf
         7ICWR+SsD+cEICW00mUpVCqbgmoyRjPoMki2KGO4j3SqB5VUJVhE7u/bBEfvZVEoIF70
         hFQukWnI9b8wRevPfKaSb9RnFjtMevXNVrdjKe4M13oWL77lyfbnOKlr33P97taeE3w9
         5omJ194jLesJBiKQoiGCHek7NCVZIuLvK5tGQPUM9X5jUEC8C33NjHoR02hgBCQrtGQz
         9yDtqxY78L2IAZRrSo1reXF0KPpSTJjNkXC/drQYr+94XK9368y0e3h9QP5JjrGU8A2T
         pMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882692; x=1723487492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt7QmiC+1K2MGxeb2j6VpzaOIs10RnCuQP9HHad9ocQ=;
        b=jvGy73PdSy5sAS+wlmsb3b/y+enoZJKm+o6X/0yhycAMWK4CUEYR6Exg3P9u3WXmKK
         1w3CjPrAufJtQUCQxW0k9zTHQQ1embMQaSqZtqkflcOvZCWvgbMu1Ej0mAxLve2uPI1w
         ejFxhhuhs81gv8XM9mGG6hfaf7ZLK7Ypr/Mb6aySInzAIzb17zr32eLX2+8/U98EW7qt
         /mym6PEsVFLv30lytpcCRKrXK6uF/uWeNVBGiHBzJ0S96JGk4VKtdKatbTPO5K319Wcg
         lZPj15hiZaySqEoPhDS3RCvfxLf4+6qa3c6Yx/sRdf+A5a/4ZCjzTC39ExAXfJCLYBAH
         2ckQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJD1qM0CbCZTW+V8C5sx12aZmLtwEoyL6xUFKWPeo1kg8tBs23JEJVKa88aDrB8erNbWSu1BugvLUSUQJtAW23pGdgeCImPULf
X-Gm-Message-State: AOJu0Yws2cc7hoWdtiHBV9QchvyskpjQzWoqAUNENH9l9CHuHd2c3aOO
	q2OcWd6Xxw5npjbnwoAUpyZ6lId2eqI2Wc/SP+iwnkWbrKUyNLf+86iwpsH7jMA=
X-Google-Smtp-Source: AGHT+IFsYDvT/ScJTO38P4uPEY7MfcyBrpm0xyFckk7S5UPZJYPzTYR+VYnkh8TLJZtvjqPo5U1Jew==
X-Received: by 2002:a05:6e02:214b:b0:39b:32f6:5e90 with SMTP id e9e14a558f8ab-39b32f65ed5mr87967485ab.15.1722882692118;
        Mon, 05 Aug 2024 11:31:32 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9af29sm30867925ab.13.2024.08.05.11.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 11:31:31 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	Tony Lindgren <tony@atomide.com>,
	Simon Horman <horms@kernel.org>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] can: m_can: Limit coalescing to peripheral instances
Date: Mon,  5 Aug 2024 20:30:47 +0200
Message-ID: <20240805183047.305630-8-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805183047.305630-1-msp@baylibre.com>
References: <20240805183047.305630-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of coalescing for non-peripheral chips in the current
implementation is limited to non-existing. Disable the possibility to
set coalescing through ethtool.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 69a7cbce19b4..5fd1af75682c 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2181,7 +2181,7 @@ static int m_can_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static const struct ethtool_ops m_can_ethtool_ops = {
+static const struct ethtool_ops m_can_ethtool_ops_coalescing = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS_IRQ |
 		ETHTOOL_COALESCE_RX_MAX_FRAMES_IRQ |
 		ETHTOOL_COALESCE_TX_USECS_IRQ |
@@ -2192,18 +2192,20 @@ static const struct ethtool_ops m_can_ethtool_ops = {
 	.set_coalesce = m_can_set_coalesce,
 };
 
-static const struct ethtool_ops m_can_ethtool_ops_polling = {
+static const struct ethtool_ops m_can_ethtool_ops = {
 	.get_ts_info = ethtool_op_get_ts_info,
 };
 
-static int register_m_can_dev(struct net_device *dev)
+static int register_m_can_dev(struct m_can_classdev *cdev)
 {
+	struct net_device *dev = cdev->net;
+
 	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &m_can_netdev_ops;
-	if (dev->irq)
-		dev->ethtool_ops = &m_can_ethtool_ops;
+	if (dev->irq && cdev->is_peripheral)
+		dev->ethtool_ops = &m_can_ethtool_ops_coalescing;
 	else
-		dev->ethtool_ops = &m_can_ethtool_ops_polling;
+		dev->ethtool_ops = &m_can_ethtool_ops;
 
 	return register_candev(dev);
 }
@@ -2389,7 +2391,7 @@ int m_can_class_register(struct m_can_classdev *cdev)
 	if (ret)
 		goto rx_offload_del;
 
-	ret = register_m_can_dev(cdev->net);
+	ret = register_m_can_dev(cdev);
 	if (ret) {
 		dev_err(cdev->dev, "registering %s failed (err=%d)\n",
 			cdev->net->name, ret);
-- 
2.45.2


