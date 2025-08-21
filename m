Return-Path: <linux-can+bounces-4279-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6622B2FC44
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 16:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6338C1BA0536
	for <lists+linux-can@lfdr.de>; Thu, 21 Aug 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DC12EDD5B;
	Thu, 21 Aug 2025 14:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmhN2gE6"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179222E3AEE;
	Thu, 21 Aug 2025 14:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785675; cv=none; b=McJg5AQ9H1R4plDTDCufZbFXkj1h5hTjGOQbMSWvlBKl2VGkA6idOnVTMOIQyMlQogi01dyywwu3duhCpkRqTu/Jv4UFLXz5rC1bthWEkhHRgHNDlfWOvsYu5nakLXc5zA40EtFehtZgAodOiA88EAR9B2nHwA7g/xs2sfzW9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785675; c=relaxed/simple;
	bh=LFKhAjA6dAibPLcKWUQX+waQMyxIMKnRbhI9XU2EIzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQRgF7Iz8NRkQJQjAvXIHDiZMTuTGwXIwCy8kmwGH5v2+5C/QF6mFCpxl1w/hIqPP+6jcdmzcrFrA53ce7NY0L/OxoYVnz8NbazR1MbjW49e3ndRMWUCq5tkdZSgre6JWm6MH5qZxF+2NW+CuvXeqDhhbMyWALyoVG9dvP9jLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmhN2gE6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b4d892175so3648295e9.2;
        Thu, 21 Aug 2025 07:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755785672; x=1756390472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmmXRKSwkXbIZJoN56vuqrEQMZUuC/SffNh3CV0RFzM=;
        b=kmhN2gE6aWqjQd1WDekc9J5JUcTvui8t4qODtfXJBZMNKJMGw3nKoy7J8APTh9GQNg
         ZIofyQsBJ7Cf/Rc3U8mhbFAnpcJZ6tmV728MeFvJlaW09yHgnMNEAxBCrbvKGwecGvXH
         m+ovEdGjKcnvtfoPYvanDLkqEoUI+mu6Q5dD94hEGnRFkD7DhksPbomNOrbGhUmtQwEJ
         /FlqBWhZL3t67VyZEMA6crKDCKpruw3ndtU/DOczxi9Pv7Tjy1Y8plIC5HSq8F4Q07vW
         48D3GMoi+1p9ZiD3ldmDqndbxvBkNaosQxrclWo4HFT/c8vBe6zfYQIvl7PlY5NZTiTL
         HUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785672; x=1756390472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WmmXRKSwkXbIZJoN56vuqrEQMZUuC/SffNh3CV0RFzM=;
        b=ZPWT/c34/RGd7SR3OoxTsb67vYzTlFiUCmWtG1tsD7zf1rBkZVSrviPi4dXfA2uSS3
         xYBjavlHc9OjIa9OcEHPZoOUpWNlMTVd2H511pjSxnvI3k0RkeM043lTpZ2GTyb8bkeA
         MK+NR6awZIoEfwk0g5JvUY2yhf3wLeP5PagrFtHgGUASaocp0QChiSg8QjJfJzQqnvHf
         Ny1mjIR01guZOPFrsfZ8ljhUxZ0hdt1X8lQ9n1/TpnlItBhlA+5dqwi6Dl1Jm7UEs0gY
         rXps5Z3L49gYxod78Hb+bcE6zTxpFNO7iaaRvdtFNiXTpVIOL6L4D3oT4rziTnems0T6
         6sNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNTHHuYvC9HlgYzUAj278t0i/dgiC006Eli1uj+Odv+vSeS6Wq1ATfcZJ1H/TD8dbE13wFhHsUjf8=@vger.kernel.org, AJvYcCVMwN7J7ojDUm+57ZwW8llvT6ckK6k7b7v6zBK0vkI8iMrVO8bkHsn9UVa1nYVByYDW3mSyj4tmr0mHrYao7p78TGE=@vger.kernel.org, AJvYcCWVBD/laVs9evwZyTIcuoketMYhBtTdRarr/vYJ0nutIZ6EjCc19B1NZkrrpnWN6FNNknEhXt5LpogXAa7w@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MywZxWTwbrB0csELb+8SSs+OEnFwmakzkkGS7u6/p0/H7vHF
	sQc0CB26FdsHMP3g1kA1pdFtaLq74AC2zuYg3B+/WfujxwMTkOtUdAxt
