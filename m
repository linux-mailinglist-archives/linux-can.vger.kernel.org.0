Return-Path: <linux-can+bounces-5154-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F35BD2B05
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 13:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBAAA341187
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55EE212572;
	Mon, 13 Oct 2025 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDNeNL0h"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D81F541E;
	Mon, 13 Oct 2025 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760353337; cv=none; b=bZq1pMzGmzzefQbJpkvvVIuuC2kZBvncAkUm33eqrV1ztz2DQfRHaMc+/0aWIe73QnB2F7NUwUBM5B7s0ghgEiU6Gnh+9WNC3bOodYIXc0K7W5bu3cWFgHayY1o16LVeeVMT2w9WzV5XwPHBVE1CmM07+u8zSLThqFHlnD3yMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760353337; c=relaxed/simple;
	bh=weNHSrowVJvIfzm6uMenk5hmDKgtwHJzOmuT7u8j5fQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jAtiuNjrb+L88IC9Abs2w9hhHWoiWHjUH1/gnUU4JwXIqqe+YYH2nuxyP8PpZ+7XeHSapbYlp5M1umL0DG1b7zTH+udY0RqQ0Q4OI0LVUFdvc5RkQKMk4/XtxbtCFdXwuZi9s+YPyviWbdcvN11hT43mV1wl2nwlpzo5O9YSUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDNeNL0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AFFC4CEE7;
	Mon, 13 Oct 2025 11:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760353337;
	bh=weNHSrowVJvIfzm6uMenk5hmDKgtwHJzOmuT7u8j5fQ=;
	h=From:Subject:Date:To:Cc:From;
	b=GDNeNL0hrAfkoVzuvwq1WC4H9OmQ6JTYfsNJ/dc1wTudjEEkotLHnQWqX52WcicG4
	 PU9F3+lHnEMo2F+5rYiwzYnKl0rxAzUfnFdTRkz7paz6opsZ9jxwTnvTz15PRpO9nS
	 y6l9rgC+49YMxXaVH/m85H6cXryDMJL+/wm3H3AeM13WEqtpfm+MatPMioOQ6jgYDY
	 vZP6qYOMQVLlUDWDNd6ue/3vkJeoGCBZ7wNvPfqPodCXFH/r3LRTYN6bmp8AQMO+Ut
	 y3p35F2SkVL+SdIfJOmgu+pWFlzlIKcmlJe194OMe+Nd6KTrT6Nd5eUpPd/LH6GQsy
	 HlzvzVBOuNQMA==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH 0/9] can: netlink: add CAN XL
Date: Mon, 13 Oct 2025 20:01:22 +0900
Message-Id: <20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAALc7GgC/yXMQQ6CMBCF4as0s3ZMW0hVrmJYlDroRCg6rYSEc
 HcaWX4vef8KiYQpQaNWEJo58RQLzElBePn4JORHMVhta2PtDYOPy4CR8sDxjV1wtfa90e5SQfl
 8hHpe/r17e1jo+yvZfIzQ+UQYpnHk3KjZnc0VJRhot20HDI6IgYwAAAA=
X-Change-ID: 20241229-canxl-netlink-bc640af10673
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3490; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=weNHSrowVJvIfzm6uMenk5hmDKgtwHJzOmuT7u8j5fQ=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlv7kiqNOdN3C71rf9MTYRRP1P8vHt3lqlq6E/fp5K79
 ObhJ1kzOkpZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAEzk2QxGhv0LT3Ft3L2zyk3G
 6BFjx9ls2cvPFLqlHTbOm6nsxF7m95iR4UBc7ib/faG6xQs/h+VZb1j8fXNpLn971cHeXfdiphf
 G8gIA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Following all the refactoring on the CAN netlink done in series [1],
[2] and [3], this is now time to finally introduce the CAN XL netlink
interface.

Similarly to how CAN FD reuses the bittiming logic of Classical CAN,
CAN XL also reuses the entirety of CAN FD features, and, on top of
that, adds new features which are specific to CAN XL.

Patch #1 adds a check in can_dev_dropped_skb() to drop CAN FD frames
when CAN FD is turned off.

Patch #2 adds CAN_CTRLMODE_RESTRICTED. Note that contrary to the other
CAN_CTRL_MODE_XL_* that are introduced in the later patches, this
control mode is not specific to CAN XL. The nuance is that because
this restricted mode was only added in ISO 11898-1:2024, it is made
mandatory for CAN XL devices but optional for other protocols. This is
why this patch is added as a preparation before introducing the core
CAN XL logic.

Patch #3 adds all the CAN XL features which are inherited from CAN FD:
the nominal bittiming, the data bittiming and the TDC.

Patch #4 and #5 add two new CAN control modes which are specific to
CAN XL: CAN_CTRLMODE_XL_TMS, CAN_CTRLMODE_XL_ERR_SIGNAL respectively.

Finally, patch #6 to #9 add the PWM logic.

[1] can: netlink: preparation before introduction of CAN XL
Link: https://lore.kernel.org/linux-can/20241112165118.586613-7-mailhol.vincent@wanadoo.fr/

[2] can: rework the CAN MTU logic (CAN XL preparation step 2/3)
Link: https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org/

[3] can: netlink: preparation before introduction of CAN XL step 3/3
Link: https://lore.kernel.org/linux-can/20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org/

---
Changes in v1:

   - Add PWM

   - Add the CAN_CTRLMODE_RESTRICTED, CAN_CTRLMODE_XL_TMS and
     CAN_CTRLMODE_XL_ERR_SIGNAL control modes.

   - A lot has changed since the original RFC was sent in November
     last year.  The preparation patches went in a separate series as
     explained in the cover letter, and what used to be a single patch
     to introduce CAN XL is now a full series. A few additional
     details are added to the individual patches, but overall I did
     not keep track of all the changes over the last year. You may as
     well consider this as a new series.
   
Link to RFC: https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/

---
Vincent Mailhol (9):
      can: dev: can_dev_dropped_skb: drop CAN FD skbs if FD is off
      can: netlink: add CAN_CTRLMODE_RESTRICTED
      can: netlink: add initial CAN XL support
      can: netlink: add CAN_CTRLMODE_XL_TMS flag
      can: netlink: add CAN_CTRLMODE_XL_ERR_SIGNAL
      can: bittiming: add PWM parameters
      can: bittiming: add PWM validation
      can: calc_bittiming: add PWM calculation
      can: netlink: add PWM netlink interface

 drivers/net/can/dev/bittiming.c      |  63 +++++++
 drivers/net/can/dev/calc_bittiming.c |  36 ++++
 drivers/net/can/dev/dev.c            |  20 +-
 drivers/net/can/dev/netlink.c        | 357 +++++++++++++++++++++++++++++++++--
 include/linux/can/bittiming.h        |  76 +++++++-
 include/linux/can/dev.h              |  49 +++--
 include/uapi/linux/can/netlink.h     |  35 ++++
 7 files changed, 595 insertions(+), 41 deletions(-)
---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20241229-canxl-netlink-bc640af10673

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


