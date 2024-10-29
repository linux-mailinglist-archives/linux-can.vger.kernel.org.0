Return-Path: <linux-can+bounces-1830-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B459B44D1
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 09:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F168AB226A0
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 08:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2009A1E00BD;
	Tue, 29 Oct 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BFKKDUCx"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6688204017
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191680; cv=none; b=erGxkn7qqXbcw6BD+Wa7iCXRtOG5268A8VjXrMWBbwISRJf6jiJZL5IPzCSrnZf22tEHUBAXl2TeoWjz4objjj7cmqb801itkIZ0l7DdtJh7ZrF4msyd6YdfZKmCZ8oiqWcpolCax3xiNfpqBG9d+jafMCHT8NhyAmJPPD6zWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191680; c=relaxed/simple;
	bh=TUaK6OnUzQOxCJI2eLhsrV/ZIgtnSP1u/wmOARhnplw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJ9P2Km0zJ0rM0PFQ8NxcDqzyc4hJan8ClUrj4UPLoTaibYgkeo8K94EC3vfXhJpatnscMIdWTA0z3jqYSGA8Z9kizF7VxYaDzwyjgTZkobJBRJxzWjMfmY/xmY4Jqtqg4Y6sVOFcmZSBqZcL4nYzWpZUMSOFKQmyBJT2blowIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=BFKKDUCx; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9932aa108cso776514666b.2
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 01:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730191676; x=1730796476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pG46qvNdim+YSCFTrvSFA2E8sjhumHv8Kb1b4NjRqM=;
        b=BFKKDUCx0HmzOBg1bNXaD0e5nITmd0dvoLygSKsA6Vp4qDcy1dMO+XXTEwTCq2GuUE
         9nT0sJMaWV/LGWV7qGo1JBvyO2sI3l7ZLodaeKv1JwejeHTjT3y3NA93WNND6lQtATTv
         rtFygfil/brAzP3tGYRd9J+j50IH2I+AAJrj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191676; x=1730796476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pG46qvNdim+YSCFTrvSFA2E8sjhumHv8Kb1b4NjRqM=;
        b=n8NhFZ8CSrIuxiryS0G1wXftfAAmXUw+XOXZ8df72mQ7KCNgkfrEaczEEtKQwBxjde
         NI0+N2VbI6dHfu+uitfQQLd5L7lSfdg6QB3ytw6agf8LZQz0AuvK1PsbtZ2Y3ErICNhz
         41PI3Wil91MR0zkytVTL8eHX5KQaPi90MNURXONsZAy7I3IWaYjtwhSFui3XIFcdgJvX
         4vj4+46douuX6eoEWMlKngDGyeVvilvMEjEIF/IH0hP7SgUVvUGJZuLLVQIC2BfSIxoI
         1OcV/UqJX4Ixxq8Zh2Yys7WFQWYlOs9GS/UAPnZlIZxlI2UAA8o7D/5enqgytIlsol42
         tA/A==
X-Forwarded-Encrypted: i=1; AJvYcCUfCyxSWMSpQ/SIAT5JxhCEjo4vd62L2flFNvuhn3lnXaX0boiBlyifeIp49s9UUdAHy/4uvjwpHJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKmhOcmQlZUt8pYFgMgRaNpmJayQnNTmgHckeRBCRWWSPcBXr
	rrKD731oIBZ0/qV8Pav8+2NCTZaBYARetHN45KHhfNS3GYr26Ux0ga7OuNGWlPo=
X-Google-Smtp-Source: AGHT+IEH0Vvw06vXsgJYrKvglm7Aca70sORX61aWDxNEVaL9ewyglYUQc3JeszXfilruEW1c5pp/+A==
X-Received: by 2002:a17:907:7d87:b0:a99:fba0:e135 with SMTP id a640c23a62f3a-a9de619ee32mr1052955866b.46.1730191676268;
        Tue, 29 Oct 2024 01:47:56 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-40-68-117.business.telecomitalia.it. [79.40.68.117])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7dacsm450134166b.9.2024.10.29.01.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 01:47:56 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 6/6] can: dev: update the error types stats (ack, CRC, form, ...)
Date: Tue, 29 Oct 2024 09:44:50 +0100
Message-ID: <20241029084525.2858224-7-dario.binacchi@amarulasolutions.com>
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

The patch modifies can_update_bus_error_stats() by also updating the
counters related to the types of CAN errors.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v1)

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


