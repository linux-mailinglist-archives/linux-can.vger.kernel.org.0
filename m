Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C969144501
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2020 20:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAUTWx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 21 Jan 2020 14:22:53 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:46221 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgAUTWx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2020 14:22:53 -0500
X-ASG-Debug-ID: 1579634569-0a88181dcefc2060001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([77.109.89.38]) by relay-b03.edpnet.be with ESMTP id k3StTnbGpvG7gBwT; Tue, 21 Jan 2020 20:22:49 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[77.109.89.38]
X-Barracuda-Apparent-Source-IP: 77.109.89.38
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 98D76C6A9D1;
        Tue, 21 Jan 2020 20:22:49 +0100 (CET)
Date:   Tue, 21 Jan 2020 20:22:48 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        o.rempel@pengutronix.de,
        syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>,
        linux-can@vger.kernel.org
Subject: Re: general protection fault in can_rx_register
Message-ID: <20200121192248.GC13462@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: general protection fault in can_rx_register
Mail-Followup-To: Oliver Hartkopp <socketcan@hartkopp.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>, o.rempel@pengutronix.de,
        syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>,
        linux-can@vger.kernel.org
References: <00000000000030dddb059c562a3f@google.com>
 <55ad363b-1723-28aa-78b1-8aba5565247e@hartkopp.net>
 <20200120091146.GD11138@x1.vandijck-laurijssen.be>
 <CACT4Y+a+GusEA1Gs+z67uWjtwBRp_s7P4Wd_SMmgpCREnDu3kg@mail.gmail.com>
 <8332ec7f-2235-fdf6-9bda-71f789c57b37@hartkopp.net>
 <2a676c0e-20f2-61b5-c72b-f51947bafc7d@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <2a676c0e-20f2-61b5-c72b-f51947bafc7d@hartkopp.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: UNKNOWN[77.109.89.38]
X-Barracuda-Start-Time: 1579634569
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 3800
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9971 1.0000 4.3098
X-Barracuda-Spam-Score: 4.31
X-Barracuda-Spam-Status: No, SCORE=4.31 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79488
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Oliver,

I decreased the CC list a bit, as I'm more like thinking in the wild
now:

Since the problems happens only rarely, and with vxcan, I assume not
vcan, I started to think to locking issues.

1. What surprised me a bit is 'rtnl_dereference()' calls, without
rcu_read_lock() around it? is that supposed to be ok?

2. is it possible to call vxcan_dellink in between the 2
rcu_assign_pointer() calls in vxcan_newlink(), resulting in a dead end,
i.e. one end is referenced, but already deleted?
I'd expect a kind of rcu_write_lock around the cross-linking at least.

It still puzzles me how this bisected to CAN_REQUIRED_SIZE() macro
commit.

Kurt

On ma, 20 jan 2020 23:35:16 +0100, Oliver Hartkopp wrote:
> 
> Answering myself ...
> 
> On 20/01/2020 23.02, Oliver Hartkopp wrote:
> 
> >
> >Added some code to check whether dev->ml_priv is NULL:
> >
> >~/linux$ git diff
> >diff --git a/net/can/af_can.c b/net/can/af_can.c
> >index 128d37a4c2e0..6fb4ae4c359e 100644
> >--- a/net/can/af_can.c
> >+++ b/net/can/af_can.c
> >@@ -463,6 +463,10 @@ int can_rx_register(struct net *net, struct
> >net_device *dev, canid_t can_id,
> >         spin_lock_bh(&net->can.rcvlists_lock);
> >
> >         dev_rcv_lists = can_dev_rcv_lists_find(net, dev);
> >+       if (!dev_rcv_lists) {
> >+               pr_err("dev_rcv_lists == NULL! %p\n", dev);
> >+               goto out_unlock;
> >+       }
> >         rcv_list = can_rcv_list_find(&can_id, &mask, dev_rcv_lists);
> >
> >         rcv->can_id = can_id;
> >@@ -479,6 +483,7 @@ int can_rx_register(struct net *net, struct net_device
> >*dev, canid_t can_id,
> >         rcv_lists_stats->rcv_entries++;
> >         rcv_lists_stats->rcv_entries_max =
> >max(rcv_lists_stats->rcv_entries_max,
> >
> >rcv_lists_stats->rcv_entries);
> >+out_unlock:
> >         spin_unlock_bh(&net->can.rcvlists_lock);
> >
> >         return err;
> >
> >And the output (after some time) is:
> >
> >[  758.505841] netlink: 'crash': attribute type 1 has an invalid length.
> >[  758.508045] bond7148: (slave vxcan1): The slave device specified does
> >not support setting the MAC address
> >[  758.508057] bond7148: (slave vxcan1): Error -22 calling dev_set_mtu
> >[  758.532025] bond10413: (slave vxcan1): The slave device specified does
> >not support setting the MAC address
> >[  758.532043] bond10413: (slave vxcan1): Error -22 calling dev_set_mtu
> >[  758.532254] dev_rcv_lists == NULL! 000000006b9d257f
> >[  758.547392] netlink: 'crash': attribute type 1 has an invalid length.
> >[  758.549310] bond7145: (slave vxcan1): The slave device specified does
> >not support setting the MAC address
> >[  758.549313] bond7145: (slave vxcan1): Error -22 calling dev_set_mtu
> >[  758.550464] netlink: 'crash': attribute type 1 has an invalid length.
> >[  758.552301] bond7146: (slave vxcan1): The slave device specified does
> >not support setting the MAC address
> >
> >So we can see that we get a ml_priv pointer which is NULL which should not
> >be possible due to this:
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/can/dev.c#n743
> 
> This reference doesn't point to the right code as vxcan has its own handling
> do assign ml_priv in vxcan.c .
> 
> >Btw. the variable 'size' is set two times at the top of alloc_candev_mqs()
> >depending on echo_skb_max. This looks wrong.
> 
> No. It looks right as I did not get behind the ALIGN() macro at first sight.
> 
> But it is still open why dev->ml_priv is not set correctly in vxcan.c as all
> the settings for .priv_size and in vxcan_setup look fine.
> 
> Best regards,
> Oliver
