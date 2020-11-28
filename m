Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A3B2C730F
	for <lists+linux-can@lfdr.de>; Sat, 28 Nov 2020 23:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389359AbgK1Vt7 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 28 Nov 2020 16:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731627AbgK1SCx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 28 Nov 2020 13:02:53 -0500
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5301::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F68C025396
        for <linux-can@vger.kernel.org>; Sat, 28 Nov 2020 09:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606585485;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ZFHOK2tOlauqaS49BG0Iljfi89bdnQDyUR1fCDYdP+4=;
        b=F3LpZ79gfJ0G/NAJDhF+RkqwUKImlUSj2ZLPYRy8U7WOhOUa5uV7dwndkaRgFX8MVg
        6qsmVVw38iehHfKxeQzmjhS/jK6Px8XnKcKCu8pVJfEnJmh5t7FnBR4NJjLUasOVn/2Q
        BZ4hl9CZ5x4MOA3KXqAFHaPoeebGs/FNC62VOYfnnZC//3aJIFZrkppYIxwrtYG0Zvpb
        R1wyUVsmPSy68xziwn3KDjaZE+Bd9dDyAmnBWJiIUq0Yrt5YVHdk8C/I5riMdoW1o6OV
        2CqZrvka60F5r8yDolKILXZCR55mzmuetNuTSd2mco6ZNc3d0UyyYq/L4IQ+CK13OX64
        l9Bw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR+J8xuzl0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwASHiezk6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sat, 28 Nov 2020 18:44:40 +0100 (CET)
Subject: Re: rx-dropped increases if the can module is not loaded (yet)
To:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <269cc265-272e-6b57-0f95-90a3bd66aea3@victronenergy.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <438db92e-692a-5fcf-db97-7ba3a51c97be@hartkopp.net>
Date:   Sat, 28 Nov 2020 18:44:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <269cc265-272e-6b57-0f95-90a3bd66aea3@victronenergy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 27.11.20 17:09, Jeroen Hofstee wrote:

> Since it took me a while to figure it out, it might be worthwhile to share.
> If a CAN-bus network interface is first set to up and only later used,
> the messages received in the meantime are counted by [1] as dropped.

Interesting! But makes sense and is consistent: When the CAN frame is 
not processed by the network layer is is just dropped in the rx path.

> If the the can module is modprobed before the interface is upped, this
> is no longer the case.
> 
> Perhaps it saves someone some time.

So far we have not documented these details for the existing netdev 
statistics. Do you think this is needed when the behaviour, which leads 
to rx-dropped, is common for other netdevs also?

Regards,
Oliver

> 
> [1] https://github.com/torvalds/linux/blob/v5.9/net/core/dev.c#L5257
> 
