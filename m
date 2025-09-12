Return-Path: <linux-can+bounces-4691-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AD4B54A4C
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 12:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB031D6064A
	for <lists+linux-can@lfdr.de>; Fri, 12 Sep 2025 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445283002A0;
	Fri, 12 Sep 2025 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kadm2p5q"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B73A2FE078
	for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757674065; cv=none; b=jgYJ8LNIGQWdmMZaTCJZuaTufXKsj6y8j0bARujNk5qXdj0ITKi5Ica+IUfhynlESccSjvMWURUVqHn7WeZWFoMpjNto+sJWts1HMlhCmD9533n01K/iYSk7aLBqKwpnpEeY3+5I96wCiq7s7+G+0X2WvC+R3vCYoa8e85pQ5IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757674065; c=relaxed/simple;
	bh=OlTOFvKJfT0A22fcOpYTqFab8+1TW6hkZGEds47Z0Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1x92iFWPRVVSX6bFg1i2xw5p1u5CxQoMU0cw22i6V35TCFw0qdvCsx4MmD0tsjz6PgGYf3ysOO5Ptu4/HiwEVnWFqcySuYeGJy9/BqiPIGIDJvQCvnSSC0O3kyfh6vEEXo31gyABg0Nks0jO28LoZpTDGDkwF4pTfJsTFmZmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kadm2p5q; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e07ffffb87so1006874f8f.2
        for <linux-can@vger.kernel.org>; Fri, 12 Sep 2025 03:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757674058; x=1758278858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdCzNJXdDljgG/kIDC0Ddrqtrlk8v9FUTdWx7KN6R8Q=;
        b=Kadm2p5qfS0acoZk72bNm8J+JOBxE0R7+Bcvs9FG+tbZ016dTIwAQbeZsQiS8xyFgV
         h1Q/jxI+fttRzVRwEwfKHST94fTXOVO8W98tq8ib57K4uuQ8NQLrggbskG3VtHJOON7O
         vK6hCJdRK686mqtvISA7x4c7lEUtYUBcThvGT/W8QZS45iTTqXjx9QHrdIMnWAuMDu/z
         VQgToeWaKvG7w+e6x3JzklivpTYbuXDzvfMS/uoMyskOt4FJ+PncHV3U1GTmbtGOU0s0
         6pgRDh7MCDqnzUoMQU/yNrxKrplGHf0KMxAq+pEB9XvUK5y/115gNItum0561XPT1VaQ
         xkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757674058; x=1758278858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdCzNJXdDljgG/kIDC0Ddrqtrlk8v9FUTdWx7KN6R8Q=;
        b=AzwIJQZ+Qm2gTDnbOkDVx9oCuUq/vGUSWz+hQtB+FEnY5btkP/dfsF459M9T76Uhdo
         CMeydc1lHpLTf26FEyfUExEvTHIl887/sp3DpGGuKLmG7Ej5T99WSlZMMjWWXcWxPALt
         jtvvF/dxf07JZ6lskEHARESD/b8HD1bYYq8loIbm8Jppn6CEiXKHm6tJ3HigwsdBdJQY
         nTax3EGOyXeCCZsWt+mvj3kdnCkSCXn1L2o3+/6pMrviFrw6KyJ9Xxx/QX5nUTFcGwnb
         8ULrkFqpHR/lAWTFcdH3+4Y2E7utn566Bezj7AwApeVKxxrUMgiKIds99DB0EQsNim6I
         uYLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNmABAg7meAxK7VTsDLSCFGqcnmFgsQ4PxwSqu/5uNgA4AK6arV/oGjIsvDONkSlNbuLii4ZdOwB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzMjfktcX0Lkf9xDtdTgEAjhXmD9+4aq0kA0I86xFoUW+MWPq
	ysvmff8iHL3qY1XJwE7DjOfRIcR7lXpS/HDX5wM6e4NdF4OYLNUqBIwt
X-Gm-Gg: ASbGncuIiII2GBpSoM+KR0wrMxFq3ZQOmpyde72RvQj7iT7qhfzluZxwLC5iGzELAmR
	6taz0H8Ej020ITz1Fu3CaHWTkHd6LPLrd9Z1fW7jVVIzk2uOHUYeEZ8wpOSwIt79avzQswcCtyx
	4iXHIFqTqbZiy29RNQRMRM7xb4nqTRPxkN1gg1lRZlxjrOhV544QWa1OEvX8jPGLn+qOMsayDKu
	W7Fiu5RbZLGs/0U6LlLWjl6/qszC+u9kFgxJJgHazzaseFpwZN9AePNr8wImP/2230bhBHd3CsT
	6dS0X6zIcFFo7LU8OkKHb7xWG4z4q4BZWnyBt88sAfX5UX3MII2oFkpBUeyFnqxICFTu7GERMqH
	GJVPTqyxTh3IQPf41AtqcoXN3gwTfz21YGSkgTs72457/lTnRr9Ij6sqIfYXP6w/ZaHrbqT/vGK
	K0qw==
X-Google-Smtp-Source: AGHT+IFX7SP3Nc3fAURuh1zzId9OJYmZNsTdzvaZuLmsYmsYDvGx6+heBUvwIB58UK6jq1AeT+W/1g==
X-Received: by 2002:a05:6000:1a8c:b0:3df:4fd3:6e95 with SMTP id ffacd0b85a97d-3e765a051b7mr1893543f8f.34.1757674058280;
        Fri, 12 Sep 2025 03:47:38 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6197316f8f.31.2025.09.12.03.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:47:38 -0700 (PDT)
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
Subject: [PATCH v2 5/7] can: rcar_canfd: Invert CAN clock and close_candev() order
Date: Fri, 12 Sep 2025 11:47:23 +0100
Message-ID: <20250912104733.173281-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
References: <20250912104733.173281-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

The CAN clock is enabled before calling open_candev(), and disabled
before calling close_candev().  Invert the order of the latter, to
restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index c26a605659eb..f0dfab177b98 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1569,8 +1569,8 @@ static int rcar_canfd_close(struct net_device *ndev)
 	netif_stop_queue(ndev);
 	rcar_canfd_stop(ndev);
 	napi_disable(&priv->napi);
-	clk_disable_unprepare(gpriv->can_clk);
 	close_candev(ndev);
+	clk_disable_unprepare(gpriv->can_clk);
 	phy_power_off(priv->transceiver);
 	return 0;
 }
-- 
2.43.0


