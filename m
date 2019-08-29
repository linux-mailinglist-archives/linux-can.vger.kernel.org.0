Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB3A1A6C
	for <lists+linux-can@lfdr.de>; Thu, 29 Aug 2019 14:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfH2Msj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 29 Aug 2019 08:48:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40503 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2Msj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Aug 2019 08:48:39 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1i3Jqv-0000ED-O2; Thu, 29 Aug 2019 14:48:37 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1i3Jqv-00016P-Gm; Thu, 29 Aug 2019 14:48:37 +0200
Date:   Thu, 29 Aug 2019 14:48:37 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, kernel@pengutronix.de
Subject: qemu can packet lost
Message-ID: <20190829124837.GA14689@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:34:00 up 24 days, 19:27, 174 users,  load average: 13,92, 11,12,
 6,33
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi all,

Just in case some one has similar problem. Current QEMU with CAN support
is not totally realistic when it comes to sending frames. When the QEMU
is attached to a vcan, then it sends out the CAN frames as fast as it
could. Another QEMU attached to the same vcan tends to drop frames
during reception.

One of the ways to fix it is to send packets from QEMU with proper
packet rate. For example the hw/net/can/can_sja1000.c could delay the TX
complete interrupt based on the configured CAN bit timing and CAN frame
length.

In case some one has time to do it:

This function can be used to calculate the frame length:

  https://github.com/linux-can/can-utils/blob/master/canframelen.c#L239

I think CFL_WORSTCASE is good enough :)

and this example shows how to properly delay and interrupt call in QEMU:

  https://github.com/qemu/qemu/blob/master/hw/net/e1000.c#L270

regards,
Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
