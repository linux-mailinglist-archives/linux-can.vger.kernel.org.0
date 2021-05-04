Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3860E3728D5
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhEDK1J (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 May 2021 06:27:09 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:48776 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhEDK1I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 06:27:08 -0400
X-Greylist: delayed 1103 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2021 06:27:08 EDT
X-ASG-Debug-ID: 1620122867-15c4341e04e09570001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.122.62.dyn.edpnet.net [94.105.122.62]) by relay-b01.edpnet.be with ESMTP id oA7MuNEIT9i5T4HU; Tue, 04 May 2021 12:07:47 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.122.62.dyn.edpnet.net[94.105.122.62]
X-Barracuda-Apparent-Source-IP: 94.105.122.62
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 7010613B598D;
        Tue,  4 May 2021 12:07:47 +0200 (CEST)
Date:   Tue, 4 May 2021 12:07:46 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>, kayoub5@live.com
Subject: Re: More flags for logging
Message-ID: <20210504100746.GB27660@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: More flags for logging
Mail-Followup-To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>, kayoub5@live.com
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
 <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.122.62.dyn.edpnet.net[94.105.122.62]
X-Barracuda-Start-Time: 1620122867
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1057
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.89703
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 04 May 2021 00:02:49 +0900, Vincent MAILHOL wrote:
> On Mon. 3 Mai 2021 at 19:08, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > On 03.05.2021 12:02:46, Marc Kleine-Budde wrote:
> > > ACK bit in data frame
> > > - Some logging hardware can act as a "spy", meaning that it records CAN
> > >   Frames, but does not set the ACK bit
> > > - A way to know for a given frame (FD or not), was the ACK bit set or
> > >   not.
> > > - Current API allow detecting missing ACK, but it does not report what
> > >   Frame had a missing ACK.
> >
> > This means the driver has to set a flag if it's configured in
> > listen-only mode. That should be possible.
> 
> For my understanding, when a controller does not see the ACK bit,
> it stops the transmission and sends an error flag. For this
> reason, the frame is not received and thus simply does not appear
> in the log.

I should correct you here.
When the controller does not see the ACK bit, the (transmitting)
controller will just repeat the frame until ...

Kind regards,
Kurt
