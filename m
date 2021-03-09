Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D543327EF
	for <lists+linux-can@lfdr.de>; Tue,  9 Mar 2021 14:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhCIN6b (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 9 Mar 2021 08:58:31 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:28288 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhCIN6I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 9 Mar 2021 08:58:08 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d12 with ME
        id eDxt240033PnFJp03Dy0P4; Tue, 09 Mar 2021 14:58:02 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 09 Mar 2021 14:58:02 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v3 0/2] Introducing new CAN FD bittiming parameters: Transmission Delay Compensation (TDC)
Date:   Tue,  9 Mar 2021 22:57:46 +0900
Message-Id: <20210309135748.29258-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

A set of two incremental patches to be applied to the v2.
Both patches are fully cosmetics.

Those two patches are to be squashed in linux-can-next/testing. Each
patch contains detailed instruction after the "---" scissors.

Changes from v2:
  - Reorder the IFLA_CAN_TDC* entries in can_policy structure
  - Increase readability of the TDCO formula by introducing a
    temporary variable.

Changes from v1:
  - Changed the commit message of the first patch of the serie to
    clarify the condition of when TDC is active.
  - Changed the alignment style from tabulations to single space in
    drivers/net/can/dev/netlink.c
  - Remove duplicated [IFLA_CAN_TERMINATION] entry in
    drivers/net/can/dev/netlink.c

Changes from the RFC:
  - The RFC was a single e-mail with all comments in bulk, made this a
    proper patch series.
  - Added the netlink interface.
  - Rename the function can_set_tdc to can_calc_tdco (the formula is
    the same, everything around it was reworked).
  - Other small miscellaneous changes.

Vincent Mailhol (2):
  can: netlink: reorder IFLA_CAN_TDC* entries in can_policy structure
  can: bittiming: add temporary variable to increase readability

 drivers/net/can/dev/bittiming.c | 5 +++--
 drivers/net/can/dev/netlink.c   | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)


base-commit: c2cd2b376005b82a251af20900fa2c67cb001d7f
prerequisite-patch-id: c628b2ba1459ffd73489ff50639ba5a051a99263
prerequisite-patch-id: 0ce44c0600bff103810eb09cdcd42285c85d365c
prerequisite-patch-id: d5ae23ff6cf14d07ea646d33f9f0ecf3a6f9e7e1
prerequisite-patch-id: 38fd449c0a0bc7c8346f25567e974edbd5243606
prerequisite-patch-id: f40a6871ffc879f75586ba04b3056ec0b5d8590a
prerequisite-patch-id: f3244bc526a5131c9b6b689dfc1b758126a0a99f
prerequisite-patch-id: 9a1a7334fd4c337d7fc9af5c89db128a54ec9c8d
prerequisite-patch-id: a2a2a06a29ac02e4796bf8bb8bebe04aa968113e
prerequisite-patch-id: 3381611eb10fd16725435b7dcce288c16d2fcb28
prerequisite-patch-id: f01462cc6867bb197ea80f3c6a14f0c28828550d
prerequisite-patch-id: fbcf50987c0bf12599657af5ea4b8f1b72cd4dae
prerequisite-patch-id: 27f813c54fcb64781e729f30beba394cb6324101
prerequisite-patch-id: f9996d1fb2545c8b0ee39afd2db6dca0b659e811
prerequisite-patch-id: 03759de4308f541a3cd3c9eb89c4ac1bcd6c36a0
prerequisite-patch-id: 91dfc83cc1eab008eef5658a638a970be13a6d4d
prerequisite-patch-id: 6f8fc8b8d9f794bc3e039a15d5d0f752c7044f65
prerequisite-patch-id: 607cb1c602ec6ce3f36ed573e6a4c23471da934d
prerequisite-patch-id: a5060baf10c13d07812b04a059dcd0108c144dd2
prerequisite-patch-id: 946baf14dd974293570f1f2e2c8aa81780b0b22e
prerequisite-patch-id: d2db79eff80fb8aa8728a1df5adf292bdc988953
prerequisite-patch-id: cd7663a0f2c16b829eb5116d4353a20867b32c4e
prerequisite-patch-id: 99606eec325782fb50338ca09a8c08ad79832e36
prerequisite-patch-id: 09e03c5f5daf820f5337bb9340071c41f60ea6fb
prerequisite-patch-id: 5f004d320a3121d2b999b6b3088671f670370d59
prerequisite-patch-id: ceb46ad3d3d00b333ebae335762ff4f01601adb5
prerequisite-patch-id: 94e90c8ddb8696e3cc469388e27a3c142fe07b23
-- 
2.26.2

