Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A752D610
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2019 09:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfE2HRM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 29 May 2019 03:17:12 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:39997 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfE2HRM (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 29 May 2019 03:17:12 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id 1B89544A00C6;
        Wed, 29 May 2019 09:18:49 +0200 (CEST)
Date:   Wed, 29 May 2019 09:17:10 +0200
From:   David Jander <david@protonic.nl>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl
Subject: Re: j1939: control messages and PGN
Message-ID: <20190529091710.48a52e7c@erd988>
In-Reply-To: <20190529050442.4ss6bvqnxic4xk6k@pengutronix.de>
References: <20190528115435.GA7453@pengutronix.de>
        <20190528131344.GA11191@x1.vandijck-laurijssen.be>
        <20190528162757.5e23e4c4@erd988>
        <20190528144803.GB11191@x1.vandijck-laurijssen.be>
        <20190529050442.4ss6bvqnxic4xk6k@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 29 May 2019 07:04:42 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, May 28, 2019 at 04:48:03PM +0200, Kurt Van Dijck wrote:
> > On di, 28 mei 2019 16:27:57 +0200, David Jander wrote:  
> > > On Tue, 28 May 2019 15:13:44 +0200
> > > Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> wrote:
> > >   
> > > > On di, 28 mei 2019 13:54:35 +0200, Oleksij Rempel wrote:  
> > > > > Hi all,
> > > > > 
> > > > > when receiving j1939 control messages, the current code looks up the
> > > > > session by DA and SA only, not taking the PGN (which is part of the
> > > > > control messages' data) into account.
> > > > > 
> > > > > When it comes to error control messages the session is aborted, even if
> > > > > the PGN doesn't match. In EOMA the session is aborted, too. This means
> > > > > receiving control messages with non matching PGNs lead to session abort.
> > > > > 
> > > > > Is this in general a good behavior?  
> > > 
> > > Tl;DR: Yes, if PGN does not match the (E)TP session should be aborted.
> > >   
> > > > It is indeed a bit stupid.
> > > > 
> > > > If 2 ends are talking to each other, and 1 of those 2 talks about
> > > > something else, that implies that you talk not about the same thing
> > > > either, and you probably want to abort soon. It would be better if
> > > > you only abort 'probably soon' and not 'immediately' in such case, since
> > > > you're right that reception of another PGN control frame does not imply
> > > > that you're current session became invalid.  
> > > 
> > > If the session is with me and I see conflicting PGN (not start of a new
> > > session), why not send an abort immediately?
> > >   
> > > > In j1939 however, the data part does not carry PGN info, since only 1
> > > > session can be open. This implies 2 things:
> > > > * Ignoring PGN difference in control frames makes you blind to the data
> > > >   consistency, so you may think in certain cases that you continue to receive
> > > >   data while it's actually the data that belongs to another PGN.  
> > > 
> > > The sender cannot start sending data without the receiver acknowledging that
> > > with a CTS message first. If the CTS contains a different PGN than the RTS,
> > > then the sender should abort immediately.
> > > For ETP, if the receiver sees a DPO frame with a different PGN, it should also
> > > send an abort for that PGN immediately.
> > >   
> > > > * If node A talks to node B on a different PGN that node B thinks that
> > > >   node A is talking, then this is AFAIK considered as protocol
> > > >   violation because you risk data corruption.
> > > > 
> > > > The PGN in all-but-1st control frame could be considered redundant, but
> > > > since it's there, it should match.  
> > > 
> > > Ack.
> > >   
> > > > So, it's still not a good behaviour, but j1939 IMHO requires you to do so.
> > > > 
> > > > So you think this is bad, let's make it even worse :-)
> > > > Between 2 nodes, actually 2 sessions may exist, 1 recv & 1 send.  
> > > 
> > > Actually four in this case: ETPrx, TPrx, ETPtx and ETPrx, right?  
> > 
> > Right, I tend to forget ETP for simplicity :-)  
> > >   
> > > > Still, control frames that to RTS, CTS, DPO, ... are uni-directional,
> > > > i.e. they map to only 1 of those 2 sessions exclusively.
> > > > This is not the case for an abort message.
> > > > _If I'm not mistaken_, the PGN info should be ignored for abort frames,
> > > > since it may be unclear what exactly you abort: a old PGN, or a newly
> > > > requested PGN. And due to that, it's also unclear if it applies to the
> > > > send or recv path, so you abort, AFAIK, both directions at once.
> > > > But I have not the specifications around now, I can't verify.  
> > > 
> > > The abort message also contains the PGN of the packeted message, so AFAICS, you
> > > can abort any one specific of the 4 theoretically simultaneous sessions,
> > > because the should have different PGN's for the different directions (rx/tx).
> > > 
> > > That's probably one of the reasons why there is always a different PGN used to
> > > talk in one direction than in the other.  
> > I see.
> > I did not implement that very nice, I think.  
> 
> Let's take some example to make me better understand all possible
> scenarios.
> We have node 0x80 and node 0x90:
> - 0x80 is transmitting data to the 0x90 with RTS PGN 0x12300
> - if 0x90 get control signal from 0x80 (DPO) with PGN 0x13300, 0x90 should
>   send abort message to 0x13300 and cancel currently running 0x80->0x90,0x12300
>   session.

I think that's ok. Unsure if canceling 0x12300 is the right thing to do though.
If the DPO came from a confused 3rd ECU, then the session from the _real_ 0x80
would still have a chance for success. Why cancel it? If 0x80 is
off-the-rails, it will otherwise just timeout and abort anyway, right?

Btw, the "reason" (byte 2 (index 1)) for this abort message would be:
"10: Unexpected EDPO PGN (PGN in EDPO is bad)"
(source: ISO/DIS 11783‐3:2017(E) page 42, chapter 5.11.4.6, table 5.9)
Note that this is specified for ETP only. For TP, the abort reason is not
defined in this case. I think we should use the same as for ETP.

> - if 0x80 get control signal from 0x90 (CTS, EOMA) with PGN 0x13300, 0x80 should
>   send abort message to 0x90 0x13300 and cancel currently running 0x80->0x90,0x12300
>   session.

Again, unsure if canceling 0x12300 is necessary/desired. The abort message is
correct IMO though.

"Reason" for bad PGN in ECTS: 14
"Reason" for bad PGN in EOMA: not specified (==> 250)?
(again, only defined for ETP in this version of the standard).

> - if 0x80 and 0x90 will get abort signal for 0x80->0x90,0x13300, which
>   was send by 0x80 or evil third ECU, currently running 0x80->0x90,0x12300
>   session should not be aborted.

Ack.

> Correct?
> 
>   What is about not related  control signals. For 0x90 - CTS, EOMA; and
>   for 0x80 - DPO?
>   I ask because this stack has loop back design, so 0x90 and 0x80 will get own
>   signals as well.
> 
> I can imagine at least some reason why we can get wrong signals:
> - address conflicts (multiple ECUs configured with same address)
> - buggy software 
> - some CAN bus issues
> - malicious attempts to exploit ECU remotely. 

Nice summary. Although due to the design of CAN and J1939, if a malicious ECU
has physical access to the CAN bus, it is game-over for the whole system
anyway. No point in even attempting to thwart an attack.
But as for resisting bugs and assuring best-effort in maintaining a working
system despite buggy/bogus messages/nodes, I agree.

Best regards,

-- 
David Jander
Protonic Holland.

