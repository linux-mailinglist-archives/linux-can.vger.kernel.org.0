Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98A266444A
	for <lists+linux-can@lfdr.de>; Wed, 10 Jul 2019 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfGJJWI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 10 Jul 2019 05:22:08 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43433 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJJWI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 10 Jul 2019 05:22:08 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hl8nd-0004Cd-EG; Wed, 10 Jul 2019 11:22:05 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hl8nc-0001tV-7B; Wed, 10 Jul 2019 11:22:04 +0200
Date:   Wed, 10 Jul 2019 11:22:04 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        robin@protonic.nl, david@protonic.nl
Subject: J1939 Mainlining
Message-ID: <20190710092204.GA25968@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:10:01 up 47 days, 15:12, 191 users,  load average: 0.87, 1.63,
 3.49
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello all,

Finally we think it's time to squash the complete j1939 development
history and apply it as single patch for mainline. Thanks to every for
making, reviewing and testing this stack.

This is a perfect moment to port all your applications and tests to
linux-can-next/j1939[1] and give us feedback. The user space API should
be stable now.

We hope as soon as it is in a proper linux release, more tests and
reviews with different use cases will be done.

Oleksij & Marc

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=j1939

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
