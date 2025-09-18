Return-Path: <linux-can+bounces-4745-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB0B84B76
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 14:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331491C27094
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122B2FD7A7;
	Thu, 18 Sep 2025 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro4qX5hI"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB97D283FD0;
	Thu, 18 Sep 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200374; cv=none; b=LH6q8VDU+N/ygZK+mLpzBFdKd+o5Y1lGf2kjc1JQCibVA6DC4UwDuzTAqflPsbtvDmTu93hJbJqelNaCg+4mbicTab8Q+UqQ7GQCwTGyTIRk9pctF1ys0zZHUbTaEfuD/eWtU5NHraAsPBXz7GUZoFOzKEHmT+kh8ysu38HDJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200374; c=relaxed/simple;
	bh=HXr87NSDl5v+ze9/uIpTWFaPMuyAsehF40DUf+AKvFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RRJFwFSKfRbFcEqoMzfGCRvvLYHfQltWTZ7a3OZv/K97RLERrA7GMuwvXxyMGKLtFtyo7NjPOp9uctCfDbhl4jVtk1YFkq6XRkHf8fjx7Bgl2WSIS19yk1k/K/3JDALwj899zLYGbKUcsEXDj4Pf1BwC7l99STSrJ0vkfDysBvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro4qX5hI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D0FC4CEE7;
	Thu, 18 Sep 2025 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758200373;
	bh=HXr87NSDl5v+ze9/uIpTWFaPMuyAsehF40DUf+AKvFM=;
	h=From:Subject:Date:To:Cc:From;
	b=Ro4qX5hIGSDya6TJ8VIl6hyqizNHE5tAVSLhxJtWg+tAxRcgj4xnuNXRiTAcwZ9Ml
	 a3amm875X4chzLUH9jyAXzjDlGOvhKmCWtpzpj9BLYI/Sk8D4gb0qyc1MvdPiZa6qp
	 UGNLTTwWQO6RqLfFaM3dStkWhyPvb6+CMfENoNmxuxbKhuDMtUXv3rw4/CJv2s/iBW
	 X+plRKCU0e31ui8kI5848ZYXRrEGtxiAFY4gp4M8ZJ70EyBrED3z9beU2zsCet5qNT
	 TV3b1Wh1/Bheh7N4lP9qMXaZInijRZLnuUeP2t2khHiyef0BOyxZoAmcIlJc5zTUZ8
	 0zCYffXZ/42/g==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH RFC 0/5] can: rework the CAN MTU logic
Date: Thu, 18 Sep 2025 21:59:10 +0900
Message-Id: <20250918-can-fix-mtu-v1-0-471edb942295@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8CzGgC/1WNwQ7CIBBEf4Xs2Y2AYixXEz/Aq+mBtqvuAapAm
 yZN/12iPejxzWTmzZAoMiWwYoZIIyfuQwG1EdA+XLgTclcYtNRGVspg6wLeeEKfB5RGumrfmMP
 OSSiLZ6RSfd6ucDmfoP6GkV5Dec5r07hE2Pbec7YiUMZAU956xwF+tVas0uOftDFakaJOOV3ZU
 UG9LG+QfW/MxgAAAA==
X-Change-ID: 20250915-can-fix-mtu-050a94b563a0
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8041; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=DZ0cKY+XhrOTnjWUrd9pwXyyWLUKqy7I9Lnk7gVWHN0=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlnmNSKbz4rOlGyxzbm+sGd1/Musb9bzaXht23l2f0X0
 pWn3vGe2FHKwiDGxSArpsiyrJyTW6Gj0Dvs0F9LmDmsTCBDGLg4BWAir2cy/K95G/qKQzg6dsaR
 9c5PF12c+Zi9Wn7L77mPZ2nIzT16YOprht9s7w7P/MYavLLFKO52eNe8YI5Spc/lAXFH+/r0GS4
 Lp7MBAA==
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2



---
RFC preface:

I am sending this as an RFC because I am not done 100% with my testing
and this depends on the other series I just sent earlier today:

Link: https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org/

I will drop the RFC tag once the above series is merged and appears in
net-next.
---

The CAN MTU logic is currently broken. can_change_mtu() will update
both the MTU and the CAN_CTRLMODE_FD flag.

