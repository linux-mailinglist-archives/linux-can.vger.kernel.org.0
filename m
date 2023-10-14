Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526C27C9448
	for <lists+linux-can@lfdr.de>; Sat, 14 Oct 2023 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjJNK6i (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 14 Oct 2023 06:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNK6i (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 14 Oct 2023 06:58:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616ECCC;
        Sat, 14 Oct 2023 03:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1697281081; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SQE19xob7peOp7Dw/OZsdbRb1t1wjY8zV6FUizOH+2TiFySqVMXAZ0hJGTAbAx8j1n
    8+sdAGY+BqC0LJdUNMTf0lRhpMfWttoLmna6KWSL+DQkyvfAucOlOV4twM2HGEKtvDtw
    srOG/E5r5htyBP7pc7PBdWsqMhRTRO5UQHOYFf6yYQpNRz7jhuMW5yNU6P8XhRqLXeTm
    rdELqvjto+y3CQlq3QU4mbRvjOrQYwp7bkIjF/m7TJwGvrwfMnQsGwnXh/9rAAh9U7x8
    NmrhEeqzid2YFA/gi+8WD4ioC8DGkGLb3YeUVNxHzYMK+o+3of2sDheEBvtFUs7UyfPb
    GB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1697281081;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gwi0R5uaAP/yKQNCwjcNZyGWLm8ODytPmaUJ975+HeQ=;
    b=bF02/dIgaYA/Srdkk4Wq15hv+qqI9eWtB219Yb14JA6fCJmI6KcdEZRhvPD6v2RfnV
    rpaflL71fuujWz5s6YDBx+ohgNRCcJAYDjdf74H+kx/YPdb0edd0yKC+2Twm0BunIofR
    NuLQgGc14fS03Qh/guL75AJKVPYM5+Y7CCO0EIxOdRtmt0OvDNIxRD62Mj+8XJQhWIPW
    27LQW45wfSSLElver14Zsaq2/e4vx37WJ7Q9+6WQmP6AoKizr3oO3jqGPXIDh4aQFPNW
    jAysTllEJodN5PKPiN+1xQTVRqEP+EHgqfk91YtzpRn5HiBnC6F14b8+x3lIBUoBYErc
    lt3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1697281081;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gwi0R5uaAP/yKQNCwjcNZyGWLm8ODytPmaUJ975+HeQ=;
    b=QHxiSV4TG/kmqQEWvUJ6ZNZAAbsTjWKSBXk8ZUpuDAN3bZnjbWrZeSXQNJRd/h4OwX
    TPsPDcpgHGo14yH9bYULFz6nfhD3gy1zz/1QybqiQasvbD45cVAjnrbDsCXF3Grel2q5
    /I1qtZ2ga2/M4FHR7B+gvOBx/h+0cU7gXVT6vbN0F26ljf8jQIXyjPF133gUzxtCzzY7
    WHCDC2y67b6R5PIz2Vrs6MSrMUjcmdcy2P31OfR8/g+iAZToNZlPV45tNjUmdWmGY8/L
    i/97wA/d5z6eA5+mcH5NUBV+aEf2iwXLb2tMlcxtuoeJZ0dHm4RKZKg4FsNrskEwEaGz
    zX6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1697281081;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=gwi0R5uaAP/yKQNCwjcNZyGWLm8ODytPmaUJ975+HeQ=;
    b=Bu17cws7f7RNas6y9ysQwBg/F9xOX+IOp24z5UgzQ8jAJiz7X1QFTF3/I/MhbJM4oC
    6YLE8SmdSRUwGoqTpYAA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id j046cdz9EAw1JSt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 14 Oct 2023 12:58:01 +0200 (CEST)
Message-ID: <383f33ac-3254-4277-a9a9-8f7104851d49@hartkopp.net>
Date:   Sat, 14 Oct 2023 12:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Outstanding latency increase in kernel CAN gateway caught by
 CANlatester daily builds at 2023-10-02
To:     Pavel Pisa <pisa@fel.cvut.cz>, linux-can@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Cc:     Ondrej Ille <ondrej.ille@gmail.com>,
        =?UTF-8?Q?Mat=C4=9Bj_Vasilevski?= <matej.vasilevski@gmail.com>,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        =?UTF-8?B?SmnFmcOtIE5vdsOhaw==?= <jnovak@fel.cvut.cz>,
        Carsten Emde <c.emde@osadl.org>,
        Jan Altenberg <Jan.Altenberg@osadl.org>
References: <202310021040.49367.pisa@fel.cvut.cz>
Content-Language: en-US
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <202310021040.49367.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Pavel,

is there any news on this latency issue?

I've not seen any can-gw related changes between 6.2 and 6.6.

The only change for linux/net/can/gw.c is this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a30b2bd01c23a7eeace3a3f82c2817227099805

Which should intentionally cause a problem when the cangw tool is used 
in a wrong way:

From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Wed, 25 Jan 2023 06:54:07 +0100
Subject: can: gw: give feedback on missing CGW_FLAGS_CAN_IIF_TX_OK flag

To send CAN traffic back to the incoming interface a special flag has to
be set. When creating a routing job for identical interfaces without this
flag the rule is created but has no effect.

This patch adds an error return value in the case that the CAN interfaces
are identical but the CGW_FLAGS_CAN_IIF_TX_OK flag was not set.

Reported-by: Jannik Hartung <jannik.hartung@tu-bs.de>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: 
https://lore.kernel.org/all/20230125055407.2053-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
  net/can/gw.c | 7 +++++++
  1 file changed, 7 insertions(+)

diff --git a/net/can/gw.c b/net/can/gw.c
index 23a3d89cad81d..37528826935e7 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -1139,6 +1139,13 @@ static int cgw_create_job(struct sk_buff *skb, 
struct nlmsghdr *nlh,
  	if (gwj->dst.dev->type != ARPHRD_CAN)
  		goto out;

+	/* is sending the skb back to the incoming interface intended? */
+	if (gwj->src.dev == gwj->dst.dev &&
+	    !(gwj->flags & CGW_FLAGS_CAN_IIF_TX_OK)) {
+		err = -EINVAL;
+		goto out;
+	}
+
  	ASSERT_RTNL();

  	err = cgw_register_filter(net, gwj);

Please let me know if I can help on this topic.
So far it looks like a RT/configuration problem to me.

Best regards,
Oliver

On 02.10.23 10:40, Pavel Pisa wrote:
> Hello Oliver and others,
> 
> two consecutive daily runs of our CAN latency system
> 
>    https://canbus.pages.fel.cvut.cz/#can-bus-channels-mutual-latency-testing
> 
> shows extreme increase in latency of the kernel CAN gateway under the load.
> The first run with increased latency (run-DATE-TIME-KERNEL-OPTIONS)
> 
>    
> run-231002-045216-hist+6.6.0-rc3-rt5-ge31516c1e553+flood-kern-prio-fd-load.jsonn
> 
> previous one consistent with daily runs form May
> 
>    
> run-231001-045220-hist+6.6.0-rc3-rt5-ge31516c1e553+flood-kern-prio-fd-load.json
> 
> The history of the monitoring for kernel gateway under the load for latest RT
> kernels,
> branch run on "linux-rt-devel/for-kbuild-bot/current-stable" branch
> 
>    
> https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&load=1&flood=1&fd=1&prio=1&kern=1
> 
> Monitoring of latency when userspace application is used to forward
> data from one to another CAN interface does not show similar excess
> 
>    
> https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&load=1&flood=1&fd=1&prio=1&kern=0
> 
> It is interesting that when priority of CAN controller interrupt service
> routines
> are not boosted then problem does not appear. Priority 90 is set for each
> irq/[0-9]+-can[0-9]
> thread by
> 
>    chrt -f --pid 90 $pid
> 
> The device under the test as well as messages generation and monitoring
> system are MZ_APO boards (AMD/XlinX Zynq XC7Z010) with CTU CAN FD IP core
> CAN controller configured for 10 ns frames timestamping.
> 
> The problem can be in configuration of our system, CTU CAN FD IP core driver
> or specific to Zynq ARM platform. But it is generally suspicious because
> after initial tuning of the test system there has not been modifications
> for long time. Monitoring system is running 6.2.0-rt3-00007-ge3a16816f987
> kernel for all time and no problem with some Rx buffers overflow
> on the tester side is reported for time covering all tests in the question.
> 
> Please, report if you have some idea which change between reported
> versions from 2023-10-01 and 2023-10-02 could be reason for the change.
> I plan to keep eye on results till end of the week and if the problem
> continues then I start to investigate more by beginning of the next week
> when I should find a little more time. I am quite busy by preparation for
> conference and teaching this week so I do not expect to find much time.
> 
> Best wishes,
> 
>                  Pavel
