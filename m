Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA82C928
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2019 16:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfE1OsK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 May 2019 10:48:10 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:46830 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfE1OsK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 May 2019 10:48:10 -0400
X-ASG-Debug-ID: 1559054885-0a7b8d614f11f5610001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.103.163.adsl.dyn.edpnet.net [77.109.103.163]) by relay-b02.edpnet.be with ESMTP id S9dr8xeIiJPTmILH; Tue, 28 May 2019 16:48:05 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Apparent-Source-IP: 77.109.103.163
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 877688766F9;
        Tue, 28 May 2019 16:48:05 +0200 (CEST)
Date:   Tue, 28 May 2019 16:48:03 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     David Jander <david@protonic.nl>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, mkl@pengutronix.de,
        wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl
Subject: Re: j1939: control messages and PGN
Message-ID: <20190528144803.GB11191@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: j1939: control messages and PGN
Mail-Followup-To: David Jander <david@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, mkl@pengutronix.de,
        wg@grandegger.com, kernel@pengutronix.de, linux-can@vger.kernel.org,
        robin@protonic.nl
References: <20190528115435.GA7453@pengutronix.de>
 <20190528131344.GA11191@x1.vandijck-laurijssen.be>
 <20190528162757.5e23e4c4@erd988>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190528162757.5e23e4c4@erd988>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Start-Time: 1559054885
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 3773
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5427 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.71916
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 28 mei 2019 16:27:57 +0200, David Jander wrote:
> On Tue, 28 May 2019 15:13:44 +0200
> Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be> wrote:
> 
> > On di, 28 mei 2019 13:54:35 +0200, Oleksij Rempel wrote:
> > > Hi all,
> > > 
> > > when receiving j1939 control messages, the current code looks up the
> > > session by DA and SA only, not taking the PGN (which is part of the
> > > control messages' data) into account.
> > > 
> > > When it comes to error control messages the session is aborted, even if
> > > the PGN doesn't match. In EOMA the session is aborted, too. This means
> > > receiving control messages with non matching PGNs lead to session abort.
> > > 
> > > Is this in general a good behavior?
> 
> Tl;DR: Yes, if PGN does not match the (E)TP session should be aborted.
> 
> > It is indeed a bit stupid.
> > 
> > If 2 ends are talking to each other, and 1 of those 2 talks about
> > something else, that implies that you talk not about the same thing
> > either, and you probably want to abort soon. It would be better if
> > you only abort 'probably soon' and not 'immediately' in such case, since
> > you're right that reception of another PGN control frame does not imply
> > that you're current session became invalid.
> 
> If the session is with me and I see conflicting PGN (not start of a new
> session), why not send an abort immediately?
> 
> > In j1939 however, the data part does not carry PGN info, since only 1
> > session can be open. This implies 2 things:
> > * Ignoring PGN difference in control frames makes you blind to the data
> >   consistency, so you may think in certain cases that you continue to receive
> >   data while it's actually the data that belongs to another PGN.
> 
> The sender cannot start sending data without the receiver acknowledging that
> with a CTS message first. If the CTS contains a different PGN than the RTS,
> then the sender should abort immediately.
> For ETP, if the receiver sees a DPO frame with a different PGN, it should also
> send an abort for that PGN immediately.
> 
> > * If node A talks to node B on a different PGN that node B thinks that
> >   node A is talking, then this is AFAIK considered as protocol
> >   violation because you risk data corruption.
> > 
> > The PGN in all-but-1st control frame could be considered redundant, but
> > since it's there, it should match.
> 
> Ack.
> 
> > So, it's still not a good behaviour, but j1939 IMHO requires you to do so.
> > 
> > So you think this is bad, let's make it even worse :-)
> > Between 2 nodes, actually 2 sessions may exist, 1 recv & 1 send.
> 
> Actually four in this case: ETPrx, TPrx, ETPtx and ETPrx, right?

Right, I tend to forget ETP for simplicity :-)
> 
> > Still, control frames that to RTS, CTS, DPO, ... are uni-directional,
> > i.e. they map to only 1 of those 2 sessions exclusively.
> > This is not the case for an abort message.
> > _If I'm not mistaken_, the PGN info should be ignored for abort frames,
> > since it may be unclear what exactly you abort: a old PGN, or a newly
> > requested PGN. And due to that, it's also unclear if it applies to the
> > send or recv path, so you abort, AFAIK, both directions at once.
> > But I have not the specifications around now, I can't verify.
> 
> The abort message also contains the PGN of the packeted message, so AFAICS, you
> can abort any one specific of the 4 theoretically simultaneous sessions,
> because the should have different PGN's for the different directions (rx/tx).
> 
> That's probably one of the reasons why there is always a different PGN used to
> talk in one direction than in the other.
I see.
I did not implement that very nice, I think.

Kind regards,
Kurt
