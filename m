Return-Path: <linux-can+bounces-3741-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76177ACAD97
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 13:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502873B3C4C
	for <lists+linux-can@lfdr.de>; Mon,  2 Jun 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD78F1F150A;
	Mon,  2 Jun 2025 11:54:37 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2A614F70;
	Mon,  2 Jun 2025 11:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748865277; cv=none; b=YZF80lWgXXkabI44CqEIL3VA6Hn/g9aJ16G/77sNg8jhq2xiTIE+gGjrm5e+KqoOpqIkc5vdJON8WqZ+MyogtjEy0n6PGfK1QpSj8vvQblpa14J4uL8+vETPTSvh7uTwRIbPm6ZcPL8GC2k328j9QDSX46n5+MBJ1AzM6i0VCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748865277; c=relaxed/simple;
	bh=3QNhaQ+gkLCMRpCG8iYhlOJFJbwz50UYGDQfXX3c3Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYRZ3+JfwX16cfw+winKblk/l/eMNLo6mf0c05+P6vQIixHAJZPS/Djoy4pkUk5TNne5+NpXJbVJM46tbFBmahaLmrjwtQ9Aj/gufzvAylVxMmLNy0/tnEL/Ga83L4b3wjdeXq5Grb6g3rT6Qm91LNeSTYtGyfiuDrGJyXWfL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A940C4CEEB;
	Mon,  2 Jun 2025 11:54:35 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Kazuhiro Takagi <kazuhiro.takagi.hh@hitachi-solutions.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/9] can: rcar_canfd: Add support for Transceiver Delay Compensation
Date: Mon,  2 Jun 2025 13:54:19 +0200
Message-ID: <cover.1748863848.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series adds CAN-FD Transceiver Delay Compensation support to
the R-Car CAN-FD driver, after the customary cleanups and refactorings.

This has been tested on R-Car V4H (White Hawk), V4M (Gray Hawk Single),
and E3 (Ebisu-4D[1]), using various data bit rates.  Without proper TDC
configuration, transmitting at 8 Mbps makes the CAN-FD controller enter
BUS-OFF state.  The TDCV value as measured by the CAN-FD controller is 4
on all boards tested (base clock 40 MHz, i.e. 25 ns period), and ca. 90
ns as measured by a logic analyzer on Gray Hawk Single.

Note that the BSP (predating upstream TDC support), uses a much simpler
method: for transfer rates >= 5 Mbps on R-Car Gen4, it enables TDC with
a hardcoded (hardware) TDCO value of 2 (i.e. actual 3), which matches
the behavior of this series at 8 Mbps.

Thanks for your comments!

[1] r8a77990.dtsi configures the CANFD core clock to 40 MHz, limiting
    transfer rates to 4 Mbps.  Enable support for 8 Mbps by adding to
    ebisu.dtsi:

	&canfd {
		assigned-clock-rates = <80000000>;
	}

Geert Uytterhoeven (9):
  can: rcar_canfd: Consistently use ndev for net_device pointers
  can: rcar_canfd: Use ndev parameter in rcar_canfd_set_bittiming()
  can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
  can: rcar_canfd: Add helper variable dev to
    rcar_canfd_reset_controller()
  can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
  can: rcar_canfd: Repurpose f_dcfg base for other registers
  can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
  can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not
    FD
  can: rcar_canfd: Add support for Transceiver Delay Compensation

 drivers/net/can/rcar/rcar_canfd.c | 193 +++++++++++++++++++-----------
 1 file changed, 126 insertions(+), 67 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

