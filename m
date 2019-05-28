Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D782C790
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2019 15:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfE1NNu (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 May 2019 09:13:50 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:56364 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfE1NNu (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 May 2019 09:13:50 -0400
X-ASG-Debug-ID: 1559049225-0a7ff5110127dfac0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.103.163.adsl.dyn.edpnet.net [77.109.103.163]) by relay-b01.edpnet.be with ESMTP id pXimhMx50RzZ3ESG; Tue, 28 May 2019 15:13:45 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Apparent-Source-IP: 77.109.103.163
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 84135876469;
        Tue, 28 May 2019 15:13:45 +0200 (CEST)
Date:   Tue, 28 May 2019 15:13:44 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: Re: j1939: control messages and PGN
Message-ID: <20190528131344.GA11191@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: j1939: control messages and PGN
Mail-Followup-To: Oleksij Rempel <o.rempel@pengutronix.de>,
        mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
References: <20190528115435.GA7453@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190528115435.GA7453@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Start-Time: 1559049225
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2707
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5015 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.71914
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On di, 28 mei 2019 13:54:35 +0200, Oleksij Rempel wrote:
> Hi all,
> 
> when receiving j1939 control messages, the current code looks up the
> session by DA and SA only, not taking the PGN (which is part of the
> control messages' data) into account.
> 
> When it comes to error control messages the session is aborted, even if
> the PGN doesn't match. In EOMA the session is aborted, too. This means
> receiving control messages with non matching PGNs lead to session abort.
> 
> Is this in general a good behavior?

It is indeed a bit stupid.

If 2 ends are talking to each other, and 1 of those 2 talks about
something else, that implies that you talk not about the same thing
either, and you probably want to abort soon. It would be better if
you only abort 'probably soon' and not 'immediately' in such case, since
you're right that reception of another PGN control frame does not imply
that you're current session became invalid.

In j1939 however, the data part does not carry PGN info, since only 1
session can be open. This implies 2 things:
* Ignoring PGN difference in control frames makes you blind to the data
  consistency, so you may think in certain cases that you continue to receive
  data while it's actually the data that belongs to another PGN.
* If node A talks to node B on a different PGN that node B thinks that
  node A is talking, then this is AFAIK considered as protocol
  violation because you risk data corruption.

The PGN in all-but-1st control frame could be considered redundant, but
since it's there, it should match.

So, it's still not a good behaviour, but j1939 IMHO requires you to do so.

So you think this is bad, let's make it even worse :-)
Between 2 nodes, actually 2 sessions may exist, 1 recv & 1 send.
Still, control frames that to RTS, CTS, DPO, ... are uni-directional,
i.e. they map to only 1 of those 2 sessions exclusively.
This is not the case for an abort message.
_If I'm not mistaken_, the PGN info should be ignored for abort frames,
since it may be unclear what exactly you abort: a old PGN, or a newly
requested PGN. And due to that, it's also unclear if it applies to the
send or recv path, so you abort, AFAIK, both directions at once.
But I have not the specifications around now, I can't verify.

Hope this helps.
Kind regards,
Kurt

> 
> regards,
> Oleksij & Marc
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
