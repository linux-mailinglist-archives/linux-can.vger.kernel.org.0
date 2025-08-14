Return-Path: <linux-can+bounces-4232-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A8B264D7
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 14:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC60A00DA7
	for <lists+linux-can@lfdr.de>; Thu, 14 Aug 2025 12:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08822FCBE0;
	Thu, 14 Aug 2025 12:02:19 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD22FC86B;
	Thu, 14 Aug 2025 12:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172939; cv=none; b=dHUpFXgGKP+5CaQ1hzJyon/28nctKzNUTILuINba7PcGQA2EF7BILh4V6SD7VC+7L/2FpzCa+a0xKZed7p5N6XJnTVPClwsO9iaZR+Yilj9nZbBK4g53XpK1OjwuPw7EoPHZzIgZewwgqEeyE0zxrMTiWIx4E3rlDVhN34g+CQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172939; c=relaxed/simple;
	bh=7cci5vvESyM2Qk/sIs5qcw+YHOkuLvCIrLJW3mJJii0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ekcDc7BBDoim3Ul5skjIUcachoKL+FIpZwL/9EER4MXsl0dyCLwD8dUjT4EASIpHbe46W8owtfamKkH0RaeUef16N7IVdZI+dlYXjZOtu8nu1lFHXXjolQ4GlJ7pyAkfo6A4DNpdqZtdGZHPc5bu+i14r9x+AWSoK8evLKSqmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0666EC4CEED;
	Thu, 14 Aug 2025 12:02:17 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/9] can: rcar_can: Miscellaneous cleanups and improvements
Date: Thu, 14 Aug 2025 14:01:58 +0200
Message-ID: <cover.1755172404.git.geert+renesas@glider.be>
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

Thanks for your comments!

[1] https://lore.kernel.org/699b2f7fcb60b31b6f976a37f08ce99c5ffccb31.1755165227.git.geert+renesas@glider.be

Geert Uytterhoeven (9):
  can: rcar_can: Consistently use ndev for net_device pointers
  can: rcar_can: Add helper variable dev to rcar_can_probe()
  can: rcar_can: Convert to Runtime PM
  can: rcar_can: Convert to BIT()
  can: rcar_can: Convert to GENMASK()
  can: rcar_can: CTLR bitfield conversion
  can: rcar_can: TFCR bitfield conversion
  can: rcar_can: BCR bitfield conversion
  can: rcar_can: Mailbox bitfield conversion

 drivers/net/can/rcar/rcar_can.c | 281 ++++++++++++++++----------------
 1 file changed, 145 insertions(+), 136 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

