Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F8348B2D
	for <lists+linux-can@lfdr.de>; Thu, 25 Mar 2021 09:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhCYIHe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Thu, 25 Mar 2021 04:07:34 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:59570 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhCYIH1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Mar 2021 04:07:27 -0400
X-ASG-Debug-ID: 1616659645-15c434584b858f70001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.176.static.edpnet.net [77.109.77.176]) by relay-b01.edpnet.be with ESMTP id Qe9MFu7ZG8lUmnyM; Thu, 25 Mar 2021 09:07:25 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.176.static.edpnet.net[77.109.77.176]
X-Barracuda-Apparent-Source-IP: 77.109.77.176
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id E8ED912F8970;
        Thu, 25 Mar 2021 09:07:24 +0100 (CET)
Date:   Thu, 25 Mar 2021 09:07:23 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     Richard Weinberger <richard@nod.at>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [PATCH] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
Message-ID: <20210325080723.GB8446@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH] [RFC] can: fix msg_namelen values depending on
 CAN_REQUIRED_SIZE
Mail-Followup-To: Oliver Hartkopp <socketcan@hartkopp.net>,
        Richard Weinberger <richard@nod.at>,
        linux-can <linux-can@vger.kernel.org>
References: <20210324215442.44537-1-socketcan@hartkopp.net>
 <224900630.112641.1616624386963.JavaMail.zimbra@nod.at>
 <f830f92e-fc89-7e5f-29ce-e245527a1e39@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f830f92e-fc89-7e5f-29ce-e245527a1e39@hartkopp.net>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.77.176.static.edpnet.net[77.109.77.176]
X-Barracuda-Start-Time: 1616659645
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1117
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

On Thu, 25 Mar 2021 08:31:09 +0100, Oliver Hartkopp wrote:
> On 24.03.21 23:19, Richard Weinberger wrote:
> >Oliver,
> >
> >----- Ursprüngliche Mail -----
> >>@@ -808,10 +810,13 @@ static int raw_recvmsg(struct socket *sock, struct msghdr
> >>*msg, size_t size,
> >>	int noblock;
> >>
> >>	noblock = flags & MSG_DONTWAIT;
> >>	flags &= ~MSG_DONTWAIT;
> >>
> >>+	if (msg->msg_name && msg->msg_namelen < RAW_MIN_NAMELEN)
> >>+		return -EINVAL;
> >>+
> >
> >Like with Kurt's patch, my test fails here too because msg->msg_namelen is 0.
> >->msg_namelen is always 0 in the recvfrom() case.
> 
> Agreed!
> 
> I just adopted that part and did no more testing yesterday (needed some
> sleep).
> 
> E.g. 'candump any' also fails at CAN frame reception time due to this wrong
> check ;-)

I'd like to understand how this check is wrong.
msg->msg_namelen should contain the size of msg->msg_name, isn't it.
if that is less than RAW_MIN_NAMELEN, you can't store the address.

candump sets msg->msg_namelen to sizeof(), so it is not 0.

> 
> Will send an update soon.

looking forward
Kurt
