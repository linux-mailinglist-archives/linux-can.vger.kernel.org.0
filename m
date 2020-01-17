Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA32C1409B1
	for <lists+linux-can@lfdr.de>; Fri, 17 Jan 2020 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgAQM0W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jan 2020 07:26:22 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59135 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgAQM0V (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2020 07:26:21 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1isQhg-0003K3-GN; Fri, 17 Jan 2020 13:26:20 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1isQhg-0004Ek-6l; Fri, 17 Jan 2020 13:26:20 +0100
Date:   Fri, 17 Jan 2020 13:26:20 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     syzbot <syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com>
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in j1939_xtp_rx_abort_one
Message-ID: <20200117122620.GC11961@pengutronix.de>
References: <0000000000005ed7710596937e86@google.com>
 <000000000000a0ef18059c082789@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000a0ef18059c082789@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:25:42 up 128 days,  1:13, 352 users,  load average: 10,18,
 10,27, 14,06
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Mon, Jan 13, 2020 at 08:42:02AM -0800, syzbot wrote:
> syzbot suspects this bug was fixed by commit:
> 
> commit ddeeb7d4822ed06d79fc15e822b70dce3fa77e39
> Author: Oleksij Rempel <o.rempel@pengutronix.de>
> Date:   Sat Nov 9 15:11:18 2019 +0000
> 
>     can: j1939: j1939_can_recv(): add priv refcounting
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a7ec76e00000
> start commit:   de620fb9 Merge branch 'for-5.4-fixes' of git://git.kernel...
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f9ff8f11e66c1fb1
> dashboard link: https://syzkaller.appspot.com/bug?extid=db4869ba599c0de9b13e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113e0d72e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136aa6e8e00000
> 
> If the result looks correct, please mark the bug fixed by replying with:

#syz fix: can: j1939: j1939_can_recv(): add priv refcounting

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
