Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EA92B8DF8
	for <lists+linux-can@lfdr.de>; Thu, 19 Nov 2020 09:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKSIw5 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 19 Nov 2020 03:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgKSIw5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 19 Nov 2020 03:52:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79870C0613CF
        for <linux-can@vger.kernel.org>; Thu, 19 Nov 2020 00:52:57 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kffgV-0004Tk-Te; Thu, 19 Nov 2020 09:52:56 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, kernel@pengutronix.de
Subject: [net-next PATCH 0/5] flexcan: fix hanging flexcan_close()
Date:   Thu, 19 Nov 2020 09:52:46 +0100
Message-Id: <20201119085251.2949181-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.29.2
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

There haven been reports, that the flexcan_close() soradically hangs during
simultanious ifdown, sending of CAN messages and probably open CAN bus:

| (__schedule) from [<808bbd34>] (schedule+0x90/0xb8)
| (schedule) from [<808bf274>] (schedule_timeout+0x1f8/0x24c)
| (schedule_timeout) from [<8016be44>] (msleep+0x18/0x1c)
| (msleep) from [<80746a64>] (napi_disable+0x60/0x70)
| (napi_disable) from [<8052fdd0>] (flexcan_close+0x2c/0x140)
| (flexcan_close) from [<80744930>] (__dev_close_many+0xb8/0xd8)
| (__dev_close_many) from [<8074db9c>] (__dev_change_flags+0xd0/0x1a0)
| (__dev_change_flags) from [<8074dc84>] (dev_change_flags+0x18/0x48)
| (dev_change_flags) from [<80760c24>] (do_setlink+0x44c/0x7b4)
| (do_setlink) from [<80761560>] (rtnl_newlink+0x374/0x68c)

I was unable to reproduce the issue, but a cleanup of the flexcan close
sequence has probably fixed the problem at the reporting user.

As this fix spans 5 patches and changes the flexcan_open() and flexcan_close()
are rather big, I'm reluctant to push this via net/master now. So I think this
series should go via net-next/master in my next pull request.

regards,
Marc


