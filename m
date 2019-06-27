Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F02A9581DC
	for <lists+linux-can@lfdr.de>; Thu, 27 Jun 2019 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfF0Lxw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 27 Jun 2019 07:53:52 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:36593 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfF0Lxv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 27 Jun 2019 07:53:51 -0400
X-ASG-Debug-ID: 1561636427-0a88186e201d6730001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.103.163.adsl.dyn.edpnet.net [77.109.103.163]) by relay-b03.edpnet.be with ESMTP id hY8QzAdCZNIXT9sV; Thu, 27 Jun 2019 13:53:47 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Apparent-Source-IP: 77.109.103.163
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id ADCA78D199C;
        Thu, 27 Jun 2019 13:53:47 +0200 (CEST)
Date:   Thu, 27 Jun 2019 13:53:46 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     David Jander <david@protonic.nl>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
Subject: Re: j1939: discussion: RX path
Message-ID: <20190627115346.GB693@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: j1939: discussion: RX path
Mail-Followup-To: Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, robin@protonic.nl,
        linux-can@vger.kernel.org, mkl@pengutronix.de,
        kernel@pengutronix.de, wg@grandegger.com
References: <20190625073009.GA15948@pengutronix.de>
 <20190625104315.57172f69@erd988>
 <3596eb35-4597-4a54-9e58-89e5ceb647a6@pengutronix.de>
 <20190625173137.GB8923@x1.vandijck-laurijssen.be>
 <20190626091524.40410c4b@erd988>
 <20190626130012.GC8923@x1.vandijck-laurijssen.be>
 <20190626160238.5d62fc15@erd988>
 <20190627093353.GA693@x1.vandijck-laurijssen.be>
 <20190627105901.GA24805@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190627105901.GA24805@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Start-Time: 1561636427
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1885
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5010 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73189
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On do, 27 jun 2019 12:59:01 +0200, Oleksij Rempel wrote:
> On Thu, Jun 27, 2019 at 11:33:53AM +0200, Kurt Van Dijck wrote:

> For David's use case you want to receive the initial message by the
> client, the you create a new socket()/bind()/connect() it. While the
> newly created socket is active, you don't want to receive any messages
> from that client on the server socket. This might be done by modifying
> the filters. As soon as you close the dedicated client socket, you have
> to modify the filers again. These are two separate operations, thus
> racy by design. If you do it right, you don't loose any messages, but
> receive them in both sockets. (Which makes user space handling more
> complex).
> 
[...]
> We'd like to have an API that supports the whole spectrum of use cases.
ack

> > If this is not feasible, then adapt your listening socket's filters
> > accordingly.
> 
> I don't like this, due to the raciness of the approach.
> > 

> 
> We just prototyped a sock option for "server" sockets. The options is
> disabled by default, when enabled all packets that are received in a
> connect()ed socket are ignored on this socket.

Doing so applies the (IMO) broken semantics not by default,
but the semantics remain broken until you can restrict the pool of
sockets being evaluated for the server option to your own connection
sockets.

Looking at all requirements, you want to tell the kernel that it should
divert delivery of a limited set of SRC/PGN/DST combination to another
socket of yours. 

How about:

	setsockopt(ocnnsock, SO_J1939_SET_FILTERS, ...)
	setsockopt(connsock, SO_J1939_DIVERT_FILTERS, &srvsock, sizeof(srvsock));
	connect(connsock, ...)

This allows to maintain a list of related sockets to the server to
evaulate for packet reception.
I have no idea how to implement though.

Kind regards,
Kurt
