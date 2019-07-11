Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C8651B3
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2019 08:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfGKGGy (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 Jul 2019 02:06:54 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:33838 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfGKGGy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jul 2019 02:06:54 -0400
X-Greylist: delayed 133213 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 02:06:53 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562825209;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3RJ50qeAZBt82xCxYeX61Eu0qk8/thIVmLJ7bBiVWKI=;
        b=fYFYNkGwtuEsT6hhgWQqHtPpqiu2jJKBAANqtpoEEG2KParYvKyx4qrzZC53GcUtnm
        uMREtnWxPW4UCwg1cBaIOXt9SkU5zyff9JcKgj/9E5835xfSjK5RgvEC78xuYHqW3Kmp
        adwCGJhkezW3u5y4WU9NX2Wz4QsydOl0LX/XMZXtSqTjVSuvu2AnsLh/zGU4+pkeOOGF
        hgP+yyUw952dRtnRglyTl5ltVVcsVTAFnCUO0i+tRxGtl96sg2pgG5OaBcRjt16IohJC
        umrO2W2AhJc9b6gv86sc00DDhxaQw+44kl5KYK+R3MkJZMws/CFOjTVz5eIvXW/UAiLd
        JgSQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVsh7kSA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6B66m5sC
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 11 Jul 2019 08:06:48 +0200 (CEST)
Subject: Re: BCM on ethernet link
To:     laurent vaudoit <laurent.vaudoit@gmail.com>,
        linux-can <linux-can@vger.kernel.org>
References: <CAA7hF3zC2SrgC6JaKWzTDE6L6bP2o=zM_ZwdXgU7hwfJMraiCA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <03c043d3-94e8-1865-b427-cc2a401bbd39@hartkopp.net>
Date:   Thu, 11 Jul 2019 08:06:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAA7hF3zC2SrgC6JaKWzTDE6L6bP2o=zM_ZwdXgU7hwfJMraiCA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Laurent,

On 10/07/2019 14.45, laurent vaudoit wrote:
> Hi all,
> we are using CAN-BCM protocol for communication between two cpu (one
> with Linux, the other one without OS).
> The communication is basically exchanging some data periodically
> between the 2 cpus (to keep data synchronous between the 2 side)
> 
> On a futur architecture of the board, we plan to get some ethernet
> link between the 2 CPUs instead of CAN.
> But with still a "Linux CPU" and the other one without OS (which
> exclude too complex implementation).
> 
> So my idea was to write a driver inspired from can-bcm, but instead of
> using can frame using some TCP or UDP socket.  Userspace would use
> netlink socket to communicate with the driver, as this would not be a
> AF_CAN driver.
> 
> But before starting this work, i was wondering:
> -if it is the good choice?

The CAN_BCM provides a wide range of tx/rx timing modes and even 
bit-wise filtering and notifications - inspired by OSEK COM use-cases in 
vehicles. What kind of BCM functionalities are you currently using?

Did you already take a look on "reliable datagram sockets" (RDS) for 
your requirements?

https://www.kernel.org/doc/Documentation/networking/rds.txt

There's also a reference to "RDMA for RDS" which could be interesting 
depending on the potential overhead for your intended data sizes.

Would that fit for you?

Best regards,
Oliver

> -if there  is some existing implementation which could be the good
> choice, or a better start point?
> 
> Thanks in advance for your advice
> 
> Regards
> Laurent
> 
