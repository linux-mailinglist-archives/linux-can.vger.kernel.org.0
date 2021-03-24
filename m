Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4C3348121
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 20:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbhCXTBh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 24 Mar 2021 15:01:37 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:46562 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbhCXTBN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 15:01:13 -0400
X-ASG-Debug-ID: 1616612466-15c4336f024be200001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.77.176.adsl.dyn.edpnet.net [77.109.77.176]) by relay-b02.edpnet.be with ESMTP id nMOoidNQ1PNpBzlL; Wed, 24 Mar 2021 20:01:06 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.77.176.adsl.dyn.edpnet.net[77.109.77.176]
X-Barracuda-Apparent-Source-IP: 77.109.77.176
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 0B74D12F6DD1;
        Wed, 24 Mar 2021 20:01:06 +0100 (CET)
Date:   Wed, 24 Mar 2021 20:01:04 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-can@vger.kernel.org
Subject: Re: Breaking UAPI change?
Message-ID: <20210324190104.GB3342@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: Breaking UAPI change?
Mail-Followup-To: Richard Weinberger <richard@nod.at>,
        linux-can@vger.kernel.org
References: <1883346738.111675.1616599858539.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1883346738.111675.1616599858539.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.77.176.adsl.dyn.edpnet.net[77.109.77.176]
X-Barracuda-Start-Time: 1616612466
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 1416
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.88755
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

On Wed, 24 Mar 2021 16:30:58 +0100, Richard Weinberger wrote:
> Hi!
> 
> commit f5223e9eee65 ("can: extend sockaddr_can to include j1939 members") increased the size of 
> struct sockaddr_can.
> This is a problem for applications which use recvfrom() with addrlen being sizeof(struct sockaddr_can)
> or sizeof(struct sockaddr).
> If such an application was built before the change it will no longer function correctly on newer kernels.

This scenario was identified, and explicitely dealt with.
This requires a tiny bit different code, i.e. net/can/raw.c should use
REQUIRED_SIZE() instead of sizeof() for testing the size of the address
structure.

> In fact I ran into such a scenario and found the said commit later that day.

Looking to the v5.10 kernel (which I happen to have checked out),
your claim indeed seems true, the raw_recvmsg does not (raw_bind and
raw_sendmsg work correct, but that's not important for your problem).

> 
> Is this a known issue?

It wasn't, until you found it :-)

> Or is this allowed and application must not use sizeof(struct sockaddr_can) as addrlen?

sizeof(struct sockaddr_can). As you already mentioned, applications may have been built
before the size increase, and so they should not be recompiled.


> If so, what is the proposed way to avoid future breakage?

Your application should not change. Kernel must be fixed.

Kurt
