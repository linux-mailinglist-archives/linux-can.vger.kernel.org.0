Return-Path: <linux-can+bounces-4856-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A466AB9492F
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 08:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92DC74E2C34
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 06:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0747F30F547;
	Tue, 23 Sep 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijJOC8Im"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D138530E0FC;
	Tue, 23 Sep 2025 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758609451; cv=none; b=EfBU0AxxKpQolI2nTs1yKE2+KC58pN1bN8vc2ETIsnpGaNU2S8tYTUgm9ykduaJ43HC78I40jM/8kWCnlbNhTuC+9gNB1yOjkMrFY9nlNzbvuNYOIs2v0VLs8SZimdKPeZiCxZ9aL5j/1tM1WM7nK6eqTt761hTGcLFwjo4gxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758609451; c=relaxed/simple;
	bh=Pxu+qJLYh5kmDZMIAhw3xQfnHRm/wsdLe+4n2WFD5As=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Cmb3O+AOVMxFRAqC2QPsydcwCn2q1qEQbxw5XZ3rJIE9S8/e5PAs31HFWI5enY4kCmT623Isj65ViHImTTF7z0TgkRbFeQ7jGNRrCy7GPLxqj1nfqhf05M5LZ0Lmnat441A+Vk+wjEj+tgkaqYidJcJCckB1fnDNrLIK0TCTsQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijJOC8Im; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97015C4CEF5;
	Tue, 23 Sep 2025 06:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758609451;
	bh=Pxu+qJLYh5kmDZMIAhw3xQfnHRm/wsdLe+4n2WFD5As=;
	h=From:Subject:Date:To:Cc:From;
	b=ijJOC8ImReEFW1YraR1WGGkmVD4p9RaAjPVe33Zbk0PqAPPwbWr/PyufcXNyNKh83
	 FelxlvaUe1/hbmFEDqG4K1mNkec7hzGe3qrP76HBY0Cly4IvvheXE15Wz/A7yAOhxa
	 kg3qqDBi9P28Np3uN0L/zy7B26nv+RRiDAJ17cIrfjcwptZGpDih3rIbXjdN+igQhY
	 H8i3N0SloXRzLK8KUaNLttBA1wAenBxE49m0wBWKHfhilUZRxfqdfXB2MprJLJpEIW
	 /3uBSur6MbgWc5ZmHrVHClXn7ebBSfPYQYyCJoPS1OXOGQpBhouRMgBjixM2vRclNx
	 U/rVOgjbD4+Jw==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v3 0/4] can: rework the CAN MTU logic (CAN XL preparation
 step 2/3)
Date: Tue, 23 Sep 2025 15:37:07 +0900
Message-Id: <20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABNA0mgC/1XOQQ6CMBAF0KuQrh0thSJl5T2MiwIDNNqibSEYw
 t2t4EKWfybvz8zEoVXoSBHNxOKonOpNCMkhIlUnTYug6pAJo4xTEXOopIFGTaD9AJRTKdKSZ4m
 kJIinxbBa2663LVt8DaHUb0NSSodQ9VorX0QGPRic/ElLZcgXdMr53r7Xb8Z4Fb/D+e7wGAOF9
 BxjXYqUMcEvd7QGH8fetmvRyP4wS/aYBSzytBF5ltdlJnZ4WZYPKi5wJxUBAAA=
X-Change-ID: 20250915-can-fix-mtu-050a94b563a0
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6061; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=Pxu+qJLYh5kmDZMIAhw3xQfnHRm/wsdLe+4n2WFD5As=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXHCS/cmzpqmG32lHmvuquzkTPZdZe5vr3RVn6Jmcaf
 VvB2vawo5SFQYyLQVZMkWVZOSe3Qkehd9ihv5Ywc1iZQIYwcHEKwETObmRkOPHTePJNiacud+Ja
 UpWEpnDcejVb6/HpDMvXvBOrutS7XBn+11wNbWEs2sPy0mLr3Gvbrl/Xc9vGIyR25dzFbS3qEYa
 OfAA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

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

Point 1. will allow us to get rid of the can_change_mtu() in a near
future for all the physical devices and point 2. allows the end user
to see the valid MTU range by doing a:

  $ ip --details link show can0

Finally, because using the net core, it will be possible after the
removal of can_change_mtu() to modify the MTU while the device is up.
As stated previously, the only modifications allowed will be within
the MTU range of a given CAN protocol. So for Classical CAN and CAN
FD, the MTU is fixed to, respectively, CAN_MTU and CANFD_MTU. For the
upcoming CAN XL, the user will be able to change the MTU to anything
between CANXL_MIN_MTU and CANXL_MAX_MTU even if the device is up.

The first patch of this series annotates the read access on
net_device->mtu. This preparation is needed to prevent any race
condition to occur when modifying the MTU while the device is up.

The second patch is another preparation change which moves
can_set_static_ctrlmode() from dev.h to dev.c.

The third patch populates the MTU minimum and maximum value.

The fourth patch is just a clean-up to remove the old
can_change_mtu().

The fourth and last patch comes as a bonus content and modifies the
default MTU of the vcan and vxcan so that CAN XL is on by default.

Note that after this series, the old can_change_mtu() becomes
useless. That function can not yet be removed because some pending
changes from other maintainers' trees still depend on it. It will be
removed in the next development window once all those changes reach
net-next.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v3:

  - v2 was based on Linus tree and, as a result, my other series which
    depends on this one did not apply smoothly:

      https://lore.kernel.org/linux-can/13f98eed-b535-4360-a545-0a11dbc8aa12@kernel.org/

    Rebase on net-next.

Link to v2: https://lore.kernel.org/r/20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org

Changes in v2:

  - Drop RFC prefix

  - Patch "can: treewide: remove can_change_mtu()" is removed because
    it depends on the MTU fix:

      https://lore.kernel.org/linux-can/20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org/

    which at the time of writing, does not yet appear in net-next. It
    is also still used in the Nuvoton driver which is also not yet
    merged. This patch will be resent in the next development window.

Link to v1: https://lore.kernel.org/r/20250918-can-fix-mtu-v1-0-471edb942295@kernel.org

---
Vincent Mailhol (4):
      can: annotate mtu accesses with READ_ONCE()
      can: dev: turn can_set_static_ctrlmode() into a non-inline function
      can: populate the minimum and maximum MTU values
      can: enable CAN XL for virtual CAN devices by default

 drivers/net/can/dev/dev.c     | 38 +++++++++++++++++++++++++++++++++++++-
 drivers/net/can/dev/netlink.c |  9 ++++-----
 drivers/net/can/vcan.c        |  2 +-
 drivers/net/can/vxcan.c       |  2 +-
 include/linux/can/dev.h       | 24 +++---------------------
 net/can/af_can.c              |  2 +-
 net/can/isotp.c               |  2 +-
 net/can/raw.c                 |  2 +-
 8 files changed, 49 insertions(+), 32 deletions(-)
---
base-commit: 9b277fca90c39c8b749e659bf5c23e924c46c93b
change-id: 20250915-can-fix-mtu-050a94b563a0

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


