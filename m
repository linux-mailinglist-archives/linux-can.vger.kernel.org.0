Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1FE487D0D
	for <lists+linux-can@lfdr.de>; Fri,  7 Jan 2022 20:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiAGTbL (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 7 Jan 2022 14:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbiAGTbL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 7 Jan 2022 14:31:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0226C061574
        for <linux-can@vger.kernel.org>; Fri,  7 Jan 2022 11:31:10 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n5uxB-0004K2-Eg
        for linux-can@vger.kernel.org; Fri, 07 Jan 2022 20:31:09 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id CA48F6D33C5
        for <linux-can@vger.kernel.org>; Fri,  7 Jan 2022 19:31:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id 172276D33BA;
        Fri,  7 Jan 2022 19:31:07 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 614a271e;
        Fri, 7 Jan 2022 19:31:06 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [PATCH v2 1/7] can: flexcan: change RX-FIFO feature at runtime
Date:   Fri,  7 Jan 2022 20:30:58 +0100
Message-Id: <20220107193105.1699523-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

Here's the v2 of Dario's and my patches to switch of RTR reception to
make use of bigger RX buffer:

Show available private flags:

| $ sudo ethtool --show-priv-flags can0
| Private flags for can0:
| rx-rtr: on

Change private flag:

| $ sudo ethtool --set-priv-flags can0 rx-rtr off
| netlink error: Device or resource busy

...does not work if interface is up.

Shut down interface and change "rx-rtr":

| $ sudo ip link set dev can0 down
| $ sudo ethtool --set-priv-flags can0 rx-rtr off
| $ sudo ethtool --show-priv-flags can0
| Private flags for can0:
| rx-rtr: off

regards,
Marc

Changes since v2:
- add missing variable initialization, tnx Dario
- renamed flag rx-fifo -> rx-rtr
- renamed existing quirks
- added more quirks to describe controller
- added Dario's documentation patches

Changes since RFC:
- move driver into subdir
- replaced memcpy() by direct assignment, do this earlier
- use priv->devtype_data.quirks where possible
- rename flexcan_main.c -> flexcan-core.c
  (mcp251xfd and tcan4x5x driver have the same naming scheme)
- use copyright notice from flexcan.c in flexcan.h
- add private flag support to set rx-fifo
- remove drvinfo, the kernel will fall back to the default implementation