Back then, commit bc05a8944a34 ("can: allow to change the device mtu
for CAN FD capable devices") stated that:

  The configuration can be done either with the 'fd { on | off }'
  option in the 'ip' tool from iproute2 or by setting the CAN
  netdevice MTU to CAN_MTU (16) or to CANFD_MTU (72).

  Link: https://git.kernel.org/torvalds/c/bc05a8944a34

The problem is that after doing for example:

  $ ip link set can0 mtu 72 bittiming 500000

on a CAN FD interface, we are left with a device on which CAN FD is
enabled but which does not have the FD databittiming parameters
configured.

The same goes on when setting the mtu back to 16:

  ip link set can0 type can bitrate 500000 fd on dbitrate 5000000
  ip link set can0 mtu 16

The device is now in Classical CAN mode but iproute2 is still
reporting the databittiming values (although this time, the issue
seems less critical as it is only a reporting problem).

The only way to resolve the problem and bring the device back to a
coherent state is to call again the netlink interface using the
"fd on" or "fd off" options.

The idea of being able to infer the CAN_CTRLMODE_FD flag from the MTU
value is just incorrect for physical devices. Note that this logic
remains valid on virtual interfaces (vcan and vxcan) because those do
not have control mode flags and thus no conflict occurs.

This series reworks the CAN MTU logic. The goal is to always maintain
a coherent state between the MTU and the control mode flags as listed
in below table:

		fd off, xl off		fd on, xl off		fd any, xl on
  ---------------------------------------------------------------------------
  default mtu	CAN_MTU			CANFD_MTU		CANXL_MTU
  min mtu	CAN_MTU			CANFD_MTU		CANXL_MIN_MTU
  max mtu	CAN_MTU			CANFD_MTU		CANXL_MAX_MTU

In order to switch between one column to another, the user must use
the fd/xl on/off flags. Directly modifying the MTU from one column to
the other is not permitted any more.

The CAN XL is not yet supported at the moment, so the last column is
just given as a reference to better understand what is coming up. This
series will just implement the first two columns.

While doing the rewrite, the logic is adjusted to reuse as much as
possible the net core infrastructure. By populating:

  net_device->min_mtu

and

  net_device->max_mtu

the net core infrastructure will automatically:
    
  1. validate that the user's inputs are in range.

  2. report those min and max MTU values through the netlink
     interface.
    
Point 1. allows us to get rid of the can_change_mtu() for all the
physical devices and point 2. allows the end user to see the valid MTU
range by doing a:

  $ ip --details link show can0

Finally, because using the net core, it will be possible to modify the
MTU while the device is up. As stated previously, the only
modifications allowed will be within the MTU range of a given MTU. So
for Classical CAN and CAN FD, the MTU is fixed to, respectively,
CAN_MTU and CANFD_MTU. For the upcoming CAN XL, the user will be able
to change the MTU to anything between CANXL_MIN_MTU and CANXL_MAX_MTU
even if the device is up.

The first patch of this series annotates the read access on
net_device->mtu. This preparation is needed to prevent any race
condition to occur when modifying the MTU while the device is up.

The second patch is another preparation change which moves
can_set_static_ctrlmode() from dev.h to dev.c.

The third patch populates the MTU minimum and maximum value.

The fourth patch is just a clean-up to remove the old
can_change_mtu().

The fifth and last patch comes as a bonus content and modifies the
default MTU of the vcan and vxcan so that CAN XL is on by default.

To: Oliver Hartkopp <socketcan@hartkopp.net>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>

---
Vincent Mailhol (5):
      can: annotate mtu accesses with READ_ONCE()
      can: dev: turn can_set_static_ctrlmode() into a non-inline function
      can: populate the minimum and maximum MTU values
      can: treewide: remove can_change_mtu()
      can: enable CAN XL for virtual CAN devices by default

 drivers/net/can/at91_can.c                         |  1 -
 drivers/net/can/bxcan.c                            |  1 -
 drivers/net/can/c_can/c_can_main.c                 |  1 -
 drivers/net/can/can327.c                           |  1 -
 drivers/net/can/cc770/cc770.c                      |  1 -
 drivers/net/can/ctucanfd/ctucanfd_base.c           |  1 -
 drivers/net/can/dev/dev.c                          | 54 +++++++++++-----------
 drivers/net/can/dev/netlink.c                      |  9 ++--
 drivers/net/can/esd/esd_402_pci-core.c             |  1 -
 drivers/net/can/flexcan/flexcan-core.c             |  1 -
 drivers/net/can/grcan.c                            |  1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c              |  1 -
 drivers/net/can/janz-ican3.c                       |  1 -
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c |  1 -
 drivers/net/can/m_can/m_can.c                      |  1 -
 drivers/net/can/mscan/mscan.c                      |  1 -
 drivers/net/can/peak_canfd/peak_canfd.c            |  1 -
 drivers/net/can/rcar/rcar_can.c                    |  1 -
 drivers/net/can/rcar/rcar_canfd.c                  |  1 -
 drivers/net/can/rockchip/rockchip_canfd-core.c     |  1 -
 drivers/net/can/sja1000/sja1000.c                  |  1 -
 drivers/net/can/slcan/slcan-core.c                 |  1 -
 drivers/net/can/softing/softing_main.c             |  1 -
 drivers/net/can/spi/hi311x.c                       |  1 -
 drivers/net/can/spi/mcp251x.c                      |  1 -
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     |  1 -
 drivers/net/can/sun4i_can.c                        |  1 -
 drivers/net/can/ti_hecc.c                          |  1 -
 drivers/net/can/usb/ems_usb.c                      |  1 -
 drivers/net/can/usb/esd_usb.c                      |  1 -
 drivers/net/can/usb/etas_es58x/es58x_core.c        |  1 -
 drivers/net/can/usb/f81604.c                       |  1 -
 drivers/net/can/usb/gs_usb.c                       |  1 -
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |  1 -
 drivers/net/can/usb/mcba_usb.c                     |  1 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |  1 -
 drivers/net/can/usb/ucan.c                         |  1 -
 drivers/net/can/usb/usb_8dev.c                     |  1 -
 drivers/net/can/vcan.c                             |  2 +-
 drivers/net/can/vxcan.c                            |  2 +-
 drivers/net/can/xilinx_can.c                       |  1 -
 include/linux/can/dev.h                            | 25 ++--------
 net/can/af_can.c                                   |  2 +-
 net/can/isotp.c                                    |  2 +-
 net/can/raw.c                                      |  2 +-
 45 files changed, 38 insertions(+), 97 deletions(-)
---
base-commit: 5e87fdc37f8dc619549d49ba5c951b369ce7c136
change-id: 20250915-can-fix-mtu-050a94b563a0
prerequisite-change-id: 20250918-can-fix-mtu-b521e1ed1a29:v1
prerequisite-patch-id: ace4f8ad663553a2a04ec56ca28fd2445b0ce06e
prerequisite-patch-id: 10ebdab5a42d989075b951bba3e93b5bea178ead
prerequisite-patch-id: 11502adb20b40227221185c363cd4f0733ca2239
prerequisite-patch-id: be9ed4f4caaa323a1757a7c5d4d2a4bfb2cfc124

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


