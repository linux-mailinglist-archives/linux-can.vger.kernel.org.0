Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4953AD9CA
	for <lists+linux-can@lfdr.de>; Sat, 19 Jun 2021 13:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhFSL0Q (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 19 Jun 2021 07:26:16 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:18776 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFSL0Q (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 19 Jun 2021 07:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1624101833;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:References:To:From:Subject:Cc:Date:From:
    Subject:Sender;
    bh=W/FBRczRthfH8wY1xfuTKFLk8Jtk/A/fac/RMutkg0c=;
    b=CqeyHsUM+Z55CgkWy7R3USjA7gdcQRqRSLgXHBoPfU0FJld6jzEiqZmdiL4rqaDJCF
    HkFX/GbodZtPifnG3RvLbxQY1xbUVzzYIna1WhQjoWBEcjQp3g5/QoU7MuFg1d+H4a7h
    nwCXCyWuLIKNQDZlOKv0Ayt4la5OU64QBrNtADYq6mRsfqyQTYpSLotxFbnZqIPDdlED
    4GDpQjE3GEIOpAi/yFMWQVPmqtpfBPwVTgLGPUSY+65d6gjp1yHCABQqX6IDiOe6Nfg5
    BwveA+PccG2R9Oal8H0o3Mw4VWS96N5CqxKK7b34K16IPSHLWVql5Eh1KIZly6elSgXo
    emxw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xozF0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.27.3 DYNA|AUTH)
    with ESMTPSA id N0b2dax5JBNr3Z3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 19 Jun 2021 13:23:53 +0200 (CEST)
Subject: Re: vxcan RX/TX/echo semantics
From:   Oliver Hartkopp <socketcan@hartkopp.net>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can <linux-can@vger.kernel.org>
References: <20210527150759.az3lal4vnhivwhlx@pengutronix.de>
 <ebaf846a-f325-80fd-f926-6ad9854bf453@hartkopp.net>
Message-ID: <4b35d316-3987-4c77-14a0-f37c4ca265a3@hartkopp.net>
Date:   Sat, 19 Jun 2021 13:23:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ebaf846a-f325-80fd-f926-6ad9854bf453@hartkopp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

I sent a RFC patch which enables the local echo on vxcan interfaces by 
simply removing the IFF_ECHO flag which is set by default.

With this solution we make use of the echo functionality in can_send() 
which is used by slcan and vcan by default.

This approach sends the echo'ed frame instantly without checking whether 
the frame has been delivered to the peer interface in the other namespace.

I don't know whether it's worth the effort to handle the local echo in 
vxcan_xmit() for that 'successful delivery' feature?!?

At least vxcan feels more natural with this patch.

Best regards,
Oliver

On 01.06.21 10:50, Oliver Hartkopp wrote:
> Hello Marc,
> 
> On 27.05.21 17:07, Marc Kleine-Budde wrote:
> 
>> I was wondering what the RX, TX and echo semantics on vxcan interfaces
>> should be.
>>
>> I have started a "cangen" in one namespace and a "candump" in other.
>>
>> The "candump" in the receiving namespace shows the CAN frames as "TX"
>> and in the sending namespace the CAN frames don't show up in a "candump"
>> at all. Is this intentional? If so what's the idea behind this and is
>> this documented?
>>
>> I'm adding "cangw" to the mix and see what happens....
> 
> Yes. That is needed ...
> 
> If you take a look at slide 19 here:
> https://wiki.automotivelinux.org/_media/agl-distro/agl2018-socketcan.pdf
> 
> The difference to vcan's (which are providing a local echo 
> functionality) the vxcan's are more like veth's:
> 
> Providing a link between two namespaces but nothing more.
> 
> The question is if it would make sense to provide an additional local 
> echo in vxcan_xmit() when sending to a vxcan?
> 
> When deriving vxcan from veth I probably had a some weird thoughts why 
> that local echo could add problems. But while looking at it now, 
> creating a second skb for a local echo on the side where the CAN frame 
> is put into the vxcan seems applicable.
> 
> What do you think?
> 
> Best,
> Oliver
