Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B764524BB
	for <lists+linux-can@lfdr.de>; Tue, 25 Jun 2019 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfFYHaO (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jun 2019 03:30:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58901 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfFYHaO (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Jun 2019 03:30:14 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hffu7-0003Ju-IT; Tue, 25 Jun 2019 09:30:11 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1hffu5-0007AX-Qn; Tue, 25 Jun 2019 09:30:09 +0200
Date:   Tue, 25 Jun 2019 09:30:09 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com
Cc:     kernel@pengutronix.de, linux-can@vger.kernel.org,
        robin@protonic.nl, david@protonic.nl
Subject: j1939: discussion: RX path
Message-ID: <20190625073009.GA15948@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:19:13 up 32 days, 13:22, 112 users,  load average: 0.19, 0.26,
 0.35
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello all,

We already had a discussion about the J1939 use case for server
implementation. Short description of the challenge will looks as follow:
- main socket is listening on DST address and PGN.
- as soon as connection was requested from peer the server will
  create new connect()ed socket with SRC, DST addresses and PGN.

With current stack implementation both sockets (main and connected) will
receive same packages. At least with huge packages it will start to be
not really good :).

To solve this issue we have following variants:
variant a:
 - all sockets can receive everything (as currently implemented)
variant b:
 - only one socket will receive specific tuple. In this case kernel
   should calculate RX "priority". Only highest priority will RX packet.
   - all sockets with same priority will receive the matching packet
   - socket option promisc == same priority as exact match
variant c:
 - all sockets can receive everything
   add socket option: "ignore me if other can rx"

We think variant b makes most sense to us.

Opinions?

regards, Oleksij & Marc

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
