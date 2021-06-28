Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00EE3B65FB
	for <lists+linux-can@lfdr.de>; Mon, 28 Jun 2021 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhF1Pqx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 28 Jun 2021 11:46:53 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:60411 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbhF1PqZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 28 Jun 2021 11:46:25 -0400
Received: from tomoyo.flets-east.jp ([114.149.34.46])
        by mwinf5d35 with ME
        id Nfjq2501T0zjR6y03fjxdN; Mon, 28 Jun 2021 17:43:59 +0200
X-ME-Helo: tomoyo.flets-east.jp
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 28 Jun 2021 17:43:59 +0200
X-ME-IP: 114.149.34.46
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     =?UTF-8?q?Stefan=20M=C3=A4tje?= <Stefan.Maetje@esd.eu>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH v4 0/4] iplink_can: cleaning, fixes and adding TDC support.
Date:   Tue, 29 Jun 2021 00:43:58 +0900
Message-Id: <20210628154402.1176099-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The main purpose is to add commandline support for Transmitter Delay
Compensation (TDC) in iproute. Other issues found during the
development of this feature also get addressed.

This patch series contains four patches which respectively:
  1. Correct the bittiming ranges in the print_usage function.
  2. factorize the many print_*(PRINT_JSON, ...) and fprintf
  occurrences in a single print_*(PRINT_ANY, ...) call and fix the
  signedness while doing that.
  3. report the value of the bitrate prescalers (brp and dbrp).
  4. adds command line support for the TDC in iproute and goes together
  with below series in the kernel:
  https://lore.kernel.org/linux-can/20210628150607.1128574-1-mailhol.vincent@wanadoo.fr/T/#t

I am sending this series as RFC because the related patch series on
the kernel side have yet to be approved. Aside of that, I consider
this series to be ready. If the can:netlink patch series get accepted,
I will resend this one as is (just remove the RFC tag).

** Changelog **

From v3 to RFC v4:
  * Reflect the changes made on the kernel side.

From RFC v2 to v3:
  * Dropped the RFC tag. Now that the kernel patch reach the testing
    branch, I am finaly ready.
  * Regression fix: configuring a link with only nominal bittiming
    returned -EOPNOTSUPP
  * Added two more patches to the series:
      - iplink_can: fix configuration ranges in print_usage()
      - iplink_can: print brp and dbrp bittiming variables
  * Other small fixes on formatting.

From RFC v1 to RFC v2:
  * Add an additional patch to the series to fix the issues reported
    by Stephen Hemminger
    Ref: https://lore.kernel.org/linux-can/20210506112007.1666738-1-mailhol.vincent@wanadoo.fr/T/#t

Vincent Mailhol (4):
  iplink_can: fix configuration ranges in print_usage()
  iplink_can: use PRINT_ANY to factorize code and fix signedness
  iplink_can: print brp and dbrp bittiming variables
  iplink_can: add new CAN FD bittiming parameters: Transmitter Delay
    Compensation (TDC)

 include/uapi/linux/can/netlink.h |  30 +-
 ip/iplink_can.c                  | 464 +++++++++++++++++--------------
 2 files changed, 286 insertions(+), 208 deletions(-)

-- 
2.31.1

