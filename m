Return-Path: <linux-can+bounces-3581-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0741ABC488
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 18:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FF37A4867
	for <lists+linux-can@lfdr.de>; Mon, 19 May 2025 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCA42874F9;
	Mon, 19 May 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b="kPZaTe8i"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81071E5701
	for <linux-can@vger.kernel.org>; Mon, 19 May 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672276; cv=none; b=GWbAuBx2MNkSaxVhYl7jjlmqa3ulSBJ2EiGf06Zn1MVu2izNe5wR/1XtxtumOQsVtj+D+LicmQo0rRa25tBDB342mKU8lPXJig3WXslYBSkrNifq24xii+QAJFK8PGtOrSCZ2vJLrS1bLU5IiWG16CQuff4uvYrgHFJDPo3YMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672276; c=relaxed/simple;
	bh=oXexxwZZiwmh3DawzUHBCO6tKtJHmZvrqwWUK12vbLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujPGUMK5wv5DNQCsExPhWuzi32MfXw6d6eEkCwyPHWwFZkI36VJSrUWreVEoOCjgwn2mW3nDp/bKA7s/nR5DhMjT45zgBWr+/oeGVK1iu8qsyg2rKmJuXpVt/ndXxSy31s+5OmDI14bvyO2g2LKVkW6GL8/VFdmsNGPPKZfdxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com; spf=pass smtp.mailfrom=geotab.com; dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b=kPZaTe8i; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geotab.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a36e090102so763077f8f.2
        for <linux-can@vger.kernel.org>; Mon, 19 May 2025 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geotab.com; s=google; t=1747672269; x=1748277069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpK+HFKbwWUzUOKaNCCCVm5vGZlxVuXN4FuKy0Os3XA=;
        b=kPZaTe8i2CSClY9TXmu9o49DFcORAbAIoJCwfsVL3GnUtvP9NqXRqJ0nEuEW3+0QeJ
         3czDYZYTuYxScenCWJEex257ZSaq3VSSXQVr6Nb15WXH5rVxeb8ddDUMiRwRljJqQuCx
         Cdk+/vt2wh8sYJfaBXyXxY2+OJAu0YPCtbsI/FOr1J4xbIhqDTfztLXdv6/DEqWy3gfU
         iSQvhj2cCtqbN4dVD596frxSpQe1jGzbRELmKWSFrbwqWt8yBTTE6qFHg7jzye0OYnr7
         l+ot1db8hRT2rQbHnmhz3MzhpZN0oT98QLjOuyW7aSfVaDnLZg89rLo2sczFQmO9z6qt
         RpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747672269; x=1748277069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpK+HFKbwWUzUOKaNCCCVm5vGZlxVuXN4FuKy0Os3XA=;
        b=SJsltK2a613v6vvk36/gvQx6GEfg1hEUDA2uAZwKQaaLsbWMS/H6luhL9preYYc/QI
         7NCJrR4DfWly0KhSJastbc4bs8HUsWoHDH+nb20XeotYhN6IgNZzLlOL1ZwU3E2DH5gw
         Lnmgx8YLHyP/NMrCR1Lk4GxKbRc09HNHuaT40T8W/0RdxaQizCgBIl0bDX4VEu5GPHxS
         fB1wjF68SpRUkMTHocGRlCTbdQIq0DpWxxPUAwJlIw3WSi0jaVBeJGAl5pej2D+O10J5
         K7vqaBHdi8rHZ8eSfKysh7hoNcX1Bc3F+wfiOeq2DYOne47ImxXAf6qZhanyc0PeTooP
         7RtA==
X-Forwarded-Encrypted: i=1; AJvYcCUH2kb/w/bM5RITDljfv7Gkw+ADqPhnF+/N6r2tmAZVGh+0vfs6iklhLmoVajYzaEgFHZKUIQByXtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRXDwZe3Oep8x/ZseF2FxXERGhzX2Pj+VvR7rNLYsdOUALRDO
	WlKvE1cECJl1O61ges1vmlHbO+nn0OViBCfB6h//g66qRd97cevR6FD5VYHj8BNMqOdNYjBYpTy
	SvC8/f00=
X-Gm-Gg: ASbGncuvB7xnOEN2s0+Yj2rEiTobNYOephCKloh1UmpK4EoG9cYDkEd7AxyJWMNwA/B
	02haOB72Ic6ENFUxi+pMQUgJJk7NtjZXWiVQ+Q1syAEOk6QV979AbdzB1VScrgXGqkCnzuAHeoD
	eggEHNwhTLQOWeqbzDcuxNJ6oSIHdwYuTYvVbImTtg6CLwxkZY3+ten7k04Od4cvdtmESpVCcwC
	STE8uaZUG6Fb1IhQZC/wWY3ktDyNwKritLrDp/PrxI8sN6956GY8zd4blhOJOXGL4huQrAp5UBQ
	gu2CmI/px+L2xkXr4Gw3GVfDy6eDyrInNBScD9BH1mjiNMzdTA+b3BEdTQTx6Yloa7B1oDYnd1O
	fFFqkVBTGTtw1L0KSOF5A2ws/QVdIHFyoFw==
