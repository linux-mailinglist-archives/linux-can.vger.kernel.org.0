Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958D53B7E08
	for <lists+linux-can@lfdr.de>; Wed, 30 Jun 2021 09:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhF3H3v (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 30 Jun 2021 03:29:51 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:25156 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhF3H3v (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Jun 2021 03:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1625038031;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=+zzbqhUhhpB/F4v1UuX9x2qXxTGWHJPv3eiYUNFBb5w=;
    b=G52oK+RvFRTQBGaRQE/0kqg8pxt6XetT9CotXTKIo+rfzrEx7W0ksY6DasPoQp5UuJ
    WwXiuaDIZFfEW/61/bq71Mx05yaEvI9OLqQc4fdAYMP/5JnUTRBu2Ac+vLApkOCG6ALe
    nittN9Ut+6YTI+1GpnvwAc5VXWDN7opJ1PYGLawoH5o0+w1yNoL0/hRpt8kEh+oW799K
    ucJdp5LHiIer9XyJnDcqelRF3ZoTgQi4Vdvb7OMinx2hX4kCXrVUbGX8t60/LnPjKPaj
    hZHPTrKotMZro6WBO25zMvljrzo7wCUC2sOFANurKH1lXOyxXL8tjMpcGuQqj7b3YzQc
    rQnA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8xozF0="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.27.5 DYNA|AUTH)
    with ESMTPSA id f08fc3x5U7RAH2c
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 30 Jun 2021 09:27:10 +0200 (CEST)
Subject: Re: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
To:     Harald Mommer <hmo@opensynergy.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <eb9a1f75-3bc9-aa07-9508-6a081be6a15c@opensynergy.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <42e3018d-cb08-20b2-6890-c5e0761cceae@hartkopp.net>
Date:   Wed, 30 Jun 2021 09:27:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <eb9a1f75-3bc9-aa07-9508-6a081be6a15c@opensynergy.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 29.06.21 21:39, Harald Mommer wrote:

> I still don't get it. This service process is the virtio device itself. 
> All our virtio devices are user land processes. There is no problem, 
> this works that way.

Works this way ... well, AFAIK virtio devices are usually no user space 
implementations.

> The problem may be that the virtio device should better not have used 
> vcan0 to get CAN access and that it should have used something different 
> instead. CAN GW? Is it that what you want to tell me all the time? "Do 
> not use vcan0 to exchange CAN messages but use CAN GW"?

You would still still use vcan0 or whatever you name it. But the 
"routing between CAN interfaces" can be done more efficiently inside the 
kernel.

> In this case in 
> the picture the box "Device Linux / VCAN / vcan0" changes but not the 
> userland virtio CAN device service process box.

My suggestion is more like: Create a virtual CAN device that exposes the 
virtio net driver as a CAN device inside kernel space.

An then you can use can-gw to do filtering/firewalling/forwarding to 
different application specific vcan's with can-gw.

> If it's this I'll get into CAN GW to understand what all this means now 
> and how to use it.

Just try this (as root):

modprobe can-gw

cangw -A -s vcan0 -d vcan1 -e
cangw -A -s vcan0 -d vcan2 -e -m OR:ID:400.8.8888888888888888

cangen vcan0

(and candump -c -c any on a second terminal)

This should give an impression. No filtering shown.

> But anyway, if so this should not have any impact on the driver or the 
> spec, this would be an issue of the device implementation itself which 
> is closed source and should now not be this interesting.

IMO a CAN virtio driver can be from public interest - and it has no USP. 
So why putting such a simple thing under closed source?

Regards,
Oliver

ps. Some can-gw / CAN net namespace slideware: 
https://wiki.automotivelinux.org/_media/agl-distro/agl2018-socketcan.pdf
