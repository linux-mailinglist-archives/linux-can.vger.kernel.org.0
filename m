Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6E3A3AC6
	for <lists+linux-can@lfdr.de>; Fri, 11 Jun 2021 06:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhFKEOc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 11 Jun 2021 00:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKEOc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 11 Jun 2021 00:14:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE7AC061574
        for <linux-can@vger.kernel.org>; Thu, 10 Jun 2021 21:12:35 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1lrYX3-0007WV-L0; Fri, 11 Jun 2021 06:12:33 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1lrYX2-00055a-Uc; Fri, 11 Jun 2021 06:12:32 +0200
Date:   Fri, 11 Jun 2021 06:12:32 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     =?utf-8?B?UsOpbXk=?= DZIEMIASZKO <remy.dziemiaszko@smile.fr>
Cc:     linux-can@vger.kernel.org
Subject: Re: How to statically set J1939 addresses and names
Message-ID: <20210611041232.6avft7jhzsqcuuwc@pengutronix.de>
References: <CAEWvZg2rvR=9kE_wcm-KtzMvDtnqTEXSLF56zrB=3TgqZbEs1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEWvZg2rvR=9kE_wcm-KtzMvDtnqTEXSLF56zrB=3TgqZbEs1w@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:04:13 up 190 days, 18:10, 38 users,  load average: 0.09, 0.08,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Rémy,

On Tue, Jun 08, 2021 at 05:27:45PM +0200, Rémy DZIEMIASZKO wrote:
> Hello,
> 
> I need that my applications do not care about J1939 node addresses but
> directly bind / connect to socket based on node name only and the
> kernel takes care of the conversion to addresses.
> 
> I know this is possible if addresses are dynamically assigned through
> the Address Claiming protocol that is implemented in the kernel. The
> kernel keeps track of its own address and name as well as the
> addresses and names of other ECUs on the network and convert name to
> adresse when requested by the applications.
> 
> But I don't want to use the Address Claiming protocol. I want to
> statically set all addresses and names.
> 
> Is there a way to assign J1939 addresses and names to a CAN interface
> without using the J1939 address claim protocol?

Current version do not have this functionality.

> I found in old j1939 kernel documentation something like
> ip addr add dev canX j1939 0xXX
> ip addr add dev canX j1939 name 0xXX
> See https://www.spinics.net/lists/netdev/msg162350.html
> 
> But in the latest j1939 kernel documentation I do not find any
> reference to these commands.

Yes, it was pre mainline version. For mainlining we reduced UAPI to the
minimum to simplify reviewing, mainlining and testing process.

IF you need this option, you are welcome to send patches :)
Or you can contact us or other company to implement it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
