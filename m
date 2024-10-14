Return-Path: <linux-can+bounces-1660-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9099D288
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504EB1C23D3A
	for <lists+linux-can@lfdr.de>; Mon, 14 Oct 2024 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B701CACD4;
	Mon, 14 Oct 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XBk9Vi6U"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190B1C8776
	for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919494; cv=none; b=C95mOOPbAMVamtXgVIJu/iEk21M2mMIqnx4IdARTa9wMvXnXPl779sZDugECKSfY0hJjRVEW4poP0QIXmVa2ha/TEFV3uiK6mZ9a8CHSuFjk7yhsBvPKVC8GLc9EVczNKpcrzkD/KQnbWqiyLt9UO6/dygMKfgSmyjfXCibVRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919494; c=relaxed/simple;
	bh=xpAc5RRbhHfs28chKhvyL6+voVGmTaE2zNIZn+iatNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rvvb+j5NORGD6kg4Ivqm/MV1+ZNdSp0si814yo5MDBmltfoyNw4kEz5ueQhuqskOrDaeB/ZXDVrMhCcw8eao0O9H/kJNFLXoVg5HQDEXo97GkgbceUBlJ/H0q1OmmbdIp/aidBYHfRD7Ndo+XEbl5ClmHR39CiJSqL00ZbcNcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=XBk9Vi6U; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d461162b8so2955404f8f.1
        for <linux-can@vger.kernel.org>; Mon, 14 Oct 2024 08:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728919490; x=1729524290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiHw9EzZ4u2R61UsONsymQwt0FhsGds7xVoU4Q9fXYA=;
        b=XBk9Vi6UrCXHgGV7QvBZvby0+oJfoKOFoPOLHiwZ3u0oSDxCcg8uTYVeyudSIVhiNT
         lvqoEtSTtPUzWrA1jzSv8O83/NBYdkCu2Cgv2UzWbQ0xfnHheaZczXncau2WxVIsf0u2
         /YgLr4TX+w1VJQ4HHQHWbBaKjW5ZmVToJ6VrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919490; x=1729524290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QiHw9EzZ4u2R61UsONsymQwt0FhsGds7xVoU4Q9fXYA=;
        b=fWCI9KiwEgrtkZLv5Z+0Yq5RwrGU2kfcbpcahDxQhlMVEYTS4TuUF9FCXpdTrrIKso
         28e2AF+VoYV7Kvj4+qns+JDkWJnaaiaSa8rOtwYbTO4bkeIIHBGtJ8kj1VXU1t9YMwV7
         hy8omow6NWjA1y3lT6qCJvqqLVTkBhEGVjKDpeaWHsCCv85/mS963ju34Ni8aFl2H5vm
         T4OXvZchDp+ZBUAKlPd8g3tGMJIToJgIRY1zOssy8+PN5DJIAJwr2bl31XIQcTByejVE
         dl8ny7Yvsrl7cbtBDOIuHBRPcXPdYhtevLdRLJxYowKrfw0fUsJRz/bqbLCdL4s77BwN
         n0WA==
X-Forwarded-Encrypted: i=1; AJvYcCXEWm5P0L8NU/w6S+Ji8scFr0VFhLkwIch3/ClI3lOOeiVPGh8BeBLAqHAqs9/6d4WcvjWLpgweOc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgde9qIxYjQcC7xOUA3mMDqezMcYcx821EjSDFNcC4jNdJwmYh
	usssoDHSR0//8LDvX4RAxpJVUiRL/Xve/qMiTfQEcE56bRZ6riv+qmBYfvBJpog=
X-Google-Smtp-Source: AGHT+IFGv9Z7cCWKPOZTMaenQuoxsKq/VuIJIPMHB9aEeYKLQjYeCtT40BlGCnbEbTTHOhkV/N3T+A==
X-Received: by 2002:adf:a407:0:b0:37d:509e:8742 with SMTP id ffacd0b85a97d-37d5fe954c8mr5128907f8f.1.1728919490496;
        Mon, 14 Oct 2024 08:24:50 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com ([2.196.40.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6bd1b7sm11629911f8f.37.2024.10.14.08.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 08:24:50 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Carolina Jubran <cjubran@nvidia.com>,
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
Subject: [RFC PATCH 6/6] can: dev: update the error types stats (ack, CRC, form, ...)
Date: Mon, 14 Oct 2024 17:24:21 +0200
Message-ID: <20241014152431.2045377-7-dario.binacchi@amarulasolutions.com>
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

The patch modifies can_update_bus_error_stats() by also updating the
counters related to the types of CAN errors.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/net/can/dev/dev.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 0a3b1aad405b..f035e68044b3 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -27,16 +27,31 @@ void can_update_bus_error_stats(struct net_device *dev, struct can_frame *cf)
 	priv = netdev_priv(dev);
 	priv->can_stats.bus_error++;
 
-	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] == CAN_ERR_PROT_LOC_ACK)
+	if ((cf->can_id & CAN_ERR_ACK) && cf->data[3] == CAN_ERR_PROT_LOC_ACK) {
+		priv->can_stats.ack_error++;
 		tx_errors = true;
-	else if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0))
+	}
+
+	if (cf->data[2] & (CAN_ERR_PROT_BIT1 | CAN_ERR_PROT_BIT0)) {
+		priv->can_stats.bit_error++;
 		tx_errors = true;
+	}
 
-	if (cf->data[2] & (CAN_ERR_PROT_FORM | CAN_ERR_PROT_STUFF))
+	if (cf->data[2] & CAN_ERR_PROT_FORM) {
+		priv->can_stats.form_error++;
 		rx_errors = true;
-	else if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
-		 (cf->data[3] == CAN_ERR_PROT_LOC_CRC_SEQ))
+	}
+
+	if (cf->data[2] & CAN_ERR_PROT_STUFF) {
+		priv->can_stats.stuff_error++;
 		rx_errors = true;
+	}
+
+	if ((cf->data[2] & CAN_ERR_PROT_BIT) &&
+	    cf->data[3] == CAN_ERR_PROT_LOC_CRC_SEQ) {
+		priv->can_stats.crc_error++;
+		rx_errors = true;
+	}
 
 	if (rx_errors)
 		dev->stats.rx_errors++;
-- 
2.43.0


