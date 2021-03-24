Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F843481DC
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 20:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhCXT2N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 24 Mar 2021 15:28:13 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:38958 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbhCXT1v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 15:27:51 -0400
X-ASG-Debug-ID: 1616614068-15c4336eff4c1030001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.176.static.edpnet.net [77.109.77.176]) by relay-b02.edpnet.be with ESMTP id HGOuCL3sTLd0IJoz; Wed, 24 Mar 2021 20:27:48 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.176.static.edpnet.net[77.109.77.176]
X-Barracuda-Apparent-Source-IP: 77.109.77.176
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 2A3D412F6E3C;
        Wed, 24 Mar 2021 20:27:48 +0100 (CET)
Date:   Wed, 24 Mar 2021 20:27:46 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-can <linux-can@vger.kernel.org>
Subject: PATCH: Breaking UAPI change?
Message-ID: <20210324192746.GA7408@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: PATCH: Breaking UAPI change?
Mail-Followup-To: Richard Weinberger <richard@nod.at>,
        linux-can <linux-can@vger.kernel.org>
References: <1883346738.111675.1616599858539.JavaMail.zimbra@nod.at>
 <20210324190104.GB3342@x1.vandijck-laurijssen.be>
 <1135648123.112255.1616613706554.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1135648123.112255.1616613706554.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.77.176.static.edpnet.net[77.109.77.176]
X-Barracuda-Start-Time: 1616614068
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 3675
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.88755
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> ----- Ursprüngliche Mail -----
> >> commit f5223e9eee65 ("can: extend sockaddr_can to include j1939 members")
> >> increased the size of
> >> struct sockaddr_can.
> >> This is a problem for applications which use recvfrom() with addrlen being
> >> sizeof(struct sockaddr_can)
> >> or sizeof(struct sockaddr).
> >> If such an application was built before the change it will no longer function
> >> correctly on newer kernels.
> > 
> > This scenario was identified, and explicitely dealt with.
> > This requires a tiny bit different code, i.e. net/can/raw.c should use
> > REQUIRED_SIZE() instead of sizeof() for testing the size of the address
> > structure.
> > 
> >> In fact I ran into such a scenario and found the said commit later that day.
> > 
> > Looking to the v5.10 kernel (which I happen to have checked out),
> > your claim indeed seems true, the raw_recvmsg does not (raw_bind and
> > raw_sendmsg work correct, but that's not important for your problem).
> > 
> >> 
> >> Is this a known issue?
> > 
> > It wasn't, until you found it :-)
> 
> Thanks for the prompt reply!
>  
> >> Or is this allowed and application must not use sizeof(struct sockaddr_can) as
> >> addrlen?
> > 
> > sizeof(struct sockaddr_can). As you already mentioned, applications may have
> > been built
> > before the size increase, and so they should not be recompiled.
> > 
> > 
> >> If so, what is the proposed way to avoid future breakage?
> > 
> > Your application should not change. Kernel must be fixed.
> 
> Feel free to CC me when you submit a patch, I'll happily test it.

Here it goes.
Even not compile tested :-( on my v5.10, at this hour.
I spotted a similar problem in getsockname/getpeername calls.

The patch will test for minimum required size before touching anything,
later on, the maximum size will be evaluated.

Happy testing?

commit 124900109ca88d29382ef2e2b848d3a2f9d67b98
Author: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Date:   Wed Mar 24 20:08:50 2021

    can raw: don't increase provided name length
    
    The length of the buffer is known by the application,
    not the kernel. Kernel is supposed to return only the
    size of used bytes.
    There is a minimum required size for the struct sockaddr_can
    to be usefull for can_raw, so errors are returned when
    the provided size is lower
    
    Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

diff --git a/net/can/raw.c b/net/can/raw.c
index 6ec8aa1d0da4..00d352ae221e 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -475,7 +475,7 @@ static int raw_getname(struct socket *sock, struct sockaddr *uaddr,
 	if (peer)
 		return -EOPNOTSUPP;
 
-	memset(addr, 0, sizeof(*addr));
+	memset(addr, 0, CAN_REQUIRED_SIZE(*addr, ifindex));
 	addr->can_family  = AF_CAN;
 	addr->can_ifindex = ro->ifindex;
 
@@ -806,6 +806,10 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		return sock_recv_errqueue(sk, msg, size,
 					  SOL_CAN_RAW, SCM_CAN_RAW_ERRQUEUE);
 
+	if (msg->name && msg->msg_namelen <
+			CAN_REQUIRED_SIZE(struct sockaddr_can, ifindex))
+		return -EINVAL;
+
 	skb = skb_recv_datagram(sk, flags, noblock, &err);
 	if (!skb)
 		return err;
@@ -825,7 +829,8 @@ static int raw_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 
 	if (msg->msg_name) {
 		__sockaddr_check_size(sizeof(struct sockaddr_can));
-		msg->msg_namelen = sizeof(struct sockaddr_can);
+		if (msg->msg_namelen > sizeof(struct sockaddr_can))
+			msg->msg_namelen = sizeof(struct sockaddr_can);
 		memcpy(msg->msg_name, skb->cb, msg->msg_namelen);
 	}
 
