Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC552C8B9
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2019 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfE1O17 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 May 2019 10:27:59 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:35601 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbfE1O17 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 28 May 2019 10:27:59 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id 1259244A0026;
        Tue, 28 May 2019 16:29:36 +0200 (CEST)
Date:   Tue, 28 May 2019 16:27:57 +0200
From:   David Jander <david@protonic.nl>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, mkl@pengutronix.de,
        wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl
Subject: Re: j1939: control messages and PGN
Message-ID: <20190528162757.5e23e4c4@erd988>
In-Reply-To: <20190528131344.GA11191@x1.vandijck-laurijssen.be>
References: <20190528115435.GA7453@pengutronix.de>
        <20190528131344.GA11191@x1.vandijck-laurijssen.be>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 28 May 2019 15:13:44 +0200
Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> wrote:

> On di, 28 mei 2019 13:54:35 +0200, Oleksij Rempel wrote:
> > Hi all,
> > 
> > when receiving j1939 control messages, the current code looks up the
> > session by DA and SA only, not taking the PGN (which is part of the
> > control messages' data) into account.
> > 
> > When it comes to error control messages the session is aborted, even if
> > the PGN doesn't match. In EOMA the session is aborted, too. This means
> > receiving control messages with non matching PGNs lead to session abort.
> > 
> > Is this in general a good behavior?

Tl;DR: Yes, if PGN does not match the (E)TP session should be aborted.

> It is indeed a bit stupid.
> 
> If 2 ends are talking to each other, and 1 of those 2 talks about
> something else, that implies that you talk not about the same thing
> either, and you probably want to abort soon. It would be better if
> you only abort 'probably soon' and not 'immediately' in such case, since
> you're right that reception of another PGN control frame does not imply
> that you're current session became invalid.

If the session is with me and I see conflicting PGN (not start of a new
session), why not send an abort immediately?

> In j1939 however, the data part does not carry PGN info, since only 1
> session can be open. This implies 2 things:
> * Ignoring PGN difference in control frames makes you blind to the data
>   consistency, so you may think in certain cases that you continue to receive
>   data while it's actually the data that belongs to another PGN.

The sender cannot start sending data without the receiver acknowledging that
with a CTS message first. If the CTS contains a different PGN than the RTS,
then the sender should abort immediately.
For ETP, if the receiver sees a DPO frame with a different PGN, it should also
send an abort for that PGN immediately.

> * If node A talks to node B on a different PGN that node B thinks that
>   node A is talking, then this is AFAIK considered as protocol
>   violation because you risk data corruption.
> 
> The PGN in all-but-1st control frame could be considered redundant, but
> since it's there, it should match.

Ack.

> So, it's still not a good behaviour, but j1939 IMHO requires you to do so.
> 
> So you think this is bad, let's make it even worse :-)
> Between 2 nodes, actually 2 sessions may exist, 1 recv & 1 send.

Actually four in this case: ETPrx, TPrx, ETPtx and ETPrx, right?

> Still, control frames that to RTS, CTS, DPO, ... are uni-directional,
> i.e. they map to only 1 of those 2 sessions exclusively.
> This is not the case for an abort message.
> _If I'm not mistaken_, the PGN info should be ignored for abort frames,
> since it may be unclear what exactly you abort: a old PGN, or a newly
> requested PGN. And due to that, it's also unclear if it applies to the
> send or recv path, so you abort, AFAIK, both directions at once.
> But I have not the specifications around now, I can't verify.

The abort message also contains the PGN of the packeted message, so AFAICS, you
can abort any one specific of the 4 theoretically simultaneous sessions,
because the should have different PGN's for the different directions (rx/tx).

That's probably one of the reasons why there is always a different PGN used to
talk in one direction than in the other.

Best regards,

-- 
David Jander
Protonic Holland.
