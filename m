Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0C42AF7CF
	for <lists+linux-can@lfdr.de>; Wed, 11 Nov 2020 19:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgKKSRF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 11 Nov 2020 13:17:05 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:13117 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKSRF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 11 Nov 2020 13:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605118620;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=7jxTcYkxu86pA1FYhd6bGLjT7n7dhg6KsFeWweHAS/w=;
        b=EwKgRxn7AlcsVv9TiEtqj4u9dnY8twfQPKx2JEii8RIOyeH2yZAJa5GpbxqnYPeWix
        CsMNFEemloBX14r+ZxTfZ69YTS3d+NPgd+5DENqMwmED3nnDTB5iHG+WwbK0wXfzesHH
        k12Wj4GkNRCdGndTkwJoexWFTqNPg/u6Au1UfY3bXcF2bfaa2RICKTrn3t60TevgVp/t
        TIMKg2naZrKG0e1yRcEaw/hiTxuuXwjzbae83yGbe6hhBF1hrCKxTwg6ePz3Th9b+PBz
        sepjOhQp3nPjsMaPVqHzzPX9t80CbqfIYR1pXp7XP1ipt1UVA0KoHk/2qzbPZO7sJk2x
        zaiQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKNNeQJA=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwABIGx5HW
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 11 Nov 2020 19:16:59 +0100 (CET)
Subject: Re: [PATCH v8] can-dev: add len8_dlc support for various CAN adapters
To:     =?UTF-8?Q?Stefan_M=c3=a4tje?= <Stefan.Maetje@esd.eu>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     "mailhol.vincent@wanadoo.fr" <mailhol.vincent@wanadoo.fr>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
References: <20201111095923.2535-1-socketcan@hartkopp.net>
 <4ef80738553cb4787d5a3146e2f696829b3dd9e6.camel@esd.eu>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <531de8eb-42c0-77dd-388a-07c7e74ce80b@hartkopp.net>
Date:   Wed, 11 Nov 2020 19:16:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <4ef80738553cb4787d5a3146e2f696829b3dd9e6.camel@esd.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Stefan,

On 11.11.20 13:58, Stefan Mätje wrote:

> I would like to jump on the rolling train for the Classical CAN driver
> in
> 
> - esd_usb2
> 
> that supports the esd CAN-USB/2 and CAN-USB/Micro devices and add the
> CAN_CTRLMODE_CC_LEN8_DLC capability. At least I could do some tests
> with both devices.

Great! Thanks for your support!

> Am I right with the assumption that your patches are based on the
> linux-can tree?

No. The patches were originally based on the net-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git

But you can now use the 'testing' branch of linux-can-next as Marc 
applied the patches there for the upstream process:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=testing

> At the moment I'm in home-office and therefore will only on Friday
> again have access to my Linux test machine and the USB devices.

You would also need the updated can-utils which are currently only on my 
personal fork:

https://github.com/hartkopp/can-utils

I need to start a pull request :-)

And you would need to extend the 'ip' tool from

https://git.kernel.org/pub/scm/network/iproute2/iproute2.git

with this patch:

https://lore.kernel.org/linux-can/20201029083326.41627-1-socketcan@hartkopp.net/

Best regards,
Oliver
