Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53E7148E32
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2020 20:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbgAXTFS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 24 Jan 2020 14:05:18 -0500
Received: from relay-b02.edpnet.be ([212.71.1.222]:44541 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbgAXTFS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 24 Jan 2020 14:05:18 -0500
X-ASG-Debug-ID: 1579892713-0a7b8d335e5b540001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be ([77.109.89.38]) by relay-b02.edpnet.be with ESMTP id MXiSHqDrEuXMng5v; Fri, 24 Jan 2020 20:05:13 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: UNKNOWN[77.109.89.38]
X-Barracuda-Apparent-Source-IP: 77.109.89.38
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 70C52C7700B;
        Fri, 24 Jan 2020 20:05:13 +0100 (CET)
Date:   Fri, 24 Jan 2020 20:05:12 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        o.rempel@pengutronix.de,
        syzbot <syzbot+c3ea30e1e2485573f953@syzkaller.appspotmail.com>,
        linux-can@vger.kernel.org
Subject: Re: general protection fault in can_rx_register
Message-ID: <20200124190512.GB14622@x1.vandijck-laurijssen.be>
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
 <20200121192248.GC13462@x1.vandijck-laurijssen.be>
 <9a6be054-ac52-761d-83f0-809ec80e7764@hartkopp.net>
 <20200121203954.GG13462@x1.vandijck-laurijssen.be>
 <afa442db-d893-25b5-c580-b29323c8816c@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afa442db-d893-25b5-c580-b29323c8816c@hartkopp.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: UNKNOWN[77.109.89.38]
X-Barracuda-Start-Time: 1579892713
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1878
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3430
X-Barracuda-Spam-Score: 4.34
X-Barracuda-Spam-Status: No, SCORE=4.34 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79531
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On vr, 24 jan 2020 19:43:23 +0100, Oliver Hartkopp wrote:
> Hi Kurt, Dmitry,
> 
> On 21/01/2020 21.39, Kurt Van Dijck wrote:
> 
> >Maybe move the crosslinking to before the register, then they're
> >inaccessible from userspace.
> 
> I think I found the problem:

Well done!

> 
> [ 1814.648904] bond5128: (slave vxcan1): Error -22 calling dev_set_mtu
> [ 1814.649124] dev_rcv_lists == NULL! 000000008e41fb06 (bond5128)
> 
> The bonding netdev bond5128 enslaved the vxcan1 netdev. As vxcan1 is a CAN
> netdev with ARPHRD_CAN the bonding process executes
> 

You were able to make the syscalls comprehensible then?

> if (slave_dev->type != ARPHRD_ETHER)
> 	bond_setup_by_slave(bond_dev, slave_dev);
> 
> in bond_enslave() in .../bonding/bond_main.c
> 
> Which does this:
> 
> static void bond_setup_by_slave(struct net_device *bond_dev,
>                                 struct net_device *slave_dev)
> {
>         bond_dev->header_ops        = slave_dev->header_ops;
> 
>         bond_dev->type              = slave_dev->type;
>         bond_dev->hard_header_len   = slave_dev->hard_header_len;
>         bond_dev->addr_len          = slave_dev->addr_len;
> 
>         memcpy(bond_dev->broadcast, slave_dev->broadcast,
>                 slave_dev->addr_len);
> }
> 
> So bond5128 becomes an ARPHDR_CAN interface BUT without having a
> netdev_priv() space which contains our lovely can_ml_priv structure with the
> dev_rcv_lists for the CAN filters.
> 
> I was able to confirm the bisected commit but the crashes still were pure
> luck IMO.
> 
> can_rx_register() accesses netdev_priv() of the bonding device - but there
> are no CAN filters. BAM!
> 
> So we need to make sure that ARPHDR_CAN dev->type can not be enslaved by the
> bonding driver.

This implies modifying bond_main.c, right?
> 
> Best regards,
> Oliver
