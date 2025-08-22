Return-Path: <linux-can+bounces-4301-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87575B31486
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 12:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1873B1CE146A
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 09:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858B2EE611;
	Fri, 22 Aug 2025 09:50:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162342D7DF5;
	Fri, 22 Aug 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856255; cv=none; b=o1jsNNqVODgk1rke7lrrVRZpwyyIDmiS3SubqAZ/5BXXGq3R+8MPEAVaGxB7O5OpJsfw7tmCWMthG2RL5/P/B64X7Z9Y16G3wdxF/gBqOZgsy6A7X/F8ag3f7TD2ot5RpDVv710VYYWjGRaqUTwIfBM5HgnXWXeEBWxnHI0FuJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856255; c=relaxed/simple;
	bh=Z4X5+LQ7+8DK5rIVCgxb3Mpe01BP2W5L399+BG+Ka2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzDnCHYjALB2i1ESLF/yyMchT7vtl/HDb1uMsOuChDG9ovgv3+CqhFqvDBkjmT05WfQJ+wa5DEKK02J6cguIntuJ12YguSUVmqk+jn/BuWGXZRFJGHEkQO0N/rKrvKDFNAqjpF6RhvvMvPkErzo6pmVBv2zgtv+YBQxgD0xDr4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A137C4CEED;
	Fri, 22 Aug 2025 09:50:53 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/6] can: rcar_canfd: Add suspend/resume support
Date: Fri, 22 Aug 2025 11:50:38 +0200
Message-ID: <cover.1755855779.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series adds proper suspend/resume support to the Renesas
R-Car CAN-FD controller driver, after the customary cleanuops and fixes.
It aims to fix CAN-FD operation after resume from s2ram on systems where
PSCI powers down the SoC.

The last patch is marked RFC, as it causes a regression on R-Car Gen4.
More details can be found in that patch.

This has been tested on Ebisu-4D (R-Car E3) and White Hawk (R-Car V4H).

Thanks for your comments!

Geert Uytterhoeven (6):
  can: rcar_canfd: Invert reset assert order
  can: rcar_canfd: Invert global vs. channel teardown
  can: rcar_canfd: Extract rcar_canfd_global_{,de}init()
  can: rcar_canfd: Invert CAN clock and close_candev() order
  can: rcar_canfd: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
  [RFC] can: rcar_canfd: Add suspend/resume support

 drivers/net/can/rcar/rcar_canfd.c | 225 ++++++++++++++++++++----------
 1 file changed, 152 insertions(+), 73 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

