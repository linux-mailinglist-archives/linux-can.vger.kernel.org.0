Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BDC2DC0F
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2019 13:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfE2LlP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 29 May 2019 07:41:15 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50733 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfE2LlO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 29 May 2019 07:41:14 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hVwxC-0007p0-FJ; Wed, 29 May 2019 13:41:10 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hVwxC-0003zQ-5d; Wed, 29 May 2019 13:41:10 +0200
Date:   Wed, 29 May 2019 13:41:10 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     David Jander <david@protonic.nl>
Cc:     robin@protonic.nl, mkl@pengutronix.de, kernel@pengutronix.de,
        wg@grandegger.com, linux-can@vger.kernel.org
Subject: Re: j1939: control messages and PGN
Message-ID: <20190529114110.GA23332@pengutronix.de>
References: <20190528115435.GA7453@pengutronix.de>
 <20190528131344.GA11191@x1.vandijck-laurijssen.be>
 <20190528162757.5e23e4c4@erd988>
 <20190528144803.GB11191@x1.vandijck-laurijssen.be>
 <20190529050442.4ss6bvqnxic4xk6k@pengutronix.de>
 <20190529091710.48a52e7c@erd988>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529091710.48a52e7c@erd988>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:04:20 up 5 days, 17:07, 126 users,  load average: 2.86, 2.44,
 2.88
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, May 29, 2019 at 09:17:10AM +0200, David Jander wrote:
> > Let's take some example to make me better understand all possible
> > scenarios.
> > We have node 0x80 and node 0x90:
> > - 0x80 is transmitting data to the 0x90 with RTS PGN 0x12300
> > - if 0x90 get control signal from 0x80 (DPO) with PGN 0x13300, 0x90 should
> >   send abort message to 0x13300 and cancel currently running 0x80->0x90,0x12300
> >   session.
> 
> I think that's ok. Unsure if canceling 0x12300 is the right thing to do though.

We've changed the code to not cancel the ongoing 0x12300. We send an
abort to 0x13300 though (unless the offending control message is a BAM
or an abort).

> If the DPO came from a confused 3rd ECU, then the session from the _real_ 0x80
> would still have a chance for success. Why cancel it? If 0x80 is
> off-the-rails, it will otherwise just timeout and abort anyway, right?

ACK.

> Btw, the "reason" (byte 2 (index 1)) for this abort message would be:
> "10: Unexpected EDPO PGN (PGN in EDPO is bad)"
> (source: ISO/DIS 11783‐3:2017(E) page 42, chapter 5.11.4.6, table 5.9)
> Note that this is specified for ETP only. For TP, the abort reason is not
> defined in this case. I think we should use the same as for ETP.

Done.

> > - if 0x80 get control signal from 0x90 (CTS, EOMA) with PGN 0x13300, 0x80 should
> >   send abort message to 0x90 0x13300 and cancel currently running 0x80->0x90,0x12300
> >   session.
> 
> Again, unsure if canceling 0x12300 is necessary/desired. The abort message is
> correct IMO though.

Done.

> "Reason" for bad PGN in ECTS: 14
> "Reason" for bad PGN in EOMA: not specified (==> 250)?
> (again, only defined for ETP in this version of the standard).

Done.

> > - if 0x80 and 0x90 will get abort signal for 0x80->0x90,0x13300, which
> >   was send by 0x80 or evil third ECU, currently running 0x80->0x90,0x12300
> >   session should not be aborted.
> 
> Ack.

Done.

> > Correct?
> > 
> >   What is about not related  control signals. For 0x90 - CTS, EOMA; and
> >   for 0x80 - DPO?
> >   I ask because this stack has loop back design, so 0x90 and 0x80 will get own
> >   signals as well.
> > 
> > I can imagine at least some reason why we can get wrong signals:
> > - address conflicts (multiple ECUs configured with same address)
> > - buggy software 
> > - some CAN bus issues
> > - malicious attempts to exploit ECU remotely. 
> 
> Nice summary. Although due to the design of CAN and J1939, if a malicious ECU
> has physical access to the CAN bus, it is game-over for the whole system
> anyway.

:)

> No point in even attempting to thwart an attack.
> But as for resisting bugs and assuring best-effort in maintaining a working
> system despite buggy/bogus messages/nodes, I agree.

ACK

---

There is another error class which leads to aborts and should be
clarified:

1) control message length < 8
   Currently we send an abort message, which accesses the non-existing
   data :(
   I think it's best to ignore too short control messages.
2) PGN and command doesn't match regarding TP or ETP.
   This means receiving an ETP command on the TP command PGN or the
   other way round.
3) TP or ETP control PGN but unknown command.

Looking at it Problem 2) is a special case of 3). In the current
implementation we're bombing everything with aborts...:(

Does the standard suggest what to do?

We think it's best to not abort out session and probably not send aborts
at all. If a packet is malformed, then how much sense does it make to
extract any information (SA/DA from the CAN id and session-PGN from the
CAN data) from it and use it to send aborts and/or about our session.

regards,
Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
