Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7723348B3C
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 09:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCYINd (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Mar 2021 04:13:33 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:42340 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhCYINT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 04:13:19 -0400
X-ASG-Debug-ID: 1616659996-15c4354a926cc940001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.176.static.edpnet.net [77.109.77.176]) by relay-b03.edpnet.be with ESMTP id fgmtD1LUe2hTxcTR; Thu, 25 Mar 2021 09:13:17 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.176.static.edpnet.net[77.109.77.176]
X-Barracuda-Apparent-Source-IP: 77.109.77.176
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id DA86F12F898A;
        Thu, 25 Mar 2021 09:13:16 +0100 (CET)
Date:   Thu, 25 Mar 2021 09:13:15 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
Message-ID: <20210325081315.GC8446@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
Mail-Followup-To: Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, Richard Weinberger <richard@nod.at>
References: <20210324215442.44537-1-socketcan@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210324215442.44537-1-socketcan@hartkopp.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.77.176.static.edpnet.net[77.109.77.176]
X-Barracuda-Start-Time: 1616659997
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2198
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.88768
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 24 Mar 2021 22:54:42 +0100, Oliver Hartkopp wrote:
> Since commit f5223e9eee65 ("can: extend sockaddr_can to include j1939
> members") the sockaddr_can has been extended in size and a new
> CAN_REQUIRED_SIZE macro has been introduced to calculate the protocol
> specific needed size.
> 
> The ABI for the msg_name and msg_namelen has not been adapted to the
> new CAN_REQUIRED_SIZE macro which leads to a problem when an existing
> binary reads the (increased) struct sockaddr_can in msg_name.
> 
> Fixes: f5223e9eee65 ("can: extend sockaddr_can to include j1939 members")
> Link: https://lore.kernel.org/linux-can/1135648123.112255.1616613706554.JavaMail.zimbra@nod.at/T/#t
> Reported-by: Richard Weinberger <richard@nod.at>
> Suggested-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>  net/can/bcm.c   | 14 ++++++++++----
>  net/can/isotp.c | 14 ++++++++++----
>  net/can/raw.c   | 17 +++++++++++------
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
...
> @@ -808,10 +810,13 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>  	int noblock;
>  
>  	noblock = flags & MSG_DONTWAIT;
>  	flags &= ~MSG_DONTWAIT;
>  
> +	if (msg->msg_name && msg->msg_namelen < RAW_MIN_NAMELEN)
> +		return -EINVAL;
> +
>  	if (flags & MSG_ERRQUEUE)
>  		return sock_recv_errqueue(sk, msg, size,
>  					  SOL_CAN_RAW, SCM_CAN_RAW_ERRQUEUE);
>  
>  	skb = skb_recv_datagram(sk, flags, noblock, &err);
> @@ -830,12 +835,12 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
>  	}
>  
>  	sock_recv_ts_and_drops(msg, sk, skb);
>  
>  	if (msg->msg_name) {
> -		__sockaddr_check_size(sizeof(struct sockaddr_can));
> -		msg->msg_namelen = sizeof(struct sockaddr_can);
> +		__sockaddr_check_size(RAW_MIN_NAMELEN);
> +		msg->msg_namelen = RAW_MIN_NAMELEN;

Why not fill up to MIN(msg->msg_namelen, sizeof(struct sockaddr_can))? 

>  		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
>  	}
>  
>  	/* assign the flags that have been recorded in raw_rcv() */
>  	msg->msg_flags |= *(raw_flags(skb));
> -- 
> 2.30.2
> 
