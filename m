Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793683234E7
	for <lists+linux-can@lfdr.de>; Wed, 24 Feb 2021 02:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhBXBHS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 20:07:18 -0500
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:58409 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhBXAWz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 19:22:55 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d12 with ME
        id YoLV2400J3PnFJp03oLaNP; Wed, 24 Feb 2021 01:20:37 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Feb 2021 01:20:37 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 0/5] Introducing new CAN FD bittiming parameters: Transmission Delay Compensation (TDC)
Date:   Wed, 24 Feb 2021 09:20:03 +0900
Message-Id: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

At high bit rates, the propagation delay from the TX pin to the RX pin
of the transceiver causes measurement errors and needs to be
corrected.

To solve this issue, ISO 11898-1 introduces in section 11.3.3
"Transmitter delay compensation" (here after TDC) a SSP (Secondary
Sample Point) equal to the distance, in time quanta, from the start of
the bit time on the TX pin to the actual measurement on the RX pin.

This patch series implements the TDC parameters which allow the
controller to calculate that SSP.

The first patch introduces the new structures, the second one saves
eight bytes on struct can_priv, the third fixes some existing
checkpatch warnings in preparation on the next one, the fourth one
implements the netlink interface and, finally, the fifth one adds the
calculation.

This is a follow-up on the RFC is sent already more than one month
ago.

Ref: https://lore.kernel.org/linux-can/CAMZ6RqLtg1ynVeePLLriUw0+KLbTpPJHapTEanv1_EZYJSrK=g@mail.gmail.com/T/#u

You might also be interested in below patch which implement those
changes in iproute command line:
https://lore.kernel.org/linux-can/20210223181714.219655-1-mailhol.vincent@wanadoo.fr/T/#t
Because this v2 introduced no changes on the netlink interface, the
iproute patch will *not* be resend.

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

TODO: the documentation will be updated after the netlink interface
gets approved.


Yours sincerely,
Vincent

Vincent Mailhol (5):
  can: add new CAN FD bittiming parameters: Transmitter Delay
    Compensation (TDC)
  can: dev: reorder struct can_priv members for better packing
  can: netlink: move '=' operators back to previous line (checkpatch
    fix)
  can: add netlink interface for CAN-FD Transmitter Delay Compensation
    (TDC)
  can: bittiming: add calculation for CAN FD Transmitter Delay
    Compensation (TDC)

 drivers/net/can/dev/bittiming.c  |  23 +++++++
 drivers/net/can/dev/netlink.c    | 100 ++++++++++++++++++++++++++-----
 include/linux/can/bittiming.h    |  71 ++++++++++++++++++++++
 include/linux/can/dev.h          |  14 +++--
 include/uapi/linux/can/netlink.h |   6 ++
 5 files changed, 194 insertions(+), 20 deletions(-)


base-commit: 1b34628ac60360ef7455c00f01dc62f82ed08d8c
-- 
2.26.2

