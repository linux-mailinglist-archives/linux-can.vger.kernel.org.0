Return-Path: <linux-can+bounces-3595-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05373ABD474
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 12:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8EE179257
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE626772C;
	Tue, 20 May 2025 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b="UemDByGJ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D425D216
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747736593; cv=none; b=hdhek6YLAIoYHMoPOY0YZzXCgm8IRmHUQcyj5GyvDRVPQgOpdJdceJBDZTahbfx3NaMqvzT0Vj3sduJhwCblmqYTJCqxCwVRKyl0e2YMPLII1te2xf85BKsJaVSABL4O/MF9CZAsysnwiesp9eLqcWrdJRRJ8W+iOdZsIc3o5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747736593; c=relaxed/simple;
	bh=IT85x+Qm19T+gXJ1j5REkTyywFuZ5QCanTcc7OoGf+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QovnRnsDEhEq69Oa7z91WtrJ+5x547Odm85iSQWk6JzF6ww34U1Ddol8EuildMiMVcUZ3ltEW25WthRvaknga0rmev3TQumVmoPPX27HjyprU1nKmWjcbz1k+LTAFOjxU0LJCIlMi2zn7AGgPaiFoqa2cW+LgWKlOlhiIItofec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com; spf=pass smtp.mailfrom=geotab.com; dkim=pass (2048-bit key) header.d=geotab.com header.i=@geotab.com header.b=UemDByGJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geotab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geotab.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso67752505e9.2
        for <linux-can@vger.kernel.org>; Tue, 20 May 2025 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=geotab.com; s=google; t=1747736588; x=1748341388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ut3ITiveFKvhoZ5CAZQdHp5vH+BSYrrEMd7CvFm+VZ0=;
        b=UemDByGJV4cYNbQ5hAKm9WoMzdS1pcB6f2qTLvwPat/GRBcMGF0i5xnkMJP6b4Z+Rh
         StSqkMHOVUiisdVtsBUpUygCw//Szr2fhPCiXb92iv7R3HsBQRfoOCrUXnY1YwCibZrb
         MSXEhuCLNvk15qz8q6V+OjfgJ5SRAd9YG5hfgDiz4NoxWF2ua4Q4J2CMBplWAEI4Vbld
         1dxd0PEcr3AKjIP9iQSyNy3pLdV9mQ8/itjPfl6xFdqFT40RQK0NMzU5O7LhJL0K8xrT
         neLWjwSMjQmkaPFzXqhy5tkb7wPPXzGgaJKi+wf6B9zckDRuH9g/fwW1quVPlzrBYf75
         JPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747736588; x=1748341388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ut3ITiveFKvhoZ5CAZQdHp5vH+BSYrrEMd7CvFm+VZ0=;
        b=s3Djsi08wOIv20ZMljSdR3kY3vLE3tm9wFr3HQbPdlApHkdwRJNzBNO0tBsFypGtKO
         l9YZUdshmSknPW/9a071DukJvmy3mqDcJzjs0SQ45p98mhJEhNVnlEeEzfjh+BI4a/9d
         o+4vvXen+Q5XD9AAHqbq86xXDSXbiWF7335I+2MLTZy026l9A/AETyXPvn+wfRaG/kzg
         0NFYJnzRkzvaVztq6/KGDk16pXxX65cr1HdzLvC7zY8JQjbRKsBoumQiXj38cSQtK+/2
         7fW9e454R3gYDhgxoSg4QXG1L3mTB1bNNyKMPMIUfOCCtkQ5OL6VKfcy7JkV9SsC1YsM
         bL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZaGcghMeEFphrKOOTggyfvYKcswqtQlX5ntVdYIq1T2wSUg1cvzKJUz8KiEvWRJ6m/VRiquq/3o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeRrMzZ6bm8g0u2sKGM/vfqWHPWwnakHrFCDq7HW8V4a2e76G
	mY32Lh9mzPMWxlKuWgqGHmlQdAuJMFmxJtNrjPr25yfuhsrqc2XfxJuXhpkhTHTiVgukiqRDeMJ
	6ffh+gqA=
