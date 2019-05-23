Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021DE27A3B
	for <lists+linux-can@lfdr.de>; Thu, 23 May 2019 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfEWKUb (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 23 May 2019 06:20:31 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:59553 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfEWKUb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 23 May 2019 06:20:31 -0400
X-ASG-Debug-ID: 1558606827-0a7b8d6150d4dc30001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.103.163.adsl.dyn.edpnet.net [77.109.103.163]) by relay-b02.edpnet.be with ESMTP id bH18nzSLG7V1AOBe; Thu, 23 May 2019 12:20:27 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Apparent-Source-IP: 77.109.103.163
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 47FCC860934;
        Thu, 23 May 2019 12:20:27 +0200 (CEST)
Date:   Thu, 23 May 2019 12:20:25 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
Subject: Re: [PATCH v1 00/17] introduce socket session queue support
Message-ID: <20190523102025.GC2318@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH v1 00/17] introduce socket session queue support
Mail-Followup-To: Oleksij Rempel <o.rempel@pengutronix.de>,
        mkl@pengutronix.de, wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl, david@protonic.nl
References: <20190523094139.15517-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523094139.15517-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.103.163.adsl.dyn.edpnet.net[77.109.103.163]
X-Barracuda-Start-Time: 1558606827
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1954
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5410 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.71678
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On do, 23 mei 2019 11:41:22 +0200, Oleksij Rempel wrote:
> This patch series is a preparation and actual session queue support.
> From now, we are able to use full available wmem of the socket and
> queue all requests if it is needed. The stack will process
> all queued requests in the FIFO order and notify user space application
> about error or completion over the errqueue interface. 

I don't understand why it is necessary to queue single messages into a
FIFO and notify user space later on?

Are you sure that different sockets still send asynchronous from each
other as long as TP/ETP is not involved?


> 
> As usual, reviews and tests are welcome.
> 
> Oleksij Rempel (17):
>   j1939: store session type in to session and start to use it
>   j1939: transport: do not send packets from j1939_tp_send
>   j1939: transport: seed retry timeout for (E)TP sessions
>   j1939: pack simple messages in to a session
>   j1939: socket: use min_t where possible
>   j1939: transport: fix broken refcounting on j1939_xtp_rx_rts_current
>     error
>   j1939: move struct j1939_sock to the header file
>   j1939: transport: return proper error on skb underrun.
>   j1939: split j1939_tp_send
>   j1939: transport: cancel session on j1939_tp_txnext error
>   j1939: transport: abort not started session if requested
>   j1939: add session state
>   j1939: transport: better protect j1939_session_insert with lock
>   j1939: implement session queue
>   j1939: rename j1939_sk_send_multi to j1939_sk_send_loop
>   j1939: rename tp_sessionq to active_session_list
>   j1939: rename jsk_fifo to sk_session_queue_entry
> 
>  net/can/j1939/j1939-priv.h |  78 +++++++-
>  net/can/j1939/main.c       |   2 +
>  net/can/j1939/socket.c     | 238 +++++++++++++----------
>  net/can/j1939/transport.c  | 384 ++++++++++++++++++-------------------
>  4 files changed, 388 insertions(+), 314 deletions(-)
> 
> -- 
> 2.20.1
> 
