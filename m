Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48009A8053
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2019 12:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfIDK0A (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Sep 2019 06:26:00 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:16674 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDK0A (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2019 06:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1567592758;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=LwvJY9uSS0+gju5peOv1p/ZaL2QQ+pdOYbwlYdYvGds=;
        b=E/Pt0aoPMtN0/gZfPMPaO6SGaePWsO4ZObHF2z3rKBVRWEnXowouL96zeIh6cvIIlq
        uap7j6pxSAuLXZ2HSmMy4ssCQuW/rYpFX1pRCXh7dEF0Dzw70UuY65o95+Cp5KYByja4
        MHi7q9efxhjdPNDAwW2mhrB3BHAxYquiosebV+ZCUqq1zaBQMkmKSmAlWfBkLXfY6l0j
        FutUR3uI8wyZ3oyl87IBEfoxDoCGZK9qExLZPqhr+8kMAR2XUtPIY+PKAzaX+olfrvlQ
        G3a+l14ACreT5D6RgfCX65fi1fNnfd1EzkNUZ4RNXm30eDYk6po56UgEw4OLMynzwacy
        XK9Q==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1q3DbdV+MXxt8X0BVxvFP"
X-RZG-CLASS-ID: mo00
Received: from [172.20.10.6]
        by smtp.strato.de (RZmta 44.27.0 DYNA|AUTH)
        with ESMTPSA id j0667fv84APwQNR
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Sep 2019 12:25:58 +0200 (CEST)
Subject: Re: [PATCH 00/21] Add support for the J1939 Protocol
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can @ vger . kernel . org" <linux-can@vger.kernel.org>
Cc:     kernel@pengutronix.de
References: <20190828065226.23604-1-mkl@pengutronix.de>
 <a101ddf0-5150-dd48-e456-3571cfc7036b@hartkopp.net>
 <80f42661-48d3-09a0-3323-8ac4a0bda74a@pengutronix.de>
 <c3ed7db0-3d80-a17c-6c9e-0a4f821ed5db@hartkopp.net>
 <47797657-653b-8600-e896-98953f90b10d@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <2578c177-0bf2-6acc-e197-83ef78b4dafb@hartkopp.net>
Date:   Wed, 4 Sep 2019 12:25:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <47797657-653b-8600-e896-98953f90b10d@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On 04/09/2019 09.15, Marc Kleine-Budde wrote:
> On 9/3/19 6:16 PM, Oliver Hartkopp wrote:

>> Some patches do not work alone out of that sequence. Does it make sense
>> to squash them into one?
> 
> Yes, the patches build on top of each other, but the series is
> bisectable. The criterium is to have one change per patch and the tree
> can be compiled before and after the patch. Smaller changes and thus
> patches are usually easier to review.
> 
> It would be nice to have the "renaming things" patches separate, for the
> above reasons. But the introduction of the mid-layer should stay
> separate: introduce it and allocate the mid-layer memory, switch the
> framework over to make use of it and finally remove all left overs.
> 
>> squash patches 1-4 into one ?
> 
> See above.

Ah, I've just seen that the sequence first renamed the structs and then 
the variable names step-by-step.

That is indeed the best approach ... forget my remarks about squashing 
these patches.

You can add my Acked-by for all of these renaming patches too.

Thanks,
Oliver