X-Google-Smtp-Source: AGHT+IHhHAoIUHGM/xvAHz7hOE9ULekXE182CqLowPgJUGZEqf2V+JGigScmFrMedwqMbRp62sppTQ==
X-Received: by 2002:a05:6000:2504:b0:3a3:6dc6:4bbb with SMTP id ffacd0b85a97d-3a36dc64d82mr3650013f8f.58.1747672268954;
        Mon, 19 May 2025 09:31:08 -0700 (PDT)
Received: from localhost.localdomain (11.red-83-33-67.dynamicip.rima-tde.net. [83.33.67.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a892sm13127013f8f.24.2025.05.19.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:31:08 -0700 (PDT)
From: Carlos Sanchez <carlossanchez@geotab.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	linux-can@vger.kernel.org,
	Carlos Sanchez <carlossanchez@geotab.com>
Subject: [PATCH v3] can: slcan: allow reception of short error messages
Date: Mon, 19 May 2025 18:31:00 +0200
Message-ID: <20250519163100.733754-1-carlossanchez@geotab.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows slcan to receive short messages (typically errors) from the serial
interface.

When error support was added to slcan protocol in
b32ff4668544e1333b694fcc7812b2d7397b4d6a ("can: slcan: extend the protocol
with error info") the minimum valid message size changed from 5 (minimum
standard can frame tIII0) to 3 ("e1a" is a valid protocol message, it is
one of the examples given in the comments for slcan_bump_err() ), but the
check for minimum message length prodicating all decoding was not adjusted.
This makes short error messages discarded and error frames not being
generated.

This patch changes the minimum length to the new minimum (3 characters,
excluding terminator, is now a valid message).

Signed-off-by: Carlos Sanchez <carlossanchez@geotab.com>
Fixes: b32ff4668544 ("can: slcan: extend the protocol with error info")
---

I have remove the unclear global min length check incoming serial
line messages, and add a min size check per message type. While doing
so, I have renamed SLCAN_STATE_FRAME_LEN by s/FRAME/MSG/, because
those are serial line *messages* (and CAN frame is one of the possible
types of messages). Using "frame" the old way was confusing, even more
when adding the defines for other message types.


 drivers/net/can/slcan/slcan-core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 24c6622d36bd..bbb2f82a6147 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -74,9 +74,14 @@ MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
 #define SLCAN_STATE_LEN 1
 #define SLCAN_STATE_BE_RXCNT_LEN 3
 #define SLCAN_STATE_BE_TXCNT_LEN 3
-#define SLCAN_STATE_FRAME_LEN       (1 + SLCAN_CMD_LEN + \
-				     SLCAN_STATE_BE_RXCNT_LEN + \
-				     SLCAN_STATE_BE_TXCNT_LEN)
+#define SLCAN_STATE_MSG_LEN     (SLCAN_CMD_LEN +		\
+                                 SLCAN_STATE_LEN +		\
+                                 SLCAN_STATE_BE_RXCNT_LEN +	\
+                                 SLCAN_STATE_BE_TXCNT_LEN)
+#define SLCAN_ERROR_MSG_LEN_MIN (SLCAN_CMD_LEN + 2)
+#define SLCAN_FRAME_MSG_LEN_MIN (SLCAN_CMD_LEN +	\
+                                 SLCAN_SFF_ID_LEN +	\
+                                 1)
 struct slcan {
 	struct can_priv         can;
 
@@ -176,6 +181,9 @@ static void slcan_bump_frame(struct slcan *sl)
 	u32 tmpid;
 	char *cmd = sl->rbuff;
 
+	if (sl->rcount < SLCAN_FRAME_MSG_LEN_MIN)
+		return;
+
 	skb = alloc_can_skb(sl->dev, &cf);
 	if (unlikely(!skb)) {
 		sl->dev->stats.rx_dropped++;
@@ -281,7 +289,7 @@ static void slcan_bump_state(struct slcan *sl)
 		return;
 	}
 
-	if (state == sl->can.state || sl->rcount < SLCAN_STATE_FRAME_LEN)
+	if (state == sl->can.state || sl->rcount != SLCAN_STATE_MSG_LEN)
 		return;
 
 	cmd += SLCAN_STATE_BE_RXCNT_LEN + SLCAN_CMD_LEN + 1;
@@ -328,6 +336,9 @@ static void slcan_bump_err(struct slcan *sl)
 	bool rx_errors = false, tx_errors = false, rx_over_errors = false;
 	int i, len;
 
+	if (sl->rcount < SLCAN_ERROR_MSG_LEN_MIN)
+		return;
+
 	/* get len from sanitized ASCII value */
 	len = cmd[1];
 	if (len >= '0' && len < '9')
@@ -456,8 +467,7 @@ static void slcan_bump(struct slcan *sl)
 static void slcan_unesc(struct slcan *sl, unsigned char s)
 {
 	if ((s == '\r') || (s == '\a')) { /* CR or BEL ends the pdu */
-		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
-		    sl->rcount > 4)
+		if (!test_and_clear_bit(SLF_ERROR, &sl->flags))
 			slcan_bump(sl);
 
 		sl->rcount = 0;
-- 
2.49.0


