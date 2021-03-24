Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02CE3481D4
	for <lists+linux-can@lfdr.de>; Wed, 24 Mar 2021 20:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbhCXTWS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-can@lfdr.de>); Wed, 24 Mar 2021 15:22:18 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:50178 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237939AbhCXTVt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 24 Mar 2021 15:21:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5C79C606BA2E;
        Wed, 24 Mar 2021 20:21:48 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HkNl_ppg0nuN; Wed, 24 Mar 2021 20:21:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EEC5E606BA32;
        Wed, 24 Mar 2021 20:21:47 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XmnQht0caK2W; Wed, 24 Mar 2021 20:21:47 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id CC303606BA2A;
        Wed, 24 Mar 2021 20:21:47 +0100 (CET)
Date:   Wed, 24 Mar 2021 20:21:46 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc:     linux-can <linux-can@vger.kernel.org>
Message-ID: <1135648123.112255.1616613706554.JavaMail.zimbra@nod.at>
In-Reply-To: <20210324190104.GB3342@x1.vandijck-laurijssen.be>
References: <1883346738.111675.1616599858539.JavaMail.zimbra@nod.at> <20210324190104.GB3342@x1.vandijck-laurijssen.be>
Subject: Re: Breaking UAPI change?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: Breaking UAPI change?
Thread-Index: K8NenHyofe3u9EFYzr8YNwGssI5I1w==
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Kurt,

----- Ursprüngliche Mail -----
>> commit f5223e9eee65 ("can: extend sockaddr_can to include j1939 members")
>> increased the size of
>> struct sockaddr_can.
>> This is a problem for applications which use recvfrom() with addrlen being
>> sizeof(struct sockaddr_can)
>> or sizeof(struct sockaddr).
>> If such an application was built before the change it will no longer function
>> correctly on newer kernels.
> 
> This scenario was identified, and explicitely dealt with.
> This requires a tiny bit different code, i.e. net/can/raw.c should use
> REQUIRED_SIZE() instead of sizeof() for testing the size of the address
> structure.
> 
>> In fact I ran into such a scenario and found the said commit later that day.
> 
> Looking to the v5.10 kernel (which I happen to have checked out),
> your claim indeed seems true, the raw_recvmsg does not (raw_bind and
> raw_sendmsg work correct, but that's not important for your problem).
> 
>> 
>> Is this a known issue?
> 
> It wasn't, until you found it :-)

Thanks for the prompt reply!
 
>> Or is this allowed and application must not use sizeof(struct sockaddr_can) as
>> addrlen?
> 
> sizeof(struct sockaddr_can). As you already mentioned, applications may have
> been built
> before the size increase, and so they should not be recompiled.
> 
> 
>> If so, what is the proposed way to avoid future breakage?
> 
> Your application should not change. Kernel must be fixed.

Feel free to CC me when you submit a patch, I'll happily test it.

Thanks,
//richard
