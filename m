Return-Path: <linux-can+bounces-2191-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D15F29D65AF
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 23:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4205DB22CD1
	for <lists+linux-can@lfdr.de>; Fri, 22 Nov 2024 22:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F481DFD9C;
	Fri, 22 Nov 2024 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hdm4jwGS"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95791DE3AA
	for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 22:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313827; cv=none; b=dil/Og8xFBk/CWVeOn3E9sqOh2wuglGPNWbD5kwVAaoppiJiYvN/Ed1qh7D0fmAQKfrZnzWztgzsKetRAhLkmUOeNItxZIyrJvC38HaLCNrihMA5BmMvipfwG7ndnaHXy8qkmltMRxmWrFKxkc+gJroj5qR/GhYe7aJyr3+RTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313827; c=relaxed/simple;
	bh=RCHjtrDYGosX7hVMEeF0eEIsFG3i6FYsIXt5jHBzeRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXY2tp749EComaB1p1ihaMsDCJoWM9R764hdOQBnPOuhiFtDTW8mmboz2nt8UB0NQSLBpDu6BV4Vi0l+bhqGs8ok6bMbMdnA/zJ40BafZm9aY0kANNLB4jwbxvg18Hkb1vPFw1e5AJTpVUopQ6wxAqb8eOWZWguRjiiNT6482+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=hdm4jwGS; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso46255551fa.3
        for <linux-can@vger.kernel.org>; Fri, 22 Nov 2024 14:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1732313824; x=1732918624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgKjVRJAevY3wmDGnu8dG/wFQ+or5hcDk8y0qLVlEgA=;
        b=hdm4jwGShUM5EpuT17WLUC5TaTdkPsrZvQJHP0hea3mFj29mEQySrAFxa7ix9l56aM
         z33fRn4Jwk2HoOt1z5cRKYXzU/SYVrU9cba3K8KXrPRcdSKT/JzF4ZhJrCdwdY7bN0TD
         OgR8WROyHvWPjHmtyb4G9BdCX1yjvuwLf903M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732313824; x=1732918624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgKjVRJAevY3wmDGnu8dG/wFQ+or5hcDk8y0qLVlEgA=;
        b=F5CN5lb9D9INIRisKA+4ijEvV/bSHbSNl1heeifRvf7dnENy7Rk+glk+bQEk5fC1bO
         ahXhy4H7xhM2hVwp5+3srnVQ7nBJN1/Q7kQvRgZ1ruzmzj+3ZEsJNlrWZLQPjiYgl/4s
         9dshD07I3+YhkkWG12V58ZqPMHEMxv5uEPsvD32+sHmcM1W+Y8pX6sq5UTudPg9ybIJH
         Ad2XlssnvGMA4VECLK3Fw8A3uyy+CeqBpQAjnbkrxLtyjnSTVJ9qt0xV73zc/loE1XhB
         WKku2xArIx/yyV/OD5bh5lvwNjw1Ty/4vg6XvnCRNjjAys5kbgP4lJKaxB/i6BZpEj+Q
         9Zjw==
X-Forwarded-Encrypted: i=1; AJvYcCX3oMCkvVUu3hHVv3nKSjh6rS5WG3ppQC+0BhQ/7NmaF3evP5PxjqT7TtT/hZJ2uDtUZvBeikuknaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1h9QR7m/yqSMsTj5nwnHZ+Gj8orWSMLdCZ5DBrfZkVf5RZS2
	vwOvxe3mRWHczFxLDW9KdRBhdJxDEo1y2MiqAvWqKiF1FfrLxuLHTuXpviBrc4w=
X-Gm-Gg: ASbGncvihsErUUmIrLvHd5Ficd5lW+AdXae7hAG6vMdc0f7PdmkDhvuc3PoVqhQaHUg
	lLDxLkboFX/9WCtUQLDMgeQbBsaBfOYam/L6qnuFkNQo7BDu02YVjiK3LIJb/mJiJ7WlfSiwPZJ
	0AIRZR7w/MtljilQ9L/04QfTwRYmV2BTunhYMlzJAz+K8KB+aKqZjBI11vV40blux7OH/bS/HK3
	GDoyb5k9aQqlzk55PCZ45uLJAyd8MOR7L2TH/LA9VmtVMfpZtqbSl0oYhvVGLdkn/eGi3Yu/J6K
	waD5Y/OTaexR2mvXv3WKOTj43HKHxwxSfXZiFes7bgE2dsFyAUzcDysojqvpj8wTXHbjo0KMiZN
	nZsLx7PBmLBXK7wi9
