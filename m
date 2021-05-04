Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A823728D6
	for <lists+linux-can@lfdr.de>; Tue,  4 May 2021 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhEDK1J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Tue, 4 May 2021 06:27:09 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:60692 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhEDK1I (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 May 2021 06:27:08 -0400
X-ASG-Debug-ID: 1620123027-15c43553ead31ab0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.122.62.dyn.edpnet.net [94.105.122.62]) by relay-b03.edpnet.be with ESMTP id ZZAlTdfcBncX78KZ; Tue, 04 May 2021 12:10:27 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.122.62.dyn.edpnet.net[94.105.122.62]
X-Barracuda-Apparent-Source-IP: 94.105.122.62
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 59DA213B59CB;
        Tue,  4 May 2021 12:10:27 +0200 (CEST)
Date:   Tue, 4 May 2021 12:10:26 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Ayoub Kaanich <kayoub5@live.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: More flags for logging
Message-ID: <20210504101026.GC27660@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: More flags for logging
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Ayoub Kaanich <kayoub5@live.com>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        linux-can <linux-can@vger.kernel.org>
References: <20210503100246.n7uu437kbabdzu7m@pengutronix.de>
 <20210503100810.cacbmdfmpjipgoka@pengutronix.de>
 <CAMZ6RqLKp981zBus9K1RiLL14zC0B2BGp0U+xuQGvj1fjDMF1g@mail.gmail.com>
 <DBBPR03MB70828377F51A1747B4E9E6529D5B9@DBBPR03MB7082.eurprd03.prod.outlook.com>
 <20210503154749.q3nrfjveixsqp3uj@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210503154749.q3nrfjveixsqp3uj@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.122.62.dyn.edpnet.net[94.105.122.62]
X-Barracuda-Start-Time: 1620123027
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 873
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

On Mon, 03 May 2021 17:47:49 +0200, Marc Kleine-Budde wrote:
> On 03.05.2021 15:31:34, Ayoub Kaanich wrote:
> > For the ack bit, I think we could go with the bit being a “NO_ACK”
> > bit, so a spy listener will set it to 1, if it receives a CAN frame,
> > but it does not see any node in the bus acknowledging it. This way we
> > preserve backward compatibility.
> 
> As Vincent pointed out, the device should not receive the CAN frame that
> has not been acked as I do on the flexcan.
> 
> And even on the mcp251xfd, where I receive the CAN frame, there's no way
> to tell if this frame has been acked or not.

in listen-only mode, it's debatable if you should see an ack.
If there's only 1 active node on the bus, you would not be able to probe
the bitrate using listen-only mode, unless you accept CAN frames that
are only miss the ACK bit.

Kurt
