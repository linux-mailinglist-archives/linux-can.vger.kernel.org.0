Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1546736F
	for <lists+linux-can@lfdr.de>; Fri,  3 Dec 2021 09:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379302AbhLCIsT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 3 Dec 2021 03:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351292AbhLCIsS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 3 Dec 2021 03:48:18 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8624BC061757
        for <linux-can@vger.kernel.org>; Fri,  3 Dec 2021 00:44:54 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z8so4737227ljz.9
        for <linux-can@vger.kernel.org>; Fri, 03 Dec 2021 00:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kvaser.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nDjpRXICPCHSQs+2lhepbmHrGRwDJ4dTdulpB2X4trg=;
        b=w7sogOVV3GtH1yYeWK4dNiijGxnd/G6LgDUEvA7aETzpcCJsrKbHSEZGyLPy1bkI+2
         Jj3qbDACJnKt7XVDSExH4aPn3vo1WG8ejfmPtJiPy/qp6DnnlJzeXsCVTvywvfhU4yt3
         EgoJZaUCezxgKoG4+H6rtZdXMhBrCnNZcnxTjKIEm4j5gbbf6QTOh2kMEUrtKlWKaPjk
         x4/e55VyBCJ4i5kwcCqfl8p2r5wlliVQBlMDBQs6CdGzeqVIgi/0QzVaNiJ+ssa3DCF2
         1GQY3Wdzg//UNZdCykAjUA46NNloSoaE9eOdphKPVetCA+h1NCSyFkupra0edwda6IGE
         afWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nDjpRXICPCHSQs+2lhepbmHrGRwDJ4dTdulpB2X4trg=;
        b=x9W4lq2vB3BIy+K9A/Xie8pSitRvKLYGcFQm48RlhrLpIqS2FLwbBQ+hlEngk7NgWk
         /pFbTdxw3rvvhK/mSA6Ac9zouYGehLGnVbrjrczZnTgJmgB+kgNSscKRwfuZzwTeNgXf
         evV0A8QhAZH7GQIkSC7O7CmAQQL6CLWJKwQyGqCP5DClnHSYhR6k+C4xQZ0J6f3uiOHw
         pA/CXcqhOkj7p8sLSHtWAI+E+MDho44K6XfYqkq0yiyx+v6JXNorDGxld+EFaeAUm2oD
         37KUxTVDKbu4oaSHudrfLj+nv2czUGER9XCrgfgljKyhhyGvdTtxlvQa6uKVvslvcAfi
         Ab7A==
X-Gm-Message-State: AOAM531XTcDc6bDywDp4gHalevPSY7jExjSpDsLpqzoY3g4INW1DLAdu
        9isODnllC8GPbOdS4vQO/bW4yQ==
X-Google-Smtp-Source: ABdhPJyIQbv4VdsCECR2QyApqxy4jXuqALQ61Fmppv4TEoJSvmR1d4Bg9aeDsHVPkA2XtfkBwLL31g==
X-Received: by 2002:a2e:151b:: with SMTP id s27mr16824453ljd.274.1638521092718;
        Fri, 03 Dec 2021 00:44:52 -0800 (PST)
Received: from [10.0.6.3] (rota.kvaser.com. [195.22.86.90])
        by smtp.gmail.com with ESMTPSA id e17sm283187lfq.102.2021.12.03.00.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 00:44:52 -0800 (PST)
Subject: Re: [PATCH v3 5/5] can: do not increase tx_bytes statistics for RTR
 frames
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Yasushi SHOJI <yashi@spacecubics.com>,
        Stephane Grosjean <s.grosjean@peak-system.com>
References: <20211128123734.1049786-1-mailhol.vincent@wanadoo.fr>
 <20211128123734.1049786-6-mailhol.vincent@wanadoo.fr>
 <5ba88e96-444e-39c0-d00d-03f2153e7e6f@kvaser.com>
 <CAMZ6RqJ4WWAZSrk1AqS=TFbyrx7Ys49=fN-GTxkwh62GCS8Rqw@mail.gmail.com>
From:   Jimmy Assarsson <extja@kvaser.com>
Message-ID: <79c86cf6-26bd-6a84-81a3-577ae7f01c7d@kvaser.com>
Date:   Fri, 3 Dec 2021 09:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMZ6RqJ4WWAZSrk1AqS=TFbyrx7Ys49=fN-GTxkwh62GCS8Rqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 2021-12-03 02:05, Vincent MAILHOL wrote:
> On Fri. 3 Dec. 2021 at 08:35, Jimmy Assarsson <extja@kvaser.com> wrote:
>> On 2021-11-28 13:37, Vincent Mailhol wrote:
>>> The actual payload length of the CAN Remote Transmission Request (RTR)
>>> frames is always 0, i.e. nothing is transmitted on the wire. However,
>>> those RTR frames still use the DLC to indicate the length of the
>>> requested frame.
>>>
>>> As such, net_device_stats:tx_bytes should not be increased when
>>> sending RTR frames.
>>>
>>> The function can_get_echo_skb() already returns the correct length,
>>> even for RTR frames (c.f. [1]). However, for historical reasons, the
>>> drivers do not use can_get_echo_skb()'s return value and instead, most
>>> of them store a temporary length (or dlc) in some local structure or
>>> array. Using the return value of can_get_echo_skb() solves the
>>> issue. After doing this, such length/dlc fields become unused and so
>>> this patch does the adequate cleaning when needed.
>>>
>>> This patch fixes all the CAN drivers.
>>>
>>> Finally, can_get_echo_skb() is decorated with the __must_check
>>> attribute in order to force future drivers to correctly use its return
>>> value (else the compiler would emit a warning).
>>>
>>> [1] commit ed3320cec279 ("can: dev: __can_get_echo_skb():
>>> fix real payload length return value for RTR frames")
>>
>> Hi Vincent!
>>
>> Thanks for the patch!
>> I've reviewed and tested the changes affecting kvaser_usb.
>> Looks good to me, only a minor nitpick inline :)

...

>>> diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
>>> index 17fabd3d0613..9f423a5fb63f 100644
>>> --- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
>>> +++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c

...

>>> @@ -1493,13 +1489,13 @@ kvaser_usb_hydra_frame_to_cmd_std(const struct kvaser_usb_net_priv *priv,
>>>        if (cf->can_id & CAN_RTR_FLAG)
>>>                flags |= KVASER_USB_HYDRA_CF_FLAG_REMOTE_FRAME;
>>>
>>> -     flags |= (cf->can_id & CAN_ERR_FLAG ?
>>> -               KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME : 0);
>>> +     if (cf->can_id & CAN_ERR_FLAG)
>>> +             flags |= KVASER_USB_HYDRA_CF_FLAG_ERROR_FRAME;
>>
>> This has nothing to do with RTR. Maybe put it in a separate patch?
> 
> Arg... You are right. This should not be here. I saw it in my
> final check, removed it in my tree and forgot to redo a "git
> format-patch".
> 
> This is some leftover of a previous version in which I did more
> heavy changes to kvaser_usb_hydra_frame_to_cmd_std(). This is
> purely cosmetic though. I am not willing to go into a clean up
> crusade of all CAN drivers so I will just leave the ternary
> operator untouched. Free to you to reuse it if you want to do a
> clean up later on.

Sure, I'll save it for later :) If you got more changes, feel free to share
them.

Best regards,
jimmy
