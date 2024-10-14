Return-Path: <linux-can+bounces-1655-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4203499D277
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07211284F72
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF351BE238;
	Mon, 14 Oct 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jb4S/I5q"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEE31B85CB
	for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919487; cv=none; b=TJMaQFC9siuMfNloBPdrueoItMPgoIsNys+PWSoKu7bbrA6cs8w1HbXE0zKIeNqv7si9pM3BeFg7UbePfPr/kbbwERyj55kGIwHxVL2BaMTpPITqDby//yoClaZb4tubjPc5DrRv65bFkmCRg4ZN5jYRMkBApUTpUog7e7skMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919487; c=relaxed/simple;
	bh=0ONmNV9vzQUGV6frLDhiV8OgSXVkIdlWsYOsJ1KXX2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiO9x/lynT0KbrL+bYs7SaCKaDrPmaoIlLmxF8fUcB1CsNIv7dHwzaKB0Il9YsxB+Y8eU8sBMt+mXHEPpnGSGQkHX25vHkfr7A4Woyf8n5blJYquSnT32lScauc21HPLJrN7darhozT7+HASPvjVmDzRnxbQLMF5QSianF5TurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=jb4S/I5q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d447de11dso3215586f8f.1
        for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728919484; x=1729524284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvkSVt8VpmX4gMY6ZJ043PHdZhz1ZoH+BaE3ci1zs5w=;
        b=jb4S/I5qA15TE/GGPwwMJJXd50/byw1rJtxglFwKu9RHDaybS95MZ09NjSNhnPz2v3
         CPPkaff1xzcm38hPUdrbdWgn781pvIv7OK35wCvihD0REI3mJDNIfzSIBJNInQQp4kSv
         MRQcMVNqhKWYlYfw7e6HOHEhMi7ghjZ9BI0h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919484; x=1729524284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvkSVt8VpmX4gMY6ZJ043PHdZhz1ZoH+BaE3ci1zs5w=;
        b=IRVg8RyVaTOIlzbswWwTX40C6cAmoQHQ69rMYpcW19V+DBz2HRKevl5SKWAssn9LBd
         hVoREOmb6+7Xa+Ge3RfMymy9G2QIlzq0r+izwgxzb8jE+vBXpn/zis8UcWFUZP3ETYhC
         1e9iRejG2KlmduxjCuE5uk2pDSLnhFoWzOfBjnM0Up6z4HuTy3lxls88j1mgo/dGhAcM
         xIkUZr2B/GsLfSvNr0YOnqm5qPySxI5a5+LWGExGShhz31BrngLmD+Nfzf5dxBHPwQPy
         tu2HAXNxZ1ppC6H2faASpuCsdct05UY+EKwLvbvEeqq/rr8rIqrvpilVg4uKmg734FEk
         NSag==
X-Forwarded-Encrypted: i=1; AJvYcCXf53oAuAQf59/CkWTWLg70VTFlCjzzl54QEmZKTTCCD6hp+haqhFCKlve2c5cGCRFIOhJrGuYZtBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtuWic4Wktg9hnmzJuCyWyF7F49d3TIN1zBwpyf3nmYYVxzG0f
	jyIRM6yTiGg9TKVLI35oNvOzjctxSCGYoUC9+IQZwVzErV5rWwhq2biY9ORPYsY=
X-Google-Smtp-Source: AGHT+IGU6W/9rfcwX33740fJ/ldX1KMdmDVw4ohUw0JiVPbpOmH7KL8veexmd93cyiyKKuklxb5y8Q==
X-Received: by 2002:adf:e88b:0:b0:37d:4cd6:6f2b with SMTP id ffacd0b85a97d-37d551d2566mr7314184f8f.14.1728919483907;
        Mon, 14 Oct 2024 08:24:43 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd1b7sm11629911f8f.37.2024.10.14.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:24:43 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 1/6] can: dev: add generic function can_update_bus_error_stats()
Date: Mon, 14 Oct 2024 17:24:16 +0200
Message-ID: <20241014152431.2045377-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
References: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function aims to generalize the statistics update by centralizing
the related code, thus avoiding code duplication.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/dev/dev.c | 30 ++++++++++++++++++++++++++++++
 include/linux/can/dev.h   |  1 +
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 6792c14fd7eb..0a3b1aad405b 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -16,6 +16,36 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 
+void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	bool rx_errors = false, tx_errors = false;
+
+	if (!cf || !(cf->can_id & (CAN_ERR_PROT | CAN_ERR_BUSERROR)))
+		return;
+
+	priv = netdev_priv(dev);
+	priv->can_stats.bus_error++;
+
+	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] == CAN_ERR_PROT_LOC_ACK)
+		tx_errors = true;
+	else if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0))
+		tx_errors = true;
+
+	if (cf->data[2] & (CAN_ERR_PROT_FORM | CAN_ERR_PROT_STUFF))
+		rx_errors = true;
+	else if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
+		 (cf->data[3] == CAN_ERR_PROT_LOC_CRC_SEQ))
+		rx_errors = true;
+
+	if (rx_errors)
+		dev->stats.rx_errors++;
+
+	if (tx_errors)
+		dev->stats.tx_errors++;
+}
+EXPORT_SYMBOL_GPL(can_update_bus_error_stats);
+
 static void can_update_state_error_stats(struct net_device *dev,
 					 enum can_state new_state)
 {
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 23492213ea35..0977656b366d 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -201,6 +201,7 @@ void can_state_get_by_berr_counter(const struct net_device *dev,
 				   enum can_state *rx_state);
 void can_change_state(struct net_device *dev, struct can_frame *cf,
 		      enum can_state tx_state, enum can_state rx_state);
+void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf);
 
 #ifdef CONFIG_OF
 void of_can_transceiver(struct net_device *dev);
-- 
2.43.0


