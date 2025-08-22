Return-Path: <linux-can+bounces-4310-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B089EB314F3
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5DC11CE319A
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 10:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9240F218AD1;
	Fri, 22 Aug 2025 10:17:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7276F21ABC9;
	Fri, 22 Aug 2025 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755857839; cv=none; b=rhnwBhE7y/cl/HDKQ1zl1WwgRs2uQhTU55/2WlfRLyCqW3mWbUMB9nWFj0QIDnbFBgheP2wvcHNiFgtJpVfSmunCgrx+yZJCnNEAQmMWWDi5TH5zMjW4vxdeD0+4N+df8racxvUFKqHM1GadgvHORXYapwrL4B2IvaRsdD7uuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755857839; c=relaxed/simple;
	bh=0PLHotQVwXLk4Ewi6OXeoK4zZqYJ9pazhNDfarc2lyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VO6OUHSMQQyibXl6cH4+2zYeQqV+y0I81V2aiZM/x2d7HED4C1FT+xY2pkm8btLm1ZEkR0Bck/jZQ8erV3OIAitgbKeylWl21TMHcaQNaeuU/qeQZ6HULDwDE8osMCBlD/PQYgEvQDml0kzCsunrqw0AgWrsnrCK37W8eSY+yj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25E2C4CEED;
	Fri, 22 Aug 2025 10:17:17 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 00/11] can: rcar_can: Miscellaneous cleanups and improvements
Date: Fri, 22 Aug 2025 12:17:01 +0200
Message-ID: <cover.1755857536.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series contains miscellaneous cleanups and improvements for
the R-Car CAN driver.  I deliberately sent this as a separate series
from "[PATCH] can: rcar_can: Fix s2ram with PSCI"[1], to avoid blocking
the latter.  However, this series (in particular [PATCH 3/9]) does
depend on it.

Changes compared to v1[2]:
  - Convert new Runtime PM error messages to %pe,
  - New patches 10 and 11.

Thanks for your comments!

[1] https://lore.kernel.org/699b2f7fcb60b31b6f976a37f08ce99c5ffccb31.1755165227.git.geert+renesas@glider.be
[2] https://lore.kernel.org/cover.1755172404.git.geert+renesas@glider.be

Geert Uytterhoeven (11):
  can: rcar_can: Consistently use ndev for net_device pointers
  can: rcar_can: Add helper variable dev to rcar_can_probe()
  can: rcar_can: Convert to Runtime PM
  can: rcar_can: Convert to BIT()
  can: rcar_can: Convert to GENMASK()
  can: rcar_can: CTLR bitfield conversion
  can: rcar_can: TFCR bitfield conversion
  can: rcar_can: BCR bitfield conversion
  can: rcar_can: Mailbox bitfield conversion
  can: rcar_can: Do not print alloc_candev() failures
  can: rcar_can: Convert to %pe

 drivers/net/can/rcar/rcar_can.c | 292 ++++++++++++++++----------------
 1 file changed, 149 insertions(+), 143 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

