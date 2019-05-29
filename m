Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E362D4FB
	for <lists+linux-can@lfdr.de>; Wed, 29 May 2019 07:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfE2FEp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 29 May 2019 01:04:45 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49157 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfE2FEp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 29 May 2019 01:04:45 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hVqlX-0000dh-9q; Wed, 29 May 2019 07:04:43 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1hVqlW-0000Bw-PW; Wed, 29 May 2019 07:04:42 +0200
Date:   Wed, 29 May 2019 07:04:42 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     David Jander <david@protonic.nl>, mkl@pengutronix.de,
        wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl
Subject: Re: j1939: control messages and PGN
Message-ID: <20190529050442.4ss6bvqnxic4xk6k@pengutronix.de>
References: <20190528115435.GA7453@pengutronix.de>
 <20190528131344.GA11191@x1.vandijck-laurijssen.be>
 <20190528162757.5e23e4c4@erd988>
 <20190528144803.GB11191@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528144803.GB11191@x1.vandijck-laurijssen.be>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:34:29 up 11 days, 10:52, 32 users,  load average: 0.02, 0.02,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, May 28, 2019 at 04:48:03PM +0200, Kurt Van Dijck wrote:
> On di, 28 mei 2019 16:27:57 +0200, David Jander wrote:
> > On Tue, 28 May 2019 15:13:44 +0200
> > Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> wrote:
> > 
> > > On di, 28 mei 2019 13:54:35 +0200, Oleksij Rempel wrote:
> > > > Hi all,
> > > > 
> > > > when receiving j1939 control messages, the current code looks up the
> > > > session by DA and SA only, not taking the PGN (which is part of the
> > > > control messages' data) into account.
> > > > 
> > > > When it comes to error control messages the session is aborted, even if
> > > > the PGN doesn't match. In EOMA the session is aborted, too. This means
> > > > receiving control messages with non matching PGNs lead to session abort.
> > > > 
> > > > Is this in general a good behavior?
> > 
> > Tl;DR: Yes, if PGN does not match the (E)TP session should be aborted.
> > 
> > > It is indeed a bit stupid.
> > > 
> > > If 2 ends are talking to each other, and 1 of those 2 talks about
> > > something else, that implies that you talk not about the same thing
> > > either, and you probably want to abort soon. It would be better if
> > > you only abort 'probably soon' and not 'immediately' in such case, since
> > > you're right that reception of another PGN control frame does not imply
> > > that you're current session became invalid.
> > 
> > If the session is with me and I see conflicting PGN (not start of a new
> > session), why not send an abort immediately?
> > 
> > > In j1939 however, the data part does not carry PGN info, since only 1
> > > session can be open. This implies 2 things:
> > > * Ignoring PGN difference in control frames makes you blind to the data
> > >   consistency, so you may think in certain cases that you continue to receive
> > >   data while it's actually the data that belongs to another PGN.
> > 
> > The sender cannot start sending data without the receiver acknowledging that
> > with a CTS message first. If the CTS contains a different PGN than the RTS,
> > then the sender should abort immediately.
> > For ETP, if the receiver sees a DPO frame with a different PGN, it should also
> > send an abort for that PGN immediately.
> > 
> > > * If node A talks to node B on a different PGN that node B thinks that
> > >   node A is talking, then this is AFAIK considered as protocol
> > >   violation because you risk data corruption.
> > > 
> > > The PGN in all-but-1st control frame could be considered redundant, but
> > > since it's there, it should match.
> > 
> > Ack.
> > 
> > > So, it's still not a good behaviour, but j1939 IMHO requires you to do so.
> > > 
> > > So you think this is bad, let's make it even worse :-)
> > > Between 2 nodes, actually 2 sessions may exist, 1 recv & 1 send.
> > 
> > Actually four in this case: ETPrx, TPrx, ETPtx and ETPrx, right?
> 
> Right, I tend to forget ETP for simplicity :-)
> > 
> > > Still, control frames that to RTS, CTS, DPO, ... are uni-directional,
> > > i.e. they map to only 1 of those 2 sessions exclusively.
> > > This is not the case for an abort message.
> > > _If I'm not mistaken_, the PGN info should be ignored for abort frames,
> > > since it may be unclear what exactly you abort: a old PGN, or a newly
> > > requested PGN. And due to that, it's also unclear if it applies to the
> > > send or recv path, so you abort, AFAIK, both directions at once.
> > > But I have not the specifications around now, I can't verify.
> > 
> > The abort message also contains the PGN of the packeted message, so AFAICS, you
> > can abort any one specific of the 4 theoretically simultaneous sessions,
> > because the should have different PGN's for the different directions (rx/tx).
> > 
> > That's probably one of the reasons why there is always a different PGN used to
> > talk in one direction than in the other.
> I see.
> I did not implement that very nice, I think.

Let's take some example to make me better understand all possible
scenarios.
We have node 0x80 and node 0x90:
- 0x80 is transmitting data to the 0x90 with RTS PGN 0x12300
- if 0x90 get control signal from 0x80 (DPO) with PGN 0x13300, 0x90 should
  send abort message to 0x13300 and cancel currently running 0x80->0x90,0x12300
  session.

- if 0x80 get control signal from 0x90 (CTS, EOMA) with PGN 0x13300, 0x80 should
  send abort message to 0x90 0x13300 and cancel currently running 0x80->0x90,0x12300
  session.

- if 0x80 and 0x90 will get abort signal for 0x80->0x90,0x13300, which
  was send by 0x80 or evil third ECU, currently running 0x80->0x90,0x12300
  session should not be aborted.
 
Correct?

  What is about not related  control signals. For 0x90 - CTS, EOMA; and
  for 0x80 - DPO?
  I ask because this stack has loop back design, so 0x90 and 0x80 will get own
  signals as well.

I can imagine at least some reason why we can get wrong signals:
- address conflicts (multiple ECUs configured with same address)
- buggy software 
- some CAN bus issues
- malicious attempts to exploit ECU remotely. 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
