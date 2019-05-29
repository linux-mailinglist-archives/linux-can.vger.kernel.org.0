Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCF72DE11
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2019 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfE2NZ0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 29 May 2019 09:25:26 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:41587 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726029AbfE2NZ0 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 29 May 2019 09:25:26 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id BBF3244A00C6;
        Wed, 29 May 2019 15:27:03 +0200 (CEST)
Date:   Wed, 29 May 2019 15:25:25 +0200
From:   David Jander <david@protonic.nl>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     robin@protonic.nl, mkl@pengutronix.de, kernel@pengutronix.de,
        wg@grandegger.com, linux-can@vger.kernel.org
Subject: Re: j1939: control messages and PGN
Message-ID: <20190529152525.409fbca2@erd988>
In-Reply-To: <20190529114110.GA23332@pengutronix.de>
References: <20190528115435.GA7453@pengutronix.de>
        <20190528131344.GA11191@x1.vandijck-laurijssen.be>
        <20190528162757.5e23e4c4@erd988>
        <20190528144803.GB11191@x1.vandijck-laurijssen.be>
        <20190529050442.4ss6bvqnxic4xk6k@pengutronix.de>
        <20190529091710.48a52e7c@erd988>
        <20190529114110.GA23332@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 29 May 2019 13:41:10 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Wed, May 29, 2019 at 09:17:10AM +0200, David Jander wrote:
> > > Let's take some example to make me better understand all possible
> > > scenarios.
> > > We have node 0x80 and node 0x90:
> > > - 0x80 is transmitting data to the 0x90 with RTS PGN 0x12300
> > > - if 0x90 get control signal from 0x80 (DPO) with PGN 0x13300, 0x90 should
> > >   send abort message to 0x13300 and cancel currently running 0x80->0x90,0x12300
> > >   session.  
> > 
> > I think that's ok. Unsure if canceling 0x12300 is the right thing to do though.  
> 
> We've changed the code to not cancel the ongoing 0x12300. We send an
> abort to 0x13300 though (unless the offending control message is a BAM
> or an abort).
> 
> > If the DPO came from a confused 3rd ECU, then the session from the _real_ 0x80
> > would still have a chance for success. Why cancel it? If 0x80 is
> > off-the-rails, it will otherwise just timeout and abort anyway, right?  
> 
> ACK.
> 
> > Btw, the "reason" (byte 2 (index 1)) for this abort message would be:
> > "10: Unexpected EDPO PGN (PGN in EDPO is bad)"
> > (source: ISO/DIS 11783‐3:2017(E) page 42, chapter 5.11.4.6, table 5.9)
> > Note that this is specified for ETP only. For TP, the abort reason is not
> > defined in this case. I think we should use the same as for ETP.  
> 
> Done.
> 
> > > - if 0x80 get control signal from 0x90 (CTS, EOMA) with PGN 0x13300, 0x80 should
> > >   send abort message to 0x90 0x13300 and cancel currently running 0x80->0x90,0x12300
> > >   session.  
> > 
> > Again, unsure if canceling 0x12300 is necessary/desired. The abort message is
> > correct IMO though.  
> 
> Done.
> 
> > "Reason" for bad PGN in ECTS: 14
> > "Reason" for bad PGN in EOMA: not specified (==> 250)?
> > (again, only defined for ETP in this version of the standard).  
> 
> Done.
> 
> > > - if 0x80 and 0x90 will get abort signal for 0x80->0x90,0x13300, which
> > >   was send by 0x80 or evil third ECU, currently running 0x80->0x90,0x12300
> > >   session should not be aborted.  
> > 
> > Ack.  
> 
> Done.
> 
> > > Correct?
> > > 
> > >   What is about not related  control signals. For 0x90 - CTS, EOMA; and
> > >   for 0x80 - DPO?
> > >   I ask because this stack has loop back design, so 0x90 and 0x80 will get own
> > >   signals as well.
> > > 
> > > I can imagine at least some reason why we can get wrong signals:
> > > - address conflicts (multiple ECUs configured with same address)
> > > - buggy software 
> > > - some CAN bus issues
> > > - malicious attempts to exploit ECU remotely.   
> > 
> > Nice summary. Although due to the design of CAN and J1939, if a malicious ECU
> > has physical access to the CAN bus, it is game-over for the whole system
> > anyway.  
> 
> :)
> 
> > No point in even attempting to thwart an attack.
> > But as for resisting bugs and assuring best-effort in maintaining a working
> > system despite buggy/bogus messages/nodes, I agree.  
> 
> ACK
> 
> ---
> 
> There is another error class which leads to aborts and should be
> clarified:
> 
> 1) control message length < 8
>    Currently we send an abort message, which accesses the non-existing
>    data :(
>    I think it's best to ignore too short control messages.

Unsure what's best to do here. Ignore would lead at most to a timeout which is
not a problem.... so I guess it is safe to do that if that's easier.

> 2) PGN and command doesn't match regarding TP or ETP.
>    This means receiving an ETP command on the TP command PGN or the
>    other way round.

That would equate to sending a CM with an unknown control byte value. I
suppose ignore is the best course of action. We never know if we are dealing
with a newer version of the standard or some proprietary extension that uses
those values for something.

> 3) TP or ETP control PGN but unknown command.

Same as 2) above.

> Looking at it Problem 2) is a special case of 3). In the current
> implementation we're bombing everything with aborts...:(

That doesn't seem correct to me. We should differentiate between known message
types which are malformed (abort) and unknown (to us) message types (ignore).

> Does the standard suggest what to do?

Standard says (about TP in this case):

"Control byte: 0 to 15, 18, 20 to 31, 33 to 254 reserved for
assignment in a future International Standard"

> We think it's best to not abort out session and probably not send aborts
> at all. If a packet is malformed, then how much sense does it make to
> extract any information (SA/DA from the CAN id and session-PGN from the
> CAN data) from it and use it to send aborts and/or about our session.

I still think it is best to abort on an error (malformed control frame), and
silently ignore messages that could otherwise be unimplemented future
functionality, or that we simply don't know how to deal with (unknown control
byte for this PGN, etc...).

Best regards,

-- 
David Jander
Protonic Holland.
