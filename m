Return-Path: <linux-can+bounces-3810-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829C7AD5AD5
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 17:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3645B1885C8D
	for <lists+linux-can@lfdr.de>; Wed, 11 Jun 2025 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480D01C6FF6;
	Wed, 11 Jun 2025 15:37:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB71B0412;
	Wed, 11 Jun 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656269; cv=none; b=XwQHFK5Qyl/R3iAnysxL//cJbsGdHTpCwKZpzw+5jGt985s7B4vX+q0JP+EetwnyL+RCwVXHPgPc+5cFeOVwq0qtCviP14epQ8ycCn4mz8HSJSY8iYaLEaPHg6rI5mDMlWmOiWK7U3eSHdKE61tikyDD1CftFOP6wltxIpBiTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656269; c=relaxed/simple;
	bh=YdwfrHn55EcHmzR6Vvqw1F/4MhrbhfwW1Xd3P6mL9LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfsVdBokJuHGf6De9xrQKcX/sg2IO5ERgh9TtxKlDhFld5Dol22jlejLWeTNwdARiNmxlW5m37uxAigTtxT8pveNpgLmq2oge8CCyBHuCGTUoccApK0eJgdpSIz3f19iIp+x3LpOxv9GZ9G56Iew5/acpCJpUtGF4FEdG0fBXJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE93EC4CEE3;
	Wed, 11 Jun 2025 15:37:46 +0000 (UTC)
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
Subject: [PATCH v2 00/10] can: rcar_canfd: Add support for Transceiver Delay Compensation
Date: Wed, 11 Jun 2025 17:37:29 +0200
Message-ID: <cover.1749655315.git.geert+renesas@glider.be>
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

Changes compared to v1:
  - Dropped patch "can: rcar_canfd: Use ndev parameter in
    rcar_canfd_set_bittiming()",
  - New patch "[PATCH v2 02/10] can: rcar_canfd: Remove bittiming debug
    prints",
  - New patch "[PATCH v2 07/10] can: rcar_canfd: Rename
    rcar_canfd_setrnc() to rcar_canfd_set_rnc()",
  - Add Reviewed-by,
  - Replace function-like RCANFD_F_*() macros by rcar_canfd_f_*()
    inline functions,
  - Replace function-like macro RCANFD_FDSTS_TDCR() by bitmask
    RCANFD_FDSTS_TDCR and helper function rcar_canfd_get_tdcr(),
  - Replace function-like macro RCANFD_FDSTS_TDCVF() by two bit
    definitions,
  - Drop debug print of tdc mode and tdco value.

This has been tested on R-Car V4H (White Hawk), V4M (Gray Hawk Single),
and E3 (Ebisu-4D[2]), using various data bit rates.  Without proper TDC
configuration, transmitting at 8 Mbps makes the CAN-FD controller enter
BUS-OFF state.  The TDCV value as measured by the CAN-FD controller is 4
on all boards tested (base clock 40 MHz, i.e. 25 ns period), and ca. 90
ns as measured by a logic analyzer on Gray Hawk Single.

Note that the BSP (predating upstream TDC support), uses a much simpler
method: for transfer rates >= 5 Mbps on R-Car Gen4, it enables TDC with
a hardcoded (hardware) TDCO value of 2 (i.e. actual 3), which matches
the behavior of this series at 8 Mbps.

Thanks for your comments!

[1] "[PATCH 0/9] can: rcar_canfd: Add support for Transceiver Delay Compensation"
    https://lore.kernel.org/cover.1748863848.git.geert+renesas@glider.be

[2] r8a77990.dtsi configures the CANFD core clock to 40 MHz, limiting
    transfer rates to 4 Mbps.  Enable support for 8 Mbps by adding to
    ebisu.dtsi:

	&canfd {
		assigned-clock-rates = <80000000>;
	}

    I plan to send patches to update this on all R-Car Gen3 and RZ/G2
    SoCs once this series has reached upstream.

Geert Uytterhoeven (10):
  can: rcar_canfd: Consistently use ndev for net_device pointers
  can: rcar_canfd: Remove bittiming debug prints
  can: rcar_canfd: Add helper variable ndev to rcar_canfd_rx_pkt()
  can: rcar_canfd: Add helper variable dev to
    rcar_canfd_reset_controller()
  can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
  can: rcar_canfd: Repurpose f_dcfg base for other registers
  can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
  can: rcar_canfd: Share config code in rcar_canfd_set_bittiming()
  can: rcar_canfd: Return early in rcar_canfd_set_bittiming() when not
    FD
  can: rcar_canfd: Add support for Transceiver Delay Compensation

 drivers/net/can/rcar/rcar_canfd.c | 228 ++++++++++++++++++++----------
 1 file changed, 156 insertions(+), 72 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

