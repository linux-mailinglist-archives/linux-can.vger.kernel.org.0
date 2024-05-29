Return-Path: <linux-can+bounces-686-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF828D32A4
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2024 11:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A7F51C22616
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2024 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87216936C;
	Wed, 29 May 2024 09:12:28 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5ED16A37D
	for <linux-can@vger.kernel.org>; Wed, 29 May 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716973948; cv=none; b=E/045iRyMpxUoG166ZeVzRENGyD1S6b944PmT07OWGSxGmlp6fwh+1Ti6+vJgNNfjFgMnPAyZJrdpxoksqNjg0EVmXCdm9AMLkZKIKo4Ev90MeBLNbNa3P27/rL9qbTPC9CR+/odtWojlFhZk4cvXJ6VnxDL067Z4hDcd7tjbnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716973948; c=relaxed/simple;
	bh=FaQW69bwWIIghwkQdBMochv1fi+x9fc0JtNMz7gRvgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QmcM46jzWZ2nzo2izGWvIbzx3+o0TmDz1EcpVAIMlanTOz5V5whR5f1sWUsSKwnYcXkq/lB12OzDDBfcuXl5nR65hmApEYVgv4PhrJEo39svruGitZsWRFAfUiCo/Y7AGICvTWw+Kvtx0TU1SsdMjC7B0ZEciGLzdmspND/9ff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:1b01:1838:131c:4de4])
	by michel.telenet-ops.be with bizsmtp
	id UxCJ2C0013VPV9V06xCJ24; Wed, 29 May 2024 11:12:18 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFL5-00GF9Y-Ek;
	Wed, 29 May 2024 11:12:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sCFM1-008w8c-RZ;
	Wed, 29 May 2024 11:12:17 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] can: rcar_canfd: Improve printing of global operational state
Date: Wed, 29 May 2024 11:12:14 +0200
Message-Id: <14c8c5ce026e9fec128404706d1c73c8ffa11ced.1716973640.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716973640.git.geert+renesas@glider.be>
References: <cover.1716973640.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the printing of internal numerical values by the printing of
strings reflecting their meaning, to make the message self-explanatory.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 474840b58e8f13f1..c2c1c47bcc7a166c 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2049,8 +2049,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, gpriv);
-	dev_info(dev, "global operational state (clk %d, fdmode %d)\n",
-		 gpriv->extclk, gpriv->fdmode);
+	dev_info(dev, "global operational state (%s clk, %s mode)\n",
+		 gpriv->extclk ? "ext" : "canfd",
+		 gpriv->fdmode ? "fd" : "classical");
 	return 0;
 
 fail_channel:
-- 
2.34.1


