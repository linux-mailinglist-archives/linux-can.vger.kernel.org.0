Return-Path: <linux-can+bounces-4599-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED886B50DA5
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1E75E20F3
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C5304973;
	Wed, 10 Sep 2025 06:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt+bdhVh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17EE3043AE;
	Wed, 10 Sep 2025 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484286; cv=none; b=iz4Je5y5k3koxUtYuqO8TMahWiH0HS3adrBGxA5HSZ/85k/jZrlbJ3hNzz9cg8IkQsxXC2K1zgjRTa16sKjWNdEZ3UXn+KGExXs8IsQVkgzp+mimp7csBXGjweDHc63vFAxnor0oGzMRNpA+D/X5o0j3qj5vF0qBxhAzEF6Bm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484286; c=relaxed/simple;
	bh=N2U7GhDpMZvg4XexOPOt7yPQ+W4562suX0oH7fx9zPM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qaaDYWOQTCGORJgJtGdQA4tR1Zoo14RykkmYkcCtOXUTQDtzlCqkJU0iKHSy8oNxlNdnYDWfJ8IxYVHsszHsVrHY7VyK3Pjxj8VRHdxK+LNtmk9B/+3vvClubrwl/8M5UGMFo8ZMbUXKAFEre+4EbtIechX+TkMktOTaCgtfofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt+bdhVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17269C4CEF0;
	Wed, 10 Sep 2025 06:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484286;
	bh=N2U7GhDpMZvg4XexOPOt7yPQ+W4562suX0oH7fx9zPM=;
	h=From:Subject:Date:To:Cc:From;
	b=Zt+bdhVhNEmbRaUJVCp/D712YxpFf1mndccrTP8fvVuxYjORoxxuy0+YLVIM1WXx0
	 ctGbuTcML7gr2wIuCX0bVkbiqF+7Xb/yb3XePOD1iIuCcYfWDLMqVq6Ivg8G//dwLY
	 v1VeNXnkLZd+/sYTsT63yXuGXhat1IQb9u+48xMGVhDrYkY16o+zxPkADPUIU8ON0h
	 gz+qrXupte8SJooeJ7l4duD43dZVejSKloNmRCPhlP/3K4tOCSRbE/f0tppoO7J4AH
	 s0OoHo1yKte+aYx2AbEEWu1hNivyGq1O9h8Zr2KGiPugps7UiQRmmci/XPgNGAwg80
	 8K8nSIgYnBRkQ==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 00/20] can: netlink: preparation before introduction of
 CAN XL step 2/2
Date: Wed, 10 Sep 2025 15:03:25 +0900
Message-Id: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK0UwWgC/22Oyw6CMBREf4XctdXyUCkr/8OwKPQCN0DBthIM4
 d+tZetyJjlnZgOLhtBCEW1gcCFLk/YhOUVQd1K3yEj5DAlPrjxPY1ZLvQ5MoxtI92w2ODOhqib
 PRN4oocCDvmxoDdJneWSDr7d3u6OESlpk9TSO5IrIu7xvdZdRkoYf0JF1k/mEU0sciLAvePpvf
 4kZZ4Jnlbrx9F4r8ejRaBzOk2mh3Pf9C8S0gjTmAAAA
X-Change-ID: 20250831-canxl-netlink-prep-9dbf8498fd9d
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6311; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=N2U7GhDpMZvg4XexOPOt7yPQ+W4562suX0oH7fx9zPM=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRY48ubmgYFfJaod3HNt/3PjVIr7nRdCZx6sFpqoES
 Cl/ZX1ysaOUhUGMi0FWTJFlWTknt0JHoXfYob+WMHNYmUCGMHBxCsBEjocy/JXeY5nHNltXZnlX
 jPGmpScP/Gv90aWcv/B7zTfGnPj71yoYGRYuXalloy+x2XrPKd7D39Zc6k/k+/IxeK7lcb7m1aV
 ulQwA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

In November last year, I sent an RFC to introduce CAN XL [1]. That
RFC, despite positive feedback, was put on hold due to some unanswered
question concerning the PWM encoding [2].

While stuck, some small preparation work was done in parallel in [3]
by refactoring the struct can_priv and doing some trivial clean-up and
renaming. Initially, [3] received zero feedback but was eventually
merged after splitting it in smaller parts and resending it.

Finally, in July this year, we clarified the remaining mysteries about
PWM calculation, thus unlocking the series. Summer being a bit busy
because of some personal matters brings us to now.

After doing all the refactoring and adding all the CAN XL features,
the final result is roughly 30 patches, probably too much for a single
series. So I am splitting it in two:

  - preparation (this series)
  - CAN XL (will come later, after this series get ACK-ed)

