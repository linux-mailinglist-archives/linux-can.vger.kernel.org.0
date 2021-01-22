Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0688E2FFF6C
	for <lists+linux-can@lfdr.de>; Fri, 22 Jan 2021 10:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAVJoM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 22 Jan 2021 04:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbhAVJlO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 22 Jan 2021 04:41:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7055C061788
        for <linux-can@vger.kernel.org>; Fri, 22 Jan 2021 01:40:33 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1l2svf-00044l-9G; Fri, 22 Jan 2021 10:40:31 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1l2sve-0002zw-No; Fri, 22 Jan 2021 10:40:30 +0100
Date:   Fri, 22 Jan 2021 10:40:30 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [5.10 CAN BUG report] kernel dump about echo skb
Message-ID: <20210122094030.dvyzutfy4bw2si6f@pengutronix.de>
References: <DB8PR04MB6795E0155F4523CA9D4AAC1CE6A10@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <DB8PR04MB679559428DCCA341EE53A6E4E6A00@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <CAMZ6RqLuL_BzQisQ0kGEnj7zPTe3iKnsd6n2ivZQ+bPnZW_VhA@mail.gmail.com>
 <20210122092324.fchsd253qnrjxwvr@hardanger.blackshift.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210122092324.fchsd253qnrjxwvr@hardanger.blackshift.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:38:55 up 50 days, 23:45, 29 users,  load average: 0.05, 0.06,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Fri, Jan 22, 2021 at 10:23:24AM +0100, Marc Kleine-Budde wrote:
> On Fri, Jan 22, 2021 at 06:08:18PM +0900, Vincent MAILHOL wrote:
> > > > 1. Kernel dump log:
> > > > [  101.688327] ------------[ cut here ]------------ [  101.692968] refcount_t:
> > > > addition on 0; use-after-free.
> > 
> > The skb already had its refcount at zero when reaching
> > can_put_echo_skb(). It is as if it was already freed/consumed!
> 
> ACK
> 
> > If you remove Oleksij’s patch, can_put_echo_skb() will probably not
> > clone the skb and thus not check the refcount: this means that you
> > will not see the warning, however, it does not necessarily mean that
> > the bug did not occur.
> 
> ACK
> 
> > So far, it seems to me to be another bug which was invisible until
> > now and which Oleksij’s patch just uncovered. But I do not yet fully
> > understand what the root cause could be.
> 
> Or it's the same bug, hitting earlier. Oleksij's backtrace was in the
> TX-complete path and the problem was fixes by cloning the skb in before TX.
> This means the refcount of the original skb was decremented between TX and
> TX-complete. Here the refcount is decremented even before TX.
> 
> Does this make sense?

Is socket was closed just before TX?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
