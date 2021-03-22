Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB845344B44
	for <lists+linux-can@lfdr.de>; Mon, 22 Mar 2021 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhCVQ1w (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Mar 2021 12:27:52 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:13055 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhCVQ1n (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 22 Mar 2021 12:27:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1616430459; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O5S/VmDuIf3fImJQ02KVHRUczViNt4Ui4Ah54lhDR8fDh24JlBOPTt5ybuD0XXwO7S
    emkbxLMslTfWN0D4z6nreCtC6tJHsi3XyeafxwcZfg+k2qbYMJvJn5MwZpbdZW2FUx2Q
    tB2nt1ZweNPOR65g2YJNnmidvPpOOksMcASfJS7YV50qnjaJy5slnvuwCq+6ea1z1qvz
    WL+G4/E6Iu3eTJcR2MPWP/VuT1RIoqMNskB7cC456M/HoSZSiYNjRf/EJHHqi3pNckjm
    IGbC0aWjMC4QPvvO3b4pzqBRy0w9M+FRPN27cTW9ucfIKoxgWAtwTaWl3nHzff7LvtiN
    74OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1616430459;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UzgZE8C1F6Rvk7tIkrI4akGPt8+k/EJuO+ebcqqQZlk=;
    b=IBOFdMruoi05b4SHcQt7pNPpJMm6DJtMnOr3VjaIeOPzz+9sp37GiPTDmdXdYb6Iuh
    4tpOLX9NrPVj+yDs1Zwk7OGh6tYEsYf+RqAc53tgm5mSCyeDvS5Mf6980zEt1bd+3Ilo
    +tlb1UVR5J2FJqjfBt5Ws5GgAITGoclKVEWwXqQ+Xa3ID3wi0wmse+9/tG2KG+137tNr
    D3xlUxJqqlFGx6Pb8OqYQU82tEMQWCPS3EcQUhwNvtoLHgK+vY6g/V5R30IQ6As0A5Fu
    gHiFW7sG7+03V0U/yPK63zsy+SBWGTYJv5n0vUaSRXknxtnR99DrT1xstfovpNTz7ed3
    LFNg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1616430459;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=UzgZE8C1F6Rvk7tIkrI4akGPt8+k/EJuO+ebcqqQZlk=;
    b=IKqMvmgNFzKkBRmFxUvOf4wTjqEUkwUkvr6sjVkL2gLVWR1Hrz3EZlHU1aA7VdN7uB
    xEyGCLA+8QojlqCCBN/xaaaKzXsUyTJuCD7C22RtfK8ZocMu8K7LgJelEX/sJ5cx2/aa
    yJ2UJCkFohkznHnR6UprSWtnfdQ4GvukjGyH70VIl4ATiE1qjsN38Sfl9o4B8nX89fSO
    yL1vrZ9P1+Y9Sgix7CUGIa7kYBRxOD5sZ8QYyhVjuv0N27udih+qivOC/lkXrENVswrT
    KFPhNqbTK4PfGasyXHKogbDzJxZm72LlOYi7m/xgGXiEgFU3Iqc0v5yPAvyoyo6lZOn8
    5whQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVNiOMpjpw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
    by smtp.strato.de (RZmta 47.21.0 DYNA|AUTH)
    with ESMTPSA id R01debx2MGRdCxF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 22 Mar 2021 17:27:39 +0100 (CET)
Subject: Re: [PATCH] can: uapi: can.h: mark union inside struct can_frame
 packed
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de, Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>
References: <20210322102814.402850-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <61ef8390-6c08-8fcc-4753-5294483ec41a@hartkopp.net>
Date:   Mon, 22 Mar 2021 17:27:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210322102814.402850-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 22.03.21 11:28, Marc Kleine-Budde wrote:
> In commit ea7800565a12 ("can: add optional DLC element to Classical
> CAN frame structure") the struct can_frame::can_dlc was put into an
> anonymous union with another u8 variable.
> 
> For various reasons some members in struct can_frame and canfd_frame
> including the first 8 byes of data are expected to have the same
> memory layout. This is enforced by a BUILD_BUG_ON check in af_can.c.
> 
> Since the above mentioned commit this check fails on at least one compiler
> (arm-linux-gnueabi-gcc (GCC) 9.3.0). Rong Chen analyzed the problem
> and found that the union in struct can_frame takes 4 bytes instead of
> the expected 1:
> 
> | struct can_frame {
> |          canid_t                    can_id;               /* 0     4 */
> |          union {
> |                  __u8               len;                  /* 4     1 */
> |                  __u8               can_dlc;              /* 4     1 */
> |          };                                               /* 4     4 */
> |          __u8                       __pad;                /* 8     1 */
> |          __u8                       __res0;               /* 9     1 */
> |          __u8                       len8_dlc;             /* 10     1 */
> |
> |          /* XXX 5 bytes hole, try to pack */
> |
> |          __u8                       data[8]
> | __attribute__((__aligned__(8))); /*    16     8 */
> |
> |          /* size: 24, cachelines: 1, members: 6 */
> |          /* sum members: 19, holes: 1, sum holes: 5 */
> |          /* forced alignments: 1, forced holes: 1, sum forced holes: 5 */
> |          /* last cacheline: 24 bytes */
> | } __attribute__((__aligned__(8)));
> 
> Marking the union as packed fixes the problem.

Is this a proper answer to this issue?

Shouldn't this problem cause the developer to update the compiler?

https://lore.kernel.org/linux-can/f8075a19-10e1-abf9-6d59-1a46454b74b1@hartkopp.net/T/#u

Regards,
Oliver

> 
> Fixes: ea7800565a12 ("can: add optional DLC element to Classical CAN frame structure")
> Suggested-by: Rong Chen <rong.a.chen@intel.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>   include/uapi/linux/can.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
> index f75238ac6dce..9842bb55ffd9 100644
> --- a/include/uapi/linux/can.h
> +++ b/include/uapi/linux/can.h
> @@ -113,7 +113,7 @@ struct can_frame {
>   		 */
>   		__u8 len;
>   		__u8 can_dlc; /* deprecated */
> -	};
> +	} __attribute__((packed));
>   	__u8 __pad; /* padding */
>   	__u8 __res0; /* reserved / padding */
>   	__u8 len8_dlc; /* optional DLC for 8 byte payload length (9 .. 15) */
> 
