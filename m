Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D76830BA0D
	for <lists+linux-can@lfdr.de>; Tue,  2 Feb 2021 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhBBIgv (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 2 Feb 2021 03:36:51 -0500
Received: from relay-b01.edpnet.be ([212.71.1.221]:34316 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhBBIgs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 2 Feb 2021 03:36:48 -0500
X-Greylist: delayed 729 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Feb 2021 03:36:46 EST
X-ASG-Debug-ID: 1612254234-15c4347fa25ec350001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.126.125.adsl.dyn.edpnet.net [77.109.126.125]) by relay-b01.edpnet.be with ESMTP id MABNyBCTBzxzn7Oh; Tue, 02 Feb 2021 09:23:54 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.126.125.adsl.dyn.edpnet.net[77.109.126.125]
X-Barracuda-Apparent-Source-IP: 77.109.126.125
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id D63A0123BD9C;
        Tue,  2 Feb 2021 09:23:53 +0100 (CET)
Date:   Tue, 2 Feb 2021 09:23:40 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <extja@kvaser.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [Question] Sending CAN error frames
Message-ID: <20210202082340.GA23043@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [Question] Sending CAN error frames
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <extja@kvaser.com>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can <linux-can@vger.kernel.org>
References: <CAMZ6RqK0rTNg3u3mBpZOoY51jLZ-et-J01tY6-+mWsM4meVw-A@mail.gmail.com>
 <87e3dd54-50ab-1190-efdb-18ddb3b21a02@hartkopp.net>
 <42080d05-7ab3-99be-92e2-73ed262350ba@gmail.com>
 <CAMZ6RqJWrObGZRwyA1kD5cEZRUd_-4zt8rsMR+zZPLpxD6AWAQ@mail.gmail.com>
 <1debcaeb-71c7-6b78-88b3-7f121a33c1c1@kvaser.com>
 <CAMZ6Rq+ObkS2RDFbgbPP7HZH26WbN-eoLeQyiY6+CpDGYjE10w@mail.gmail.com>
 <17b14b11-87bf-9508-0da5-1031c5d5e132@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17b14b11-87bf-9508-0da5-1031c5d5e132@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.126.125.adsl.dyn.edpnet.net[77.109.126.125]
X-Barracuda-Start-Time: 1612254234
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1992
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.87688
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 02 Feb 2021 08:35:14 +0100, Marc Kleine-Budde wrote:
> On 2/2/21 1:22 AM, Vincent MAILHOL wrote:
> [...]
> 
> >> Right, it would be nice to sort this out. I prefer to keep the
> >> functionality, since we got customers using it.
> > 
> > Basically, I would see this as an expert function: add a
> > CAN_CTRLMODE_TX_ERR and have the user explicitly enable the
> > feature through netlink when configuring the interface. The
> > rationale is to prevent by default an unprivileged application
> > from messing with the bus.
> 
> The CAN_CTRLMODE_TX_ERR would be a per device option. Another option might be a
> sockopt, where you have to enable the TX_ERR explicitly. I'm not sure, which
> option is the best here.

a sockopt is only correct if it can detect that the device underneath
has CAN_CTRLMODE_TX_ERR capability.

So I'd think we start with adding the CAN_CTRLMODE_TX_ERR to the driver level.

It would allow to see if a driver will behave properly with CAN_ERR_FLAG
can_frames in the tx path.

> 
> > If CAN_CTRLMODE_TX_ERR is on the device generates an error
> > flag. Else, the CAN_ERR_FLAG is simply ignored (masked out).
> > The CAN ID, DLC and payload of the TX error frames are
> > ignored (i.e. reserved for future).

IMO, can_frames in the tx path with CAN_ERR_FLAG should be dropped
if the driver can't handle them. vcan in this regard is capable of
handling those, as does the kvaser usb.

I think it's wrong that CAN_ERR_FLAG messages would appear as regular
frame on CAN, as happens today if I understood well.

> > 
> > I do not see the need for more complex logic at the moment
> > because your device is only capable of generating one type of
> > error flags: the active error. If one day a device has the
> > ability to generate both the active and passive error flags, we
> > should then define how to send those (maybe by putting a flag in
> > the payload, similar to what is done on the RX path).

ack.

Kurt