And so, this series continues and finishes the preparation work done
in [3]. It contains all the refactoring needed to smoothly introduce
CAN XL. The goal is to:

  - split the functions in smaller pieces: CAN XL will introduce a
    fair amount of code. And some functions which are already fairly
    long (86 lines for can_validate(), 216 lines for can_changelink())
    would grow to disproportionate sizes if the CAN XL logic were to
    be inlined in those functions.

  - repurpose the existing code to handle both CAN FD and CAN XL: a
    huge part of CAN XL simply reuses the CAN FD logic. All the
    existing CAN FD logic is made more generic to handle both CAN FD
    and XL.

In more details:

  - Patch #1 moves struct data_bittiming_params from dev.h to
    bittiming.h and patch #2 makes can_get_relative_tdco() FD agnostic
    before also moving it to bittiming.h.

  - Patch #3 adds some comments to netlink.h tagging which IFLA
    symbols are FD specific.

  - Patches #4 to #6 are refactoring can_validate() and
    can_validate_bittiming().

  - Patches #7 to #11 are refactoring can_changelink() and
    can_tdc_changelink().

  - Patches #12 and #13 are refactoring can_get_size() and
    can_tdc_get_size().

  - Patches #14 to #17 are refactoring can_fill_info() and
    can_tdc_fill_info().

  - Patch #18 makes can_calc_tdco() FD agnostic.

  - Patch #19 adds can_get_ctrlmode_str() which converts control mode
    flags into strings. This is done in preparation of patch #20.

  - Patch #20 is the final patch and improves the user experience by
    providing detailed error messages whenever invalid parameters are
    provided. All those error messages came into handy when debugging
    the upcoming CAN XL patches.

Aside from the last patch, the other changes do not impact any of the
existing functionalities.

The follow up series which introduces CAN XL is nearly completed but
will be sent only once this one is approved: one thing at a time, I do
not want to overwhelm people (including myself).

[1] https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/
[2] https://lore.kernel.org/linux-can/c4771c16-c578-4a6d-baee-918fe276dbe9@wanadoo.fr/
[3] https://lore.kernel.org/linux-can/20241110155902.72807-16-mailhol.vincent@wanadoo.fr/

To: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Stéphane Grosjean <stephane.grosjean@hms-networks.com>
Cc: Robert Nawrath <mbro1689@gmail.com>
Cc: Minh Le <minh.le.aj@renesas.com>
Cc: Duy Nguyen <duy.nguyen.rh@renesas.com>
Cc: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - Move can_validate()'s comment block to can_validate_databittiming().
    Consequently,

      [PATCH 07/21] can: netlink: remove comment in can_validate()

    from v1 is removed.

  - Change any occurrences of WARN_ON(1) into return -EOPNOTSUPP to
    suppress the three gcc warnings which were reported by the kernel
    test robot:
    Link: https://lore.kernel.org/linux-can/202509050259.NjPdQyAD-lkp@intel.com/
    Link: https://lore.kernel.org/linux-can/202509050404.ZLQknagH-lkp@intel.com/
    Link: https://lore.kernel.org/linux-can/202509050541.1FKRbqOi-lkp@intel.com/

  - Small rewrite of patch #12 "can: netlink: make can_tdc_get_size()
    FD agnostic" description to add more details.

- Link to v1: https://lore.kernel.org/r/20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org

---
Vincent Mailhol (20):
      can: dev: move struct data_bittiming_params to linux/can/bittiming.h
      can: dev: make can_get_relative_tdco() FD agnostic and move it to bittiming.h
      can: netlink: document which symbols are FD specific
      can: netlink: refactor can_validate_bittiming()
      can: netlink: add can_validate_tdc()
      can: netlink: add can_validate_databittiming()
      can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic
      can: netlink: remove useless check in can_tdc_changelink()
      can: netlink: make can_tdc_changelink() FD agnostic
      can: netlink: add can_dtb_changelink()
      can: netlink: add can_ctrlmode_changelink()
      can: netlink: make can_tdc_get_size() FD agnostic
      can: netlink: add can_data_bittiming_get_size()
      can: netlink: add can_bittiming_fill_info()
      can: netlink: add can_bittiming_const_fill_info()
      can: netlink: add can_bitrate_const_fill_info()
      can: netlink: make can_tdc_fill_info() FD agnostic
      can: calc_bittiming: make can_calc_tdco() FD agnostic
      can: dev: add can_get_ctrlmode_str()
      can: netlink: add userland error messages

 drivers/net/can/dev/calc_bittiming.c |  10 +-
 drivers/net/can/dev/dev.c            |  33 ++
 drivers/net/can/dev/netlink.c        | 614 ++++++++++++++++++++++-------------
 include/linux/can/bittiming.h        |  48 ++-
 include/linux/can/dev.h              |  42 +--
 include/uapi/linux/can/netlink.h     |  14 +-
 6 files changed, 478 insertions(+), 283 deletions(-)
---
base-commit: c6142e1913de563ab772f7b0e4ae78d6de9cc5b1
change-id: 20250831-canxl-netlink-prep-9dbf8498fd9d

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


