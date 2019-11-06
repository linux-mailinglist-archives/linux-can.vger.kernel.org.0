Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD8F14C5
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 12:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfKFLPr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 6 Nov 2019 06:15:47 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:22654 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKFLPr (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 06:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573038945;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=eEnAG/vALt+BCcxP9W6+pY9H2QaRD6sEvviKLH8NiI4=;
        b=eIBWXUhhFP8A6ucOQQvEwMd73CfKlaTrvued7ZkK0MFo6xaRmPLJmo1v2jiXoD/wVS
        ZhLF7knc69yzlhwynBitP4+BW8h2KuahLC5VKZ7FNiayav0W9MWyVFf36kzQ1fft5a2J
        zSLgyypFxUgKBVpNFYjb2zS5OXEIP1RKMV2VeFai4eygcLRuVzh+HECytcQFGz8KHqHo
        2Gmxd0TRCRzso7hO/+Pp3+OXnXlpy2RUO1PVUiFK3HhMFSgOkqYfBQ14djp/A/IU5OmH
        jM3X6sar//0A/e2BHQiKqNjOQz0jTHc+BW4rYQgtckeOtZQ56wJpPBgsUb+dwM7pocS0
        hylA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJV8h+lyA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id C03a03vA6BCjN0o
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 6 Nov 2019 12:12:45 +0100 (CET)
Subject: Re: Fwd: Return value of write() in BUS-OFF state
To:     jara.beran@gmail.com, linux-can@vger.kernel.org
References: <CADNXvDw5KDju9pHaRY1_6T-GgoOo=T2i4FZJRvd0GuP0jZis=g@mail.gmail.com>
 <CADNXvDy5qj0=tUQ1h_aN4UuCRtnXQ+4y55+JSKneyx9-C1CyBA@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <7e91f790-22f5-070c-f56d-a432779c7e4d@hartkopp.net>
Date:   Wed, 6 Nov 2019 12:12:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADNXvDy5qj0=tUQ1h_aN4UuCRtnXQ+4y55+JSKneyx9-C1CyBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Jaroslav,

On 05/11/2019 22.46, Jaroslav Beran wrote:

> So far I've learned this issue is most probably caused by upper (net
> and can) layers (so this is not specific for certain controller
> driver). When a driver calls can_bus_off, it sets carrier-off and
> triggers linkwatch_* actions that deactivate net queues and substitute
> a struct qdisc with `noop_qdisc`. Upon sending a frame, it's enqueue
> function - noop_enqueue - just returns NET_XMIT_CN, which is
> transformed by net_xmit_errno macro to zero, that's passed by
> net/can/af_can.c:can_send up to a userspace caller of write as
> success.

Hm.

> According to description for qdisc return codes in
> include/linux/netdevice.h, NET_XMIT_CN stands for `congestion
> notification` and further
> 
> /* NET_XMIT_CN is special. It does not guarantee that this packet is lost. It
>   * indicates that the device will soon be dropping packets, or already drops
>   * some packets of the same priority; prompting us to send less aggressively. */
> 
> 
> Is this behavior appropriate for a node in BUS-OFF state? I'd rather
> expect such controller would be always dropping all frames (not just
> soon and some) until reset.

The common use of the net_xmit_errno macro probably really does not fit 
to the CAN specialties ...

> In current situation a caller of write gets success even if his frame
> is lost for sure. Is there any specific reason for this? Of course he
> can be notified by receiving error frame, but why don't just return
> error in can_send?

Yes. It makes sense to forward the carrier-off state that is thankfully 
provided by the linkwatch triggers to the user space.

Looking to man(2) send we should provide -ENOBUFS in the case of 
carrier-off state, right?

Would you like to provide a patch?

Best regards,
Oliver
