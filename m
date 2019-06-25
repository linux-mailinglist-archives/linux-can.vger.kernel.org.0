Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5962F526F5
	for <lists+linux-can@lfdr.de>; Tue, 25 Jun 2019 10:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfFYInR (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 25 Jun 2019 04:43:17 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:35415 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728774AbfFYInR (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 25 Jun 2019 04:43:17 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id 7712144A0026;
        Tue, 25 Jun 2019 10:44:59 +0200 (CEST)
Date:   Tue, 25 Jun 2019 10:43:15 +0200
From:   David Jander <david@protonic.nl>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     dev.kurt@vandijck-laurijssen.be, mkl@pengutronix.de,
        wg@grandegger.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, robin@protonic.nl
Subject: Re: j1939: discussion: RX path
Message-ID: <20190625104315.57172f69@erd988>
In-Reply-To: <20190625073009.GA15948@pengutronix.de>
References: <20190625073009.GA15948@pengutronix.de>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 25 Jun 2019 09:30:09 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hello all,
> 
> We already had a discussion about the J1939 use case for server
> implementation. Short description of the challenge will looks as follow:
> - main socket is listening on DST address and PGN.
> - as soon as connection was requested from peer the server will
>   create new connect()ed socket with SRC, DST addresses and PGN.
> 
> With current stack implementation both sockets (main and connected) will
> receive same packages. At least with huge packages it will start to be
> not really good :).
> 
> To solve this issue we have following variants:
> variant a:
>  - all sockets can receive everything (as currently implemented)
> variant b:
>  - only one socket will receive specific tuple. In this case kernel
>    should calculate RX "priority". Only highest priority will RX packet.
>    - all sockets with same priority will receive the matching packet
>    - socket option promisc == same priority as exact match

How is this "priority" determined?
Something like this:

 for each socket:
	 prio = 0
	 listening on same DST or PGN ==> prio++
	 listening on same DST and PGN ==> prio++
	 connect()ed to same SRC ==> prio++
 deliver frame to socket(s) with highest prio.

Is that what you mean?

> variant c:
>  - all sockets can receive everything
>    add socket option: "ignore me if other can rx"

That will be confusing I believe...

> We think variant b makes most sense to us.

I think I agree.

> Opinions?
> 
> regards, Oleksij & Marc
> 

Best regards,

-- 
David Jander
Protonic Holland.
