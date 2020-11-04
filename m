Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2BF2A6725
	for <lists+linux-can@lfdr.de>; Wed,  4 Nov 2020 16:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgKDPIj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 4 Nov 2020 10:08:39 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:36670 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKDPIh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 4 Nov 2020 10:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1604502513;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=LFNlSnRIMqT5BtljLlTRrG6haADq6Msx9PuYf8a0aBY=;
        b=b0iH0hNFj++mVF46BTtlT26ZcSUMzT0gp/eAWiCG+v+xSBWxWiZ/c/4b8u512NuSfe
        qA08AT2iqfW9IJxCVQ3qbcMVpXp8+/te+LJRDJfwdwvZwy3Y2t/OzDkV9BQhLGcFQrHm
        tm/YmO3ARS6EO5aXjcYtaL22lB0jovhnVkY1REY4QYOTgFP+QSDfZtDO8T1PRKPW3rjq
        6YbSv3uEWzt8DW+awsgLidLIUdpfD6y028rvGjlmS57nx3hWlFh/j8c/Hku5sP/wQpBL
        wdaLG3+VcGdvYhDhv5TQ007Y66BYSrzsyIM+GrBsakmTSCYgBgAiIHymHwbXp1CF1n8+
        EtWA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiO8lopw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.3.0 DYNA|AUTH)
        with ESMTPSA id L010bewA4F8OJtl
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 4 Nov 2020 16:08:24 +0100 (CET)
Subject: Re: [PATCH v3 0/4] Introduce optional DLC element for Classic CAN
To:     Marc Kleine-Budde <mkl@pengutronix.de>, mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org
References: <20201029083218.41505-1-socketcan@hartkopp.net>
 <05f5257e-2ece-d9d4-2481-57b05b961d10@hartkopp.net>
 <08cf2c95-df53-9ecb-d84a-9d95239b4b04@pengutronix.de>
 <e561625a-f6bb-bd10-332b-53cc2ae104b0@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <d71984e5-a093-7bd3-4010-e2ad9f3337bc@hartkopp.net>
Date:   Wed, 4 Nov 2020 16:08:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e561625a-f6bb-bd10-332b-53cc2ae104b0@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 03.11.20 23:27, Marc Kleine-Budde wrote:
> On 11/3/20 11:26 PM, Marc Kleine-Budde wrote:
>> On 11/3/20 11:33 AM, Oliver Hartkopp wrote:
>>> Hello Marc,
>>>
>>> I did some more testing with different CAN-USB adapters and feel pretty
>>> comfortable on the below patch set now.
>>>
>>> Would you think this is something for can-next?
>>
>> Yes, this would go via
> 
> ...net-next/master

ok

There are some patches in the current linux-can pull request that have 
an impact on renaming the get_dlc helpers.

Therefore I would have to wait until net is merged to net-next.

But the net-next window will still be open for a while ...

Thanks,
Oliver