X-Gm-Gg: ASbGncvtrT+QAGOrN6G28j+i4p+gHdVoJtWdS0y5C2PaAkMklJMQvVvAa7zQMfKj7F/
	I4Lh8akMX26kImjJt3j1PVQE9vaVDf3lHBEO2apYlbHVCaEtp+kwBuZD5hE5yT4YbXJwt+LIxGC
	RQ6DYqfWOtTlPHjDeEz9BQu2fiAGacvxbVuTWbqmtw1GvofQrRUC5TXu5N6l8eVMYurJuLqvkGs
	ULqwVCFgZ6jyBO98TfydmigH6NP9pRoxM+bRE5m0r6M3PDUOLC62LtuFvleByy9KCTEP/xPVZzr
	T8XnVuAMLScVBt9gVkO/bJDzCrXUEKqG8nJsFOyqrSp1J+dRivYAntaxHtwJactt5yuSEUCxzxW
	OyR699njwZKrZL8uxq9Z56xqyABttSD4mvPA=
X-Google-Smtp-Source: AGHT+IGChcjKhmFx9UyD8B4ADq2rQOQFoCk4Dd/Jl11zU+9A4RrBcGzh87BDMwYeBTJn7trhlI34jA==
X-Received: by 2002:a05:600c:4e0e:b0:442:faa3:fadb with SMTP id 5b1f17b1804b1-442fd608293mr177825385e9.2.1747736588597;
        Tue, 20 May 2025 03:23:08 -0700 (PDT)
Received: from localhost.localdomain (din-12-254-235-87.ipcom.comunitel.net. [87.235.254.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d310sm16035717f8f.17.2025.05.20.03.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 03:23:08 -0700 (PDT)
From: Carlos Sanchez <carlossanchez@geotab.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	Carlos Sanchez <carlossanchez@geotab.com>
Subject: [PATCH v4] can: slcan: allow reception of short error messages
Date: Tue, 20 May 2025 12:23:05 +0200
Message-ID: <20250520102305.1097494-1-carlossanchez@geotab.com>
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

Added macros for all the lengths as requested by
Dario Binacchi <dario.binacchi@amarulasolutions.com>
on v3.
SLCAN_DATA_LENGTH_LEN is slightly confusing, because it is the length
of the "data length" field itselft (which is 1). This confusing
name is the main reason I had chosen to use a literal 1 on the
previous version of the patch, but IMHO as we there are several
macros with _LEN prefix to indicate the lengths of each field,
it is still clear enough.

 drivers/net/can/slcan/slcan-core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 24c6622d36bd..58ff2ec1d975 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -71,12 +71,21 @@ MODULE_AUTHOR("Dario Binacchi <dario.binacchi@amarulasolutions.com>");
 #define SLCAN_CMD_LEN 1
 #define SLCAN_SFF_ID_LEN 3
 #define SLCAN_EFF_ID_LEN 8
+#define SLCAN_DATA_LENGTH_LEN 1
+#define SLCAN_ERROR_LEN 1
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
+#define SLCAN_ERROR_MSG_LEN_MIN (SLCAN_CMD_LEN +	\
+                                 SLCAN_ERROR_LEN +	\
+                                 SLCAN_DATA_LENGTH_LEN)
+#define SLCAN_FRAME_MSG_LEN_MIN (SLCAN_CMD_LEN +	\
+                                 SLCAN_SFF_ID_LEN +	\
+                                 SLCAN_DATA_LENGTH_LEN)
 struct slcan {
 	struct can_priv         can;
 
@@ -176,6 +185,9 @@ static void slcan_bump_frame(struct slcan *sl)
 	u32 tmpid;
 	char *cmd = sl->rbuff;
 
+	if (sl->rcount < SLCAN_FRAME_MSG_LEN_MIN)
+		return;
+
 	skb = alloc_can_skb(sl->dev, &cf);
 	if (unlikely(!skb)) {
 		sl->dev->stats.rx_dropped++;
@@ -281,7 +293,7 @@ static void slcan_bump_state(struct slcan *sl)
 		return;
 	}
 
-	if (state == sl->can.state || sl->rcount < SLCAN_STATE_FRAME_LEN)
+	if (state == sl->can.state || sl->rcount != SLCAN_STATE_MSG_LEN)
 		return;
 
 	cmd += SLCAN_STATE_BE_RXCNT_LEN + SLCAN_CMD_LEN + 1;
@@ -328,6 +340,9 @@ static void slcan_bump_err(struct slcan *sl)
 	bool rx_errors = false, tx_errors = false, rx_over_errors = false;
 	int i, len;
 
+	if (sl->rcount < SLCAN_ERROR_MSG_LEN_MIN)
+		return;
+
 	/* get len from sanitized ASCII value */
 	len = cmd[1];
 	if (len >= '0' && len < '9')
@@ -456,8 +471,7 @@ static void slcan_bump(struct slcan *sl)
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


