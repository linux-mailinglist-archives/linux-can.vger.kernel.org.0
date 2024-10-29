Return-Path: <linux-can+bounces-1839-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E7B9B4898
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 12:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D088283C48
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704320515E;
	Tue, 29 Oct 2024 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qevd+j0V"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819CD20694B
	for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202402; cv=none; b=F/v5IWBryKoWfvmv3pH8wjHYWn6y9t4BF/smSvg0nnZtLI2bdFtRTitrXj68iGSP9h/swhwPiVVelVxGQCJ21oy151ZDlTOkEfD7WlzAq9JJbGy9o0SlRqx/L5J8Fb5fp09iIx2smw+BbU4Kw8hxu5JqUIhyJOsXZSnmxx9Oiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202402; c=relaxed/simple;
	bh=zGQNeCdJfkEacQEWhKkyV5Ry31CnGCgUtEGDHPY8Ta4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaObVe1ReM3UWQdTnH3J5ex0OAHxyzjM5PsGnfcSsY7Q2UHayiSFk9a7Eq5RS8pgTZytUtWRWdtboBftg/oOO3PnwquhWeNTkYTlqIywad5ZOWIt6e7EY5VkohpfcnrmY0MUxb70ApNslegFJEXKF69JePfKJ9FVDrtzial9Sb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=qevd+j0V; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so6832297a12.0
        for <linux-can@vger.kernel.org>; Tue, 29 Oct 2024 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1730202399; x=1730807199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7zf1SxmTLYYJKdIBWggPPFkkyvCdLLyYv8BJT477vU=;
        b=qevd+j0VfLZCBEtrY68CFWvqnI32U6jQGkuFLKhVohrN3u084HFOk7u3latWqJPE9p
         fktwG9TBisZm1INugFL94ydvswjdNbATutcprpDWO1Y56BqNpn438CDkFXonvqxV5Bua
         r8spWVhzbICqRQ5hxfZYo1S/f/+P/6gduESLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202399; x=1730807199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7zf1SxmTLYYJKdIBWggPPFkkyvCdLLyYv8BJT477vU=;
        b=iRB7jcHOg4swAxHIHpW8pCJCdKixbIWzkkPXvgDrv7/75mmlVSd9TUKwrWIkgMSnsn
         LxmYHayukuRptQkYkDPkL8H7QGykpIRqzsXxXt/XzyAi2WfkX5xKpgL4s3YIJWmSWAar
         pnGPQQK2mMhc7KFL2cv5YEnsGXP5ooZBvUrAR0u+fVc/lIlyEvhgKxe2M8cJCRRVAsPC
         C8q58zgM6DZLmCqq0lr+aLdvEQF/ybvETvexq34BGVBTXvDJ0UBJHxFZmMOfbzoBymRf
         GPDEgYfjuxYt032X7VjZhuQAGvZ5iiliz+gU3kAW/Rnfopa4kSVb2BYjaczTuihA1Fmx
         7hHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+EJ+3jz5qWBUidWSbcqrqU+CbboHP7l61Y+aMLy66CioPcxE3AiWIzEJDkPFuP6HLiD922okpma8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ivuafmxVAvJRQsfTCohCqqB2uEC9wPFp6Q6QQhImB1g4lX/B
	T94NQDwJw5S89Gto4YN8r/pqRt70arEXSiJFwjmIAOKb0vMcDpH6alkSd4ls00Y=
X-Google-Smtp-Source: AGHT+IFQPjRGEu5AzAkALhjbGjgLzCygsqqvVu/v3wZnXp+FNxqihXgz0zlaCUYVkgQ0pA+esg6IPw==
X-Received: by 2002:a05:6402:40d5:b0:5c9:4022:872d with SMTP id 4fb4d7f45d1cf-5cbbfa66f3dmr9918447a12.32.1730202398864;
        Tue, 29 Oct 2024 04:46:38 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.41.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6297a09sm3869301a12.21.2024.10.29.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 04:46:38 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gal Pressman <gal@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH v3 6/6] can: dev: update the error types stats (ack, CRC, form, ...)
Date: Tue, 29 Oct 2024 12:45:30 +0100
Message-ID: <20241029114622.2989827-7-dario.binacchi@amarulasolutions.com>
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

The patch modifies can_update_bus_error_stats() by also updating the
counters related to the types of CAN errors.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v1)

 drivers/net/can/dev/dev.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 4ad0698b0a74..ed2bdc6fe4a1 100644
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


