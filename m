Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43DBD323080
	for <lists+linux-can@lfdr.de>; Tue, 23 Feb 2021 19:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhBWSTR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 23 Feb 2021 13:19:17 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:30529 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBWSTQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 23 Feb 2021 13:19:16 -0500
Received: from localhost.localdomain ([153.202.107.157])
        by mwinf5d04 with ME
        id YiHU240033PnFJp03iHYZ8; Tue, 23 Feb 2021 19:17:35 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 Feb 2021 19:17:35 +0100
X-ME-IP: 153.202.107.157
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 0/1] add commandline support for Transmitter Delay Compensation (TDC) in iproute
Date:   Wed, 24 Feb 2021 03:17:13 +0900
Message-Id: <20210223181714.219655-1-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This additional patch adds command line support in userland for below
patch series:
https://lore.kernel.org/linux-can/20210223162852.218041-1-mailhol.vincent@wanadoo.fr/T/#t

For now, only sending the patch to the CAN mailing list.

Yours sincerely,
Vincent Mailhol

Vincent Mailhol (1):
  iplink_can: add new CAN FD bittiming parameters: Transmitter Delay
    Compensation (TDC)

 include/uapi/linux/can/netlink.h |  6 ++++
 ip/iplink_can.c                  | 58 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

-- 
2.26.2

