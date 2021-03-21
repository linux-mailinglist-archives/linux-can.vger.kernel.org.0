Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF433431A1
	for <lists+linux-can@lfdr.de>; Sun, 21 Mar 2021 08:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhCUHd6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 21 Mar 2021 03:33:58 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:20198 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhCUHdw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 21 Mar 2021 03:33:52 -0400
Received: from tomoyo.flets-east.jp ([153.202.107.157])
        by mwinf5d13 with ME
        id ivZc240053PnFJp03vZlav; Sun, 21 Mar 2021 08:33:46 +0100
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Mar 2021 08:33:46 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v4 0/1]  Introducing new CAN FD bittiming parameters: Transmission Delay Compensation (TDC)
Date:   Sun, 21 Mar 2021 16:33:28 +0900
Message-Id: <20210321073329.1454-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

I made a silly mistake which cause the automatic tdco calculation not
to work and failed to catch it during my testing (I probably was to
focussed to test the netlink interface, and forget to test the most
obvious use case...)

One incremental patch to be applied on the v3.  The patch contains
detailed instruction after the "---" scissors.

Changes from v3:
  - do tdco calculation after data bittiming is copied to can_priv.

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

Vincent Mailhol (1):
  can: netlink: do tdco calculation after data bittiming is copied to
    can_priv

 drivers/net/can/dev/netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.26.2

