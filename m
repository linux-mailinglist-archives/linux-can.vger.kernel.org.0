Return-Path: <linux-can+bounces-5249-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AD0BF7795
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 17:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EF21896A70
	for <lists+linux-can@lfdr.de>; Tue, 21 Oct 2025 15:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A61533509F;
	Tue, 21 Oct 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svBKy3Dh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B1B337B8C;
	Tue, 21 Oct 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061670; cv=none; b=ehV9H/NcYhJsoQwUyh5qh7BB6wMtm5vK3XU/4ZJ9r0C3AnaSDWkWkdh9gfXm2/iPsNVms4rr9R5gTZWmbaufyCeU10Q+40tYM5arP0Y3M8ZVwLjiikbvw9mtEe5kFD+86mlKhS+Z0vluLplp1A493S3fyBN37H4Oem4PNnddY8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061670; c=relaxed/simple;
	bh=sCPAXN/+lN3kJvSe9YEoX4eIqRz1F48Z4A5LcZGmJF4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y1RswafcPJ6w4wUOx74u5gr/P0mlenjZArlaA5QlrGySsQDM3KMSwvUwQoJrz4qGVwOBx28Th1HHFUWhfefxjZTB05nseYEFV9KP+7kXhITie3887wRKmHwzQi/MUy0V0pthZ9yW04GOxv7IvULJqgUP88TO78buh1o2VdeMfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svBKy3Dh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8B8C4CEF1;
	Tue, 21 Oct 2025 15:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761061669;
	bh=sCPAXN/+lN3kJvSe9YEoX4eIqRz1F48Z4A5LcZGmJF4=;
	h=From:Subject:Date:To:Cc:From;
	b=svBKy3DhW+uZXX/jwQvFXYs0EPyMuFbXqep8lVeSIp1hC99Y9DyeBclZPsA6b/ITl
	 TSHJTlzLog8h8Xv7H/hw00IXns210vP43bm1cGmbu/iSUncmsTQvNjt41tSw9pcdo3
	 HUvSru3ZU5oK9Pul3tzaEPWdDQTV9E3qqQHWoxhVk45lX0H+CQJp4xDc7tQWsrH/TA
	 CunHYUP8XPHBCQYnfSYq3tzwMZAz2RxkzEb4i7Xtg9BjgulE1X6tNg9gic487FDueu
	 gV3CJQ2d/h+tNKQUWJjhnYrAEWrRYIJD36qPm23aqwqqqReToWV29DiMxe08vFLBeF
	 NJOkdWtXmZRLw==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 00/10] can: netlink: add CAN XL
Date: Tue, 21 Oct 2025 17:47:00 +0200
Message-Id: <20251021-canxl-netlink-v2-0-8b8f58257ab6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPSq92gC/12OTQ6CMBCFr0JmbUk7ICgr72FYlDqFBmi1RYIh3
 N0KO5ffy/tbIZA3FKBKVvA0m2CcjYCnBFQnbUvMPCIDcswF4pUpaZeBWZoGY3vWqCLnUgtelBn
 EzNOTNsved68P9vR6x9rpEKGRgZhy42imKpmLVFyYVwg/c2fC5Pxn/zKL3R1nz4KL7G92Fowzn
 SM2JWGJV33ryVsaUudbqLdt+wKSzqKp2AAAAA==
X-Change-ID: 20241229-canxl-netlink-bc640af10673
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4114; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=sCPAXN/+lN3kJvSe9YEoX4eIqRz1F48Z4A5LcZGmJF4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBnfVzNc6j04OWu1VsW+04UKr9bNfLDJ/3vzgay1K8WNt
 ji4HN70vKOUhUGMi0FWTJFlWTknt0JHoXfYob+WMHNYmUCGMHBxCsBEDrUwMtznPhy4ImPO2Tkd
 Wzdsu3YhcqrHpVfrI+t+cS7zkhP6JRLKyDClT3GxRNSXvpzYMie9ydFnOlMiv7+vWJ0YsjG965/
 OXgYA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Following all the refactoring on the CAN netlink done in series [1],
[2] and [3], this is now time to finally introduce the CAN XL netlink
interface.

Similarly to how CAN FD reuses the bittiming logic of Classical CAN,
CAN XL also reuses the entirety of CAN FD features, and, on top of
that, adds new features which are specific to CAN XL.

Patch #1 is a small clean-up which makes can_calc_bittiming() use
NL_SET_ERR_MSG() instead of netdev_err().

Patch #2 adds a check in can_dev_dropped_skb() to drop CAN FD frames
when CAN FD is turned off.

Patch #3 adds CAN_CTRLMODE_RESTRICTED. Note that contrary to the other
CAN_CTRL_MODE_XL_* that are introduced in the later patches, this
control mode is not specific to CAN XL. The nuance is that because
this restricted mode was only added in ISO 11898-1:2024, it is made
mandatory for CAN XL devices but optional for other protocols. This is
why this patch is added as a preparation before introducing the core
CAN XL logic.

Patch #4 adds all the CAN XL features which are inherited from CAN FD:
the nominal bittiming, the data bittiming and the TDC.

Patch #5 and #6 add two new CAN control modes which are specific to
CAN XL: CAN_CTRLMODE_XL_TMS, CAN_CTRLMODE_XL_ERR_SIGNAL respectively.

Finally, patch #7 to #10 add the PWM logic.

[1] can: netlink: preparation before introduction of CAN XL
Link: https://lore.kernel.org/linux-can/20241112165118.586613-7-mailhol.vincent@wanadoo.fr/

[2] can: rework the CAN MTU logic (CAN XL preparation step 2/3)
Link: https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v3-0-581bde113f52@kernel.org/

[3] can: netlink: preparation before introduction of CAN XL step 3/3
Link: https://lore.kernel.org/linux-can/20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org/

---
Changes in v2:

  - Add a new patch #1.

  - In patch #9, add a return statement to can_calc_tdco() when
    CONFIG_CAN_CALC_BITTIMING is not set. This fixes a warning as
    reported by the kernel test robot:

      Link: https://lore.kernel.org/linux-can/202510140553.qo3f0I9s-lkp@intel.com/

    While at it, add an error message.

Link to v1: https://lore.kernel.org/r/20251013-canxl-netlink-v1-0-f422b7e2729f@kernel.org

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
Vincent Mailhol (10):
      can: bittiming: apply NL_SET_ERR_MSG() to can_calc_bittiming()
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
 include/linux/can/bittiming.h        |  81 +++++++-
 include/linux/can/dev.h              |  49 +++--
 include/uapi/linux/can/netlink.h     |  35 ++++
 7 files changed, 599 insertions(+), 42 deletions(-)
---
base-commit: ffee675aceb9f44b0502a8bec912abb0c4f4af62
change-id: 20241229-canxl-netlink-bc640af10673

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


