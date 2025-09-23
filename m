Return-Path: <linux-can+bounces-4861-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D3B94A1F
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 08:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640EB166112
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 06:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3213019D0;
	Tue, 23 Sep 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqjfiWXK"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC225DB0A;
	Tue, 23 Sep 2025 06:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610786; cv=none; b=Tjfd/MHsNW4+ojZBh7oonp3eLO9poOGFGq9I28s8oDZHWH3eC0cq3+D3iI3lYpgm2HmzjlUI40BayEAfJTUakce+Ua+iP317yvh8wKUx0I2W9jWl6BMd22DBnpl1SAj8/nZ/gZ8GFPExzt7gSijLUBFqKTqJKFioRKAzwwgWCoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610786; c=relaxed/simple;
	bh=XB6dPU87BTaizLtISo9PWsboSETPlt97MmgwKBuUi0I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O4Bmtp49i9m5h7pBeoE9EVYX5llMkbIQcCaSdAU9IAu3SxrCLPbmueRpbAInHHA9VVmCe7J45brR5A6rwTTKBE4CSVoatf2O5MIDe4lPDT6UW0kaIUj+jv4D2wUueBCGDCE07PE33qBYh5rAg0KNuJyCmjdd7UKeLTBHo8qrvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqjfiWXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E825C4CEF5;
	Tue, 23 Sep 2025 06:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610785;
	bh=XB6dPU87BTaizLtISo9PWsboSETPlt97MmgwKBuUi0I=;
	h=From:Subject:Date:To:Cc:From;
	b=iqjfiWXK4TZyt9a3IFcppPgWI90mpqkl7BYX/NWDHjyoGUrZCu3YYkz9B3ou7slQ2
	 tmQ8vwe8ZomQnrE2YOMucF3N2990cSl8889W5ongxCmuiqs7GHrcIAZZ/+WuEnLC8e
	 iuHmuD3mSxohD2jJRQ/kO7YQBmaqIdPr5ezhVkGf7oTkREX86WYMTPQs+IM0ipg6TI
	 JoTHZwypgQwJ9Jd9YTh18e3oRdy/kF4KTlrU6Wt4YSanwyCDGBZZnwNnSIWGt457rs
	 Az3SvNrYvNNt9bM2lFh1L/zPmMnPc5s0ONPs2HGjOX0nBhseWkN5fhO4N1ZTOlMmL3
	 E0Ptk885bcT/A==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v4 00/20] can: netlink: preparation before introduction of
 CAN XL step 3/3
Date: Tue, 23 Sep 2025 15:58:25 +0900
Message-Id: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABFF0mgC/23QTW6DMBAF4Ksgrzut/wCbVe8RZWGwSayASY2Dq
 CLu3gEWTVWWb6T53thPMrro3Uiq7Emim/zoh4BBvmWkuZpwceAtZsIpz6kSDBoT5g6CS50PN7h
 Hdwdt61ZJrVqrLcFFHLZ+3tDTec/RfT3QTvvwl66yDdYsX2HANejTA2hOjZZ1XghDq0msaG1GB
 83Q9z5VGdbjCXP66I0PZO24+jEN8Xt7x8S2kl2m4ujkiQEFTWVtCyrKxurPm4vBde9DvGzexF8
 MRg8NjkbLuLISf6bk7J8hXgx+fIdAQ5WmLJQUQrTij7Esyw9eUPqkoQEAAA==
X-Change-ID: 20250831-canxl-netlink-prep-9dbf8498fd9d
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7588; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=XB6dPU87BTaizLtISo9PWsboSETPlt97MmgwKBuUi0I=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXBV7+yS2vef7dV986v41OgZFsUUnp8/8F/mIaR33s
 /w34VUrO0pZGMS4GGTFFFmWlXNyK3QUeocd+msJM4eVCWQIAxenAExkXicjw9E3p//8PXyvsnwn
 S+Kfg9cV5TO3yDR+vKA93dy+5YaL/2WG/64bpohP6Ylysn7g6iArLeuus+q3zG1ux2Kf55USDLN
 ZOQA=
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
the final result is more than 30 patches, definitively too much for a
single series. So I am splitting the remaining changes three:

  - can: rework the CAN MTU logic [4]
  - can: netlink: preparation before introduction of CAN XL (this series)
  - CAN XL (will come right after the two preparation series get merged)

And thus, this series continues and finishes the preparation work done
in [3] and [4]. It contains all the refactoring needed to smoothly
introduce CAN XL. The goal is to:

  - split the functions in smaller pieces: CAN XL will introduce a
    fair amount of code. And some functions which are already fairly
    long (86 lines for can_validate(), 215 lines for can_changelink())
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
[4] https://lore.kernel.org/linux-can/20250923-can-fix-mtu-v2-0-984f9868db69@kernel.org/

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
Changes in v4:

  - v3 was based on Linus tree and, despite

      b4 prep --check-deps

    giving no warnings, did not apply soomthly to net-next. Rebase on
    net-next.

Link to v3: https://lore.kernel.org/r/20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org

Changes in v3:

  - Rebase on top of the "can: rework the CAN MTU logic" series.

  - Add a static_assert() in can_validate_databittiming() to prove
    that the nla attributes were already correctly aligned.

  - Replace the ! operator by ~ to fix a bug in patch #7:
    "can: netlink: refactor CAN_CTRLMODE_TDC_{AUTO,MANUAL} flag reset logic".

Link to v2: https://lore.kernel.org/r/20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org

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

Link to v1: https://lore.kernel.org/r/20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org

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
 drivers/net/can/dev/netlink.c        | 627 ++++++++++++++++++++++-------------
 include/linux/can/bittiming.h        |  48 ++-
 include/linux/can/dev.h              |  42 +--
 include/uapi/linux/can/netlink.h     |  14 +-
 6 files changed, 485 insertions(+), 289 deletions(-)
---
base-commit: 9b277fca90c39c8b749e659bf5c23e924c46c93b
change-id: 20250831-canxl-netlink-prep-9dbf8498fd9d
prerequisite-change-id: 20250915-can-fix-mtu-050a94b563a0:v3
prerequisite-patch-id: 64b7803b5453bdd2ada5f2918901ad092e4ea1cf
prerequisite-patch-id: 6aecc3f1db1cd342e3b204310464179ca66b52ba
prerequisite-patch-id: 10e3a79796f2966733349c4cfcc1a61a49bc20af
prerequisite-patch-id: 5ddc3c20a99f60bddb62d58eb192facf0eb25b75

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