X-Gm-Gg: ASbGncvU02U52xF+nGDdgFf5/0AoA2QobusbJRFDPDUJYYbxEEkV08srgarEiqhZAqe
	nmHjS7doujhAgQA0vTFec8CgWBfUY9fv/mEosHM2a0HX7hn5jOQC/hrUAaxkLJqDZLtUoLyEjfs
	/J6sbKsTLyvDexcU36XNz89cC0cA5Ej4UPyhTEWGlBHy2rmlpqeCdkI9IdlDILFmM/04Qxgl7KW
	kQOZnNgzkR3Ni7fC327BojbGcpm/wK0pbW4mmao2Y8tJZ9PXkgek0fgqyOLSxN9EDfXQao9usfr
	wTqRY4aSGkfUchDzD9RGAh5FBQlPclMURtVMbB9ulOoH7ukhoi6UTpQ4POPL24EpIk1Xw3IIdaq
	kjF6LF9HQGww2ky0z9UIAjV93Fxnl/BGs3xfFb/r1RmIDhl5aNj72zZ4mmWuihRU6PkdVwgA6EQ
	==
X-Google-Smtp-Source: AGHT+IH6aRlRng5HpzuZkmeDjmgpZvO7VE6EaPgXrI5wUqrXpiiMukcetpJ9Z6YH9VqHBh8xVY0FPQ==
X-Received: by 2002:a05:600c:4fce:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-45b4d7db5cfmr25176005e9.12.1755785672192;
        Thu, 21 Aug 2025 07:14:32 -0700 (PDT)
Received: from biju.lan (host31-53-6-191.range31-53.btcentralplus.com. [31.53.6.191])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db1be3csm33203505e9.1.2025.08.21.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 07:14:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 2/4] can: rcar_canfd: Update RCANFD_CFG_* macros
Date: Thu, 21 Aug 2025 15:14:22 +0100
Message-ID: <20250821141429.298324-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
References: <20250821141429.298324-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Update RCANFD_CFG_* macros to give a meaning to the magic number using
GENMASK macro and extract the values using FIELD_PREP macro.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Moved from patch#4 to patch#2.
 * Updated commit header and description.
 * Kept RCANFD_CFG* macro definitions to give a meaning to the magic
   number using GENMASK macro and used FIELD_PREP to extract value.
---
 drivers/net/can/rcar/rcar_canfd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ce355f79e6b6..8bae25758924 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -103,10 +103,10 @@
 /* Channel register bits */
 
 /* RSCFDnCmCFG - Classical CAN only */
-#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
-#define RCANFD_CFG_TSEG2(x)		(((x) & 0x7) << 20)
-#define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
-#define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
+#define RCANFD_CFG_SJW_MASK		GENMASK(25, 24)
+#define RCANFD_CFG_TSEG2_MASK		GENMASK(22, 20)
+#define RCANFD_CFG_TSEG1_MASK		GENMASK(19, 16)
+#define RCANFD_CFG_BRP_MASK		GENMASK(9, 0)
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
@@ -1416,8 +1416,10 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
 	} else {
-		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
-		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+		cfg = FIELD_PREP(RCANFD_CFG_TSEG1_MASK, tseg1) |
+		      FIELD_PREP(RCANFD_CFG_BRP_MASK, brp) |
+		      FIELD_PREP(RCANFD_CFG_SJW_MASK, sjw) |
+		      FIELD_PREP(RCANFD_CFG_TSEG2_MASK, tseg2);
 	}
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-- 
2.43.0


