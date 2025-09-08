Return-Path: <linux-can+bounces-4517-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 701E6B48CED
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4547F1884BAE
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA2A2FB96F;
	Mon,  8 Sep 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6hgffGQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D12F7AD7;
	Mon,  8 Sep 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333387; cv=none; b=N55FTTZhe0/olNKex3ZVn19oI4EsjGqEO6elP+wTeqmGzmRJoAe/QVy8H2MOlkSiFXB7p+OVUFsCrRNb5uD5SB9AGp9ICal/+AKqAj14MeKe11AM+ZuO+/nXmPIadtnAjov238/vOXr/PVGS16jL43cxnS1YA+3Iw+FKYcO75oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333387; c=relaxed/simple;
	bh=GnezyDOYCJRZca65lNyJwAKwwlfZn4nyBrp5UBi3Qpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYzRWjA0wA8RNoPvIxxYAIBeGw6Tmdv1Ujr/blmr0LfzFkyjsYZIQpnhxbfU1Otv/RKQhh7hEdMmaz7RrO9XACW3W4Njp9HxQyfvLJq5rwSDiQbblv4yvDlgT56LJQrkqWyNGidgOJPeAaXQT4UpRWka1cVB8qzbA3n9xIzrr8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6hgffGQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45deb61a28bso2244775e9.3;
        Mon, 08 Sep 2025 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757333384; x=1757938184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjDJCgUPYhMpaeFMs9pivkNfWSa+B+oIW/kZQ7mHCuM=;
        b=M6hgffGQ0tJiGsEHjv5F1B7ZgZZMnDOvp6Mf0h2MuPv3XSaFeAFdG3GI2GS5p5zLP5
         wJLrLgwdCk8kaAm6Pq2/KoTVipRJp5EzOh/TOwFJVOsKAjMt5j1UmL5R+A8LORroSZje
         WLUDuioH5hGyAtu/CgrEnr3Wq3Gxe/RoR4VHdWy5IX2p3zdQwy1/7kR3KPQctYtOkU4+
         /rlaQRkkUddO/1fdio7gMsg5gvAyApETiOFVsss0CvEY9IPtAkj8zLlRvKpPnnbbuZO/
         FOQikcbKKqgM83KA7bBa/6NB/eDglNjiW1v0pl/5NKqKkdyhaIrs8jNq3e5h2Cxs1nnP
         r1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333384; x=1757938184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjDJCgUPYhMpaeFMs9pivkNfWSa+B+oIW/kZQ7mHCuM=;
        b=Xc5rI1dB6X3o7qonwf3caNkIdXKbcSuCn22vN2PBgU4tPM+BwM1VMMqTDcYGC9Xwxj
         Vdi8+bqHEncxyUPQqBcMtIKZVJiGJ5J7w06ow9qwvpgjn2fUJ+SJzJTA9guf/cxwjQ2g
         Ltu/JmuhvPjSHHTh1n3HgnLepWevb4A2VV7+HSOIfY4b8A5AS6Tl3CyJzqVpUg3bk/d7
         /gt58KmiY+xClJojq44nxDgMYeyoiaVaGqYGhmD5mc7E7xN9QPeFilCs9Ij7aiSokUVz
         HnIhXFZ+QAabGA5mbLotgsWl9oQPHcuOBsM+o5xDMyNsGjyVSifJ0WhRnNhRL+dIGGUs
         EIIw==
X-Forwarded-Encrypted: i=1; AJvYcCVq/zKHHZPxbfQnrwOlhO5orm4BrvANYe1BND5NAS9iG1gNcQVU3l2DSMBWAnZmDiBmcGXqm5X3P9yd49RW@vger.kernel.org, AJvYcCWGQdBp3/g3G/wEf4Iyi5ni9olMH05ykydQnqExocE+ZQbzKRHuah9nFeuORUT8LbkgqVXKq9o0GfY=@vger.kernel.org, AJvYcCX9tyrCZ04elzzSy91Ot5HkfrNLiA220IuunRE6RD7xnCOTmDfGvPNEVQzxaBpL9PmeOOItu8Q8sZO5j8/d1Lxmsp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMza7BqJlCGyuwJaH8Ryg+coVMNfQsNZNc+DXzl4GQDcbfnWt1
	93I/mtELoFBpP5qMUvdRXAMUCx1E+O/cr2sm4Yd84Fsisli0voNkAI0d
X-Gm-Gg: ASbGnctdXEFoMrQA0GPC58C03IgRlo0XkARJ0FT/VOL/37NGkD9dOkl5WPUDQxKkqeH
	/a2fKVq59dhAgVXYTjk9aeYqlzkgCz78fgOAbj6MN3s4JKT3q7PPI7JCy/leRcc84pErWMPEhEd
	IlBxdqfUvaz6GnvVZqyn1GRdosSMA5gi3JDiYjCII02IYxHlhOXJ899mcArhS5846m4Vd5ITB7x
	Y7mBaf62dGvUBeKnZd10vba8/C0NtnNGosvTcttTky8jFbZQGvVuYto/8QgBMmD5GO5vUidZx+w
	hCcp09qzK/ZD4Rq+u0irFytToGYbAxK9sY5ovmNx6wbh5xlITosJy93b+zbFmM35hrbfuaUTsrU
	hcdjSt4eU6pxQLGpIcVGH7BJMQjEM5JTKK6xdf85Xt/8ziPv734lSLJIgeJIEePnnVDsK2raPGu
	9vPg==
X-Google-Smtp-Source: AGHT+IHPhZJ23Azpt5od3KHGgCdB3KVpfVEYcYDvOL6LWEO3NNMSIU4fp2k8TJrukTB/+wrW/htsuw==
X-Received: by 2002:a05:600c:548a:b0:458:bfb1:1fb6 with SMTP id 5b1f17b1804b1-45ddde6a471mr53818795e9.2.1757333383710;
        Mon, 08 Sep 2025 05:09:43 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e543e9f444sm9646415f8f.60.2025.09.08.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:09:43 -0700 (PDT)
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
Subject: [PATCH v3 1/4] can: rcar_canfd: Update bit rate constants for RZ/G3E and R-Car Gen4
Date: Mon,  8 Sep 2025 13:09:30 +0100
Message-ID: <20250908120940.147196-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
References: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The calculation formula for nominal bit rate of classical CAN is same as
that of nominal bit rate of CANFD on the RZ/G3E and R-Car Gen4 SoCs
compared to other SoCs. Update nominal bit rate constants.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Replaced "shared_bittiming"->"shared_can_regs" as it is same for RZ/G3E
   and R-Car Gen4.
 * Dropped the tags as it is new change.
 * Updated commit header and description.
v1->v2:
 * No change.
---
 drivers/net/can/rcar/rcar_canfd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index b3c8c592fb0e..4185fc5b4a70 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1912,7 +1912,10 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 		priv->can.fd.do_get_auto_tdcv = rcar_canfd_get_auto_tdcv;
 	} else {
 		/* Controller starts in Classical CAN only mode */
-		priv->can.bittiming_const = &rcar_canfd_bittiming_const;
+		if (gpriv->info->shared_can_regs)
+			priv->can.bittiming_const = gpriv->info->nom_bittiming;
+		else
+			priv->can.bittiming_const = &rcar_canfd_bittiming_const;
 		priv->can.ctrlmode_supported = CAN_CTRLMODE_BERR_REPORTING;
 	}
 
-- 
2.43.0


