Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC9F1279A5
	for <lists+linux-can@lfdr.de>; Fri, 20 Dec 2019 11:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfLTKuk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Fri, 20 Dec 2019 05:50:40 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43683 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfLTKuk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 20 Dec 2019 05:50:40 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iiFri-0007Bu-SQ; Fri, 20 Dec 2019 11:50:38 +0100
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1iiFre-0008KM-Uv; Fri, 20 Dec 2019 11:50:34 +0100
Date:   Fri, 20 Dec 2019 11:50:34 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Michael Frampton <Michael.Frampton@infact.co.nz>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Subject: Re: Backporting J1939 and mcp25xxfd
Message-ID: <20191220105034.c3eblysltpgcvqu2@pengutronix.de>
References: <SYXPR01MB12301FF2AEF360FD9F013AA1A12D0@SYXPR01MB1230.ausprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <SYXPR01MB12301FF2AEF360FD9F013AA1A12D0@SYXPR01MB1230.ausprd01.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:35:36 up 35 days,  1:54, 36 users,  load average: 0.27, 0.13,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michael,

On Fri, Dec 20, 2019 at 02:16:36AM +0000, Michael Frampton wrote:
> Hi,
> 
> I'm interested in porting the J1939 code and MCP2517 driver to an
> older kernel. I'm planning on using the Qualcomm 4.14 kernel.
> 
> Is it possible that working versions of this code has already been
> backported to an earlier kernel release, which I could then merge into
> 4.14?

As far as I know - no.

> I saw that Romain Forlot has asked a similar question here a
> couple of months ago
> https://www.spinics.net/lists/linux-can/msg02539.html but the thread
> was abandoned.

It needs more time then we actually expected. It will be great if you
can spend time on it. If you will be able to get a working patch set, we
can publish it here as a topic branch. In this case you will get more
testers and fixes.

> Oleksij Rempel mentioned that there is potentially and
> issue with Rx/Tx frame ordering, is this still the case?

Yes. Needed CAN patches should be backported as well.

> Thanks very much.  --Mike

You are welcome!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