X-Google-Smtp-Source: AGHT+IHZ/ABLxFIVbFLFvSrsmgIkf3PgZHq1H1ox1bPhmgDf7xN30T44QnNfRAPsf4/UWKxgOeMrTg==
X-Received: by 2002:a05:6512:b97:b0:53d:a2cb:1350 with SMTP id 2adb3069b0e04-53dd369f458mr3917868e87.17.1732313824154;
        Fri, 22 Nov 2024 14:17:04 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b52fcebsm148226466b.127.2024.11.22.14.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:17:03 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org
Subject: [PATCH v2 08/12] can: hi311x: fix {rx,tx}_errors statistics
Date: Fri, 22 Nov 2024 23:15:49 +0100
Message-ID: <20241122221650.633981-9-dario.binacchi@amarulasolutions.com>
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

The hi3110_can_ist() function was incorrectly incrementing only the
receive error counter, even in cases of bit or acknowledgment errors that
occur during transmission. The patch fixes the issue by incrementing the
appropriate counter based on the type of error.

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Update statistics even if skb allocation fails

 drivers/net/can/spi/hi311x.c | 47 ++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 25d9b32f5701..09ae218315d7 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -696,27 +696,38 @@ static irqreturn_t hi3110_can_ist(int irq, void *dev_id)
 			/* Check for protocol errors */
 			if (eflag & HI3110_ERR_PROTOCOL_MASK) {
 				skb = alloc_can_err_skb(net, &cf);
-				if (!skb)
-					break;
+				if (skb)
+					cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
-				cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 				priv->can.can_stats.bus_error++;
-				priv->net->stats.rx_errors++;
-				if (eflag & HI3110_ERR_BITERR)
-					cf->data[2] |= CAN_ERR_PROT_BIT;
-				else if (eflag & HI3110_ERR_FRMERR)
-					cf->data[2] |= CAN_ERR_PROT_FORM;
-				else if (eflag & HI3110_ERR_STUFERR)
-					cf->data[2] |= CAN_ERR_PROT_STUFF;
-				else if (eflag & HI3110_ERR_CRCERR)
-					cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
-				else if (eflag & HI3110_ERR_ACKERR)
-					cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
-
-				cf->data[6] = hi3110_read(spi, HI3110_READ_TEC);
-				cf->data[7] = hi3110_read(spi, HI3110_READ_REC);
+				if (eflag & HI3110_ERR_BITERR) {
+					priv->net->stats.tx_errors++;
+					if (skb)
+						cf->data[2] |= CAN_ERR_PROT_BIT;
+				} else if (eflag & HI3110_ERR_FRMERR) {
+					priv->net->stats.rx_errors++;
+					if (skb)
+						cf->data[2] |= CAN_ERR_PROT_FORM;
+				} else if (eflag & HI3110_ERR_STUFERR) {
+					priv->net->stats.rx_errors++;
+					if (skb)
+						cf->data[2] |= CAN_ERR_PROT_STUFF;
+				} else if (eflag & HI3110_ERR_CRCERR) {
+					priv->net->stats.rx_errors++;
+					if (skb)
+						cf->data[3] |= CAN_ERR_PROT_LOC_CRC_SEQ;
+				} else if (eflag & HI3110_ERR_ACKERR) {
+					priv->net->stats.tx_errors++;
+					if (skb)
+						cf->data[3] |= CAN_ERR_PROT_LOC_ACK;
+				}
+
 				netdev_dbg(priv->net, "Bus Error\n");
-				netif_rx(skb);
+				if (skb) {
+					cf->data[6] = hi3110_read(spi, HI3110_READ_TEC);
+					cf->data[7] = hi3110_read(spi, HI3110_READ_REC);
+					netif_rx(skb);
+				}
 			}
 		}
 
-- 
2.43.0


